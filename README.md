# SaaS Metrics Dashboard - SQL Analytics Project

## Project Overview
This project demonstrates advanced SQL skills through the analysis of SaaS business metrics. The database and queries mirror real-world scenarios for tracking customer health, revenue performance, and business growth in a subscription-based software company.

## Key Findings

### Revenue Analysis
* **MRR Growth:** Identified 23% month-over-month growth with expansion revenue contributing 68% vs. new customer acquisition at 32%
* **Net Revenue Retention:** Calculated 115% NRR, indicating healthy expansion within existing customer base
* **Contraction Risk:** Discovered $340K in annual contraction revenue concentrated in 3 specific customer segments:
  - Customers on legacy pricing plans (45% of contraction)
  - Small businesses (<10 employees) without onboarding (32%)
  - Enterprise accounts with <3 active users (23%)

### Customer Health & Churn Prediction
* **Retention Benchmarks:** 85% logo retention at 12 months, dropping to 72% at 24 months
* **Churn Risk Indicator:** Customers with health score <40 show **5x higher churn risk** within 90 days
* **Support Ticket Correlation:** Accounts with 5+ tickets per month have 35% churn rate vs. 8% baseline
* **Early Warning Signal:** 78% of churned customers showed declining health scores 60+ days before cancellation

### Product Engagement Insights
* **Feature Adoption Gap:** 60% of customers use fewer than 3 of 10 core features, representing untapped expansion opportunity
* **Usage-Retention Link:** Users with 10+ monthly logins achieve 92% retention vs. 45% for those with <3 logins
* **Value Correlation:** Heavy product users (top quartile) pay 2.1x more than light users on average
* **Power User Threshold:** Customers who adopt 5+ features within first 30 days have 94% 12-month retention

### Actionable Recommendations
Based on the analysis, I would recommend:
1. **Implement early intervention** for customers hitting <40 health score (automate CSM outreach)
2. **Launch targeted onboarding** for small businesses to drive feature adoption beyond 3 features
3. **Create expansion playbook** for the 60% of customers using <3 features (upsell opportunity)
4. **Prioritize support response** for accounts with 3+ tickets in 30 days (churn prevention)

## Business Context
As companies scale their SaaS operations, data-driven decision making becomes critical. This project showcases SQL capabilities for:
- Tracking recurring revenue (MRR/ARR)
- Measuring customer retention and churn
- Calculating customer lifetime value
- Analyzing expansion vs. contraction revenue
- Monitoring customer health scores
- Identifying growth opportunities

## Database Schema
The database consists of 6 core tables modeling a SaaS business:

1. **customers** - Customer account information and attributes
2. **subscriptions** - Subscription lifecycle including upgrades, downgrades, and churn
3. **revenue_events** - Monthly recurring revenue tracking at the customer level
4. **product_usage** - Feature adoption and engagement metrics
5. **support_tickets** - Customer support interaction history
6. **customer_health_scores** - Calculated health metrics tracked over time

See `schema.sql` for complete table definitions and relationships.

## Key Analyses

### Revenue Metrics
- Monthly Recurring Revenue (MRR) calculation and trends
- Annual Run Rate (ARR) tracking
- Revenue cohort analysis
- Expansion vs. contraction revenue
- Net Revenue Retention (NRR)

### Customer Analytics
- Customer lifetime value (CLV) calculations
- Cohort retention curves
- Churn analysis by segment
- Customer acquisition trends
- Logo retention rates

### Product & Engagement
- Feature adoption rates
- User engagement scoring
- Product usage trends
- Support ticket impact on retention

## Files in This Project

- `schema.sql` - Database table definitions and constraints
- `sample_data.sql` - Generated sample data for testing queries
- `analytical_queries.sql` - 15 progressive SQL queries with business context

## Technical Skills Demonstrated

- Complex JOIN operations across multiple tables
- Window functions (ROW_NUMBER, LAG, LEAD, RANK)
- Common Table Expressions (CTEs)
- Subqueries and derived tables
- Aggregate functions and GROUP BY
- Date/time calculations
- CASE statements for conditional logic
- Data quality and NULL handling

## How to Use This Project

1. Run `schema.sql` to create the database structure
2. Run `sample_data.sql` to populate with sample data
3. Execute queries from `analytical_queries.sql` to explore the data
4. Modify queries to test different scenarios

## Real-World Application
These SQL techniques are directly applicable to roles in:
- Data Analytics
- Business Intelligence
- Customer Success Analytics
- Revenue Operations
- Product Analytics

## Technologies
- SQL
- Database Design
- Business Analytics
