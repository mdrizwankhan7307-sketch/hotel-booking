USE hotel_booking;

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 100
)

INSERT INTO hotel_bookings (
    id,
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)

SELECT

    UUID(),

    ELT(
        FLOOR(1 + RAND()*3),
        '11111111-1111-1111-1111-111111111111',
        '22222222-2222-2222-2222-222222222222',
        '33333333-3333-3333-3333-333333333333'
    ),

    CONCAT('HOTEL-', LPAD(FLOOR(1 + RAND()*10),3,'0')),

    ELT(
        FLOOR(1 + RAND()*5),
        'Delhi',
        'Mumbai',
        'Hyderabad',
        'Bangalore',
        'Chennai'
    ),

    CURDATE() + INTERVAL FLOOR(RAND()*20) DAY,

    CURDATE() + INTERVAL FLOOR(21 + RAND()*10) DAY,

    ROUND(1000 + RAND()*25000,2),

    ELT(
        FLOOR(1 + RAND()*4),
        'CONFIRMED',
        'PENDING',
        'CANCELLED',
        'COMPLETED'
    ),

    NOW() - INTERVAL FLOOR(RAND()*60) DAY

FROM numbers;