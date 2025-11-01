-- Initial query with performance analysis
EXPLAIN ANALYZE
SELECT
    b.booking_id, b.status, b.total_price, b.start_date,
    u.user_id, u.first_name, u.last_name, u.email,
    p.property_id, p.location AS property_location, p.name AS property_name, p.price_per_night,
    h.user_id AS host_id, (h.first_name || ' ' || h.last_name) AS host_name,
    pay.payment_id, pay.amount, pay.payment_method, pay.payment_date
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN "User" h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC
LIMIT 100;

-- Optimized query with WHERE clause for better performance
EXPLAIN ANALYZE
SELECT
    b.booking_id, b.status, b.total_price, b.start_date,
    u.user_id, u.first_name, u.last_name, u.email,
    p.property_id, p.location AS property_location, p.name AS property_name, p.price_per_night,
    h.user_id AS host_id, (h.first_name || ' ' || h.last_name) AS host_name,
    pay.payment_id, pay.amount, pay.payment_method, pay.payment_date
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN "User" h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date > '2025-10-01' AND p.price_per_night > 50
ORDER BY b.start_date DESC
LIMIT 100;
