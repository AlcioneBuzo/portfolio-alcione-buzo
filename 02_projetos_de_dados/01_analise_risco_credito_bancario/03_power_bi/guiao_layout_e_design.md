# Guia de UX & Visual Design - Dashboard de Risco Bancário

## 🎨 Identidade Visual
- **Fundo do Dashboard (Dark Corporate):** `#0B132B`
- **Containers de Cartões (Cards):** `#1C2541`
- **Destaques & Métricas Principais:** `#48CAE4` (Electric Cyan)
- **Sucesso / Baixa Inadimplência:** `#10B981` (Emerald Green)
- **Alerta / NPL Crítico (>90d):** `#EF4444` (Coral Red)
- **Texto Principal:** `#F8FAFC`
- **Tipografia:** `Segoe UI` / `Segoe UI Semibold`

---

## 📱 Estrutura Visual por Páginas

### Página 1: Panorama da Carteira de Crédito & Inadimplência
- **Filtros Globais:** Safra (Ano/Mês), Modalidade de Crédito, Região.
- **Linha de KPIs:** Volume Concedido (R$), Total Operações, Taxa NPL % (Inadimplência >90d), Score Médio.
- **Gráfico Principal:** Evolução da Carteira Concedida vs Taxa NPL (%) ao longo do tempo.
- **Gráfico Secundário:** Matriz de Inadimplência por Faixa de Score vs Comprometimento de Renda.

### Página 2: Diagnóstico de Risco por Modalidade & Região
- **Matriz por Modalidade:** Tabela Dinâmica com Volume, Inadimplência, Taxa de Juros Média e Provisão de Perda.
- **Mapa/Barras de Regiões:** Distribuição do Crédito e Concentração de Risco por Estado.
