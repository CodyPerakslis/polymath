/* Challenge:
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
*/

-- Running: I used posgres,
-- `pg_ctl -D /usr/local/var/postgres start` to start it up
-- `psql postgres -f even_fib.sql` to execute
-- `pg_ctl -D /usr/local/var/postgres stop` to turn it off

-- Method:
-- Since I only need the even fibonacci terms (every 3rd),
-- I can skip to only the even values using the following:
--
-- let b be an even fibonacci (lowest being 2)
-- let a be the fibonacci that directly precedes a (lowest being 1)
-- next_1 = a+b
-- next_2 = a+next_1 = 2a+b
-- next_3 = next_1 + next_2 = (a+b)+(2a+b) = 3a+2b
-- Since it is every third, b_new = next_2, a_new = next_3.
-- This way every iteration of the loop gives us a new even fibonacci value.
CREATE OR REPLACE FUNCTION even_fib()
RETURNS int AS
$$
DECLARE
top_value INT := 4000000;

even_total INT := 0;
odd_value INT := 1;
even_value INT := 2;
hold_value INT := 0;
BEGIN
  WHILE even_value <= top_value LOOP
    even_total := even_total + even_value;
    hold_value := odd_value + 2*even_value;
    even_value := 2*odd_value + 3*even_value;
    odd_value := hold_value;
  END LOOP;
  RETURN even_total;
END;

$$
LANGUAGE 'plpgsql';

select * from even_fib();
