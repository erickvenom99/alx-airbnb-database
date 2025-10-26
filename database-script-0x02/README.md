
0x02: Database Seeding (Sample Data Population)

Objective
The goal of this task is to populate the PostgreSQL database schema defined in the previous task (0x01) with realistic sample data. This process ensures the database is functional for testing queries, relationships, and application logic.

Files
Data Strategy & Integrity
Key Data Scenarios Covered
The sample data reflects common real-world usage patterns:

Users: Includes an Admin, a Host (who also acts as a Guest), and a dedicated Guest.

Properties: Listings are owned by the Host user.

Bookings: Includes a confirmed booking, a pending booking, and a canceled booking to test all status enumerations.

Relationships: All foreign key constraints are honored. For example, a Payment record exists only for the Confirmed booking.

Communication: Includes a two-way message exchange between the Host and a Guest.

Reviews: A review is provided by the Guest for a specific Property.

UUID Handling
All primary keys (user_id, property_id, etc.) are generated as valid UUIDs within the seed.sql script to match the schema definition.

 Execution Instructions
Prerequisite: The schema must be fully deployed using the schema.sql script from the 0x01 directory before running this seed script.

1. Execute the Seed Script
Execute the seed.sql script against your airbnb_clone_db.

Note: As established previously, it is safest to execute this command while logged in as the trusted postgres system user to avoid authentication errors.

2. Data Verification
After execution, connect to the database to ensure the data was loaded correctly and relationships are intact.

Run the following queries inside the psql prompt (airbnb_clone_db=#)