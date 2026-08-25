-- PROCEDURE
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Sum(a IN NUMBER, b IN NUMBER) IS
   c NUMBER;
BEGIN
   c := a + b;
   DBMS_OUTPUT.PUT_LINE('Sum of two nos= ' || c);
END Sum;
/

-- Calling the procedure
SET SERVEROUTPUT ON;
DECLARE
   x NUMBER;
   y NUMBER;
BEGIN
   x := &x;
   y := &y;
   Sum(x, y);
END;
/
-- Output: Enter value for x: 10, Enter value for y: 20 -> Sum of two nos= 30

-- FUNCTION
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION Sum(a IN NUMBER, b IN NUMBER) RETURN NUMBER IS
   c NUMBER;
BEGIN
   c := a + b;
   RETURN c;
END;
/

-- Calling the function
SET SERVEROUTPUT ON;
DECLARE
   no1 NUMBER;
   no2 NUMBER;
   result NUMBER;
BEGIN
   no1 := &no1;
   no2 := &no2;
   result := Sum(no1, no2);
   DBMS_OUTPUT.PUT_LINE('Sum of two nos=' || result);
END;
/
-- Output: Enter value for no1:5, Enter value for no2:5 -> Sum of two nos=10