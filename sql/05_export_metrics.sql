-- Exportar Métrica 1: Volume por status
.mode csv
.headers on
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/01_volume_por_status.csv
SELECT
    status_category AS categoria_operacional,
    COUNT(*) AS total_corridas,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vw_ride_bookings_clean), 2) AS percentual
FROM vw_ride_bookings_clean
GROUP BY status_category
ORDER BY total_corridas DESC;

-- Exportar Métrica 2: Motivos cancelamento cliente
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/02_motivos_cancelamento_cliente.csv
SELECT
    cancellation_reason_customer AS motivo_cancelamento_cliente,
    COUNT(*) AS total_cancelamentos,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vw_ride_bookings_clean
    WHERE booking_status = 'Cancelled by Customer'), 2) AS percentual
FROM vw_ride_bookings_clean
WHERE booking_status = 'Cancelled by Customer'
    AND cancellation_reason_customer IS NOT NULL
GROUP BY cancellation_reason_customer
ORDER BY total_cancelamentos DESC;

-- Exportar Métrica 3: Motivos cancelamento motorista
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/03_motivos_cancelamento_motorista.csv
SELECT
    cancellation_reason_driver AS motivo_cancelamento_motorista,
    COUNT(*) AS total_cancelamentos,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vw_ride_bookings_clean
    WHERE booking_status = 'Cancelled by Driver'), 2) AS percentual
FROM vw_ride_bookings_clean
WHERE booking_status = 'Cancelled by Driver'
    AND cancellation_reason_driver IS NOT NULL
GROUP BY cancellation_reason_driver
ORDER BY total_cancelamentos DESC;

-- Exportar Métrica 4: Receita realizada vs perdida
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/04_receita.csv
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

-- Exportar Métrica 5: VTAT por status
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/05_vtat_por_status.csv
SELECT
    status_category AS categoria_operacional,
    ROUND(AVG(avg_vtat), 2) AS vtat_medio,
    ROUND(AVG(avg_ctat), 2) AS ctat_medio,
    COUNT(*) AS total_corridas
FROM vw_ride_bookings_clean
WHERE avg_vtat IS NOT NULL
GROUP BY status_category
ORDER BY vtat_medio DESC;

-- Exportar Métrica 6: Ticket médio por veículo
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/06_ticket_por_veiculo.csv
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

-- Exportar Métrica 7: Volume por período do dia
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/07_volume_por_periodo.csv
SELECT
    period_of_day AS periodo_do_dia,
    COUNT(*) AS total_corridas,
    SUM(cancelled_by_customer) AS cancelamentos_cliente,
    SUM(cancelled_by_driver) AS cancelamentos_motorista,
    ROUND(SUM(real_revenue), 2) AS receita_total
FROM vw_ride_bookings_clean
GROUP BY period_of_day
ORDER BY total_corridas DESC;

-- Exportar Métrica 8: Avaliação por veículo
.output C:/dados/Projeto_Analise_de_Dados_Uber/metrics/08_avaliacao_por_veiculo.csv
SELECT
    vehicle_type AS tipo_veiculo,
    ROUND(AVG(driver_ratings), 2) AS avaliacao_media_motorista,
    ROUND(AVG(customer_rating), 2) AS avaliacao_media_cliente,
    COUNT(*) AS total_corridas_avaliadas
FROM vw_ride_bookings_clean
WHERE driver_ratings IS NOT NULL
GROUP BY vehicle_type
ORDER BY avaliacao_media_motorista DESC;

.output stdout