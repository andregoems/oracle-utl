-- TABELA

BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME          => 'ANDRE_SANTOS',
                                TABNAME          => 'PC_TB_PARCELE_CORRIGIDO_STG',
                                ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE,
                                METHOD_OPT       =>'for all columns size repeat');
END ; 

-- INDICES

BEGIN
  DBMS_STATS.GATHER_INDEX_STATS(OWNNAME          => 'ANDRE_SANTOS',
                                INDNAME          => 'PC_TB_PARCELE_CORRIGIDO_IDX01',
                                ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE );
END ; 

--  OU 

ALTER INDEX ANDRE_SANTOS.PC_TB_PARCELE_CORRIGIDO_IDX01 REBUILD COMPUTE STATISTICS ; 
