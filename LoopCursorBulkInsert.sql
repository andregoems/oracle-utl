---  insert  
DECLARE  
  TYPE T_Cursor IS REF CURSOR;                                              
  V_T_Cursor T_Cursor;
  
  TYPE   TC_Table  IS TABLE OF SYS.DUAL%ROWTYPE ;                          -- Tabela que ser� onde ser�o inseridos os dados. Alterar quando necess�rio
  V_TC_Table TC_Table;  
     
  V_ArraySize PLS_INTEGER :=1000000 ;                                      -- Quantidades de linhas inseridas por loop. Manter abaixo de 1000000 pois h� risco de "estouro" de m�moria do Servidor.
    
  BEGIN    
      OPEN V_T_Cursor FOR                                                  -- Select que recuperara os dado para inser��o. Alterar quando necess�rio.
        SELECT /*+ PARALLEL */ *  
       FROM  DUAL  ; 
       
      LOOP
      FETCH V_T_Cursor BULK COLLECT INTO V_TC_Table LIMIT V_ArraySize;
  
      FORALL I IN 1..V_TC_Table.COUNT
      INSERT /*+ APPEND_VALUES PARALLEL */ 
		  INTO SYS.DUAL VALUES V_TC_Table(I);                                 -- Tabela que ser� onde ser�o inseridos os dados. Alterar quando necess�rio
      COMMIT;
           -- DBMS_OUTPUT.PUT_LINE('linha ='||I||' coluna1 '|| V_TC_Table(1).DUMMY) ;                           -- debug      
      EXIT WHEN V_T_Cursor%NOTFOUND;
      END LOOP;
      CLOSE V_T_Cursor;
       
  END ; 	
  
  
  
---
DECLARE  
  TYPE T_Cursor IS REF CURSOR;                                              
  V_T_Cursor T_Cursor;
  
  TYPE   TC_Table  IS TABLE OF PC_TB_CACCOUNTS_INPUT.CACCSERNO%TYPE ;      -- Tabela/Coluna que ser� como chave para o delete. Alterar quando necess�rio
  V_TC_Table TC_Table;  
     
  V_ArraySize PLS_INTEGER :=1000 ;                                         -- Quantidades de chaves/linhas processadas por delete 
  
  V_ROWS_AFFECTED  NUMBER ;                                        
  V_SEQ  NUMBER ;    

  BEGIN    
      OPEN V_T_Cursor FOR                                                  -- Select que recuperara a tabela chave para o delete 
       SELECT   CACCSERNO FROM PC_TB_CACCOUNTS_INPUT;
       
      LOOP
      FETCH V_T_Cursor BULK COLLECT INTO V_TC_Table LIMIT V_ArraySize;
  
      FORALL I IN 1..V_TC_Table.COUNT
      DELETE FROM  PC_TB_CACCOUNTS_HIST
		  WHERE  CACCSERNO =  V_TC_Table(I);                               -- Tabela que ser� deletado os registros 
      
      V_ROWS_AFFECTED := sql%rowcount ;
      INSERT INTO BK_ROWS_AFFECTED VALUES (SYSDATE,0,V_ROWS_AFFECTED  ); 

      COMMIT;
        
      EXIT WHEN V_T_Cursor%NOTFOUND;
      END LOOP;
      CLOSE V_T_Cursor;
       
  END ; 	
  

SELECT SUM(BK_ROWS_AFFECTED.ROWS_AFFECTED) / 4120487 AS "%",
       SUM(BK_ROWS_AFFECTED.ROWS_AFFECTED) AS EXECUTADO,
       4120487 AS TOTAL
  FROM BK_ROWS_AFFECTED;
  
  