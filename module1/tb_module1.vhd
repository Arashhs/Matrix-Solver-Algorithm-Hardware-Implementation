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
process
      file infile          : text is in "A.input.dat";
      variable row         : line;
      variable element     : integer;
      variable end_of_line : boolean := true;
      variable i, j: integer := 0;  
      variable A_var : mem(1 to n+m, 1 to n+m);  
   begin
         while(not endfile(infile))loop
            i := i + 1;
            readline(infile, row);
            read(row, element, end_of_line); 
            j := 0;
            while(end_of_line)loop
               j := j + 1;
               A_var(i, j) := std_logic_vector(to_signed(element, w));
               read(row, element, end_of_line); 
            end loop;
            end_of_line := true;
         end loop;

         A <= A_var;
         wait;
   end process;
   

--Read matrix X   
process
      file infile          : text is in "X.input.dat";
      variable row         : line;
      variable element     : integer;
      variable end_of_line : boolean := true;
      variable i, j: integer := 0;    
   begin
         while(not endfile(infile))loop
            i := i + 1;
            readline(infile, row);
            read(row, element, end_of_line); 
            j := 0;
            while(end_of_line)loop
               j := j + 1;
               X(i,1) <= std_logic_vector(to_signed(element, w));
               read(row, element, end_of_line); 
            end loop;
            end_of_line := true;
         end loop;
         wait;
   end process;

--Read matrix B  
process
      file infile          : text is in "B.input.dat";
      variable row         : line;
      variable element     : integer;
      variable end_of_line : boolean := true;
      variable i, j: integer := 0;    
   begin
         while(not endfile(infile))loop
            i := i + 1;
            readline(infile, row);
            read(row, element, end_of_line); 
            j := 0;
            while(end_of_line)loop
               j := j + 1;
               B(i,1) <= std_logic_vector(to_signed(element, w));
               read(row, element, end_of_line); 
            end loop;
            end_of_line := true;
         end loop;
         wait;
   end process;
   
--Write matrix F to file  
process
      file infile          : text open write_mode is "F.output.dat";
      variable row         : line;
      variable element     : integer;
      variable end_of_line : boolean := true;
      variable i, j: integer := 0;    
   begin
        wait for 10ns;
         for i in 1 to m + n loop
            element := to_integer(signed(F(i,1)));
            write(row, element);
            writeline(infile, row);
         end loop;
         wait;
   end process;


end Behavioral;
