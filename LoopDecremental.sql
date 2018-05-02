DECLARE 
  V_VISAO        NUMBER ;
  V_MES          VARCHAR(2);
  V_ANOMES       NUMBER;
  V_ANOMES_INI   NUMBER;
  V_ANOMES_FIM   NUMBER;
  V_ANO_INI      NUMBER;
  V_ANO_FIM      NUMBER;
BEGIN 
-- VARIAVEIS
V_ANOMES_INI  :=PKG_UTILIDADES.VERIFICA_ANOMES(I_ANOMES => 201506); 
V_ANOMES_FIM  :=PKG_UTILIDADES.VERIFICA_ANOMES(I_ANOMES => 201507); 

V_ANO_INI     := SUBSTR(V_ANOMES_INI,1,4);
V_ANO_FIM     := SUBSTR(V_ANOMES_FIM,1,4); 


FOR ANO IN REVERSE  V_ANO_INI..V_ANO_FIM
  LOOP
    FOR MES IN REVERSE 01..12
    LOOP
      IF MES  < 10 THEN
        V_MES:='0'||MES ;
      ELSE
        V_MES:=MES ;
      END IF ;
      V_ANOMES:=TO_NUMBER(ANO||V_MES);
      V_VISAO:=V_ANOMES ; 
IF  V_ANOMES BETWEEN V_ANOMES_INI AND V_ANOMES_FIM   THEN 

DBMS_OUTPUT.PUT_LINE(PKG_UTILIDADES.VERIFICA_ANOMES(I_ANOMES => V_VISAO));

      END IF  ;    
    END LOOP MES ;
  END LOOP ANO ;
END ; 

EXCEPTION 
 WHEN OTHERS THEN   
/*------------------------------------------------------------------LOG----------------------------------------------------------*/
 AP.AP_SP_LOG(OBJECT_NAME => $$PLSQL_UNIT, -- Nome da procedure pode usar a function $$PLSQL_UNIT 
               DESCR =>'Código Oracle: ' || SQLCODE ||' '||'Mensagem Oracle: '||SQLERRM ||' '|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
               STATUS_ID => 3               -- 0=INICIO 1=FIM  2=PROCESSANDO  3=ERRO */     
               );
/*-------------------------------------------------------------------------------------------------------------------------------*/ 
 DBMS_OUTPUT.PUT_LINE('Código Oracle: ' || SQLCODE ||' '||'Mensagem Oracle: '||SQLERRM ||' '|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
 
END 