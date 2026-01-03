-- ============================================
-- Sample Data for SaaS Metrics Database
-- ============================================
-- This script populates the database with realistic
-- sample data for a SaaS business with ~50 customers
-- spanning 2 years of operations
-- ============================================

-- ============================================
-- Insert Customers
-- ============================================
INSERT INTO customers (customer_id, customer_name, company_size, industry, signup_date, account_owner, region, is_active) VALUES
(1, 'Acme Corp', 'Enterprise', 'Technology', '2023-01-15', 'Sarah Johnson', 'North America', TRUE),
(2, 'TechStart Inc', 'Small', 'Software', '2023-01-20', 'Sarah Johnson', 'North America', TRUE),
(3, 'Global Finance LLC', 'Enterprise', 'Finance', '2023-02-01', 'Michael Chen', 'North America', TRUE),
(4, 'HealthPlus Systems', 'Medium', 'Healthcare', '2023-02-10', 'Sarah Johnson', 'North America', TRUE),
(5, 'Retail Solutions Co', 'Medium', 'Retail', '2023-02-15', 'Emily Rodriguez', 'North America', FALSE),
(6, 'EduTech Partners', 'Small', 'Education', '2023-03-01', 'Michael Chen', 'Europe', TRUE),
(7, 'Manufacturing Pro', 'Enterprise', 'Manufacturing', '2023-03-10', 'Sarah Johnson', 'North America', TRUE),
(8, 'Media Group International', 'Medium', 'Media', '2023-03-20', 'Emily Rodriguez', 'Europe', TRUE),
(9, 'Consulting Experts', 'Small', 'Professional Services', '2023-04-01', 'Michael Chen', 'North America', TRUE),
(10, 'Energy Innovations', 'Enterprise', 'Energy', '2023-04-15', 'Sarah Johnson', 'North America', TRUE),
(11, 'Legal Services Hub', 'Medium', 'Legal', '2023-05-01', 'Emily Rodriguez', 'North America', TRUE),
(12, 'Food & Beverage Corp', 'Medium', 'Food & Beverage', '2023-05-10', 'Michael Chen', 'North America', FALSE),
(13, 'Transportation Systems', 'Enterprise', 'Transportation', '2023-05-20', 'Sarah Johnson', 'Europe', TRUE),
(14, 'Real Estate Group', 'Small', 'Real Estate', '2023-06-01', 'Emily Rodriguez', 'North America', TRUE),
(15, 'Insurance Partners', 'Enterprise', 'Insurance', '2023-06-10', 'Sarah Johnson', 'North America', TRUE),
(16, 'Telecom Solutions', 'Medium', 'Telecommunications', '2023-06-20', 'Michael Chen', 'Asia Pacific', TRUE),
(17, 'Hospitality Services', 'Small', 'Hospitality', '2023-07-01', 'Emily Rodriguez', 'Europe', TRUE),
(18, 'Pharma Research Inc', 'Enterprise', 'Pharmaceuticals', '2023-07-15', 'Sarah Johnson', 'North America', TRUE),
(19, 'Construction Builders', 'Medium', 'Construction', '2023-07-25', 'Michael Chen', 'North America', TRUE),
(20, 'Marketing Agency Plus', 'Small', 'Marketing', '2023-08-01', 'Emily Rodriguez', 'North America', TRUE),
(21, 'Logistics Network', 'Enterprise', 'Logistics', '2023-08-10', 'Sarah Johnson', 'Europe', TRUE),
(22, 'Auto Parts Distributors', 'Medium', 'Automotive', '2023-08-20', 'Michael Chen', 'North America', TRUE),
(23, 'Design Studio Collective', 'Small', 'Design', '2023-09-01', 'Emily Rodriguez', 'North America', FALSE),
(24, 'Agriculture Tech', 'Medium', 'Agriculture', '2023-09-10', 'Sarah Johnson', 'North America', TRUE),
(25, 'Sports & Recreation Co', 'Small', 'Sports', '2023-09-20', 'Michael Chen', 'Europe', TRUE),
(26, 'Environmental Services', 'Medium', 'Environmental', '2023-10-01', 'Emily Rodriguez', 'North America', TRUE),
(27, 'Publishing House', 'Small', 'Publishing', '2023-10-10', 'Sarah Johnson', 'Europe', TRUE),
(28, 'Chemical Industries', 'Enterprise', 'Chemicals', '2023-10-20', 'Michael Chen', 'Asia Pacific', TRUE),
(29, 'Aerospace Components', 'Enterprise', 'Aerospace', '2023-11-01', 'Sarah Johnson', 'North America', TRUE),
(30, 'Gaming Studios', 'Medium', 'Gaming', '2023-11-10', 'Emily Rodriguez', 'North America', TRUE),
(31, 'Biotech Research', 'Enterprise', 'Biotechnology', '2023-11-20', 'Michael Chen', 'North America', TRUE),
(32, 'Fashion Retailers', 'Small', 'Fashion', '2023-12-01', 'Emily Rodriguez', 'Europe', TRUE),
(33, 'Security Systems Pro', 'Medium', 'Security', '2023-12-10', 'Sarah Johnson', 'North America', TRUE),
(34, 'Data Analytics Firm', 'Medium', 'Technology', '2024-01-05', 'Michael Chen', 'North America', TRUE),
(35, 'Cloud Services Group', 'Enterprise', 'Technology', '2024-01-15', 'Sarah Johnson', 'North America', TRUE),
(36, 'Mobile App Developers', 'Small', 'Software', '2024-01-25', 'Emily Rodriguez', 'Asia Pacific', TRUE),
(37, 'E-Commerce Platform', 'Medium', 'Retail', '2024-02-01', 'Michael Chen', 'North America', TRUE),
(38, 'HR Solutions Inc', 'Small', 'Human Resources', '2024-02-10', 'Sarah Johnson', 'North America', TRUE),
(39, 'Supply Chain Optimizers', 'Enterprise', 'Supply Chain', '2024-02-20', 'Emily Rodriguez', 'Europe', TRUE),
(40, 'Customer Support Tools', 'Medium', 'Software', '2024-03-01', 'Michael Chen', 'North America', TRUE),
(41, 'AI Research Lab', 'Medium', 'Technology', '2024-03-10', 'Sarah Johnson', 'North America', TRUE),
(42, 'Green Energy Solutions', 'Small', 'Energy', '2024-03-20', 'Emily Rodriguez', 'Europe', TRUE),
(43, 'Fintech Innovations', 'Enterprise', 'Finance', '2024-04-01', 'Michael Chen', 'North America', TRUE),
(44, 'Video Production Co', 'Small', 'Media', '2024-04-10', 'Sarah Johnson', 'North America', TRUE),
(45, 'SaaS Platform Builder', 'Medium', 'Software', '2024-04-20', 'Emily Rodriguez', 'North America', TRUE),
(46, 'Cybersecurity Experts', 'Enterprise', 'Security', '2024-05-01', 'Michael Chen', 'North America', TRUE),
(47, 'Nonprofit Solutions', 'Small', 'Nonprofit', '2024-05-10', 'Sarah Johnson', 'North America', TRUE),
(48, 'Government Tech', 'Enterprise', 'Government', '2024-05-20', 'Emily Rodriguez', 'North America', TRUE),
(49, 'Wellness & Fitness', 'Small', 'Health & Wellness', '2024-06-01', 'Michael Chen', 'Europe', TRUE),
(50, 'Blockchain Ventures', 'Medium', 'Technology', '2024-06-10', 'Sarah Johnson', 'Asia Pacific', TRUE);

-- ============================================
-- Insert Subscriptions
-- ============================================
-- Active subscriptions
INSERT INTO subscriptions (subscription_id, customer_id, plan_name, plan_mrr, start_date, end_date, subscription_status, cancellation_reason) VALUES
(1, 1, 'Enterprise', 5000.00, '2023-01-15', NULL, 'Active', NULL),
(2, 2, 'Starter', 500.00, '2023-01-20', NULL, 'Active', NULL),
(3, 3, 'Enterprise', 7500.00, '2023-02-01', NULL, 'Active', NULL),
(4, 4, 'Professional', 2000.00, '2023-02-10', NULL, 'Active', NULL),
(6, 6, 'Starter', 500.00, '2023-03-01', NULL, 'Active', NULL),
(7, 7, 'Enterprise', 6000.00, '2023-03-10', NULL, 'Active', NULL),
(8, 8, 'Professional', 2500.00, '2023-03-20', NULL, 'Active', NULL),
(9, 9, 'Starter', 500.00, '2023-04-01', NULL, 'Active', NULL),
(10, 10, 'Enterprise', 8000.00, '2023-04-15', NULL, 'Active', NULL),
(11, 11, 'Professional', 2000.00, '2023-05-01', NULL, 'Active', NULL),
(13, 13, 'Enterprise', 6500.00, '2023-05-20', NULL, 'Active', NULL),
(14, 14, 'Starter', 500.00, '2023-06-01', NULL, 'Active', NULL),
(15, 15, 'Enterprise', 9000.00, '2023-06-10', NULL, 'Active', NULL),
(16, 16, 'Professional', 3000.00, '2023-06-20', NULL, 'Active', NULL),
(17, 17, 'Starter', 500.00, '2023-07-01', NULL, 'Active', NULL),
(18, 18, 'Enterprise', 7000.00, '2023-07-15', NULL, 'Active', NULL),
(19, 19, 'Professional', 2500.00, '2023-07-25', NULL, 'Active', NULL),
(20, 20, 'Starter', 500.00, '2023-08-01', NULL, 'Active', NULL),
(21, 21, 'Enterprise', 7500.00, '2023-08-10', NULL, 'Active', NULL),
(22, 22, 'Professional', 2000.00, '2023-08-20', NULL, 'Active', NULL),
(24, 24, 'Professional', 2500.00, '2023-09-10', NULL, 'Active', NULL),
(25, 25, 'Starter', 500.00, '2023-09-20', NULL, 'Active', NULL),
(26, 26, 'Professional', 2000.00, '2023-10-01', NULL, 'Active', NULL),
(27, 27, 'Starter', 500.00, '2023-10-10', NULL, 'Active', NULL),
(28, 28, 'Enterprise', 6000.00, '2023-10-20', NULL, 'Active', NULL),
(29, 29, 'Enterprise', 8500.00, '2023-11-01', NULL, 'Active', NULL),
(30, 30, 'Professional', 3000.00, '2023-11-10', NULL, 'Active', NULL),
(31, 31, 'Enterprise', 9500.00, '2023-11-20', NULL, 'Active', NULL),
(32, 32, 'Starter', 500.00, '2023-12-01', NULL, 'Active', NULL),
(33, 33, 'Professional', 2500.00, '2023-12-10', NULL, 'Active', NULL),
(34, 34, 'Professional', 2000.00, '2024-01-05', NULL, 'Active', NULL),
(35, 35, 'Enterprise', 10000.00, '2024-01-15', NULL, 'Active', NULL),
(36, 36, 'Starter', 500.00, '2024-01-25', NULL, 'Active', NULL),
(37, 37, 'Professional', 3000.00, '2024-02-01', NULL, 'Active', NULL),
(38, 38, 'Starter', 500.00, '2024-02-10', NULL, 'Active', NULL),
(39, 39, 'Enterprise', 8000.00, '2024-02-20', NULL, 'Active', NULL),
(40, 40, 'Professional', 2500.00, '2024-03-01', NULL, 'Active', NULL),
(41, 41, 'Professional', 3000.00, '2024-03-10', NULL, 'Active', NULL),
(42, 42, 'Starter', 500.00, '2024-03-20', NULL, 'Active', NULL),
(43, 43, 'Enterprise', 9000.00, '2024-04-01', NULL, 'Active', NULL),
(44, 44, 'Starter', 500.00, '2024-04-10', NULL, 'Active', NULL),
(45, 45, 'Professional', 2500.00, '2024-04-20', NULL, 'Active', NULL),
(46, 46, 'Enterprise', 10000.00, '2024-05-01', NULL, 'Active', NULL),
(47, 47, 'Starter', 500.00, '2024-05-10', NULL, 'Active', NULL),
(48, 48, 'Enterprise', 11000.00, '2024-05-20', NULL, 'Active', NULL),
(49, 49, 'Starter', 500.00, '2024-06-01', NULL, 'Active', NULL),
(50, 50, 'Professional', 3000.00, '2024-06-10', NULL, 'Active', NULL);

-- Churned subscriptions
INSERT INTO subscriptions (subscription_id, customer_id, plan_name, plan_mrr, start_date, end_date, subscription_status, cancellation_reason) VALUES
(5, 5, 'Professional', 2000.00, '2023-02-15', '2023-11-15', 'Churned', 'Budget constraints'),
(12, 12, 'Professional', 2500.00, '2023-05-10', '2024-02-10', 'Churned', 'Switched to competitor'),
(23, 23, 'Starter', 500.00, '2023-09-01', '2024-04-01', 'Churned', 'No longer needed');

-- Upgraded subscriptions (show progression)
INSERT INTO subscriptions (subscription_id, customer_id, plan_name, plan_mrr, start_date, end_date, subscription_status, cancellation_reason) VALUES
(51, 4, 'Starter', 500.00, '2023-02-10', '2023-08-10', 'Cancelled', 'Upgraded to Professional'),
(52, 16, 'Starter', 500.00, '2023-06-20', '2024-01-20', 'Cancelled', 'Upgraded to Professional'),
(53, 30, 'Starter', 500.00, '2023-11-10', '2024-05-10', 'Cancelled', 'Upgraded to Professional');

-- ============================================
-- Insert Revenue Events
-- ============================================
-- Initial New MRR events
INSERT INTO revenue_events (event_id, customer_id, event_date, event_type, mrr_change, mrr_total, plan_name) VALUES
(1, 1, '2023-01-15', 'New', 5000.00, 5000.00, 'Enterprise'),
(2, 2, '2023-01-20', 'New', 500.00, 500.00, 'Starter'),
(3, 3, '2023-02-01', 'New', 7500.00, 7500.00, 'Enterprise'),
(4, 4, '2023-02-10', 'New', 500.00, 500.00, 'Starter'),
(5, 5, '2023-02-15', 'New', 2000.00, 2000.00, 'Professional'),
(6, 6, '2023-03-01', 'New', 500.00, 500.00, 'Starter'),
(7, 7, '2023-03-10', 'New', 6000.00, 6000.00, 'Enterprise'),
(8, 8, '2023-03-20', 'New', 2500.00, 2500.00, 'Professional'),
(9, 9, '2023-04-01', 'New', 500.00, 500.00, 'Starter'),
(10, 10, '2023-04-15', 'New', 8000.00, 8000.00, 'Enterprise'),
(11, 11, '2023-05-01', 'New', 2000.00, 2000.00, 'Professional'),
(12, 12, '2023-05-10', 'New', 2500.00, 2500.00, 'Professional'),
(13, 13, '2023-05-20', 'New', 6500.00, 6500.00, 'Enterprise'),
(14, 14, '2023-06-01', 'New', 500.00, 500.00, 'Starter'),
(15, 15, '2023-06-10', 'New', 9000.00, 9000.00, 'Enterprise'),
(16, 16, '2023-06-20', 'New', 500.00, 500.00, 'Starter'),
(17, 17, '2023-07-01', 'New', 500.00, 500.00, 'Starter'),
(18, 18, '2023-07-15', 'New', 7000.00, 7000.00, 'Enterprise'),
(19, 19, '2023-07-25', 'New', 2500.00, 2500.00, 'Professional'),
(20, 20, '2023-08-01', 'New', 500.00, 500.00, 'Starter');

-- Expansion events (upgrades)
INSERT INTO revenue_events (event_id, customer_id, event_date, event_type, mrr_change, mrr_total, plan_name) VALUES
(100, 4, '2023-08-10', 'Expansion', 1500.00, 2000.00, 'Professional'),
(101, 16, '2024-01-20', 'Expansion', 2500.00, 3000.00, 'Professional'),
(102, 30, '2024-05-10', 'Expansion', 2500.00, 3000.00, 'Professional'),
(103, 1, '2024-01-01', 'Expansion', 2000.00, 7000.00, 'Enterprise'),
(104, 3, '2024-03-01', 'Expansion', 1500.00, 9000.00, 'Enterprise');

-- Churn events
INSERT INTO revenue_events (event_id, customer_id, event_date, event_type, mrr_change, mrr_total, plan_name) VALUES
(200, 5, '2023-11-15', 'Churn', -2000.00, 0.00, 'Professional'),
(201, 12, '2024-02-10', 'Churn', -2500.00, 0.00, 'Professional'),
(202, 23, '2024-04-01', 'Churn', -500.00, 0.00, 'Starter');

-- Additional new customers
INSERT INTO revenue_events (event_id, customer_id, event_date, event_type, mrr_change, mrr_total, plan_name) VALUES
(21, 21, '2023-08-10', 'New', 7500.00, 7500.00, 'Enterprise'),
(22, 22, '2023-08-20', 'New', 2000.00, 2000.00, 'Professional'),
(23, 23, '2023-09-01', 'New', 500.00, 500.00, 'Starter'),
(24, 24, '2023-09-10', 'New', 2500.00, 2500.00, 'Professional'),
(25, 25, '2023-09-20', 'New', 500.00, 500.00, 'Starter'),
(26, 26, '2023-10-01', 'New', 2000.00, 2000.00, 'Professional'),
(27, 27, '2023-10-10', 'New', 500.00, 500.00, 'Starter'),
(28, 28, '2023-10-20', 'New', 6000.00, 6000.00, 'Enterprise'),
(29, 29, '2023-11-01', 'New', 8500.00, 8500.00, 'Enterprise'),
(30, 30, '2023-11-10', 'New', 500.00, 500.00, 'Starter'),
(31, 31, '2023-11-20', 'New', 9500.00, 9500.00, 'Enterprise'),
(32, 32, '2023-12-01', 'New', 500.00, 500.00, 'Starter'),
(33, 33, '2023-12-10', 'New', 2500.00, 2500.00, 'Professional'),
(34, 34, '2024-01-05', 'New', 2000.00, 2000.00, 'Professional'),
(35, 35, '2024-01-15', 'New', 10000.00, 10000.00, 'Enterprise'),
(36, 36, '2024-01-25', 'New', 500.00, 500.00, 'Starter'),
(37, 37, '2024-02-01', 'New', 3000.00, 3000.00, 'Professional'),
(38, 38, '2024-02-10', 'New', 500.00, 500.00, 'Starter'),
(39, 39, '2024-02-20', 'New', 8000.00, 8000.00, 'Enterprise'),
(40, 40, '2024-03-01', 'New', 2500.00, 2500.00, 'Professional'),
(41, 41, '2024-03-10', 'New', 3000.00, 3000.00, 'Professional'),
(42, 42, '2024-03-20', 'New', 500.00, 500.00, 'Starter'),
(43, 43, '2024-04-01', 'New', 9000.00, 9000.00, 'Enterprise'),
(44, 44, '2024-04-10', 'New', 500.00, 500.00, 'Starter'),
(45, 45, '2024-04-20', 'New', 2500.00, 2500.00, 'Professional'),
(46, 46, '2024-05-01', 'New', 10000.00, 10000.00, 'Enterprise'),
(47, 47, '2024-05-10', 'New', 500.00, 500.00, 'Starter'),
(48, 48, '2024-05-20', 'New', 11000.00, 11000.00, 'Enterprise'),
(49, 49, '2024-06-01', 'New', 500.00, 500.00, 'Starter'),
(50, 50, '2024-06-10', 'New', 3000.00, 3000.00, 'Professional');

-- ============================================
-- Insert Product Usage Data
-- Sample monthly usage for select customers
-- ============================================
INSERT INTO product_usage (usage_id, customer_id, usage_date, logins_count, features_used, total_features, active_users, licensed_users, api_calls) VALUES
-- High engagement customer (Customer 1)
(1, 1, '2023-02-01', 150, 9, 10, 45, 50, 5000),
(2, 1, '2023-03-01', 165, 10, 10, 48, 50, 5500),
(3, 1, '2023-04-01', 160, 10, 10, 47, 50, 5200),
(4, 1, '2023-05-01', 170, 10, 10, 49, 50, 5800),
(5, 1, '2023-06-01', 158, 9, 10, 46, 50, 5100),
-- Medium engagement (Customer 4)
(10, 4, '2023-03-01', 80, 7, 10, 15, 20, 1500),
(11, 4, '2023-04-01', 85, 7, 10, 16, 20, 1600),
(12, 4, '2023-05-01', 90, 8, 10, 17, 20, 1800),
(13, 4, '2023-06-01', 95, 8, 10, 18, 20, 2000),
-- Low engagement / at-risk (Customer 2)
(20, 2, '2023-02-01', 15, 3, 10, 2, 5, 200),
(21, 2, '2023-03-01', 12, 3, 10, 2, 5, 150),
(22, 2, '2023-04-01', 10, 2, 10, 1, 5, 100),
(23, 2, '2023-05-01', 8, 2, 10, 1, 5, 80),
-- Enterprise customer with good adoption (Customer 3)
(30, 3, '2023-03-01', 200, 10, 10, 75, 100, 8000),
(31, 3, '2023-04-01', 210, 10, 10, 80, 100, 8500),
(32, 3, '2023-05-01', 215, 10, 10, 82, 100, 9000),
(33, 3, '2023-06-01', 220, 10, 10, 85, 100, 9200),
-- Recently churned customer - declining engagement before churn (Customer 5)
(40, 5, '2023-03-01', 60, 6, 10, 10, 15, 800),
(41, 5, '2023-04-01', 55, 6, 10, 9, 15, 750),
(42, 5, '2023-05-01', 45, 5, 10, 8, 15, 600),
(43, 5, '2023-06-01', 35, 4, 10, 6, 15, 400),
(44, 5, '2023-07-01', 25, 3, 10, 5, 15, 250),
(45, 5, '2023-08-01', 20, 3, 10, 4, 15, 200),
(46, 5, '2023-09-01', 15, 2, 10, 3, 15, 150),
(47, 5, '2023-10-01', 10, 2, 10, 2, 15, 100);

-- ============================================
-- Insert Support Tickets
-- ============================================
INSERT INTO support_tickets (ticket_id, customer_id, ticket_date, priority, status, resolution_days, category) VALUES
-- Customer with good support experience
(1, 1, '2023-02-01', 'Medium', 'Closed', 2, 'How-To'),
(2, 1, '2023-03-15', 'Low', 'Closed', 1, 'Feature Request'),
(3, 1, '2023-05-20', 'High', 'Closed', 3, 'Technical Issue'),
-- Customer with poor support experience (contributed to churn)
(10, 5, '2023-04-10', 'High', 'Closed', 7, 'Bug'),
(11, 5, '2023-05-15', 'Critical', 'Closed', 10, 'Bug'),
(12, 5, '2023-06-20', 'High', 'Closed', 8, 'Technical Issue'),
(13, 5, '2023-07-10', 'Medium', 'Closed', 5, 'Bug'),
(14, 5, '2023-08-05', 'Critical', 'Closed', 12, 'Technical Issue'),
-- Customer with moderate support needs
(20, 4, '2023-03-05', 'Low', 'Closed', 2, 'How-To'),
(21, 4, '2023-04-12', 'Medium', 'Closed', 3, 'Feature Request'),
(22, 4, '2023-06-18', 'Medium', 'Closed', 4, 'Technical Issue'),
-- High-value customer with minimal issues
(30, 3, '2023-03-10', 'Low', 'Closed', 1, 'How-To'),
(31, 3, '2023-05-22', 'Medium', 'Closed', 2, 'Feature Request'),
-- Additional tickets for various customers
(40, 7, '2023-04-05', 'High', 'Closed', 4, 'Bug'),
(41, 10, '2023-05-10', 'Medium', 'Closed', 3, 'Technical Issue'),
(42, 15, '2023-07-15', 'Low', 'Closed', 1, 'How-To'),
(43, 18, '2023-08-20', 'Critical', 'Closed', 5, 'Bug'),
(44, 21, '2023-09-10', 'Medium', 'Closed', 2, 'Feature Request');

-- ============================================
-- Insert Customer Health Scores
-- ============================================
INSERT INTO customer_health_scores (health_id, customer_id, score_date, health_score, engagement_score, support_score, adoption_score, risk_level) VALUES
-- High health customer
(1, 1, '2023-03-01', 92.5, 95.0, 90.0, 92.0, 'Low'),
(2, 1, '2023-04-01', 93.0, 96.0, 91.0, 92.0, 'Low'),
(3, 1, '2023-05-01', 91.5, 94.0, 89.0, 92.0, 'Low'),
(4, 1, '2023-06-01', 92.0, 95.0, 90.0, 91.0, 'Low'),
-- Medium health customer
(10, 4, '2023-03-01', 75.0, 78.0, 72.0, 75.0, 'Medium'),
(11, 4, '2023-04-01', 76.5, 80.0, 73.0, 76.0, 'Medium'),
(12, 4, '2023-05-01', 78.0, 82.0, 74.0, 78.0, 'Medium'),
(13, 4, '2023-06-01', 80.0, 85.0, 75.0, 80.0, 'Low'),
-- Declining health / at-risk customer
(20, 2, '2023-03-01', 55.0, 45.0, 65.0, 50.0, 'High'),
(21, 2, '2023-04-01', 52.0, 42.0, 62.0, 48.0, 'High'),
(22, 2, '2023-05-01', 48.0, 38.0, 58.0, 45.0, 'High'),
(23, 2, '2023-06-01', 45.0, 35.0, 55.0, 42.0, 'High'),
-- Customer heading toward churn
(30, 5, '2023-03-01', 68.0, 70.0, 66.0, 68.0, 'Medium'),
(31, 5, '2023-04-01', 64.0, 65.0, 63.0, 64.0, 'Medium'),
(32, 5, '2023-05-01', 58.0, 58.0, 58.0, 58.0, 'High'),
(33, 5, '2023-06-01', 52.0, 50.0, 54.0, 52.0, 'High'),
(34, 5, '2023-07-01', 48.0, 45.0, 51.0, 48.0, 'High'),
(35, 5, '2023-08-01', 42.0, 38.0, 46.0, 42.0, 'High'),
(36, 5, '2023-09-01', 38.0, 32.0, 44.0, 38.0, 'High'),
(37, 5, '2023-10-01', 35.0, 28.0, 42.0, 35.0, 'High'),
-- High-value enterprise customer
(40, 3, '2023-03-01', 88.0, 92.0, 84.0, 88.0, 'Low'),
(41, 3, '2023-04-01', 89.0, 93.0, 85.0, 89.0, 'Low'),
(42, 3, '2023-05-01', 90.0, 94.0, 86.0, 90.0, 'Low'),
(43, 3, '2023-06-01', 91.0, 95.0, 87.0, 91.0, 'Low');

-- ============================================
-- Data insertion complete
-- ============================================
-- Summary:
-- - 50 customers across various industries and company sizes
-- - Mix of active, churned, and upgraded subscriptions
-- - Revenue events tracking new MRR, expansions, and churn
-- - Product usage data showing varying engagement levels
-- - Support tickets with different priorities and resolution times
-- - Customer health scores tracking over time
-- ============================================
