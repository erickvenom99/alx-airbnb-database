CREATE TABLE IF NOT EXISTS Booking_Partitioned (
    booking_id UUID,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10,2),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- 2. Create monthly partitions (example: 2025 and 2026)
CREATE TABLE IF NOT EXISTS Booking_2025_01 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE IF NOT EXISTS Booking_2025_02 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE IF NOT EXISTS Booking_2025_03 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

CREATE TABLE IF NOT EXISTS Booking_2025_04 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');

CREATE TABLE IF NOT EXISTS Booking_2025_05 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');

CREATE TABLE IF NOT EXISTS Booking_2025_06 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');

CREATE TABLE IF NOT EXISTS Booking_2025_07 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');

CREATE TABLE IF NOT EXISTS Booking_2025_08 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');

CREATE TABLE IF NOT EXISTS Booking_2025_09 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');

CREATE TABLE IF NOT EXISTS Booking_2025_10 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');

CREATE TABLE IF NOT EXISTS Booking_2025_11 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');

CREATE TABLE IF NOT EXISTS Booking_2025_12 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');

-- 2026 partitions
CREATE TABLE IF NOT EXISTS Booking_2026_01 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE IF NOT EXISTS Booking_2026_02 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');

CREATE TABLE IF NOT EXISTS Booking_2026_03 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');

CREATE TABLE IF NOT EXISTS Booking_2026_04 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');

CREATE TABLE IF NOT EXISTS Booking_2026_05 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');

    -- 4. Create indexes on the partitioned table (inherited by all partitions)
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking_Partitioned (user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking_Partitioned (property_id);
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON Booking_Partitioned (start_date);