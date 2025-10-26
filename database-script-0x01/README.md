# 0x01: Database Schema Definition For AirBnB clone (PostgreSQL)

## Objective 
To translate Data Model specification for AirBnB to a database schema using SQL AND DDL. The script
contains all required entities, primary keys, foreign Keys, Constraints and performance indexes for the entire application Model

## Files

| File | Description |
| :--- | :--- |
| schema.sql | Contains all CREATE TYPE, CREATE TABLE, and CREATE INDEX statements to fully define the database structure. |
| README.md | This documentation file. |


## Implementation Details

### Technology Stack

* SQL Dialect: PostgreSQL
* Key Data Types: UUID (for all primary keys), NUMERIC (for currency).

### Key Constraints Implemented

* Primary Keys (PK) & Foreign Keys (FK): All entity relationships (1:M, 1:1) are enforced via FK constraints.
* Uniqueness: email in the User table is constrained to be unique.
* Check Constraints: The rating column in the Review table is restricted to values between 1 and 5.
and to restrict values in the role, status, and payment_method columns to predefined lists.

### Performance Indexing

To ensure optimal query performance, especially for common lookup and join operations, the following columns are explicitly indexed:

* User.email
* Property.host_id
* Booking.property_id
* Booking.user_id
* Payment.booking_id
* Message.sender_id, Message.recipient_id

##  Execution Instructions

To deploy this schema, you must have PostgreSQL installed and running (e.g., on a local machine or WSL).

### 1. Database Setup

First, create the target database in your PostgreSQL environment:

```bash
# Execute this as the postgres system user or use the -U flag with password
sudo -i -u postgres
createdb airbnb_clone_db
exit