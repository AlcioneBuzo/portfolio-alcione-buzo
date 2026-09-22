-- ============================================================================
-- PROJETO DE ANÁLISE DE DADOS: CRÉDITO BANCÁRIO & RISCO FINANCEIRO
-- ARQUIVO: 01_schema_e_carga.sql
-- AUTORA: Alcione Buzo
-- ============================================================================

CREATE TABLE dim_clientes_banco (
    id_cliente VARCHAR(20) PRIMARY KEY,
    cliente_nome VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    regiao VARCHAR(20) NOT NULL,
    renda_mensal DECIMAL(12,2) NOT NULL,
    score_credito INT NOT NULL,
    faixa_score VARCHAR(30) NOT NULL
);

CREATE TABLE dim_produtos_credito (
    tipo_credito VARCHAR(50) PRIMARY KEY,
    categoria_produto VARCHAR(50) NOT NULL,
    taxa_minima DECIMAL(5,4) NOT NULL,
    taxa_maxima DECIMAL(5,4) NOT NULL
);

CREATE TABLE fato_operacoes_credito (
    id_contrato VARCHAR(20) PRIMARY KEY,
    data_concessao DATE NOT NULL,
    id_cliente VARCHAR(20) NOT NULL,
    tipo_credito VARCHAR(50) NOT NULL,
    canal_origem VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    regiao VARCHAR(20) NOT NULL,
    valor_emprestimo DECIMAL(12,2) NOT NULL,
    taxa_juros_anual DECIMAL(6,4) NOT NULL,
    prazo_meses INT NOT NULL,
    score_credito INT NOT NULL,
    renda_mensal DECIMAL(12,2) NOT NULL,
    parcela_estimada DECIMAL(12,2) NOT NULL,
    comprometimento_renda_pct DECIMAL(5,2) NOT NULL,
    dias_atraso INT NOT NULL,
    status_contrato VARCHAR(40) NOT NULL,
    categoria_risco VARCHAR(40) NOT NULL,
    perda_estimada_npl DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES dim_clientes_banco(id_cliente)
);

CREATE INDEX idx_credito_data ON fato_operacoes_credito(data_concessao);
CREATE INDEX idx_credito_status ON fato_operacoes_credito(status_contrato);
CREATE INDEX idx_credito_tipo ON fato_operacoes_credito(tipo_credito);
