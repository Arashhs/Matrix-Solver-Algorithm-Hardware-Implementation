--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : module3
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;

entity module4 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        Xnext: out mem(1 to n+m, 1 to 1);
        G_out: out mem(1 to n+m, 1 to n+m)
        );
end module4;

architecture Behavioral of module4 is

component module1 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        F: out mem(1 to n+m, 1 to 1));
end component;

component module2 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        DA: out mem(1 to n+m, 1 to n+m));
end component;

component module3 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (DA: in mem(1 to n+m, 1 to n+m);
        G: out mem(1 to n+m, 1 to n+m)
        );
end component;

constant n_gen: integer := 7;
constant m_gen: integer := 5;

signal F: mem(1 to n_gen+m_gen, 1 to 1) := getMem(n_gen+m_gen, 1);
signal DA: mem(1 to n_gen+m_gen, 1 to n_gen+m_gen);
signal G: mem(1 to n_gen+m_gen, 1 to n_gen+m_gen);
signal dX: mem(1 to n_gen+m_gen, 1 to 1):= getMem(n_gen+m_gen, 1);
signal Xn: mem(1 to n_gen+m_gen, 1 to 1):= getMem(n_gen+m_gen, 1);
signal Anext: mem(1 to n_gen+m_gen, 1 to n_gen+m_gen):= getMem(n_gen+m_gen, n_gen+m_gen); 

begin
m1: module1 generic map(n_gen, m_gen) port map(A, X, B, F);
m2: module2 generic map(n_gen, m_gen) port map(A, X, DA);
m3: module3 generic map(n_gen, m_gen) port map(DA, G);

G_out <= G;
dX <= G * F;
Xn <= X + dX;
Xnext <= Xn;

process(X)
    variable tmp2, tmp4: signed (2*w - 1 downto 0);
    variable tmp1, tmp3, tmp5: signed(w-1 downto 0);
    variable res: mem(1 to n+m, 1 to n+m);
    begin
        res := copyMat(A);
        for i in 1 to n loop
            tmp1 := to_signed(R_const, w);
            tmp2 := signed(X(i, 1)) * signed(X(i, 1));
            tmp3 := tmp2(w-1 downto 0);
            tmp4 := tmp1 * tmp3;
            tmp5 := tmp4(w-1 downto 0);
            res(i, i) := std_logic_vector(tmp5);
        end loop;
        Anext <= res;
    end process;



end Behavioral;
