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