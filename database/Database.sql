-- Database: meteo_db

-- DROP DATABASE IF EXISTS meteo_db;

CREATE DATABASE meteo_db
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Portugal.1252'
    LC_CTYPE = 'Portuguese_Portugal.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- SCHEMA: meteorologia

-- DROP SCHEMA IF EXISTS meteorologia ;

CREATE SCHEMA IF NOT EXISTS meteorologia
    AUTHORIZATION postgres;

-- Table: meteorologia.alertas_meteorologicos

-- DROP TABLE IF EXISTS meteorologia.alertas_meteorologicos;

CREATE TABLE IF NOT EXISTS meteorologia.alertas_meteorologicos
(
    id integer NOT NULL DEFAULT nextval('meteorologia.alertas_meteorologicos_id_seq'::regclass),
    nome_cidade_normalizado character varying(50) COLLATE pg_catalog."default",
    regiao character varying(20) COLLATE pg_catalog."default",
    data_previsao date NOT NULL,
    temp_media numeric(5,2),
    temp_min numeric(5,2),
    temp_max numeric(5,2),
    amplitude numeric(5,2),
    precipitacao_prob numeric(5,2),
    nivel_alerta character varying(20) COLLATE pg_catalog."default" NOT NULL,
    tipo_alerta character varying(100) COLLATE pg_catalog."default",
    mensagem character varying(200) COLLATE pg_catalog."default",
    acao_recomendada character varying(200) COLLATE pg_catalog."default",
    risco_saude character varying(20) COLLATE pg_catalog."default",
    score_risco integer,
    prioridade character varying(20) COLLATE pg_catalog."default",
    classificacao_temp character varying(20) COLLATE pg_catalog."default",
    descricao_tempo character varying(150) COLLATE pg_catalog."default",
    data_processamento timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT alertas_meteorologicos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS meteorologia.alertas_meteorologicos
    OWNER to postgres;

COMMENT ON TABLE meteorologia.alertas_meteorologicos
    IS 'Alertas meteorológicos calculados com níveis de risco';

COMMENT ON COLUMN meteorologia.alertas_meteorologicos.score_risco
    IS 'Score de risco de 0-100';
-- Index: idx_alertas_nivel

-- DROP INDEX IF EXISTS meteorologia.idx_alertas_nivel;

CREATE INDEX IF NOT EXISTS idx_alertas_nivel
    ON meteorologia.alertas_meteorologicos USING btree
    (nivel_alerta COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_alertas_prioridade

-- DROP INDEX IF EXISTS meteorologia.idx_alertas_prioridade;

CREATE INDEX IF NOT EXISTS idx_alertas_prioridade
    ON meteorologia.alertas_meteorologicos USING btree
    (prioridade COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_alertas_score

-- DROP INDEX IF EXISTS meteorologia.idx_alertas_score;

CREATE INDEX IF NOT EXISTS idx_alertas_score
    ON meteorologia.alertas_meteorologicos USING btree
    (score_risco DESC NULLS FIRST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;


-- Table: meteorologia.previsoes_meteorologicas

-- DROP TABLE IF EXISTS meteorologia.previsoes_meteorologicas;

CREATE TABLE IF NOT EXISTS meteorologia.previsoes_meteorologicas
(
    id integer NOT NULL DEFAULT nextval('meteorologia.previsoes_meteorologicas_id_seq'::regclass),
    codigo_cidade character varying(20) COLLATE pg_catalog."default",
    nome_cidade character varying(50) COLLATE pg_catalog."default",
    nome_cidade_normalizado character varying(50) COLLATE pg_catalog."default",
    data_previsao date NOT NULL,
    temp_media numeric(5,2),
    temp_min numeric(5,2),
    temp_max numeric(5,2),
    temp_media_fahrenheit numeric(6,2),
    temp_media_kelvin numeric(6,2),
    classificacao_temp character varying(20) COLLATE pg_catalog."default",
    precipitacao_prob numeric(5,2),
    descricao_tempo character varying(100) COLLATE pg_catalog."default",
    vento_direcao character varying(10) COLLATE pg_catalog."default",
    descricao_vento character varying(50) COLLATE pg_catalog."default",
    tipo_previsao character varying(20) COLLATE pg_catalog."default",
    fonte_dados character varying(50) COLLATE pg_catalog."default",
    validacao_status character varying(20) COLLATE pg_catalog."default",
    data_insercao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    url_api character varying(200) COLLATE pg_catalog."default",
    CONSTRAINT previsoes_meteorologicas_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS meteorologia.previsoes_meteorologicas
    OWNER to postgres;

COMMENT ON TABLE meteorologia.previsoes_meteorologicas
    IS 'Previsões meteorológicas extraídas da API IPMA';
-- Index: idx_previsoes_cidade_data

-- DROP INDEX IF EXISTS meteorologia.idx_previsoes_cidade_data;

CREATE INDEX IF NOT EXISTS idx_previsoes_cidade_data
    ON meteorologia.previsoes_meteorologicas USING btree
    (nome_cidade COLLATE pg_catalog."default" ASC NULLS LAST, data_previsao ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_previsoes_data

-- DROP INDEX IF EXISTS meteorologia.idx_previsoes_data;

CREATE INDEX IF NOT EXISTS idx_previsoes_data
    ON meteorologia.previsoes_meteorologicas USING btree
    (data_previsao ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;


-- Table: meteorologia.resumo_cidades

-- DROP TABLE IF EXISTS meteorologia.resumo_cidades;

CREATE TABLE IF NOT EXISTS meteorologia.resumo_cidades
(
    id integer NOT NULL DEFAULT nextval('meteorologia.resumo_cidades_id_seq'::regclass),
    nome_cidade_normalizado character varying(50) COLLATE pg_catalog."default" NOT NULL,
    regiao character varying(20) COLLATE pg_catalog."default",
    dias_analisados integer,
    temp_media_cidade numeric(5,2),
    temp_min_cidade numeric(5,2),
    temp_max_cidade numeric(5,2),
    score_medio numeric(5,2),
    score_maximo integer,
    total_alertas_criticos integer DEFAULT 0,
    total_alertas_altos integer DEFAULT 0,
    total_alertas_medios integer DEFAULT 0,
    risco_cidade character varying(20) COLLATE pg_catalog."default",
    data_insercao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT resumo_cidades_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS meteorologia.resumo_cidades
    OWNER to postgres;

COMMENT ON TABLE meteorologia.resumo_cidades
    IS 'Resumo agregado de alertas por cidade';
-- Index: idx_resumo_cidade

-- DROP INDEX IF EXISTS meteorologia.idx_resumo_cidade;

CREATE INDEX IF NOT EXISTS idx_resumo_cidade
    ON meteorologia.resumo_cidades USING btree
    (nome_cidade_normalizado COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;


-- SCHEMA: registos

-- DROP SCHEMA IF EXISTS registos ;

CREATE SCHEMA IF NOT EXISTS registos
    AUTHORIZATION postgres;



-- Table: registos.logs

-- DROP TABLE IF EXISTS registos.logs;

CREATE TABLE IF NOT EXISTS registos.logs
(
    id_job integer,
    jobname character varying(255) COLLATE pg_catalog."default",
    status character varying(15) COLLATE pg_catalog."default",
    errors bigint,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    logdate timestamp without time zone,
    depdate timestamp without time zone,
    log_field text COLLATE pg_catalog."default",
    executing_server character varying(255) COLLATE pg_catalog."default",
    executing_user character varying(255) COLLATE pg_catalog."default",
    client character varying(255) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS registos.logs
    OWNER to postgres;
-- Index: idx_logs_1

-- DROP INDEX IF EXISTS registos.idx_logs_1;

CREATE INDEX IF NOT EXISTS idx_logs_1
    ON registos.logs USING btree
    (id_job ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_logs_2

-- DROP INDEX IF EXISTS registos.idx_logs_2;

CREATE INDEX IF NOT EXISTS idx_logs_2
    ON registos.logs USING btree
    (errors ASC NULLS LAST, status COLLATE pg_catalog."default" ASC NULLS LAST, jobname COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_logs_3

-- DROP INDEX IF EXISTS registos.idx_logs_3;

CREATE INDEX IF NOT EXISTS idx_logs_3
    ON registos.logs USING btree
    (jobname COLLATE pg_catalog."default" ASC NULLS LAST, logdate ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;


