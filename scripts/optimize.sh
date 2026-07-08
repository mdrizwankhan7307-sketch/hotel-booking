#!/bin/bash

set -e

CONTAINER_NAME="hotel-mysql"
DB_NAME="hotel_booking"
DB_USER="admin"
DB_PASSWORD="password"

echo "Creating indexes..."

docker exec -i $CONTAINER_NAME mysql \
-u$DB_USER \
-p$DB_PASSWORD \
$DB_NAME <<EOF

CREATE INDEX idx_city_created
ON hotel_bookings(city, created_at);

CREATE INDEX idx_org_status
ON hotel_bookings(org_id, status);

CREATE INDEX idx_booking_events
ON booking_events(booking_id);

SHOW INDEX FROM hotel_bookings;
SHOW INDEX FROM booking_events;

EOF

echo ""
echo "Optimization completed."