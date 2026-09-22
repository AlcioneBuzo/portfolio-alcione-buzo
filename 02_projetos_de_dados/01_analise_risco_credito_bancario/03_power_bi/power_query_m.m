// ============================================================================
// PROJETO DE ANÁLISE DE DADOS: CRÉDITO BANCÁRIO & RISCO FINANCEIRO
// ARQUIVO: power_query_m.m
// ============================================================================

let
    Fonte = Csv.Document(File.Contents("C:\Users\User\.gemini\antigravity\scratch\projeto-analise-dados-bancarios\01_dados_excel\base_operacoes_credito_tratada.csv"), [Delimiter=";", Columns=20, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{
        {"id_contrato", type text}, 
        {"data_concessao", type date}, 
        {"id_cliente", type text}, 
        {"cliente_nome", type text}, 
        {"estado", type text}, 
        {"regiao", type text}, 
        {"canal_origem", type text}, 
        {"tipo_credito", type text}, 
        {"valor_emprestimo", Currency.Type}, 
        {"taxa_juros_anual", Percentage.Type}, 
        {"prazo_meses", Int64.Type}, 
        {"score_credito", Int64.Type}, 
        {"faixa_score", type text}, 
        {"renda_mensal", Currency.Type}, 
        {"parcela_estimada", Currency.Type}, 
        {"comprometimento_renda_pct", Percentage.Type}, 
        {"dias_atraso", Int64.Type}, 
        {"status_contrato", type text}, 
        {"categoria_risco", type text}, 
        {"perda_estimada_npl", Currency.Type}
    })
in
    #"Tipo Alterado"
