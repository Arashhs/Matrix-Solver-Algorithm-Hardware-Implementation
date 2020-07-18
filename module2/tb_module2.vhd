--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : tb_module2
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_module2 is
--  Port ( );
end tb_module2;

architecture Behavioral of tb_module2 is

component module2 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        DA: out mem(1 to n+m, 1 to n+m));
end component;

signal n: integer := 7;
signal m: integer := 5;

signal A: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);
signal X: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal DA: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);

begin
m2: module2 port map(A, X, DA);

-- Read matrix A
A <= readMat("A.input.dat", n+m, n+m);
--Read matrix X   
X <= readMat("X.input.dat", n+m, 1);
--Write matrix DA to file 
process
begin
    wait for 5ns;
    writeMat(DA, "DA.output.dat");
end process;


end Behavioral;

