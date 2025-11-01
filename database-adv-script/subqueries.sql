SELECT
    p.property_id,
    p.name AS property_name,
    AVG(r.rating) AS avg_rating
FROM Property p
LEFT JOIN Reviews r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) > 4.0;



SELECT
	u.user_id,
	u.first_name || ' '|| u.last_name,
	COUNT(b.booking_id) AS total_count
FROM "User" u
INNER JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(b.booking_id) > 3