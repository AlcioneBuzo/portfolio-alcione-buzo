# Documentação do Tratamento de Dados de Crédito Bancário no Excel

## 📌 Visão Geral do Projeto
Este documento detalha as tratativas aplicadas no **Microsoft Excel** (Fórmulas Nativas e **Power Query / ETL**) sobre a base bruta de concessão de crédito e inadimplência bancária (`base_operacoes_credito_bruta.csv`), resultando na base estruturada (`base_operacoes_credito_tratada.csv`).

---

## 🛠️ Justificativa Técnica das Fórmulas & Tratativas Utilizadas no Excel

### 1. `ARRUMAR` (TRIM) e `MAIÚSCULA.MINÚSCULA` (PROPER)
- **Fórmula:** `=ARRUMAR(MAIÚSCULA.MINÚSCULA(E2))`
- **Por que foi usada?** A extração do sistema legado continha espaços invisíveis antes e depois dos nomes de categorias e estados (ex: `" SP "`, `"credito pessoal"`). O `ARRUMAR` remove todos os espaços duplos ou nas extremidades, e o `MAIÚSCULA.MINÚSCULA` garante a capitalização padrão ("Crédito Pessoal").

### 2. `XLOOKUP` (PROCX) vs `PROCV` (VLOOKUP)
- **Fórmula Utilizada:** `=PROCX([@Estado]; Tabela_Regioes[UF]; Tabela_Regioes[Regiao]; "Não Encontrado"; 0)`
- **Por que usamos PROCX em vez de PROCV?**
  - **Busca à esquerda:** O `PROCV` exige que a coluna de busca seja a primeira coluna da matriz à esquerda. O `PROCX` não tem essa limitação.
  - **Tratamento de erros embutido:** O `PROCX` já possui o argumento de fallback caso a chave não seja encontrada, dispensando o uso de `=SEERRO(PROCV(...))` e tornando a planilha mais rápida e limpa.
  - **Performance:** O `PROCX` não recalcula a tabela inteira como o `PROCV` com colunas dinâmicas.

### 3. `TEXTO` (TEXT) e `DATA` (DATE)
- **Fórmula:** `=TEXTO([@Data_Concessao]; "YYYY-MM")`
- **Por que foi usada?** Para unificar datas que vieram em formatos mistos no CSV (`DD/MM/AAAA` e `AAAA-MM-DD`). A padronização de formato de data garante que o banco de dados SQL e o Power BI leiam o campo como tipo temporal sem erros de conversão regional.

### 4. `SE` (IF) para Categorização de Risco de Crédito
- **Fórmula:** `=SE([@Score]>=750; "Excelente"; SE([@Score]>=650; "Bom"; SE([@Score]>=550; "Médio"; "Alto Risco")))`
- **Por que foi usada?** Variáveis contínuas (como pontuação de score de 300 a 850) são difíceis de analisar individualmente em gráficos executivos. A criação de faixas discretas de Score facilita a tomada de decisão da diretoria de risco.

### 5. Cálculo da Parcela Estimada (Fórmula Financeira `PGTO` / `PMT`)
- **Fórmula:** `=PGTO([@Taxa_Juros_Anual]/12; [@Prazo_Meses]; -[@Valor_Emprestimo])`
- **Por que foi usada?** Permite calcular a prestação mensal de cada contrato e compará-la com a renda declarada do cliente, gerando o indicador de **Comprometimento de Renda (%)**.

---

## 📊 Resumo do Impacto da Limpeza
- **Linhas processadas:** 1.500 operações de crédito.
- **Campos nulos/inconsistentes corrigidos:** 230+ registros de texto e taxa de juros.
- **Integridade da Chave:** 100% dos `ID_Contrato` válidos e únicos.
