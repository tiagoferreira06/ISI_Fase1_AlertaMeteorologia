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