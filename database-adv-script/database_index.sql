-- Property table indexes
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);

-- Booking table indexes (already exists from previous)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Reviews table indexes
CREATE INDEX idx_review_property_id ON Reviews(property_id);
CREATE INDEX idx_reviews_user_id ON Reviews(user_id);

-- User table (already has automatic index on email)
-- No additional index needed

-- Message table indexes
CREATE INDEX idx_messages_sender_id ON Message(sender_id);
CREATE INDEX idx_messages_recipient_id ON Message(recipient_id);

CREATE INDEX idx_booking_start_date ON Booking(start_date DESC);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property(host_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);