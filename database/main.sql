CREATE DATABASE credit_hub;

CREATE SCHEMA IF NOT EXISTS usermgmt;


DROP SEQUENCE IF EXISTS "usermgmt"."users_rid" CASCADE;

CREATE SEQUENCE IF NOT EXISTS "usermgmt"."users_rid"
    INCREMENT 1
    START 1
    MINVALUE 1
    CACHE 1;  

DROP TABLE IF EXISTS "usermgmt"."users" CASCADE;


-- Create the table
CREATE TABLE IF NOT EXISTS usermgmt.users (
    rid bigint NOT NULL DEFAULT nextval('"usermgmt"."users_rid"'::regclass), 
    uname text NOT NULL,
    created_at timestamp WITH time ZONE NOT NULL DEFAULT now(),
    updated_by bigint,
    updated_at timestamp WITH time ZONE,
    PRIMARY KEY (rid)
);

ALTER TABLE IF EXISTS usermgmt.users 
ADD COLUMN IF NOT EXISTS "is_deleted" boolean NOT NULL DEFAULT false;

ALTER TABLE IF EXISTS usermgmt.users 
ADD COLUMN IF NOT EXISTS "password" text NOT NULL;

ALTER TABLE IF EXISTS usermgmt.users 
ADD COLUMN IF NOT EXISTS "is_active" boolean NOT NULL DEFAULT false;




CREATE SCHEMA IF NOT EXISTS amountmgmt;


DROP SEQUENCE IF EXISTS "amountmgmt"."amounts_rid" CASCADE;

CREATE SEQUENCE IF NOT EXISTS "amountmgmt"."amounts_rid"
    INCREMENT 1
    START 1
    MINVALUE 1
    CACHE 1;  

DROP TABLE IF EXISTS "amountmgmt"."amounts" CASCADE;


-- Create the table
CREATE TABLE IF NOT EXISTS amountmgmt.amounts (
    rid bigint NOT NULL DEFAULT nextval('"amountmgmt"."amounts_rid"'::regclass), 
    debit_uid bigint NOT NULL,
    credit_uid bigint NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    paid_amount NUMERIC(10,2),
    is_active boolean NOT NULL DEFAULT TRUE,
    is_deleted boolean NOT NULL DEFAULT FALSE,
    created_at timestamp WITH time ZONE NOT NULL DEFAULT now(),
    created_by bigint,
    updated_by bigint,
    updated_at timestamp WITH time ZONE,
    PRIMARY KEY (rid)
);

ALTER TABLE IF EXISTS amountmgmt.amounts DROP CONSTRAINT IF EXISTS accounts_credit_id_fkey CASCADE;

ALTER TABLE IF EXISTS amountmgmt.amounts
ADD CONSTRAINT accounts_credit_id_fkey FOREIGN KEY (credit_uid) REFERENCES usermgmt.users (rid);

ALTER TABLE IF EXISTS amountmgmt.amounts DROP CONSTRAINT IF EXISTS accounts_debit_id_fkey CASCADE;

ALTER TABLE IF EXISTS amountmgmt.amounts
ADD CONSTRAINT accounts_debit_id_fkey FOREIGN KEY (debit_uid) REFERENCES usermgmt.users (rid);


COMMENT ON TABLE "amountmgmt"."amounts" IS 'accounts management';



DROP SEQUENCE IF EXISTS "amountmgmt"."expense_rid" CASCADE;

CREATE SEQUENCE IF NOT EXISTS "amountmgmt"."expense_rid"
    INCREMENT 1
    START 1
    MINVALUE 1
    CACHE 1;  

DROP TABLE IF EXISTS "amountmgmt"."expense" CASCADE;


-- Create the table
CREATE TABLE IF NOT EXISTS amountmgmt.expense (
    rid bigint NOT NULL DEFAULT nextval('"amountmgmt"."expense_rid"'::regclass), 
    uid bigint NOT NULL,
    info_id bigint NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL,
    is_active boolean NOT NULL DEFAULT TRUE,
    is_deleted boolean NOT NULL DEFAULT FALSE,
    created_at timestamp WITH time ZONE NOT NULL DEFAULT now(),
    created_by bigint,
    updated_by bigint,
    updated_at timestamp WITH time ZONE,
    PRIMARY KEY (rid)
);

ALTER TABLE IF EXISTS amountmgmt.expense DROP CONSTRAINT IF EXISTS expense_uid_fkey CASCADE;

ALTER TABLE IF EXISTS amountmgmt.expense
ADD CONSTRAINT expense_uid_fkey FOREIGN KEY (uid) REFERENCES usermgmt.users (rid);


COMMENT ON TABLE "amountmgmt"."expense" IS 'total expense';



DROP SEQUENCE IF EXISTS "usermgmt"."group_rid" CASCADE;

CREATE SEQUENCE IF NOT EXISTS "usermgmt"."group_rid"
    INCREMENT 1
    START 1
    MINVALUE 1
    CACHE 1;  

DROP TABLE IF EXISTS "usermgmt"."group_info" CASCADE;


-- Create the table
CREATE TABLE IF NOT EXISTS usermgmt.group_info (
    rid bigint NOT NULL DEFAULT nextval('"usermgmt"."group_rid"'::regclass), 
    name text NOT NULL,
    descr TEXT,
    is_active boolean NOT NULL DEFAULT TRUE,
    is_deleted boolean NOT NULL DEFAULT FALSE,
    created_at timestamp WITH time ZONE NOT NULL DEFAULT now(),
    created_by bigint,
    updated_by bigint,
    updated_at timestamp WITH time ZONE,
    PRIMARY KEY (rid)
);


COMMENT ON TABLE "usermgmt"."group_info" IS 'group_info';




DROP SEQUENCE IF EXISTS "usermgmt"."user_group_rid" CASCADE;

CREATE SEQUENCE IF NOT EXISTS "usermgmt"."user_group_rid"
    INCREMENT 1
    START 1
    MINVALUE 1
    CACHE 1;  

DROP TABLE IF EXISTS "usermgmt"."user_group" CASCADE;


-- Create the table
CREATE TABLE IF NOT EXISTS usermgmt.user_group (
    rid bigint NOT NULL DEFAULT nextval('"usermgmt"."user_group_rid"'::regclass), 
    uid bigint NOT NULL,
    group_id bigint NOT NULL,
    is_active boolean NOT NULL DEFAULT TRUE,
    is_deleted boolean NOT NULL DEFAULT FALSE,
    created_at timestamp WITH time ZONE NOT NULL DEFAULT now(),
    created_by bigint,
    updated_by bigint,
    updated_at timestamp WITH time ZONE,
    PRIMARY KEY (rid)
);

ALTER TABLE IF EXISTS usermgmt.user_group DROP CONSTRAINT IF EXISTS user_group_uid_fkey CASCADE;

ALTER TABLE IF EXISTS usermgmt.user_group
ADD CONSTRAINT user_group_uid_fkey FOREIGN KEY (uid) REFERENCES usermgmt.users (rid);

ALTER TABLE IF EXISTS usermgmt.user_group DROP CONSTRAINT IF EXISTS user_group_gid_fkey CASCADE;

ALTER TABLE IF EXISTS usermgmt.user_group
ADD CONSTRAINT user_group_gid_fkey FOREIGN KEY (group_id) REFERENCES usermgmt.group_info (rid);

COMMENT ON TABLE "usermgmt"."user_group" IS 'user group details';



DROP SEQUENCE IF EXISTS "amountmgmt"."expense_info_rid" CASCADE;

CREATE SEQUENCE IF NOT EXISTS "amountmgmt"."expense_info_rid"
    INCREMENT 1
    START 1
    MINVALUE 1
    CACHE 1;  

DROP TABLE IF EXISTS "amountmgmt"."expense_info" CASCADE;


-- Create the table
CREATE TABLE IF NOT EXISTS amountmgmt.expense_info (
    rid bigint NOT NULL DEFAULT nextval('"amountmgmt"."expense_info_rid"'::regclass),
    expense_type bigint,
    expense_info text NOT NULL,
    expense_descr TEXT,
    is_deleted boolean NOT NULL DEFAULT FALSE,
    created_at timestamp WITH time ZONE NOT NULL DEFAULT now(),
    created_by bigint,
    updated_by bigint,
    updated_at timestamp WITH time ZONE,
    PRIMARY KEY (rid)
);

COMMENT ON TABLE "amountmgmt"."expense_info" IS 'expense info details';






