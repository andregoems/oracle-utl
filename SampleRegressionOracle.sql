--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE
  TABLE CHECK_REG
  (
    OBSERVACAO  VARCHAR2(50 BYTE),
    DUREZA      NUMBER,
    TEMPERATURA NUMBER
  );
 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
 
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('1','137','220');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('2','137','220');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('3','137','220');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('4','136','220');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('5','135','220');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('6','135','225');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('7','133','225');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('8','132','225');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('9','133','225');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('10','133','225');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('11','128','230');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('12','124','230');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('13','126','230');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('14','129','230');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('15','126','230');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('16','122','235');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('17','122','235');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('18','122','235');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('19','119','235');
Insert into CHECK_REG (OBSERVACAO,DUREZA,TEMPERATURA) values ('20','122','235');

--------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT ROUND(SQRT(REGR_R2(TEMPERATURA, DUREZA)), 8) AS R,
       ROUND(REGR_R2(TEMPERATURA, DUREZA), 8)       AS R2,
       ROUND(REGR_SLOPE(TEMPERATURA, DUREZA), 8)    AS INCLINACAO_RETA,
       REGR_INTERCEPT(TEMPERATURA, DUREZA)          AS INTERCECAO_RETA 
  FROM CHECK_REG;
--  regressão linear
--  y= INCLINACAO_RETA * x  + INTERCECAO_RETA

--------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT CHECK_REG.OBSERVACAO,
       CHECK_REG.TEMPERATURA,
       CHECK_REG.DUREZA,
       (TB.INCLINACAO_RETA * CHECK_REG.dureza) + TB.INTERCECAO_RETA AS CALCULO
  FROM CHECK_REG
INNER JOIN (SELECT SQRT(REGR_R2(TEMPERATURA, DUREZA)) AS R,
                   REGR_R2(TEMPERATURA, DUREZA)       AS R2,
                   REGR_SLOPE(TEMPERATURA, DUREZA)    AS INCLINACAO_RETA,
                   REGR_INTERCEPT(TEMPERATURA, DUREZA)          AS INTERCECAO_RETA 
              FROM CHECK_REG)  tb  
 ON  CHECK_REG.OBSERVACAO <> '100000';
