-- ============================================================================
-- PROJETO DE ANÁLISE DE DADOS: CRÉDITO BANCÁRIO & RISCO FINANCEIRO
-- ARQUIVO: 02_tratamento_e_views.sql
-- DESCRIÇÃO: Views de Negócio para Indicadores Financeiros e Inadimplência
-- ============================================================================

-- VIEW 1: Resumo de Inadimplência & NPL (Non-Performing Loans > 90 dias)
CREATE OR REPLACE VIEW vw_indicadores_npl_carteira AS
SELECT 
    DATE_TRUNC('month', data_concessao) AS mes_safra,
    TO_CHAR(data_concessao, 'YYYY-MM') AS safra_ano_mes,
    tipo_credito,
    COUNT(id_contrato) AS total_contratos,
    SUM(valor_emprestimo) AS volume_carteira_concedida,
    SUM(CASE WHEN dias_atraso > 90 THEN valor_emprestimo ELSE 0 END) AS volume_npl_inadimplente,
    ROUND(
        CAST(
            SUM(CASE WHEN dias_atraso > 90 THEN valor_emprestimo ELSE 0 END) / NULLIF(SUM(valor_emprestimo), 0) * 100 
        AS NUMERIC), 2
    ) AS taxa_npl_pct,
    SUM(perda_estimada_npl) AS provisao_perda_total
FROM fato_operacoes_credito
GROUP BY DATE_TRUNC('month', data_concessao), TO_CHAR(data_concessao, 'YYYY-MM'), tipo_credito;

-- VIEW 2: Perfil de Risco por Faixa de Score de Crédito
CREATE OR REPLACE VIEW vw_risco_faixa_score AS
SELECT 
    CASE 
        WHEN score_credito >= 750 THEN '1. Excelente (750-850)'
        WHEN score_credito >= 650 THEN '2. Bom (650-749)'
        WHEN score_credito >= 550 THEN '3. Médio (550-649)'
        ELSE '4. Baixo / Alto Risco (<550)'
    END AS faixa_score,
    COUNT(id_contrato) AS qtd_operacoes,
    SUM(valor_emprestimo) AS volume_total,
    ROUND(CAST(AVG(comprometimento_renda_pct) AS NUMERIC), 2) AS comp_renda_medio_pct,
    ROUND(CAST(AVG(dias_atraso) AS NUMERIC), 1) AS media_dias_atraso
FROM fato_operacoes_credito
GROUP BY 1;
