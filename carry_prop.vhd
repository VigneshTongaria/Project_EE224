entity carry_prop is 
port( gi1 : in bit;
      pi1 : in bit;
		gi2 : in bit;
		pi2 : in bit;
		g0 : out bit;
		p0 : out bit);
	end carry_prop;
	
architecture ca of carry_prop is
begin 
     g0 <= gi2 OR (pi2 AND gi1);
	  p0 <= pi1 AND pi2;
	end ca;
		
