# Database Performance Monitoring & Refinement Report  
`performance_monitoring.md`

---

## Objective
Continuously **monitor** and **optimize** query performance using `EXPLAIN ANALYZE`, identify bottlenecks, implement improvements, and report **measurable gains** based on **real execution plans**.

---

## Environment
- **Database**: `airbnb_clone_db` (PostgreSQL)
- **Data Size**: Small (~2–4 rows in key tables)
- **Repo**: `alx-airbnb-database`  
  **Directory**: `database-adv-script`  
  **File**: `performance_monitoring.md`

---

## Monitored Queries

| # | Query Description |
|---|-------------------|
| 1 | Full booking report with guest, property, host, and payment details |
| 2 | Average rating per property (greater than 4.0) |
| 3 | Count bookings in January 2025 |
| 4 | Users with no bookings (data quality check via `FULL OUTER JOIN`) |

---

## Performance Analysis Summary

| Query | Execution Time | Planning Time | Rows Returned | Scan Type | Join Type | Buffers |
|------|----------------|---------------|----------------|-----------|-----------|---------|
| 1.      Booking Report| 29.761 ms     | ~0.3 ms | 2 | `Seq Scan` on  `Booking` | `Hash Join` | `hit=5` |
| 2.      Avg Rating    | 25.290 ms     | 40.651 ms | 1 | `Seq Scan` on `Reviews` | `Hash Right Join` | `hit=1 read=1` |
| 3. Date Range Count | 4.378 ms | 14.499 ms | 1 (0 matches) | `Seq Scan` | — | `hit=1` |
| 4. Orphaned Records | 10.278 ms | 21.100 ms | 2 | `Seq Scan` | `Hash Full Join` | `hit=2` |

---

## Key Bottlenecks Identified

| Bottleneck | Affected Query | Cause |
|-----------|----------------|-------|
|High Planning Time | Query 2 |40.651 ms — due to outdated statistics |
|Sequential Scan on `Reviews` | Query 2 | No index on `property_id` |
|Row Estimation Error | Query 1 | Estimated570 rows, actual2 |
| Data Quality Issue | Query 4 | 2 orphaned records (users/bookings not linked) |

---

## Implemented Optimizations

```sql
-- 1. Add critical index
CREATE INDEX IF NOT EXISTS idx_reviews_property_id ON Reviews(property_id);

-- 2. Update table statistics
ANALYZE Reviews;
ANALYZE Property;
ANALYZE Booking;
ANALYZE "User";