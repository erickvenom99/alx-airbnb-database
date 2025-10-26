-- Enable pgcrypto for UUID generation
CREATE EXTENSION IF NOT EXISTS pgcrypto;

BEGIN;

-- Insert Users
INSERT INTO "User" (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('Alice', 'Johnson', 'alice@example.com', 'hashed_pw_1', '1234567890', 'guest'),
('Bob', 'Smith', 'bob@example.com', 'hashed_pw_2', '2345678901', 'host'),
('Carol', 'Lee', 'carol@example.com', 'hashed_pw_3', '3456789012', 'admin'),
('David', 'Brown', 'david@example.com', 'hashed_pw_4', '4567890123', 'guest');

-- Insert Properties
INSERT INTO Property (host_id, name, description, location, price_per_night)
SELECT user_id, 'Cozy Cottage', 'A peaceful retreat in the countryside.', 'Rivers State, Nigeria', 75.00
FROM "User" WHERE email = 'bob@example.com';

INSERT INTO Property (host_id, name, description, location, price_per_night)
SELECT user_id, 'Urban Loft', 'Modern apartment in the city center.', 'Lagos, Nigeria', 120.00
FROM "User" WHERE email = 'bob@example.com';

-- Insert Bookings
INSERT INTO Booking (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id, u.user_id, '2025-11-01', '2025-11-05', 300.00, 'confirmed'
FROM Property p, "User" u
WHERE p.name = 'Cozy Cottage' AND u.email = 'alice@example.com';

INSERT INTO Booking (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id, u.user_id, '2025-12-10', '2025-12-15', 600.00, 'pending'
FROM Property p, "User" u
WHERE p.name = 'Urban Loft' AND u.email = 'david@example.com';

-- Insert Payments
INSERT INTO Payment (booking_id, amount, payment_method)
SELECT b.booking_id, b.total_price, 'credit_card'
FROM Booking b
WHERE b.status = 'confirmed';

INSERT INTO Payment (booking_id, amount, payment_method)
SELECT b.booking_id, b.total_price, 'paypal'
FROM Booking b
WHERE b.status = 'pending';

-- Insert Reviews
INSERT INTO Reviews (property_id, user_id, rating, comment)
SELECT p.property_id, u.user_id, 5, 'Absolutely loved the stay!'
FROM Property p, "User" u
WHERE p.name = 'Cozy Cottage' AND u.email = 'alice@example.com';

INSERT INTO Reviews (property_id, user_id, rating, comment)
SELECT p.property_id, u.user_id, 4, 'Great location and amenities.'
FROM Property p, "User" u
WHERE p.name = 'Urban Loft' AND u.email = 'david@example.com';

-- Insert Messages
INSERT INTO Message (sender_id, recipient_id, message_body)
SELECT s.user_id, r.user_id, 'Hi Bob, is the cottage available in December?'
FROM "User" s, "User" r
WHERE s.email = 'alice@example.com' AND r.email = 'bob@example.com';

INSERT INTO Message (sender_id, recipient_id, message_body)
SELECT s.user_id, r.user_id, 'Yes, it is available. Let me know your dates.'
FROM "User" s, "User" r
WHERE s.email = 'bob@example.com' AND r.email = 'alice@example.com';

COMMIT;