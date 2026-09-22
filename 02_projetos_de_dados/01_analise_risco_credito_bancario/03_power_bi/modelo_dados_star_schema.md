# Modelagem Dimensional (Star Schema) - Risco Bancário

## 📌 Arquitetura de Dados
O modelo adota a arquitetura **Star Schema (Esquema em Estrela)** com uma tabela Fato centralizadora das transações de crédito e três tabelas Dimensão que fornecem contexto analítico.

```
       +-----------------------+           +-----------------------+
       |  dim_clientes_banco   |           | dim_produtos_credito  |
       +-----------------------+           +-----------------------+
       | PK: id_cliente        |           | PK: tipo_credito      |
       |     cliente_nome      |           |     categoria_produto |
       |     renda_mensal      |           +-----------+-----------+
       |     score_credito     |                       | 1
       +-----------+-----------+                       |
                   | 1                                 |
                   |                                   | *
       +-----------v-----------------------------------v-----------+
       |               fato_operacoes_credito                      |
       +-----------------------------------------------------------+
       | PK: id_contrato                                           |
       | FK: id_cliente                                            |
       | FK: data_concessao                                        |
       | FK: tipo_credito                                          |
       |     valor_emprestimo                                      |
       |     comprometimento_renda_pct                             |
       |     dias_atraso                                           |
       |     status_contrato                                       |
       |     perda_estimada_npl                                    |
       +------------------------------+----------------------------+
                                      | *
                                      | 1
                         +------------v------------+
                         |     dim_calendario      |
                         +-------------------------+
                         | PK: data_k              |
                         |     Ano / Mes           |
                         |     Ano_Mes             |
                         +-------------------------+
```
