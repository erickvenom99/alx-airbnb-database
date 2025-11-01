SELECT
    p.property_id,
    p.name          AS property_name,
    p.location,
    p.price_per_night,
    (
        SELECT AVG(r.rating)
        FROM Reviews r
        WHERE r.property_id = p.property_id
        GROUP BY r.property_id
        HAVING AVG(r.rating) > 4.0
    )               AS avg_rating
FROM Property p
WHERE
    (
        SELECT AVG(r.rating)
        FROM Reviews r
        WHERE r.property_id = p.property_id
        GROUP BY r.property_id
        HAVING AVG(r.rating) > 4.0
    ) IS NOT NULL
ORDER BY avg_rating DESC;


SELECT
	u.user_id,
	u.first_name || ' '|| u.last_name,
	COUNT(b.booking_id) AS total_count
FROM "User" u
INNER JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(b.booking_id) > 3