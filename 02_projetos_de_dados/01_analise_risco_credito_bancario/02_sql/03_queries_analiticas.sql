-- ============================================================================
-- PROJETO DE ANÁLISE DE DADOS: CRÉDITO BANCÁRIO & RISCO FINANCEIRO
-- ARQUIVO: 03_queries_analiticas.sql
-- CONSULTAS DE NÍVEL PLENO/SÊNIOR (Window Functions & CTEs)
-- ============================================================================

-- ============================================================================
-- QUERY 1: Evolução da Carteira Concedida MoM (Month-over-Month)
-- TÉCNICA: CTE + Window Function LAG()
-- ============================================================================
WITH carteira_mensal AS (
    SELECT 
        DATE_TRUNC('month', data_concessao) AS mes,
        TO_CHAR(data_concessao, 'YYYY-MM') AS safra,
        SUM(valor_emprestimo) AS volume_mes
    FROM fato_operacoes_credito
    GROUP BY DATE_TRUNC('month', data_concessao), TO_CHAR(data_concessao, 'YYYY-MM')
)
SELECT 
    safra,
    volume_mes,
    LAG(volume_mes, 1) OVER (ORDER BY mes) AS volume_safra_anterior,
    ROUND(
        CAST(
            (volume_mes - LAG(volume_mes, 1) OVER (ORDER BY mes)) / 
            NULLIF(LAG(volume_mes, 1) OVER (ORDER BY mes), 0) * 100 
        AS NUMERIC), 2
    ) AS variacao_mom_pct
FROM carteira_mensal
ORDER BY mes;


-- ============================================================================
-- QUERY 2: Ranking dos Maiores Contratos por Modalidade de Crédito
-- TÉCNICA: CTE + Window Function DENSE_RANK()
-- ============================================================================
WITH ranking_contratos AS (
    SELECT 
        tipo_credito,
        id_contrato,
        id_cliente,
        valor_emprestimo,
        score_credito,
        DENSE_RANK() OVER (PARTITION BY tipo_credito ORDER BY valor_emprestimo DESC) AS pos_ranking
    FROM fato_operacoes_credito
)
SELECT 
    tipo_credito,
    pos_ranking,
    id_contrato,
    id_cliente,
    valor_emprestimo,
    score_credito
FROM ranking_contratos
WHERE pos_ranking <= 3
ORDER BY tipo_credito, pos_ranking;


-- ============================================================================
-- QUERY 3: Participação da Inadimplência por Região (Windowing OVER)
-- TÉCNICA: SUM() OVER() para cálculo de share percentual
-- ============================================================================
SELECT 
    regiao,
    SUM(valor_emprestimo) AS volume_regiao,
    SUM(SUM(valor_emprestimo)) OVER() AS volume_nacional,
    ROUND(
        CAST(
            SUM(valor_emprestimo) / SUM(SUM(valor_emprestimo)) OVER() * 100 
        AS NUMERIC), 2
    ) AS share_carteira_pct,
    SUM(CASE WHEN dias_atraso > 90 THEN valor_emprestimo ELSE 0 END) AS npl_regiao
FROM fato_operacoes_credito
GROUP BY regiao
ORDER BY volume_regiao DESC;
