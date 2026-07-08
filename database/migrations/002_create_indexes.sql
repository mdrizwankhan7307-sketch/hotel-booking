-- =====================================================
-- Index for query optimization
-- =====================================================

CREATE INDEX idx_hotel_bookings_city_created_org_status
ON hotel_bookings (
    city,
    created_at,
    org_id,
    status
);

-- =====================================================
-- Index to speed up joins between booking_events
-- and hotel_bookings
-- =====================================================

CREATE INDEX idx_booking_events_booking_id
ON booking_events (booking_id);

-- =====================================================
-- Optional index for searching bookings by organization
-- =====================================================

CREATE INDEX idx_hotel_bookings_org
ON hotel_bookings (org_id);

-- =====================================================
-- Optional index for searching bookings by hotel
-- =====================================================

CREATE INDEX idx_hotel_bookings_hotel
ON hotel_bookings (hotel_id);