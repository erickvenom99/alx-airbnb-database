SELECT 
	p.property_id,
	p.name AS Property_name,
	r.rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id


SELECT 
	u.user_id,
	u.first_name || ' ' || u.last_name AS user_name,
	b.start_date,
FROM "User" u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;


SELECT
    p.property_id,
    p.name AS property_name,
    AVG(r.rating) AS avg_rating
FROM Property p
LEFT JOIN Reviews r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) > 4.0;