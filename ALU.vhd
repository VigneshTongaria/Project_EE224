

entity ALU is
port( x : in bit_vector( 15 downto 0);
      y : in bit_vector( 15 downto 0);
		s1: in bit;
		s0: in bit;
		output : buffer bit_vector( 15 downto 0);
		cout : out bit;
		z : out bit);
end ALU;

architecture logic of ALU is
signal  gi: bit_vector(15 downto 0);
signal  pi: bit_vector(15 downto 0);
component gen
port( x,y: in bit; g,p: out bit);
end component;
component carry_prop
port( gi1,pi1,gi2,pi2 : in bit; g0,p0: out bit);
end component;

signal g1: bit_vector(15 downto 0);
signal g2: bit_vector(15 downto 0);
signal g3: bit_vector(15 downto 0);
signal g4: bit_vector(15 downto 0);
signal p1: bit_vector(15 downto 0);
signal p2: bit_vector(15 downto 0);
signal p3: bit_vector(15 downto 0);
signal p4: bit_vector(15 downto 0);

signal car: bit_vector(15 downto 0);
signal sum: bit_vector(15 downto 0);
signal xor16: bit_vector(15 downto 0);
signal nand16: bit_vector(15 downto 0);
signal y_1: bit_vector(15 downto 0);
signal x_1: bit_vector(15 downto 0);
signal zi : bit_vector(15 downto 0);
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
		      gm : gen port map(x(i),y_1(i),gi(i),pi(i));
				xor16(i) <= pi(i) AND control4;
				nand16(i) <= (NOT gi(i)) AND control3;
		 end generate;
		 
	        g1(0) <= gi(0);
	        p1(0) <= pi(0);
			  
stage1:	    for i in 0 to 14 generate
				prop: carry_prop port map(gi(i) , pi(i), gi(i+1), pi(i+1), g1(i+1), p1(i+1));
			end generate;
			
buffer1:	   for i in 0 to 1 generate
		      g2(i) <= g1(i);
			   p2(i) <= p1(i);
			end generate;
stage2:		for i in 0 to 13 generate
				prop: carry_prop port map(g1(i),p1(i),g1(i+2),p1(i+2),g2(i+2),p2(i+2));
			end generate;
			
buffer2:	   for i in 0 to 3 generate
		      g3(i) <= g2(i);
			   p3(i) <= p2(i);
			end generate;
stage3:		for i in 0 to 11 generate
				prop: carry_prop port map(g2(i),p2(i),g2(i+4),p2(i+4),g3(i+4),p3(i+4));
			end generate;
		
buffer3:	   for i in 0 to 7 generate
		      g4(i) <= g3(i);
			   p4(i) <= p3(i);
			end generate;
stage4:		for i in 0 to 7 generate
				prop: carry_prop port map(g3(i),p3(i),g3(i+8),p3(i+8),g4(i+8),p4(i+8));
			end generate;
			
carry_gen:		for i in 0 to 15 generate
		      car(i) <= g4(i) OR ( cin AND p4(i));
				end generate;
		
		cout <= car(15);
		sum(0) <= cin XOR pi(0);
		
summation:		for i in 1 to 15 generate
		      sum(i) <= car(i-1) XOR pi(i);
				end generate;
	output(0) <= sum(0) OR xor16(0) OR nand16(0);
	zi(0) <= output(0);
output_gen:		for i in 1 to 15 generate
		      output(i) <= sum(i) OR xor16(i) OR nand16(i);
				zi(i) <= zi(i-1) OR output(i);
				end generate;
	z <= NOT(zi(15));
				
end logic;
			
	   
				
			
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
