-- ============================================
-- SaaS Metrics Analytical Queries
-- ============================================
-- This file contains 15 SQL queries demonstrating
-- progressively advanced techniques for analyzing
-- SaaS business metrics
-- ============================================

-- ============================================
-- QUERY 1: Current Monthly Recurring Revenue (MRR)
-- Business Context: Calculate total MRR from all active subscriptions
-- Difficulty: Basic
-- Techniques: Simple aggregation, WHERE clause
-- ============================================
SELECT 
    SUM(plan_mrr) AS total_mrr,
    COUNT(DISTINCT customer_id) AS active_customers,
    ROUND(SUM(plan_mrr) / COUNT(DISTINCT customer_id), 2) AS avg_mrr_per_customer
FROM subscriptions
WHERE subscription_status = 'Active';

-- Expected insight: Provides snapshot of current revenue and customer base


-- ============================================
-- QUERY 2: MRR by Plan Type
-- Business Context: Understand revenue distribution across pricing tiers
-- Difficulty: Basic
-- Techniques: GROUP BY, multiple aggregations
-- ============================================
SELECT 
    plan_name,
    COUNT(*) AS customer_count,
    SUM(plan_mrr) AS total_mrr,
    ROUND(AVG(plan_mrr), 2) AS avg_mrr,
    ROUND(SUM(plan_mrr) * 100.0 / (SELECT SUM(plan_mrr) FROM subscriptions WHERE subscription_status = 'Active'), 2) AS mrr_percentage
FROM subscriptions
WHERE subscription_status = 'Active'
GROUP BY plan_name
ORDER BY total_mrr DESC;

-- Expected insight: Shows which plans drive most revenue


-- ============================================
-- QUERY 3: Customer Acquisition by Month
-- Business Context: Track new customer growth over time
-- Difficulty: Intermediate
-- Techniques: DATE functions, GROUP BY with dates
-- ============================================
SELECT 
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(*) AS new_customers,
    SUM(COUNT(*)) OVER (ORDER BY DATE_FORMAT(signup_date, '%Y-%m')) AS cumulative_customers
FROM customers
GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
ORDER BY signup_month;

-- Expected insight: Identifies growth trends and seasonality


-- ============================================
-- QUERY 4: Revenue Movement Analysis (New, Expansion, Contraction, Churn)
-- Business Context: Detailed monthly revenue changes by type
-- Difficulty: Intermediate
-- Techniques: Pivot-style aggregation, CASE statements
-- ============================================
SELECT 
    DATE_FORMAT(event_date, '%Y-%m') AS event_month,
    SUM(CASE WHEN event_type = 'New' THEN mrr_change ELSE 0 END) AS new_mrr,
    SUM(CASE WHEN event_type = 'Expansion' THEN mrr_change ELSE 0 END) AS expansion_mrr,
    SUM(CASE WHEN event_type = 'Contraction' THEN mrr_change ELSE 0 END) AS contraction_mrr,
    SUM(CASE WHEN event_type = 'Churn' THEN mrr_change ELSE 0 END) AS churned_mrr,
    SUM(mrr_change) AS net_mrr_change
FROM revenue_events
GROUP BY DATE_FORMAT(event_date, '%Y-%m')
ORDER BY event_month;

-- Expected insight: Shows how MRR composition changes each month


-- ============================================
-- QUERY 5: Churn Rate Calculation
-- Business Context: Calculate monthly churn rate (critical SaaS metric)
-- Difficulty: Intermediate
-- Techniques: Subqueries, date calculations
-- ============================================
WITH monthly_stats AS (
    SELECT 
        DATE_FORMAT(event_date, '%Y-%m') AS month,
        COUNT(DISTINCT CASE WHEN event_type = 'Churn' THEN customer_id END) AS churned_customers,
        (SELECT COUNT(DISTINCT customer_id) 
         FROM subscriptions 
         WHERE subscription_status IN ('Active', 'Churned')
           AND start_date < LAST_DAY(event_date)) AS total_customers_start_of_month
    FROM revenue_events
    GROUP BY DATE_FORMAT(event_date, '%Y-%m')
)
SELECT 
    month,
    churned_customers,
    total_customers_start_of_month,
    ROUND(churned_customers * 100.0 / NULLIF(total_customers_start_of_month, 0), 2) AS churn_rate_percentage
FROM monthly_stats
WHERE total_customers_start_of_month > 0
ORDER BY month;

-- Expected insight: Tracks customer retention health over time


-- ============================================
-- QUERY 6: Customer Lifetime Value (CLV) Estimation
-- Business Context: Calculate average CLV by plan type
-- Difficulty: Advanced
-- Techniques: Multiple JOINs, DATEDIFF, aggregations
-- ============================================
SELECT 
    s.plan_name,
    COUNT(DISTINCT s.customer_id) AS total_customers,
    ROUND(AVG(s.plan_mrr), 2) AS avg_monthly_revenue,
    ROUND(AVG(DATEDIFF(COALESCE(s.end_date, CURDATE()), s.start_date) / 30), 1) AS avg_lifetime_months,
    ROUND(AVG(s.plan_mrr * (DATEDIFF(COALESCE(s.end_date, CURDATE()), s.start_date) / 30)), 2) AS avg_customer_lifetime_value
FROM subscriptions s
GROUP BY s.plan_name
ORDER BY avg_customer_lifetime_value DESC;

-- Expected insight: Helps prioritize which customer segments to focus on


-- ============================================
-- QUERY 7: Cohort Retention Analysis
-- Business Context: Track retention rates by signup cohort
-- Difficulty: Advanced
-- Techniques: Self-join, cohort analysis, window functions
-- ============================================
WITH cohorts AS (
    SELECT 
        customer_id,
        DATE_FORMAT(signup_date, '%Y-%m') AS cohort_month,
        signup_date
    FROM customers
),
subscription_months AS (
    SELECT 
        c.customer_id,
        c.cohort_month,
        DATE_FORMAT(s.start_date, '%Y-%m') AS active_month,
        PERIOD_DIFF(
            DATE_FORMAT(s.start_date, '%Y%m'),
            DATE_FORMAT(c.signup_date, '%Y%m')
        ) AS months_since_signup
    FROM cohorts c
    JOIN subscriptions s ON c.customer_id = s.customer_id
    WHERE s.subscription_status IN ('Active', 'Cancelled')
)
SELECT 
    cohort_month,
    COUNT(DISTINCT CASE WHEN months_since_signup = 0 THEN customer_id END) AS month_0,
    COUNT(DISTINCT CASE WHEN months_since_signup = 1 THEN customer_id END) AS month_1,
    COUNT(DISTINCT CASE WHEN months_since_signup = 2 THEN customer_id END) AS month_2,
    COUNT(DISTINCT CASE WHEN months_since_signup = 3 THEN customer_id END) AS month_3,
    COUNT(DISTINCT CASE WHEN months_since_signup = 6 THEN customer_id END) AS month_6,
    ROUND(COUNT(DISTINCT CASE WHEN months_since_signup = 3 THEN customer_id END) * 100.0 / 
          NULLIF(COUNT(DISTINCT CASE WHEN months_since_signup = 0 THEN customer_id END), 0), 1) AS retention_rate_month_3
FROM subscription_months
GROUP BY cohort_month
ORDER BY cohort_month;

-- Expected insight: Shows how well different cohorts retain over time


-- ============================================
-- QUERY 8: Net Revenue Retention (NRR) Calculation
-- Business Context: Measure revenue retention including expansion
-- Difficulty: Advanced
-- Techniques: Complex CTEs, revenue calculations
-- ============================================
WITH cohort_revenue AS (
    SELECT 
        DATE_FORMAT(c.signup_date, '%Y-%m') AS cohort_month,
        c.customer_id,
        MIN(r.mrr_total) AS starting_mrr,
        MAX(CASE WHEN r.event_date >= DATE_ADD(c.signup_date, INTERVAL 12 MONTH) 
                 THEN r.mrr_total ELSE 0 END) AS mrr_after_12_months
    FROM customers c
    JOIN revenue_events r ON c.customer_id = r.customer_id
    WHERE c.signup_date <= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
    GROUP BY DATE_FORMAT(c.signup_date, '%Y-%m'), c.customer_id
)
SELECT 
    cohort_month,
    COUNT(customer_id) AS cohort_size,
    SUM(starting_mrr) AS total_starting_mrr,
    SUM(mrr_after_12_months) AS total_mrr_after_12_months,
    ROUND(SUM(mrr_after_12_months) * 100.0 / NULLIF(SUM(starting_mrr), 0), 2) AS nrr_percentage
FROM cohort_revenue
GROUP BY cohort_month
HAVING total_starting_mrr > 0
ORDER BY cohort_month;

-- Expected insight: NRR > 100% indicates expansion revenue exceeds churn


-- ============================================
-- QUERY 9: Customer Health Score Analysis
-- Business Context: Identify at-risk customers by health trends
-- Difficulty: Advanced
-- Techniques: Window functions (LAG), trend analysis
-- ============================================
WITH health_trends AS (
    SELECT 
        customer_id,
        score_date,
        health_score,
        risk_level,
        LAG(health_score, 1) OVER (PARTITION BY customer_id ORDER BY score_date) AS previous_score,
        LAG(health_score, 2) OVER (PARTITION BY customer_id ORDER BY score_date) AS two_months_ago_score
    FROM customer_health_scores
),
latest_health AS (
    SELECT 
        customer_id,
        health_score,
        previous_score,
        two_months_ago_score,
        risk_level,
        ROUND(health_score - previous_score, 2) AS one_month_change,
        ROUND(health_score - two_months_ago_score, 2) AS two_month_change,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY score_date DESC) AS rn
    FROM health_trends
)
SELECT 
    lh.customer_id,
    c.customer_name,
    c.company_size,
    s.plan_name,
    s.plan_mrr,
    lh.health_score,
    lh.risk_level,
    lh.one_month_change,
    lh.two_month_change,
    CASE 
        WHEN lh.risk_level = 'High' AND lh.two_month_change < -10 THEN 'Immediate Action Required'
        WHEN lh.risk_level = 'High' THEN 'High Priority'
        WHEN lh.risk_level = 'Medium' AND lh.one_month_change < -5 THEN 'Monitor Closely'
        ELSE 'Stable'
    END AS action_priority
FROM latest_health lh
JOIN customers c ON lh.customer_id = c.customer_id
JOIN subscriptions s ON lh.customer_id = s.customer_id AND s.subscription_status = 'Active'
WHERE lh.rn = 1
ORDER BY 
    CASE 
        WHEN lh.risk_level = 'High' AND lh.two_month_change < -10 THEN 1
        WHEN lh.risk_level = 'High' THEN 2
        WHEN lh.risk_level = 'Medium' THEN 3
        ELSE 4
    END,
    lh.health_score ASC;

-- Expected insight: Prioritizes customer success outreach efforts


-- ============================================
-- QUERY 10: Product Adoption & Usage Correlation with Retention
-- Business Context: Does higher feature adoption predict better retention?
-- Difficulty: Advanced
-- Techniques: Multiple JOINs, aggregations, correlation analysis
-- ============================================
SELECT 
    CASE 
        WHEN pu.features_used >= 8 THEN 'High Adopters (8+ features)'
        WHEN pu.features_used >= 5 THEN 'Medium Adopters (5-7 features)'
        ELSE 'Low Adopters (< 5 features)'
    END AS adoption_segment,
    COUNT(DISTINCT pu.customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN s.subscription_status = 'Churned' THEN pu.customer_id END) AS churned_customers,
    ROUND(COUNT(DISTINCT CASE WHEN s.subscription_status = 'Churned' THEN pu.customer_id END) * 100.0 / 
          COUNT(DISTINCT pu.customer_id), 2) AS churn_rate,
    ROUND(AVG(pu.logins_count), 1) AS avg_monthly_logins,
    ROUND(AVG(pu.active_users * 100.0 / NULLIF(pu.licensed_users, 0)), 1) AS avg_user_activation_rate
FROM product_usage pu
JOIN subscriptions s ON pu.customer_id = s.customer_id
WHERE pu.usage_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY adoption_segment
ORDER BY 
    CASE adoption_segment
        WHEN 'High Adopters (8+ features)' THEN 1
        WHEN 'Medium Adopters (5-7 features)' THEN 2
        ELSE 3
    END;

-- Expected insight: Should show correlation between adoption and retention


-- ============================================
-- QUERY 11: Support Ticket Impact on Customer Health
-- Business Context: Analyze relationship between support issues and churn
-- Difficulty: Advanced
-- Techniques: CTEs, complex JOINs, statistical grouping
-- ============================================
WITH customer_support_stats AS (
    SELECT 
        st.customer_id,
        COUNT(*) AS total_tickets,
        AVG(st.resolution_days) AS avg_resolution_days,
        SUM(CASE WHEN st.priority IN ('High', 'Critical') THEN 1 ELSE 0 END) AS high_priority_tickets,
        MAX(st.ticket_date) AS last_ticket_date
    FROM support_tickets st
    WHERE st.ticket_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY st.customer_id
)
SELECT 
    CASE 
        WHEN css.total_tickets = 0 THEN '0 tickets'
        WHEN css.total_tickets <= 2 THEN '1-2 tickets'
        WHEN css.total_tickets <= 5 THEN '3-5 tickets'
        ELSE '6+ tickets'
    END AS ticket_volume,
    COUNT(DISTINCT css.customer_id) AS customer_count,
    ROUND(AVG(chs.health_score), 2) AS avg_health_score,
    COUNT(DISTINCT CASE WHEN s.subscription_status = 'Churned' THEN css.customer_id END) AS churned_count,
    ROUND(COUNT(DISTINCT CASE WHEN s.subscription_status = 'Churned' THEN css.customer_id END) * 100.0 / 
          COUNT(DISTINCT css.customer_id), 2) AS churn_rate,
    ROUND(AVG(css.avg_resolution_days), 1) AS avg_resolution_time
FROM customer_support_stats css
LEFT JOIN customer_health_scores chs ON css.customer_id = chs.customer_id 
    AND chs.score_date = (SELECT MAX(score_date) FROM customer_health_scores WHERE customer_id = css.customer_id)
LEFT JOIN subscriptions s ON css.customer_id = s.customer_id
GROUP BY ticket_volume
ORDER BY 
    CASE ticket_volume
        WHEN '0 tickets' THEN 1
        WHEN '1-2 tickets' THEN 2
        WHEN '3-5 tickets' THEN 3
        ELSE 4
    END;

-- Expected insight: High ticket volume likely correlates with lower health scores


-- ============================================
-- QUERY 12: Expansion Revenue Opportunities
-- Business Context: Identify customers ready for upsell
-- Difficulty: Advanced
-- Techniques: Multiple CTEs, complex conditions
-- ============================================
WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.company_size,
        s.plan_name,
        s.plan_mrr,
        chs.health_score,
        chs.engagement_score,
        chs.adoption_score,
        pu.features_used,
        pu.active_users,
        pu.licensed_users,
        ROUND(pu.active_users * 100.0 / NULLIF(pu.licensed_users, 0), 1) AS seat_utilization,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY chs.score_date DESC) AS health_rn,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY pu.usage_date DESC) AS usage_rn
    FROM customers c
    JOIN subscriptions s ON c.customer_id = s.customer_id AND s.subscription_status = 'Active'
    LEFT JOIN customer_health_scores chs ON c.customer_id = chs.customer_id
    LEFT JOIN product_usage pu ON c.customer_id = pu.customer_id
)
SELECT 
    customer_id,
    customer_name,
    company_size,
    plan_name,
    plan_mrr,
    health_score,
    engagement_score,
    adoption_score,
    features_used,
    seat_utilization,
    CASE 
        WHEN plan_name = 'Starter' AND health_score >= 75 AND engagement_score >= 80 THEN 'Ready for Professional'
        WHEN plan_name = 'Professional' AND health_score >= 80 AND seat_utilization >= 85 THEN 'Ready for Enterprise'
        WHEN seat_utilization >= 90 THEN 'Seat Expansion Opportunity'
        WHEN features_used >= 8 AND plan_name != 'Enterprise' THEN 'Feature-driven Upsell'
        ELSE 'Not Ready'
    END AS expansion_opportunity
FROM customer_metrics
WHERE health_rn = 1 AND usage_rn = 1
    AND health_score >= 70
HAVING expansion_opportunity != 'Not Ready'
ORDER BY health_score DESC, plan_mrr DESC;

-- Expected insight: Qualified leads for account management team


-- ============================================
-- QUERY 13: Revenue Concentration Risk
-- Business Context: Identify dependency on top customers
-- Difficulty: Advanced
-- Techniques: Window functions, running totals
-- ============================================
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        s.plan_mrr,
        ROW_NUMBER() OVER (ORDER BY s.plan_mrr DESC) AS revenue_rank
    FROM customers c
    JOIN subscriptions s ON c.customer_id = s.customer_id
    WHERE s.subscription_status = 'Active'
),
total_metrics AS (
    SELECT SUM(plan_mrr) AS total_mrr FROM customer_revenue
),
cumulative_revenue AS (
    SELECT 
        cr.*,
        SUM(cr.plan_mrr) OVER (ORDER BY cr.revenue_rank) AS cumulative_mrr,
        tm.total_mrr,
        ROUND(SUM(cr.plan_mrr) OVER (ORDER BY cr.revenue_rank) * 100.0 / tm.total_mrr, 2) AS cumulative_percentage
    FROM customer_revenue cr
    CROSS JOIN total_metrics tm
)
SELECT 
    revenue_rank,
    customer_name,
    plan_mrr,
    cumulative_mrr,
    cumulative_percentage,
    CASE 
        WHEN cumulative_percentage <= 50 THEN 'Top 50% Revenue'
        WHEN cumulative_percentage <= 80 THEN 'Next 30% Revenue'
        ELSE 'Remaining 20% Revenue'
    END AS revenue_segment
FROM cumulative_revenue
WHERE revenue_rank <= 20
ORDER BY revenue_rank;

-- Expected insight: Shows concentration risk in customer base


-- ============================================
-- QUERY 14: Seasonal Trends in Customer Acquisition & Churn
-- Business Context: Identify patterns to inform forecasting
-- Difficulty: Advanced
-- Techniques: Date functions, seasonal analysis
-- ============================================
SELECT 
    QUARTER(event_date) AS quarter,
    MONTH(event_date) AS month,
    MONTHNAME(event_date) AS month_name,
    COUNT(DISTINCT CASE WHEN event_type = 'New' THEN customer_id END) AS new_customers,
    COUNT(DISTINCT CASE WHEN event_type = 'Churn' THEN customer_id END) AS churned_customers,
    SUM(CASE WHEN event_type = 'New' THEN mrr_change ELSE 0 END) AS new_mrr,
    SUM(CASE WHEN event_type = 'Expansion' THEN mrr_change ELSE 0 END) AS expansion_mrr,
    SUM(CASE WHEN event_type = 'Churn' THEN ABS(mrr_change) ELSE 0 END) AS churned_mrr,
    SUM(CASE WHEN event_type IN ('New', 'Expansion') THEN mrr_change 
             WHEN event_type = 'Churn' THEN mrr_change ELSE 0 END) AS net_new_mrr
FROM revenue_events
GROUP BY QUARTER(event_date), MONTH(event_date), MONTHNAME(event_date)
ORDER BY quarter, month;

-- Expected insight: Reveals seasonal patterns in growth and churn


-- ============================================
-- QUERY 15: Customer Segmentation for Targeted Strategies
-- Business Context: Create actionable customer segments
-- Difficulty: Expert
-- Techniques: Multiple CTEs, complex CASE logic, comprehensive joins
-- ============================================
WITH latest_health AS (
    SELECT 
        customer_id,
        health_score,
        engagement_score,
        adoption_score,
        risk_level,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY score_date DESC) AS rn
    FROM customer_health_scores
),
latest_usage AS (
    SELECT 
        customer_id,
        features_used,
        logins_count,
        ROUND(active_users * 100.0 / NULLIF(licensed_users, 0), 1) AS user_activation,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY usage_date DESC) AS rn
    FROM product_usage
),
customer_tenure AS (
    SELECT 
        customer_id,
        DATEDIFF(CURDATE(), signup_date) / 30 AS months_as_customer
    FROM customers
),
support_history AS (
    SELECT 
        customer_id,
        COUNT(*) AS total_tickets,
        AVG(resolution_days) AS avg_resolution_time
    FROM support_tickets
    WHERE ticket_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY customer_id
)
SELECT 
    c.customer_id,
    c.customer_name,
    c.company_size,
    c.industry,
    s.plan_name,
    s.plan_mrr,
    ct.months_as_customer,
    lh.health_score,
    lh.engagement_score,
    lh.risk_level,
    lu.features_used,
    lu.user_activation,
    COALESCE(sh.total_tickets, 0) AS recent_tickets,
    CASE 
        -- VIP Customers: High value, healthy, long tenure
        WHEN s.plan_mrr >= 5000 AND lh.health_score >= 80 AND ct.months_as_customer >= 6 
            THEN 'VIP - High Touch Required'
        
        -- Growth Potential: Healthy smaller customers ready to expand
        WHEN s.plan_name IN ('Starter', 'Professional') AND lh.health_score >= 75 AND lu.user_activation >= 80
            THEN 'Growth - Expansion Opportunity'
        
        -- At Risk: Any customer with declining health
        WHEN lh.risk_level = 'High' OR lh.health_score < 50
            THEN 'At Risk - Immediate Intervention'
        
        -- New Customers: Recently signed, need onboarding support
        WHEN ct.months_as_customer < 3
            THEN 'New - Onboarding Critical'
        
        -- Stable Core: Healthy mid-tier customers
        WHEN lh.health_score >= 70 AND lh.health_score < 80
            THEN 'Stable - Maintain & Monitor'
        
        -- Low Engagement: Healthy account but low usage
        WHEN lh.health_score >= 65 AND lu.features_used <= 4
            THEN 'Low Engagement - Drive Adoption'
        
        ELSE 'Standard - Regular Cadence'
    END AS customer_segment,
    CASE 
        WHEN s.plan_mrr >= 5000 AND lh.health_score >= 80 THEN 'Quarterly Business Reviews'
        WHEN lh.risk_level = 'High' THEN 'Weekly Check-ins'
        WHEN ct.months_as_customer < 3 THEN 'Onboarding Track'
        WHEN s.plan_name IN ('Starter', 'Professional') AND lh.health_score >= 75 THEN 'Upsell Campaign'
        ELSE 'Monthly Touch Points'
    END AS recommended_cadence
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id AND s.subscription_status = 'Active'
LEFT JOIN latest_health lh ON c.customer_id = lh.customer_id AND lh.rn = 1
LEFT JOIN latest_usage lu ON c.customer_id = lu.customer_id AND lu.rn = 1
LEFT JOIN customer_tenure ct ON c.customer_id = ct.customer_id
LEFT JOIN support_history sh ON c.customer_id = sh.customer_id
ORDER BY 
    CASE 
        WHEN lh.risk_level = 'High' THEN 1
        WHEN s.plan_mrr >= 5000 THEN 2
        ELSE 3
    END,
    s.plan_mrr DESC;

-- Expected insight: Actionable customer segments for CS team resource allocation

-- ============================================
-- End of Analytical Queries
-- ============================================
-- These 15 queries progress from basic to expert level and demonstrate:
-- - Fundamental SaaS metrics (MRR, ARR, churn)
-- - Advanced analytics (cohort analysis, NRR, CLV)
-- - Predictive insights (churn risk, expansion opportunities)
-- - Strategic segmentation for business action
-- ============================================
