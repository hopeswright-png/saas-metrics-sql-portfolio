# SaaS Metrics Dashboard - SQL Analytics Project

## Project Overview
This project demonstrates advanced SQL skills through the analysis of SaaS business metrics. The database and queries mirror real-world scenarios for tracking customer health, revenue performance, and business growth in a subscription-based software company.

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
