SELECT
    Booking_Status,
    Cancelled_by_Customer,
    Cancelled_by_Driver,
    Booking_Value,
    Driver_Ratings,
    Avg_VTAT
FROM ride_bookings
WHERE Booking_Status IN (
    'Cancelled by Customer',
    'Cancelled by Driver'
                        )
LIMIT 20

