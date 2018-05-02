  create or replace PACKAGE PKG_TYPES IS

--- ---------------------------------------------------------------------------------------------------------------------------------------------
TYPE TbTpCARTEIRA IS TABLE OF CARTEIRA%ROWTYPE;
TYPE RwTpCARTEIRA IS RECORD(
                            SERNOCT CARTEIRA.SERNOCT%TYPE,
                            ANOMES_DTBASE CARTEIRA.ANOMES_DTBASE%TYPE,
                            DTBASE CARTEIRA.DTBASE%TYPE,
                            TPTRANSACAO CARTEIRA.TPTRANSACAO%TYPE,
                            PRODUTO CARTEIRA.PRODUTO%TYPE,
                            CACCSERNO CARTEIRA.CACCSERNO%TYPE,
                            CARDSERNO CARTEIRA.CARDSERNO%TYPE,
                            PARCELA CARTEIRA.PARCELA%TYPE,
                            TX_JUROS CARTEIRA.TX_JUROS%TYPE,
                            TX_IOF_ABERTURA CARTEIRA.TX_IOF_ABERTURA%TYPE,
                            TX_IOF_DIARIO CARTEIRA.TX_IOF_DIARIO%TYPE,
                            CONTRATACAO CARTEIRA.CONTRATACAO%TYPE,
                            DT_BASE_PRORATA CARTEIRA.DT_BASE_PRORATA%TYPE,
                            VENCIMENTO1 CARTEIRA.VENCIMENTO1%TYPE,
                            DIAS_PRO_RATA CARTEIRA.DIAS_PRO_RATA%TYPE,
                            PRINCIPAL CARTEIRA.PRINCIPAL%TYPE,
                            TOTAL_FINANCIADO CARTEIRA.TOTAL_FINANCIADO%TYPE,
                            ULTIMA_POSTAGEM_PREVISTA CARTEIRA.ULTIMA_POSTAGEM_PREVISTA%TYPE,
                            POSTAGEM CARTEIRA.POSTAGEM%TYPE,
                            ULTIMO_VENCIMENTO_PREVISTO CARTEIRA.ULTIMO_VENCIMENTO_PREVISTO%TYPE,
                            VENCIMENTO CARTEIRA.VENCIMENTO%TYPE,
                            TOTAL_PARCELA CARTEIRA.TOTAL_PARCELA%TYPE,
                            TOTAL_FINANCIAMENTO CARTEIRA.TOTAL_FINANCIAMENTO%TYPE,
                            PRINCIPAL_AMORT CARTEIRA.PRINCIPAL_AMORT%TYPE,
                            IOF_ABER_OP_AMORT CARTEIRA.IOF_ABER_OP_AMORT%TYPE,
                            IOF_DIARIO_AMORT CARTEIRA.IOF_DIARIO_AMORT%TYPE,
                            JUROS_AMORT CARTEIRA.JUROS_AMORT%TYPE,
                            PRINCIPAL_SALDO CARTEIRA.PRINCIPAL_SALDO%TYPE,
                            IOF_ABER_OP_SALDO CARTEIRA.IOF_ABER_OP_SALDO%TYPE,
                            IOF_DIARIO_SALDO CARTEIRA.IOF_DIARIO_SALDO%TYPE,
                            JUROS_SALDO CARTEIRA.JUROS_SALDO%TYPE,
                            PRINCIPAL_72 CARTEIRA.PRINCIPAL_72%TYPE,
                            IOF_ABER_OP_72 CARTEIRA.IOF_ABER_OP_72%TYPE,
                            IOF_DIARIO_72 CARTEIRA.IOF_DIARIO_72%TYPE,
                            JUROS_72 CARTEIRA.JUROS_72%TYPE,
                            PRINCIPAL_72_CUR CARTEIRA.PRINCIPAL_72_CUR%TYPE,
                            IOF_ABER_OP_72_CUR CARTEIRA.IOF_ABER_OP_72_CUR%TYPE,
                            IOF_DIARIO_72_CUR CARTEIRA.IOF_DIARIO_72_CUR%TYPE,
                            JUROS_72_CUR CARTEIRA.JUROS_72_CUR%TYPE );
-- ---------------------------------------------------------------------------------------------------------------------------------------------

END PKG_TYPES;
-- ---------------------------------------------------------------------------------------------------------------------------------------------




CREATE OR REPLACE FUNCTION FC_CARTEIRA (I_VISAO VARCHAR2)
  RETURN PKG_TYPES.TbTpCARTEIRA PIPELINED IS var_linha PKG_TYPES.RwTpCARTEIRA;
BEGIN
  FOR CUR_ROW IN
  ( SELECT
      SERNOCT,
      ANOMES_DTBASE,
      TPTRANSACAO,
      PRODUTO,
      PRINCIPAL_SALDO FROM  CARTEIRA  WHERE ANOMES_DTBASE =  I_VISAO
  ) LOOP
  
    var_linha.SERNOCT         :=CUR_ROW.SERNOCT;
    var_linha.ANOMES_DTBASE   :=CUR_ROW.ANOMES_DTBASE;
    var_linha.TPTRANSACAO     :=CUR_ROW.TPTRANSACAO;
    var_linha.PRODUTO         :=cur_row.PRODUTO ;
    var_linha.PRINCIPAL_SALDO :=cur_row.PRINCIPAL_SALDO ;
    PIPE ROW(VAR_LINHA);
  
  END LOOP;
RETURN;
END FC_CARTEIRA;


SELECT
  SERNOCT,
  ANOMES_DTBASE,
  TPTRANSACAO,
  PRODUTO,
  PRINCIPAL_SALDO
FROM
  TABLE(FC_CARTEIRA('201507')) ;
  


     
  

   1- Criando a package HR.PKG_TYPES  
        A package HR.PKG_TYPES contém os tipos de dados que são criados para retornarem uma tabela virtual na função que será criada no próximo passo:


          create or replace package HR.PKG_TYPES as   
                      TYPE TABLEEMPTYPE IS TABLE OF EMPLOYEES%ROWTYPE;
                      TYPE ROWEMPTYPE IS RECORD (EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE,
                                  FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
                                  LAST_NAME EMPLOYEES.LAST_NAME%TYPE,
                                  EMAIL EMPLOYEES.EMAIL%TYPE,
                                  PHONE EMPLOYEES.PHONE_NUMBER%TYPE,
                                  HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE,
                                  JOB_ID EMPLOYEES.JOB_ID%TYPE,
                                  SALARY EMPLOYEES.SALARY%TYPE,                                 
                                  COMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE,
                                  MANAGER_ID EMPLOYEES.MANAGER_ID%TYPE,
                                  DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE                                  );   
            END;
            /
    
   2- Criando a função HR.FC_OBTER_EMPREGADOS   
        A função HR.FC_OBTER_EMPREGADOS lê e retorna os dados de apenas 4 colunas da tabela HR.EMPLOYEES, transformando os dados das colunas LAST_NAME e EMAIL:


           CREATE OR REPLACE  function HR.FC_OBTER_EMPREGADOS
                         return PKG_TYPES.TABLEEMPTYPE PIPELINED IS
                               var_linha PKG_TYPES.ROWEMPTYPE;
           BEGIN
                   FOR CUR_ROW IN (SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL
                                                 FROM    HR.EMPLOYEES)
                   LOOP
                         var_linha.EMPLOYEE_ID:=CUR_ROW.EMPLOYEE_ID;
                         var_linha.FIRST_NAME:=CUR_ROW.FIRST_NAME;
                         var_linha.LAST_NAME:=UPPER(CUR_ROW.LAST_NAME);
                         var_linha.EMAIL:= UPPER(cur_row.EMAIL || '@ORACLE.COM');
 
                        PIPE ROW(VAR_LINHA);
                  END LOOP;
        
                  RETURN;
           END;
           /


         Obs.: A instrução PIPE ROW retorna os resultados para a sessão de usuário Oracle, linha por linha. Isso otimiza o tempo de resposta da aplicação.
     

   3- Testando a função HR.FC_OBTER_EMPREGADOS    
         A query abaixo retorna os dados da função HR.FC_OBTER_EMPREGADOS, como se fossem uma tabela virtual:


        SELECT * FROM TABLE(HR.FC_OBTER_EMPREGADOS);  
  