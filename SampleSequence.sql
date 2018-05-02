

CREATE
  TABLE "ANDRE_SANTOS"."PC_TB_PARCELE_TPTRNX"
  (
    "PC_TB_PARCELE_TPTRNX_ID"  NUMBER NOT NULL ,
    "PARCELE_SERNOCT"          NUMBER(10,0) NOT NULL ENABLE,
    "PARCELE_CACCSERNO"        NUMBER(10,0),
    "PARCELE_I013_TRXN_DATE"   VARCHAR2(8 BYTE),
    "PARCELE_TPTRANSACAO"      VARCHAR2(46 BYTE),
    "PARCELE_VALOR"            NUMBER,
    "PAGAMENTO_SERNOCT"        NUMBER(10,0) NOT NULL ENABLE,
    "PAGAMENTO_TPTRANSACAO"    VARCHAR2(50 BYTE),
    "PAGAMENTO_I013_TRXN_DATE" VARCHAR2(8 BYTE),
    "PAGAMENTO_VALOR"          NUMBER,
    "PARCELE_SALDO"            NUMBER,
    "PARCELE_SALDO_POSITION"   NUMBER
  );
  

CREATE SEQUENCE PC_SQ_PARCELE_TPTRNX
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

  
CREATE OR REPLACE TRIGGER PC_TG_PARCELE_TPTRNX BEFORE
  INSERT
    ON PC_TB_PARCELE_TPTRNX FOR EACH ROW BEGIN 
          <<COLUMN_SEQUENCES>>
            BEGIN 
            IF INSERTING AND :NEW.PC_TB_PARCELE_TPTRNX_ID IS NULL THEN
                  SELECT  PC_SQ_PARCELE_TPTRNX.NEXTVAL   INTO :NEW.PC_TB_PARCELE_TPTRNX_ID FROM DUAL;
            END IF;
          END COLUMN_SEQUENCES;
END;



