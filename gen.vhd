entity gen is
port(   x : in bit;
        y : in bit;
		  g : out bit;
		  p : out bit);
end gen;

architecture g of gen is 
begin 
     g <= x AND y;
	  p <= x XOR y;
end g;