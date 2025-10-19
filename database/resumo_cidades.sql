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