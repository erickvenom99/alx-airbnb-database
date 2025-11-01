SELECT
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    subquery.avg_rating
FROM
    Property p
JOIN (
    SELECT
        property_id,
        AVG(rating) AS avg_rating
    FROM
        Reviews
    GROUP BY
        property_id
    HAVING
        AVG(rating) > 4.0
) AS subquery ON p.property_id = subquery.property_id
ORDER BY
    subquery.avg_rating DESC;


SELECT
	u.user_id,
	u.first_name || ' '|| u.last_name,
	COUNT(b.booking_id) AS total_count
FROM "User" u
INNER JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(b.booking_id) > 3