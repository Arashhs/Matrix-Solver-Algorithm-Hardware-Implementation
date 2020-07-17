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

constant w: integer := 32;
constant m: integer := 5;
constant n: integer := 7;


-- type mem is array(natural range <>, natural range <>) of std_logic_vector;
type memA is array(1 to n+m, 1 to n+m) of std_logic_vector(w-1 downto 0);
type memB is array(1 to n+m, 1 to 1) of std_logic_vector(w-1 downto 0);

function getMemA return memA;
function getMemB return memB;

function getProduct (A: memA;
                    row: integer;
                    B: memB;
                    col: integer;
                    size: integer)
        return signed;

end package pds_utils;

package body pds_utils is

-- Init and return memory for the corresponding matrix n*m
function getMemA 
        return memA is
        variable mat : memA;
begin
        -- initializing memory
        mat := (others => (others => (others => '0')));   
        return mat;
end getMemA;  

function getMemB
        return memB is
        variable mat : memB;
begin
        -- initializing memory
        mat := (others => (others => (others => '0')));   
        return mat;
end getMemB; 

function getProduct (A: memA;
                    row: integer;
                    B: memB;
                    col: integer;
                    size: integer)
        return signed is
        variable prod: signed(w * 2 - 1 downto 0) := (others => '0');
        variable res: signed(w - 1 downto 0);      
begin
        for i in 1 to size loop
            prod := prod + (signed(A(row, i)) * signed(B(i, col)));
        end loop;
        res := prod(w - 1 downto 0);
        
        return res;
        
end getProduct; 
        


end package body pds_utils;
