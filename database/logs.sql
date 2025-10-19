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