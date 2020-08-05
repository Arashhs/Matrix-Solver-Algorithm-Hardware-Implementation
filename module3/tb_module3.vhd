--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : tb_module2
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_module3 is
--  Port ( );
end tb_module3;

architecture Behavioral of tb_module3 is

component module3 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (DA: in mem(1 to n+m, 1 to n+m);
        G: out mem(1 to n+m, 1 to n+m)
        );
end component;

signal n: integer := 7;
signal m: integer := 5;
signal DA: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);
signal G: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);

begin
m3: module3 generic map(n, m) port map(DA, G);

-- Read matrix DA
DA <= readMat("DA.input.dat", n+m, n+m);
--Write matrix G to file 
process
begin
    wait for 5ns;
    writeMat(G, "G.output.dat");
end process;


end Behavioral;
