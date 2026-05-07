CREATE VIEW vw_ride_bookings_clean AS

SELECT

    -- Datas e tempo
    DATE(Date) AS ride_date,
    Time AS ride_time,
    STRFTIME('%H', Time) AS ride_hour,
    CASE
        WHEN CAST(STRFTIME('%H', Time) AS INTEGER) BETWEEN 5 AND 11 THEN 'Manhã'
        WHEN CAST(STRFTIME('%H', Time) AS INTEGER) BETWEEN 12 AND 17 THEN 'Tarde'
        WHEN CAST(STRFTIME('%H', Time) AS INTEGER) BETWEEN 18 AND 22 THEN 'Noite'
        ELSE 'Madrugada'
    END AS period_of_day,

    -- Identificadores
    REPLACE(Booking_ID, '"', '') AS booking_id,
    REPLACE(Customer_ID, '"', '') AS customer_id,

    -- Status e classificação operacional
    Booking_Status AS booking_status,
    CASE
        WHEN Booking_Status = 'Completed' THEN 'Receita Realizada'
        WHEN Booking_Status = 'Cancelled by Driver' THEN 'Perda por Motorista'
        WHEN Booking_Status = 'Cancelled by Customer' THEN 'Perda por Cliente'
        WHEN Booking_Status = 'Incomplete' THEN 'Perda Operacional'
        WHEN Booking_Status = 'No Driver Found' THEN 'Falha da Oferta'
        ELSE 'Outro'
    END AS status_category,

    -- Veículo e localização
    Vehicle_Type AS vehicle_type,
    Pickup_Location AS pickup_location,
    Drop_Location AS drop_location,

    -- Tempos de atendimento
    Avg_VTAT AS avg_vtat,
    Avg_CTAT AS avg_ctat,

    -- Flags de cancelamento tratando nulos como zero
    COALESCE(Cancelled_by_Customer, 0) AS cancelled_by_customer,
    COALESCE(Cancelled_by_Driver, 0) AS cancelled_by_driver,
    Cancellation_Reason_Customer AS cancellation_reason_customer,
    Cancellation_Reason_Driver AS cancellation_reason_driver,

    -- Corridas incompletas
    COALESCE(Incomplete_Rides, 0) AS incomplete_rides,
    Incomplete_Rides_Reason AS incomplete_rides_reason,

    -- Financeiro
    COALESCE(Booking_Value, 0) AS booking_value,
    CASE
        WHEN Booking_Status = 'Completed' THEN COALESCE(Booking_Value, 0)
        ELSE 0
    END AS real_revenue,

    -- Distância e avaliações
    Ride_Distance AS ride_distance,
    Driver_Ratings AS driver_ratings,
    Customer_Rating AS customer_rating,
    Payment_Method AS payment_Method

FROM ride_bookings;