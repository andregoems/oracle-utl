DECLARE
  ex_custom EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_custom, -20001 );
BEGIN
  raise_application_error( -20001, 'This is a custom error' );
EXCEPTION
WHEN ex_custom THEN
  dbms_output.put_line( sqlerrm );
END;