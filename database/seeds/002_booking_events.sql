USE hotel_booking;

INSERT INTO booking_events (

    booking_id,
    event_type,
    payload,
    created_at

)

SELECT

    id,

    ELT(
        FLOOR(1 + RAND()*4),
        'BOOKING_CREATED',
        'PAYMENT_RECEIVED',
        'BOOKING_CONFIRMED',
        'BOOKING_CANCELLED'
    ),

    JSON_OBJECT(

        'source','seed',

        'user','system',

        'version',1

    ),

    NOW()

FROM hotel_bookings

ORDER BY created_at

LIMIT 50;