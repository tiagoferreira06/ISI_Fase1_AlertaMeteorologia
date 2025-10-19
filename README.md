# 🌦️ ISI Fase 1 — Sistema de Alertas Meteorológicos

## Identificação do Autor
**Nome:** Tiago Nunes Ferreira  
**Número:** *27980*  

---

## Descrição do Projeto
Este projeto implementa um sistema **ETL (Extract, Transform, Load)** para recolha, validação, análise e visualização de **dados meteorológicos** obtidos através da **API do IPMA**.  

O sistema foi desenvolvido no âmbito da unidade curricular **Integração de Sistemas de Informação (ISI)** e tem como principal objetivo gerar **alertas automáticos** baseados em condições meteorológicas críticas, armazenando os resultados numa base de dados **PostgreSQL** e apresentando-os num **dashboard Node-RED**.

---

## Estrutura de Ficheiros

## Documentação
- [documentation/Relatorio_ISI_Fase_1.pdf](documentation/Relatorio_ISI_Fase_1.pdf) — Relatório final do projeto

---

## Transformações ETL

### Pentaho — Transformações
- [transformations/T1_Extrair_Previsoes_IPMA.ktr](transformations/T1_Extrair_Previsoes_IPMA.ktr) — Extração de dados da API IPMA  
- [transformations/T2_Validacoes_REGEX.ktr](transformations/T2_Validacoes_REGEX.ktr) — Validação e limpeza de dados (Regex)  
- [transformations/T3.ktr](transformations/T3.ktr) — Cálculo de alertas e relatórios

### Pentaho — Job
- [jobs/JOB_Principal.kjb](jobs/JOB_Principal.kjb) — Job principal (execução sequencial)

## Base de Dados

- [database/Database.sql](database/Database.sql) — Script principal de criação da base de dados  
- [database/alertas_meteorologicos.sql](database/alertas_meteorologicos.sql) — Tabela de alertas meteorológicos  
- [database/previsoes_meteorologicas.sql](database/previsoes_meteorologicas.sql) — Tabela de previsões meteorológicas  
- [database/resumo_cidades.sql](database/resumo_cidades.sql) — Tabela de resumo por cidade  
- [database/logs.sql](database/logs.sql) — Registo de execuções e logs de processos  
- [database/schemameteorologia.sql](database/schemameteorologia.sql) — Estrutura do esquema meteorologia  
- [database/schemaregistos.sql](database/schemaregistos.sql) — Estrutura do esquema de registos


## Node-RED
- [node-red/weatheralerts.json](node-red/weatheralerts.json) — Interface de alertas meteorológicos  
- [node-red/weatherforecasts.json](node-red/weatherforecasts.json) — Interface de previsões meteorológicas  
- [node-red/citiessummary.json](node-red/citiessummary.json) — Resumo de cidades e médias  
- [node-red/database.json](node-red/database.json) — Ligação à base de dados PostgreSQL


---

## Objetivos do Projeto
- Extrair previsões meteorológicas da **API do IPMA**.  
- Validar e normalizar os dados meteorológicos.  
- Calcular automaticamente **níveis de alerta** com base em temperatura e precipitação.  
- Armazenar os resultados em **PostgreSQL**.  
- Gerar relatórios automáticos e visualização em **Node-RED Dashboard**.

---

## Ferramentas Utilizadas

| Software | Versão | Função |
|-----------|---------|--------|
| **Pentaho Data Integration (Kettle)** | 9.4 | Processos ETL |
| **PostgreSQL** | 16 | Base de dados |
| **Node-RED** | 4.1 | Visualização interativa |
| **Node.js** | 22.16 | Execução do Node-RED |
| **LaTeX** | — | Elaboração do relatório técnico |

---

## 🚀 Como Executar o Projeto

### 1 Pré-requisitos

**Instalar PostgreSQL**
```bash
createdb alerta_meteorologia
psql -d alerta_meteorologia -f sql/schema_meteorologia.sql
psql -d alerta_meteorologia -f sql/schema_registos.sql

Instalar Node-RED

npm install -g node-red
npm install node-red-contrib-postgres
npm install node-red-dashboard

2 - Configuração

Editar as credenciais da base de dados no Node-RED e no Pentaho.

Confirmar que o PostgreSQL está ativo na porta padrão 5432.

Importar os fluxos (node-red/*.json) no Node-RED.

3 - Execução do Pipeline ETL

Abrir o Spoon (interface gráfica do Pentaho).

Executar o job jobs/JOB_Principal.kjb.

Verificar os logs de execução no schema registos.

Visualizar os resultados no Node-RED Dashboard (http://localhost:1880).

```

Demonstração em Vídeo

QR Code: disponível no relatório (documentation/Relatorio_ISI_Fase_1.pdf)

Fonte dos Dados

API: https://api.ipma.pt

Instituto Português do Mar e da Atmosfera (IPMA)

Dados meteorológicos diários e previsões por cidade.

Autor

Tiago Nunes Ferreira
Engenharia de Sistemas Informáticos — LESI
tiagoferr1402@gmail.com


