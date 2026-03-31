-- Squelette pour l'exercice sur les machines � �tats

library IEEE;
use IEEE.STD_LOGIC_1164.all;                             
                                                         
entity FSM is                                            
port (	Clk :in STD_LOGIC;                          
		nRst: in STD_LOGIC;                          
     	Start_Stop, Clear:	in 	STD_LOGIC;           
      	Cnt_En, Cnt_Rst: out STD_LOGIC);          
end entity;                                              
                                                         
architecture RTL of FSm is                               
type StateType is (Zero, Start, Running, Stop, Stopped, Reset); 
Signal State : StateType;


begin        
process(Clk, nRst)
begin 

	if nRst = '0' then
		State <= Zero;
		Cnt_En <= '0'; 
		Cnt_Rst <= '0';
	elsif Rising_Edge(Clk) then 
		case State is 
		when Zero =>
			if Start_Stop = '1' then
				State <= Start; 
				Cnt_En <= '1';
				Cnt_rst <= '0'; 
			end if;
		when Start => 
			if Start_Stop = '0' then
				State <= Running;
				Cnt_En <= '1';
				Cnt_rst <= '0'; 
			end if;
		when Running =>
			if Start_Stop = '1' then
				State <= Stop;
				Cnt_En <= '0';
				Cnt_rst <= '0'; 
			end if;
		when Stop =>
			if Start_Stop = '0' then
				State <= Stopped;
				Cnt_En <= '0';
				Cnt_rst <= '0'; 
			end if;
		when Stopped =>
			if Start_Stop = '1' then
				State <= Start;
				Cnt_En <= '1';
				Cnt_rst <= '0'; 
			elsif clear = '1' then
				State <= Reset;
				Cnt_En <= '0';
				Cnt_rst <= '1';
			end if;
		when Reset =>
			if Clear = '0' then
				State <= Zero;
				Cnt_En <= '0';
				Cnt_rst <= '0'; 
			end if;                                              
			end case; 
			end if;                                                                                           
end process;
                                                         
                                                         
end architecture;
