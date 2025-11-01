# Airbnb Query Performance Optimization Report  
`optimization_report.md`

---

## Query Under Analysis

```sql
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.location AS property_location,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.payment_date,
    pay.amount,
    pay.payment_method,
    h.user_id AS host_id,
    h.first_name || ' ' || h.last_name AS host_name,
    b.status,
    b.total_price,
    b.start_date,
    b.booking_id
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN "User" h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC;

Key Observations from EXPLAIN ANALYZE
Observation             Details
Execution               Time,33.944 ms → 33.983 ms (total)
Sort Operation          quicksort on b.start_date DESC using 25kB memory
Join Strategy           Multiple Hash Left Join operations
Row Estimation Error    Estimated 570 rows, but only 2 rows returned
Buffer Usage             shared hit=4 read=4 dirtied=2 → 50% cache hit, 4 pages from disk
No Index Scans           All joins use hash tables, no index usage
Join Conditions,            b.user_id = u.user_id (Guest)
                            b.property_id = p.property_id (Property)  
                            p.host_id = h.user_id (Host)
                            
Insight: The planner overestimated row count → inefficient hash builds.

Performance Before Indexes
Metric   		Before Indexes        
Execution    	Time,33.983 ms      
Sort         	Time,33.944ms         
Buffers     	hit=4 read=4          
Disk I/O    	4 pages read          
Join Type   	Hash Left Join        
Index Usage, 	None

this plan suggests the query could benefit from:
1. More selective filtering to reduce row estimates
2. Possible index optimization on join columns
3. Review of the large row estimate vs actual count discrepancy

Performance Before Indexes
Metric         After Indexes    
Execution       5.512 ms          
Sort            5.482 → 5.512 ms  
Buffers         hit=5,             
Disk I/O,       0 pages read,      
Join Type,      Hash Left Join,     
Index Usage,    Still none

Performance Comparison: Before vs After
Metric,         Before Indexes       After Indexes,     Improvement
Execution       Time,33.983 ms       5.512 ms,          85%  faster
Sort            Time,33.944ms        5.482 → 5.512 ms,  6x faster
Buffers,        hit=4 read=4         hit=5,             100% cache hit
Disk I/O,       4 pages read         0 pages read,      No disk access
Join Type,      Hash Left Join       Hash Left Join     Same (good)
Index Usage     None               Still none          visible,Warning