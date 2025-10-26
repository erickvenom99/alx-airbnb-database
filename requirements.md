# Database Specification - AirBnB Clone

This document details the entities, attributes, constraints, and indexing requirements for the AirBnB clone relational database schema.


## 1. Entities and Attributes

### User

| Attribute | Data Type & Constraints | Notes |
| :--- | :--- | :--- |
| user_id | Primary Key, UUID, Indexed | Unique identifier for the user. |
| **first_name | VARCHAR, NOT NULL | |
| last_name | VARCHAR, NOT NULL | |
| email | VARCHAR, UNIQUE, NOT NULL | Must be unique across all users. |
| password_hash | VARCHAR, NOT NULL | Stores hashed password for security. |
| phone_number | VARCHAR, NULL | Optional contact number. |
| role | ENUM (guest, host, admin), NOT NULL | Defines user privileges. |
| created_at | TIMESTAMP, DEFAULT CURRENT_TIMESTAMP | |

### Property

| Attribute | Data Type & Constraints | Notes |
| :--- | :--- | :--- |
| property_id | Primary Key, UUID, Indexed | Unique identifier for the property. |
| host_id | Foreign Key, references User(user_id) | Links property to the host. |
| name | VARCHAR, NOT NULL | |
| description | TEXT, NOT NULL | |
| location | VARCHAR, NOT NULL | City/general area. |
| pricepernight | DECIMAL, NOT NULL | Daily rental rate. |
| created_at | TIMESTAMP, DEFAULT CURRENT_TIMESTAMP | |
| updated_at | TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP | Automatically updated on change. |

### Booking

| Attribute | Data Type & Constraints | Notes |
| :--- | :--- | :--- |
| booking_id | Primary Key, UUID, Indexed | Unique identifier for the booking. |
| property_id | Foreign Key, references Property(property_id) | The property being reserved. |
| user_id | Foreign Key, references User(user_id) | The guest making the reservation. |
| start_date | DATE, NOT NULL | |
| end_date | DATE, NOT NULL | |
| total_price | DECIMAL, NOT NULL | Final calculated price. |
| status | ENUM (pending, confirmed, canceled), NOT NULL | Current state of the booking. |
| created_at | TIMESTAMP, DEFAULT CURRENT_TIMESTAMP | |

### Payment

| Attribute | Data Type & Constraints | Notes |
| :--- | :--- | :--- |
| payment_id | Primary Key, UUID, Indexed | Unique identifier for the payment record. |
| booking_id | Foreign Key, references Booking(booking_id) | Payment must be linked to a valid booking. |
| amount | DECIMAL, NOT NULL | Amount paid. |
| payment_date | TIMESTAMP, DEFAULT CURRENT_TIMESTAMP | |
| payment_method | ENUM (credit_card, paypal, stripe), NOT NULL | Method used for payment. |

### Review

| Attribute | Data Type & Constraints | Notes |
| :--- | :--- | :--- |
| review_id | Primary Key, UUID, Indexed | Unique identifier for the review. |
| property_id | Foreign Key, references Property(property_id) | The property reviewed. |
| user_id | Foreign Key, references User(user_id) | The user who wrote the review. |
| rating | INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL | Rating score (1 to 5). |
| comment | TEXT, NOT NULL | Review text. |
| created_at | TIMESTAMP, DEFAULT CURRENT_TIMESTAMP | |

### Message

| Attribute | Data Type & Constraints | Notes |
| :--- | :--- | :--- |
| message_id | Primary Key, UUID, Indexed | Unique identifier for the message. |
| sender_id | Foreign Key, references User(user_id) | The user sending the message. |
| recipient_id | Foreign Key, references User(user_id) | The user receiving the message. |
| message_body | TEXT, NOT NULL | Content of the message. |
| sent_at | TIMESTAMP, DEFAULT CURRENT_TIMESTAMP | |


## 2. Constraints

This section highlights key integrity rules beyond simple data types and NULL constraints.

* User Table: Enforces a Unique constraint on `email`.
* Booking Table: `status` must be one of the enumerated values: `pending`, `confirmed`, or `canceled`.
* Review Table: Enforces a CHECK constraint ensuring `rating` is between 1 and 5.


## 3. Indexing for Performance

In addition to Primary Keys (which are automatically indexed), the following columns require dedicated indexes for optimal search and join performance:

* User Table: `email`
* Property Table: `host_id`
* Booking Table: `property_id`, `user_id`
* Payment Table: `booking_id`
* Message Table: `sender_id`, `recipient_id`