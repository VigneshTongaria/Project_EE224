entity ALU is 
port( x,y : in bit_vector(15 downto 0);
      s1,s0 : in bit;
		cout: out bit;
		output : out bit_vector(15 downto 0);
		z : out bit );
end ALU;

architecture arithmetic of ALU is 
 
 signal carry : bit_vector(16 downto 0);
 signal ny : bit_vector(15 downto 0);
 signal subtract : bit_vector(15 downto 0);
 signal xor16 :  bit_vector(15 downto 0);
 signal nand16 :  bit_vector( 15 downto 0);
 signal control1 : bit;
 signal control2 : bit;
 signal control3 : bit;
 signal zi : bit_vector(15 downto 0);
begin 
 carry(0) <= '1';
 control1 <= (NOT s1) AND s0;
 control2 <= s1 AND (NOT s0);
 control3 <= s1 AND s0;
 ny(0) <= (NOT y(0));
					 subtract(0) <= (x(0) XOR ny(0) XOR carry(0)) AND control1;
					 carry(1) <= ((x(0) AND ny(0)) OR (x(0) AND carry(0)) OR (ny(0) AND carry(0))) AND control1;
					 nand16(0) <= (x(0) NAND y(0)) AND control2;
					 xor16(0) <= (x(0) XOR y(0)) AND control3;
					 output(0) <= subtract(0) OR xor16(0) OR nand16(0);

     for_gen:
		          for i in 1 to 15 generate
					 ny(i) <= (NOT y(i));
					 subtract(i) <= (x(i) XOR ny(i) XOR carry(i)) AND control1;
					 carry(i+1) <= ((x(i) AND ny(i)) OR (x(i) AND carry(i)) OR (ny(i) AND carry(i))) AND control1;
					 nand16(i) <= (x(i) NAND y(i)) AND control2;
					 xor16(i) <= (x(i) XOR y(i)) AND control3;
					 output(i) <= subtract(i) OR xor16(i) OR nand16(i);
                zi(i) <= subtract(i) OR subtract(i-1) OR nand16(i) OR nand16(i-1) OR xor16(i) OR xor16(i-1);
					 end generate;
		cout <= carry(16);
		z <= NOT (zi(14) OR zi(15));

end arithmetic;
					 
  