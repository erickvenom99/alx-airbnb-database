-- Query 1: INNER JOIN - All bookings with their users
SELECT
    b.booking_id,
    b.property_id,
    b.user_id,
    b.status,
    b.total_price,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    u.email
FROM
    Booking b
INNER JOIN
    "User" u ON b.user_id = u.user_id
ORDER BY
    b.created_at DESC;

-- Query 2: LEFT JOIN - All properties with their reviews (including properties with no reviews)
SELECT
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    u.first_name AS reviewer_first_name,
    u.last_name AS reviewer_last_name
FROM
    Property p
LEFT JOIN
    Reviews r ON p.property_id = r.property_id
LEFT JOIN
    "User" u ON r.user_id = u.user_id
ORDER BY
    p.name, r.created_at DESC;

-- Query 3: FULL OUTER JOIN - All users and all bookings
SELECT
    COALESCE(u.user_id, b.user_id) AS user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    b.booking_id,
    b.property_id,
    b.status,
    b.start_date,
    CASE
        WHEN u.user_id IS NULL THEN 'Booking without user'
        WHEN b.booking_id IS NULL THEN 'User without bookings'
        ELSE 'Matched'
    END AS record_type
FROM
    "User" u
FULL OUTER JOIN
    Booking b ON u.user_id = b.user_id
ORDER BY
    COALESCE(u.last_name, b.user_id),
    b.booking_id;
