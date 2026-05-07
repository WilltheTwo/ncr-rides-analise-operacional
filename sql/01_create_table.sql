CREATE TABLE IF NOT EXISTS ride_bookings (
    Date TEXT,
    Time TEXT,
    Booking_ID TEXT,
    Booking_Status TEXT,
    Customer_ID TEXT,
    Vehicle_Type TEXT,
    Pickup_Location TEXT,
    Drop_Location TEXT,
    Avg_VTAT REAL,
    Avg_CTAT REAL,
    Cancelled_by_Customer INTEGER,
    Cancellation_Reason_Customer TEXT,
    Cancelled_by_Driver INTEGER,
    Cancellation_Reason_Driver TEXT,
    Incomplete_Rides INTEGER,
    Incomplete_Rides_Reason TEXT,
    Booking_Value REAL,
    Ride_Distance REAL,
    Driver_Ratings REAL,
    Customer_Rating REAL,
    Payment_Method TEXT
);


