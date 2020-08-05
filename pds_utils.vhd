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
use std.textio.all;
use ieee.std_logic_textio.all;


package pds_utils is

constant R_const : integer := 2;
constant L_const : integer := 3;
constant w: integer := 8;
constant z: integer := 2;
constant E: integer := 500;

type mem is array(integer range <>, integer range <>) of std_logic_vector(w-1 downto 0);

function getProduct (A: mem; row: integer; B: mem; col: integer) return signed;   
function getMem (n,m: integer) return mem;
function "*" (matA, matB: mem) return mem;
function dotMul (num: signed; matrix: mem) return mem;
function "-" (matA, matB: mem) return mem;
function "+" (matA, matB: mem) return mem;
function copyMat (matB: mem) return mem;
function transpose (matA: mem) return mem;
function initA_with_A12 (matA12, X: mem) return mem;

function readMat (fileName: string; n, m: integer) return mem;
procedure writeMat (mat: mem; fileName: string);

end package pds_utils;

package body pds_utils is

-- Init and return memory for the corresponding matrix n*m

function getProduct (A: mem;
                    row: integer;
                    B: mem;
                    col: integer)
        return signed is
        variable prod: signed(w * 2 - 1 downto 0) := (others => '0');
        variable res: signed(w - 1 downto 0);      
begin
        for i in 1 to B'length loop
            prod := prod + (signed(A(row, i)) * signed(B(i, 1)));
        end loop;
        res := prod(w - 1 downto 0);
        return res;       
end getProduct;
       
        
function getMem (n,m: integer)
        return mem is
        variable res: mem(1 to n, 1 to m) := (others => (others => (others => '0')));  
begin
       return res;
        
end getMem;


function "*" (matA, matB: mem) return mem is
    variable prod: signed(w * 2 - 1 downto 0) := (others => '0');
    variable tmp: signed(w-1 downto 0);
	variable res: mem(1 to matA'length, 1 to matB'length(2));
	begin
	for i in 1 to matA'length loop
	   for j in 1 to matB'length(2) loop
	       prod := (others => '0');
	       for k in 1 to matB'length loop
	           prod := prod + (signed(matA(i, k)) * signed(matB(k, j)));
	           tmp := prod(w-1 downto 0);
	           res(i, j) := std_logic_vector(tmp);         	       
	       end loop;
	   end loop;
    end loop;
	
    return res;
end "*";

function dotMul (num: signed; matrix: mem) return mem is
	variable result: mem(1 to matrix'length, 1 to matrix'length(2));
	variable tmp: signed(2*w-1 downto 0);
	begin
	for i in 1 to matrix'length loop
	   for j in 1 to matrix'length(2) loop
	       tmp := num * signed(matrix(i, j));
	       result(i, j) := std_logic_vector(tmp(w-1 downto 0));
	   end loop;
    end loop;
	
    return result;
end dotMul;

function "+" (matA, matB: mem) return mem is
	variable res: mem(1 to matA'length, 1 to matA'length(2));
	begin
	for i in 1 to matA'length loop
	   for j in 1 to matB'length(2) loop
	       res(i, j) := std_logic_vector(signed(matA(i, j)) + signed(matB(i, j)));
	   end loop;
    end loop;
	
    return res;
end "+";

function "-" (matA, matB: mem) return mem is
	variable res: mem(1 to matA'length, 1 to matA'length(2));
	begin
	for i in 1 to matA'length loop
	   for j in 1 to matB'length(2) loop
	       res(i, j) := std_logic_vector(signed(matA(i, j)) - signed(matB(i, j)));
	   end loop;
    end loop;
	
    return res;
end "-";

function readMat (fileName: string; n, m: integer) return mem is
      file infile          : text is in fileName;
      variable row         : line;
      variable element     : integer;
      variable end_of_line : boolean := true;
      variable i, j: integer := 0;
      variable result: mem(1 to n, 1 to m);  
   begin
         while(not endfile(infile))loop
            i := i + 1;
            readline(infile, row);
            read(row, element, end_of_line); 
            j := 0;
            while(end_of_line)loop
               j := j + 1;
               result(i,j) := std_logic_vector(to_signed(element, w));
               read(row, element, end_of_line); 
            end loop;
            end_of_line := true;
         end loop;
         
         return result;
end readMat;


procedure writeMat (mat: mem; fileName: string) is
      file infile          : text open write_mode is fileName;
      variable row         : line;
      variable element     : integer;
      variable end_of_line : boolean := true;
      variable i, j: integer := 0;   
   begin
         for i in 1 to mat'length loop
            for j in 1 to mat'length(2) loop
                element := to_integer(signed(mat(i,j)));
                if j > 1 then
                    write(row, element, right, 7);
                else
                    write(row, element, right, 5);
                end if;    
            end loop;
            writeline(infile, row);
         end loop;
end writeMat;

function copyMat (matB: mem) return mem is
	variable res: mem(1 to matB'length, 1 to matB'length(2));
	begin
	for i in 1 to matB'length loop
	   for j in 1 to matB'length(2) loop
	       res(i, j) := matB(i, j);
	   end loop;
    end loop;
	
    return res;
end copyMat;

function transpose (matA: mem) return mem is
	variable res: mem(1 to matA'length, 1 to matA'length(2));
	begin
	for i in 1 to matA'length loop
	   for j in 1 to matA'length(2) loop
	       res(i, j) := matA(j, i);
	   end loop;
    end loop;
	
    return res;
end transpose;

function initA_with_A12 (matA12, X: mem) return mem is
    variable n_val, m_val: integer;
	variable res: mem(1 to matA12'length + matA12'length(2), 1 to matA12'length + matA12'length(2))
	               := getMem(matA12'length + matA12'length(2), matA12'length + matA12'length(2));
	variable tmp2, tmp4: signed (2*w - 1 downto 0);
    variable tmp1, tmp3, tmp5: signed(w-1 downto 0);
	begin
	n_val := matA12'length;
	m_val := matA12'length(2);
	for i in 1 to n_val loop
	   for j in n_val + 1 to n_val + m_val loop
	       res(i, j) := matA12(i, j - n_val);
	   end loop;
    end loop;
    
    for i in n_val + 1 to n_val + m_val loop
	   for j in 1 to n_val loop
	       res(i, j) := matA12(j, i - n_val);
	   end loop;
    end loop;
    
    for i in 1 to n_val loop
	   tmp1 := to_signed(R_const, w);
        tmp2 := signed(X(i, 1)) * signed(X(i, 1));
        tmp3 := tmp2(w-1 downto 0);
        tmp4 := tmp1 * tmp3;
        tmp5 := tmp4(w-1 downto 0);
        res(i, i) := std_logic_vector(tmp5);
    end loop;
    return res;
end initA_with_A12;

end package body pds_utils;
