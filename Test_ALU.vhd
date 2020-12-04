entity Test_ALU is
end Test_ALU;

architecture logic of Test_ALU is
signal x1,x2,u : bit_vector(15 downto 0);
signal zor,cor,c1,c0 : bit;
component ALU_1 is
port(  x,y : in bit_vector(15 downto 0);
       s1,s0 : in bit;
		 output : buffer bit_vector(15 downto 0);
		 cout,z : out bit);
end component;
 begin 
     ALU_instance : ALU_1 port map( x1,x2,c1,c0,u,cor,zor);
	  
process 
  begin
    
	 x1 <= "1111111111111111";
	 x2 <= "1111111111111111";
	 c1 <= '0';
	 c0 <= '0';
	 wait for 5 ns;
	 
	 x1 <= "0110111110111010";
	 x2 <= "1000101111001101";
	 c1 <= '1';
	 c0 <= '1';
	 wait for 5 ns;
end process;
end logic;