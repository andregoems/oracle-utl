-- Todo cabeçalho de procedure deve conter a variável de inpunt I_LogID, exatamente como no exemplo abaixo 
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE  SUA_PROCEDURE (I_LogID IN NUMBER DEFAULT NULL) IS 
--- ------------------------------------------------------------------------------------------------------------------------------------------------------------
  --    Variáveis para o LOG
  V_objectname   VARCHAR2(200) :='SUA_PROCEDURE';
  V_logtimestamp TIMESTAMP     :=LOCALTIMESTAMP ;
  V_descr        VARCHAR2(200) ;
  V_logid        NUMBER        :=I_LogID;

BEGIN 
  -- INICIO
   V_descr:='Inserindo dados na tabela xxxx';
  PKG_LOG$PROCESSOS.INICIO(I_OBJECTNAME => V_objectname, I_DESCR => V_descr, IO_LOGID => V_logid, O_LOGTIMESTAMP => V_logtimestamp);
  

  -- PROCESSANDO
   V_descr:='Escrever aqui o que está sendo processado';  
  PKG_LOG$PROCESSOS.PROCESSANDO ( I_OBJECTNAME => V_objectname, I_DESCR => V_descr, I_LOGID => V_logid, I_LOGTIMESTAMP => V_logtimestamp) ;
  
  -- FIM -- ERRO
  PKG_LOG$PROCESSOS.FIM ( I_OBJECTNAME => V_objectname, I_DESCR => V_descr, I_LOGID => V_logid, I_LOGTIMESTAMP => V_logtimestamp);        
    EXCEPTION 
	  WHEN OTHERS THEN   
	   ROLLBACK ; 
	    PKG_LOG$PROCESSOS.ERRO ( I_OBJECTNAME=>V_objectname,I_LOGID=> V_logid,I_LOGTIMESTAMP => V_logtimestamp,
		            		     I_SQLCOD=> SQLCODE,I_SQLERRM=> SQLERRM,I_SQLERRFORMAT => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE) ; 

 END  ;
--- ------------------------------------------------------------------------------------------------------------------------------------------------------------