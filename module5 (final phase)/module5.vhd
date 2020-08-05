--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : module4
--  *******************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;

entity module5 is
    generic (n: integer := 4;
            m: integer := 3);
  Port (A12: in mem(1 to n, 1 to m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        clk: in std_logic;
        Xnext: out mem(1 to n+m, 1 to 1);
        G_out: out mem(1 to n+m, 1 to n+m)
        );
end module5;

architecture Behavioral of module5 is

component module4 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        Xnext: out mem(1 to n+m, 1 to 1);
        G_out: out mem(1 to n+m, 1 to n+m);
        Anext: out mem(1 to n+m, 1 to n+m);
        dx: out mem(1 to n+m, 1 to 1);
        F_out: out mem(1 to n+m, 1 to 1) := getMem(n+m, 1)
        );
end component;
signal A_reg: mem(1 to n+m, 1 to n+m);
signal X_reg: mem(1 to n+m, 1 to 1);
signal Xnext_reg: mem(1 to n+m, 1 to 1);
signal G_reg: mem(1 to n+m, 1 to n+m);
signal Anext_reg: mem(1 to n+m, 1 to n+m);
signal dx_reg: mem(1 to n+m, 1 to 1);
signal F: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);

begin
data_path: module4 generic map (n, m) port map(A_reg, X_reg, B, Xnext_reg, G_reg, Anext_reg, dx_reg, F);

 

    process(clk)
    variable maxdx: signed(w-1 downto 0);
    begin
        if(rising_edge(clk)) then
        if A_reg(1,1)(1) = 'U' or X_reg(1,1)(1) = 'X' then
            A_reg <= initA_with_A12 (A12, X); 
            X_reg <= X;
        else
            maxdx := (others => '0');
            for i in 1 to n+m loop
                if abs(signed(dx_reg(i, 1))) > maxdx then
                    maxdx := abs(signed(dx_reg(i, 1)));
                else
                    null;
                end if;
            end loop;
             
            if maxdx >= to_signed(E, w) then
                X_reg <= Xnext_reg; 
                A_reg <= Anext_reg;
            else
                null;
            end if; 
            end if;
            end if;
            G_out <= G_reg;
            Xnext <= X_reg;
            
         end process;
    


end Behavioral;
