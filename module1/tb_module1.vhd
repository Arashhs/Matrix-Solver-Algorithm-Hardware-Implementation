----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2020 07:05:12 PM
-- Design Name: 
-- Module Name: tb_module1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_module1 is
--  Port ( );
end tb_module1;

architecture Behavioral of tb_module1 is

component module1 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        F: out mem(1 to n+m, 1 to 1));
end component;

signal n: integer := 7;
signal m: integer := 5;

signal A: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);
signal X: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal B: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal F: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);

begin
m1: module1 port map(A, X, B, F);

-- Read matrix A
A <= readMat("A.input.dat", n+m, n+m);
--Read matrix X   
X <= readMat("X.input.dat", n+m, 1);
--Read matrix B  
B <= readMat("B.input.dat", n+m, 1);
--Write matrix F to file 
process
begin
    wait for 5ns;
    writeMat(F, "F.output.dat");
end process;


end Behavioral;
