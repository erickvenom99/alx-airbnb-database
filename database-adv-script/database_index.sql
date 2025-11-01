-- Measure performance before index creation
-- Query to find properties with average rating > 4.0
EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM Property p
JOIN Reviews r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) > 4.0;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property(host_id);
CREATE INDEX IF NOT EXISTS idx_property_location ON Property(location);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON Booking(start_date DESC);
CREATE INDEX IF NOT EXISTS idx_review_property_id ON Reviews(property_id);
CREATE INDEX IF NOT EXISTS idx_reviews_user_id ON Reviews(user_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX IF NOT EXISTS idx_messages_sender_id ON Message(sender_id);
CREATE INDEX IF NOT EXISTS idx_messages_recipient_id ON Message(recipient_id);

-- Measure performance after index creation
-- Query to find properties with average rating > 4.0
EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM Property p
JOIN Reviews r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) > 4.0;
