/* CMS PROC CD Starts */

CREATE TABLE CMS_PROC_CD
(
    proc_cd VARCHAR(15) NOT NULL,
    cy_txt VARCHAR(4) NOT NULL,
    creat_dttm TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    creat_user_id VARCHAR(250) NULL,
    chg_dttm TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    chg_user_id VARCHAR(250) NULL,
    updt_ver_nbr INTEGER NULL DEFAULT 0,
    creat_sys_ref_id INTEGER NULL,
    chg_sys_ref_id INTEGER NULL,
    data_secur_rule_list JSONB NULL,
    data_qlty_iss_list JSON NULL,
    iptnt_ind SMALLINT NULL,
    CONSTRAINT CMS_PROC_CD_PK PRIMARY KEY (proc_cd,cy_txt)
);

CREATE INDEX CMS_PROC_CD_GIN1 ON CMS_PROC_CD
USING GIN(data_secur_rule_list);

/* CMS PROC CD ENDS */

/* CVX - NDC Starts */

CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE CVX
(
	cvx_cd               VARCHAR(10) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	data_secur_rule_list JSONB NULL,
	data_qlty_iss_list   JSON NULL,
	cvx_shrt_desc        VARCHAR(150) NOT NULL,
	full_vccn_desc       VARCHAR(300) NOT NULL,
	cvx_sts_cd           VARCHAR(20) NOT NULL,
	commt_txt            VARCHAR(1000) NULL,
	lst_cdc_chg_dt       DATE NULL,
	CONSTRAINT CVX_PK PRIMARY KEY (cvx_cd)
);

CREATE INDEX CVX_GIST1 ON CVX
USING GIST(lower(cvx_shrt_desc) gist_trgm_ops);

CREATE INDEX CVX_GIST2 ON CVX
USING GIST(lower(full_vccn_desc) gist_trgm_ops);

CREATE INDEX CVX_GIN1 ON CVX
USING GIN(data_secur_rule_list);

CREATE TABLE NDC_CVX_XWLK
(
	ndc_prdct_pkg_cd     VARCHAR(20) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	data_secur_rule_list JSONB NULL,
	data_qlty_iss_list   JSON NULL,
	cvx_cd               VARCHAR(10) NULL,
	mvx_cd               VARCHAR(10) NULL,
        cvx_othr_txt         VARCHAR(300) NULL,
        strt_dt              DATE NULL,
        end_dt               DATE NULL,
	CONSTRAINT NDC_CVX_XWLK_PK PRIMARY KEY (ndc_prdct_pkg_cd)
);

CREATE INDEX NDC_CVX_XWLK_GIN1 ON NDC_CVX_XWLK
USING GIN(data_secur_rule_list);

ALTER TABLE NDC_CVX_XWLK
ADD CONSTRAINT NDC_CVX_XWLK_CVX_b3df FOREIGN KEY (cvx_cd) REFERENCES CVX (cvx_cd);

/* CVX - NDC Ends */