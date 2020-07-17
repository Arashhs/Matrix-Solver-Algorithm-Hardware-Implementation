--/*
--**********************************************************
--  Design Automation Course Homework (Spring, 2020 Semester)
--  Amirkabir University of Technology (Tehran Polytechnic)
--  Department of Computer Engineering (CE-AUT)
--  https://ce.aut.ac.ir
--  Designed TA (ali[dot]mohammadpour[at]ac[dot]ir)
--  *******************************************************
--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : PDS Utilities Package
--  *******************************************************
--  Additional Comments:
--*/
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

package pds_utils is

constant R_const : integer := 7;
constant L_const : integer := 13;


type mem is array(natural range <>, natural range <>) of std_logic_vector;

function getMem (n, m: integer) return mem;

function getProduct (A: mem;
                    row: integer;
                    B: mem;
                    col: integer;
                    size: integer)
        return signed;

end package pds_utils;

package body pds_utils is

-- Init and return memory for the corresponding matrix n*m
function getMem (n, m: integer)
        return mem is
        variable mat : mem(1 to n, 1 to m);
begin
        -- initializing memory
        mat := (others => (others => (others => '0')));   
        return mat;
end getMem;  

function getProduct (A: mem;
                    row: integer;
                    B: mem;
                    col: integer;
                    size: integer)
        return signed is
        variable prod: signed(a(1, 1)'range);
        
begin
        for i in 1 to size loop
            prod := prod + (signed(A(row, i)) * signed(B(i, col)));
        end loop;
        
        return prod;
        
end getProduct; 
        


end package body pds_utils;
