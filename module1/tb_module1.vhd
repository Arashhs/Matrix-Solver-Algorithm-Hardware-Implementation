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
  port (A: in memA;
        X: in memB;
        B: in memB;
        F: out memB);
end component;

signal n: integer := 7;
signal m: integer := 5;

signal A: memA := getMemA;
signal X: memB := getMemB;
signal B: memB := getMemB;
signal F: memB := getMemB;

begin
m1: module1 port map(A, X, B, F);


	
-- Read matrix A
process
      file infile          : text is in "A.input.dat";
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
               A(i, j) <= std_logic_vector(to_signed(element, w));
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
               B(i, j) <= std_logic_vector(to_signed(element, w));
               read(row, element, end_of_line); 
            end loop;
            end_of_line := true;
         end loop;
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
               X(i, j) <= std_logic_vector(to_signed(element, w));
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
            element := to_integer(signed(F(i, 1)));
            write(row, element);
            writeline(infile, row);
         end loop;
         wait;
   end process;


end Behavioral;
