----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2020 09:30:11 PM
-- Design Name: 
-- Module Name: module1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity module1 is
    generic (n: integer := 7;
            m: integer := 5;
            w: integer);
  Port (A, X, B: in mem;
         F: out mem);
end module1;

architecture Behavioral of module1 is

begin

    process(A, X, B)
    variable product: signed(w-1 downto 0);
    variable p: integer := n + m;
    variable resMat: mem := getMem(p, 1); -- p*1 matrix
    begin
    
        for i in 1 to p loop
            resMat(i, 1) := std_logic_vector((getProduct(A, i, X, 1, p) - signed(B(i, 1))));
        end loop;
    
    end process;


end Behavioral;
