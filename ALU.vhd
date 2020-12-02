

entity ALU is
port( x : in bit_vector( 0 downto 15);
      y : in bit_vector( 0 downto 15);
		s1: in bit;
		s0: in bit;
		output : out bit_vector( 0 downto 15);
		cout : out bit;
		z : out bit);
end ALU;

architecture logic of ALU is
signal  gi: bit_vector(0 downto 15);
signal  pi: bit_vector(0 downto 15);

signal g1: bit_vector(0 downto 15);
signal g2: bit_vector(0 downto 15);
signal g3: bit_vector(0 downto 15);
signal g4: bit_vector(0 downto 15);
signal p1: bit_vector(0 downto 15);
signal p2: bit_vector(0 downto 15);
signal p3: bit_vector(0 downto 15);
signal p4: bit_vector(0 downto 15);

signal car: bit_vector(0 downto 15);
signal sum: bit_vector(0 downto 15);
signal xor16: bit_vector(0 downto 15);
signal nand16: bit_vector(0 downto 15);
signal y_1: bit_vector(0 downto 15);
signal x_1: bit_vector(0 downto 15);
signal cin: bit;
signal control1: bit;
signal control2: bit;
signal control3: bit;
signal control4: bit;

begin 
  control1 <= (NOT s1) AND (NOT s0);
  control2 <= (NOT s1) AND s0;
  control3 <= s1 AND (NOT s0);
  control4 <= s1 AND s0;
  cin <= control2;
  
  general: 
       for i in 0 to 15 generate
		      y_1(i) <= (y(i) AND control1) OR ((NOT y(i)) AND control2);
				x_1(i) <= (X(i) AND (control1 OR control2));
		      gm : gen port map( x => x(i) , y => y_1(i) , g => gi(i), p => pi(i));
				xor16(i) <= p(i) AND control4;
				nand16(i) <= g(i) AND control3;
		 end generate;
		 
	        g1(0) <= gi(0);
	        p1(0) <= pi(0);
			  
stage1:	    for i in 0 to 14 generate
				ca: carry port map(gi_1 => gi(i) , pi_1 => pi(i) , gi_2 => gi(i+1) , pi_2 => pi(i+1) , g0 => g1(i+1) , p0 => p1(i+1) );
			end generate;
			
buffer1:	   for i in 0 to 1 generate
		      g2(i) <= g1(i);
			   p2(i) <= p1(i);
			end generate;
stage2:		for i in 0 to 13 generate
				ca: carry port map(gi_1 => g1(i) , pi_1 => p1(i) , gi_2 => g1(i+2) , pi_2 => p1(i+2) , g0 => g2(i+2) , p0 => p2(i+2) );
			end generate;
			
buffer2:	   for i in 0 to 3 generate
		      g3(i) <= g2(i);
			   p3(i) <= p2(i);
			end generate;
stage3:		for i in 0 to 11 generate
				ca: carry port map(gi_1 => g2(i) , pi_1 => p2(i) , gi_2 => g2(i+4) , pi_2 => p2(i+4) , g0 => g3(i+4) , p0 => p3(i+4) );
			end generate;
		
buffer3:	   for i in 0 to 7 generate
		      g4(i) <= g3(i);
			   p4(i) <= p3(i);
			end generate;
stage4:		for i in 0 to 7 generate
				ca: carry port map(gi_1 => g3(i) , pi_1 => p3(i) , gi_2 => g3(i+8) , pi_2 => p3(i+8) , g0 => g4(i+8) , p0 => p4(i+8) );
			end generate;
			
carry:		for i in 0 to 15 generate
		      car(i) <= g4(i) OR ( cin AND p4(i));
				end generate;
		
		cout <= car(15);
		sum(0) <= cin XOR pi(0);
		
sum:		for i in 1 to 15 generate
		      sum(i) <= C(i-1) XOR pi(i);
				end generate;
output:		for i in 0 to 15 generate
		      output(i) <= sum(i) OR xor16(i) OR nand16(i);
				end generate;
				
end logic;
			
	   
				
			
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
