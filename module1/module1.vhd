--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : module1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;

entity module1 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        F: out mem(1 to n+m, 1 to 1));
end module1;

architecture Behavioral of module1 is

begin

    F <= (A*X) - B;

end Behavioral;
