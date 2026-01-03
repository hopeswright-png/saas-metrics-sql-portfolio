-- ============================================
-- SaaS Metrics Database Schema
-- ============================================
-- This schema models a subscription-based SaaS business
-- with tables for tracking customers, subscriptions, revenue,
-- product usage, support, and customer health.
-- ============================================

-- Drop tables if they exist (for clean reruns)
DROP TABLE IF EXISTS customer_health_scores;
DROP TABLE IF EXISTS support_tickets;
DROP TABLE IF EXISTS product_usage;
DROP TABLE IF EXISTS revenue_events;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS customers;

-- ============================================
-- Table: customers
-- Stores customer account information
-- ============================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    company_size VARCHAR(20), -- 'Small', 'Medium', 'Enterprise'
    industry VARCHAR(50),
    signup_date DATE NOT NULL,
    account_owner VARCHAR(100),
    region VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: subscriptions
-- Tracks subscription lifecycle events
-- ============================================
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    plan_name VARCHAR(50) NOT NULL, -- 'Starter', 'Professional', 'Enterprise'
    plan_mrr DECIMAL(10, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE, -- NULL if active
    subscription_status VARCHAR(20) NOT NULL, -- 'Active', 'Cancelled', 'Churned'
    cancellation_reason VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================
-- Table: revenue_events
-- Monthly recurring revenue tracking
-- ============================================
CREATE TABLE revenue_events (
    event_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(20) NOT NULL, -- 'New', 'Expansion', 'Contraction', 'Churn', 'Reactivation'
    mrr_change DECIMAL(10, 2) NOT NULL,
    mrr_total DECIMAL(10, 2) NOT NULL,
    plan_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================
-- Table: product_usage
-- Feature adoption and engagement metrics
-- ============================================
CREATE TABLE product_usage (
    usage_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    usage_date DATE NOT NULL,
    logins_count INT DEFAULT 0,
    features_used INT DEFAULT 0,
    total_features INT DEFAULT 10,
    active_users INT DEFAULT 0,
    licensed_users INT DEFAULT 0,
    api_calls INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================
-- Table: support_tickets
-- Customer support interaction history
-- ============================================
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    ticket_date DATE NOT NULL,
    priority VARCHAR(20), -- 'Low', 'Medium', 'High', 'Critical'
    status VARCHAR(20), -- 'Open', 'In Progress', 'Resolved', 'Closed'
    resolution_days INT,
    category VARCHAR(50), -- 'Bug', 'Feature Request', 'How-To', 'Technical Issue'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================
-- Table: customer_health_scores
-- Calculated health metrics over time
-- ============================================
CREATE TABLE customer_health_scores (
    health_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    score_date DATE NOT NULL,
    health_score DECIMAL(5, 2), -- 0-100 scale
    engagement_score DECIMAL(5, 2),
    support_score DECIMAL(5, 2),
    adoption_score DECIMAL(5, 2),
    risk_level VARCHAR(20), -- 'Low', 'Medium', 'High'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================
-- Create indexes for query performance
-- ============================================
CREATE INDEX idx_subscriptions_customer ON subscriptions(customer_id);
CREATE INDEX idx_subscriptions_dates ON subscriptions(start_date, end_date);
CREATE INDEX idx_revenue_customer ON revenue_events(customer_id);
CREATE INDEX idx_revenue_date ON revenue_events(event_date);
CREATE INDEX idx_usage_customer ON product_usage(customer_id);
CREATE INDEX idx_usage_date ON product_usage(usage_date);
CREATE INDEX idx_tickets_customer ON support_tickets(customer_id);
CREATE INDEX idx_health_customer ON customer_health_scores(customer_id);
CREATE INDEX idx_health_date ON customer_health_scores(score_date);

-- ============================================
-- Schema created successfully
-- ============================================
