                                Database Normalization Principles
This document confirms that the schema for the AirBnB Clone database adheres to the first three levels of database normalization (1NF, 2NF, and 3NF).

1. First Normal Form (1NF)
The schema complies with 1NF by ensuring:

Atomic Values & Consistent Data Types: Data types are consistent within each column (e.g., VARCHAR for names, UUID for IDs, DATE for dates), and no mixed data types are present.

Unique Identification (Primary Keys): Every entity table has a dedicated, unique primary key, which serves as a unique identifier for each row:

user_id, property_id, booking_id, payment_id, message_id, and review_id.

No Repeating Groups: All attributes are single-valued, and no column contains lists or nested tables.

2. Second Normal Form (2NF)
The schema complies with 2NF by ensuring:

1NF Requirement Met: The database is already in 1NF.

Elimination of Partial Dependencies: Every non-key column is fully dependent on the entire primary key.

Strategy: We avoided composite primary keys in core transactional tables. For instance, instead of using a composite key like (user_id, property_id) for the Booking table, we assigned a single, surrogate primary key (booking_id).

Result: This structure guarantees that every attribute (e.g., start_date, total_price) depends on the single primary key (booking_id), thereby eliminating any possibility of partial dependency.

3. Third Normal Form (3NF)
The schema complies with 3NF by ensuring:

2NF Requirement Met: The database is already in 2NF.

Elimination of Transitive Dependencies: No non-key attribute is dependent on another non-key attribute (i.e., every column must depend only on the primary key).

Verification by Entity:

Message Table: The attributes (sender_id, receiver_id, message_body, sent_at) all depend directly on the primary key (message_id) and not on each other.

User, Property, Booking, Payment, and Review Tables: The same principle is applied across the entire ERD. For example, in the Review table, rating and comment both directly describe the review_id and are not transitively dependent on any other non-key column like user_id or property_id.