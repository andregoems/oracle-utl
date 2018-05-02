

-- PLSQL_CODE_TYPE = ‘INTERPRETED’: Neste modo, o código é compilado em uma área intermediaria da memória e persistido no dicionário de dados da instancia, para ser interpretado em tempo de execução (o que é mais demorado).

-- PLSQL_CODE_TYPE = ‘NATIVE’: Neste caso o código não será interpretado em tempo de execução, pois o mesmo já será persistido em sua forma nativa, consequentemente a execução será mais rápida.

-- Você pode alterar o valor do parâmetro PLSQL_CODE_TYPE no escopo de sessão:

ALTER SESSION SET PLSQL_CODE_TYPE = NATIVE;

-- Ou no momento da compilação do seu objeto PLSQL:

ALTER PROCEDURE my_proc COMPILE PLSQL_CODE_TYPE = NATIVE;