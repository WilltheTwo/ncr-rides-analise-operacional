-- ================================
-- MÉTRICA 1: Volume de corridas por status
-- ================================
SELECT
    booking_status,
    status_category AS catego_operaci,
    count(*) AS total_corridas,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percent_total

FROM vw_ride_bookings_clean

GROUP BY booking_status, status_category
ORDER BY total_corridas DESC;

-- ================================
-- MÉTRICA 2: Motivos de cancelamento pelo cliente
-- ================================
SELECT 
    cancellation_reason_customer AS motivo_cancelamento_cliente,
    COUNT(*) AS total_cancelamentos,
    ROUND(COUNT(*) * 100.00 / 
    (SELECT COUNT(*) 
    FROM vw_ride_bookings_clean
    WHERE booking_status = 'Cancelled by Customer'), 2) AS percentual

FROM vw_ride_bookings_clean

WHERE booking_status = 'Cancelled by Customer'
    AND cancellation_reason_customer IS NOT NULL
    
GROUP BY cancellation_reason_customer
ORDER BY total_cancelamentos DESC;

-- ================================
-- MÉTRICA 3: Motivos de cancelamento pelo motorista
-- ================================

SELECT 
    cancellation_reason_driver AS motivo_cancelamento_motorista,
    COUNT(*) AS total_cancelamentos,
    ROUND(COUNT(*) * 100.0 /
    (SELECT COUNT(*) 
    FROM vw_ride_bookings_clean
    WHERE booking_status = 'Cancelled by Driver'), 2) AS percentual

FROM vw_ride_bookings_clean

WHERE booking_status = 'Cancelled by Driver'
    AND cancellation_reason_driver IS NOT NULL

GROUP BY cancellation_reason_driver
ORDER BY cancellation_reason_driver DESC;

-- ================================
-- MÉTRICA 4: Receita realizada vs perdida
-- ================================

SELECT
    status_category AS categoria_operacional,
    COUNT(*) AS total_corridas,
    ROUND(SUM(real_revenue), 2) AS receita_realizada,
    ROUND(COUNT(*) * (
        SELECT AVG(booking_value) 
        FROM vw_ride_bookings_clean 
        WHERE booking_status = 'Completed'
    ), 2) AS receita_perdida_estimada,
    ROUND(AVG(CASE 
        WHEN booking_status = 'Completed' 
        THEN booking_value END), 2) AS ticket_medio
FROM vw_ride_bookings_clean
GROUP BY status_category
ORDER BY receita_realizada DESC;

-- ================================
-- MÉTRICA 5: VTAT médio por status
-- ================================
SELECT
    status_category AS categoria_operacional,
    ROUND(AVG(avg_vtat), 2) AS vtat_medio,
    ROUND(AVG(avg_ctat), 2) AS ctat_medio,
    COUNT(*) AS total_corridas

FROM vw_ride_bookings_clean

WHERE avg_vtat IS NOT NULL
GROUP BY status_category
ORDER BY vtat_medio DESC;

-- ================================
-- MÉTRICA 6: Ticket médio por tipo de veículo
-- ================================
SELECT
    vehicle_type AS tipo_veiculo,
    COUNT(*) AS total_corridas,
    ROUND(SUM(real_revenue), 2) AS receita_total,
    ROUND(AVG(CASE 
        WHEN booking_status = 'Completed' 
        THEN booking_value END), 2) AS ticket_medio,
    ROUND(AVG(CASE 
        WHEN booking_status = 'Completed' 
        THEN ride_distance END), 2) AS distancia_media

FROM vw_ride_bookings_clean

GROUP BY vehicle_type
ORDER BY receita_total DESC;

-- ================================
-- MÉTRICA 7: Volume de corridas por período do dia
-- ================================
SELECT
    period_of_day AS periodo_do_dia,
    COUNT(*) AS total_corridas,
    SUM(cancelled_by_customer) AS cancelamentos_cliente,
    SUM(cancelled_by_driver) AS cancelamentos_motorista,
    ROUND(SUM(real_revenue), 2) AS receita_total

FROM vw_ride_bookings_clean

GROUP BY period_of_day
ORDER BY total_corridas DESC;

-- ================================
-- MÉTRICA 8: Avaliação média por tipo de veículo
-- ================================
SELECT
    vehicle_type AS tipo_veiculo,
    ROUND(AVG(driver_ratings), 2) AS avaliacao_media_motorista,
    ROUND(AVG(customer_rating), 2) AS avaliacao_media_cliente,
    COUNT(*) AS total_corridas_avaliadas

FROM vw_ride_bookings_clean

WHERE driver_ratings IS NOT NULL
GROUP BY vehicle_type
ORDER BY avaliacao_media_motorista DESC;