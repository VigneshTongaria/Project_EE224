entity carry is 
port( gi_1 : in bit;
      pi_1 : in bit;
		gi_2 : in bit;
		pi_2 : in bit;
		g0 : out bit;
		p0 : out bit);
	end carry;
	
architecture ca of carry is
begin 
     g0 <= gi_2 OR (pi_2 AND gi_1);
	  p0 <= pi_1 AND pi_2;
	end ca;
		
