--  Usado monitorar o processo que está rodando no Oracle.

DECLARE
  V_RINDEX        BINARY_INTEGER;
  V_SLNO          BINARY_INTEGER;
  V_TOTALWORK     NUMBER DEFAULT 1;
  V_SOFAR         NUMBER DEFAULT 0;
  V_CONTEXT       PLS_INTEGER DEFAULT 0;
  V_OBJ           BINARY_INTEGER DEFAULT 0;
  V_TARGET        PLS_INTEGER DEFAULT 0;
  V_TABLE_TARGET  VARCHAR2(2000);
  V_DESC_OPERACAO VARCHAR2(2000);
  V_UNITS         VARCHAR2(2000) DEFAULT NULL; 
  
BEGIN
  V_RINDEX := DBMS_APPLICATION_INFO.SET_SESSION_LONGOPS_NOHINT;
  V_TABLE_TARGET  := 'teste';
  V_DESC_OPERACAO := 'teste2 ';  
  
  DBMS_APPLICATION_INFO.SET_MODULE(MODULE_NAME => V_TABLE_TARGET,
                                   ACTION_NAME => V_DESC_OPERACAO);
                                   
  /*DBMS_APPLICATION_INFO.SET_SESSION_LONGOPS ( RINDEX      => V_RINDEX,
                                              SLNO        => V_SLNO,
                                              OP_NAME     => V_TABLE_TARGET || V_DESC_OPERACAO,
                                              CONTEXT     => V_CONTEXT,
                                              SOFAR       => V_SOFAR,
                                              TOTALWORK   => V_TOTALWORK,
                                              TARGET      => V_TARGET,
                                              TARGET_DESC => V_TABLE_TARGET || V_DESC_OPERACAO,
                                              UNITS       => V_UNITS) ;  */
END ;