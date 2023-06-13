library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity new_example is
    Port (
        clk     : in  STD_LOGIC;
        HEX0    : out STD_LOGIC_VECTOR(6 downto 0);
        green1  : out STD_LOGIC;
        red1    : out STD_LOGIC;
        yellow1 : out STD_LOGIC;
        green2  : out STD_LOGIC;
        red2    : out STD_LOGIC;
        yellow2 : out STD_LOGIC
    );
end new_example;

architecture Behavioral of new_example is
    signal count     : integer range 0 to 2000000000 := 0;
    signal state     : integer range 0 to 3 := 0;
    signal remaining : integer range 0 to 2000000000; -- 6.25 seconds

    constant clk_frequency : integer := 500000;

    function bcd (n : integer) return STD_LOGIC_VECTOR is
    begin
        case n is
            when 0    => return "1111001";
            when 1    => return "0100100";
            when 2    => return "0110000";
            when 3    => return "0011001";
            when 4    => return "0010010";
            when 5    => return "0000010";
            when 6    => return "0000010";
            when others => return "1111111";
        end case;
    end function bcd;

begin
    process (clk)
    begin
        if rising_edge(clk) then
            case state is
                when 0 =>  -- red1 and green2
                    if count = (clk_frequency * 500) then
                        count <= 0;
                        state <= 1;
                    else
                        count <= count + 1;
                        red1 <= '1';
                        green1 <= '0';
                        yellow1 <= '0';
                        green2 <= '1';
                        red2 <= '0';
                        yellow2 <= '0';
                        HEX0 <= bcd((312500000 - count)/50000000);
                    end if;
                when 1 =>  -- red1 and yellow2
                    if count = (clk_frequency * 125) then
                        count <= 0;
                        state <= 2;
                    else
                        count <= count + 1;
                        red1 <= '1';
                        green1 <= '0';
                        yellow1 <= '0';
                        green2 <= '0';
                        red2 <= '0';
                        yellow2 <= '1';
                        HEX0 <= bcd((62500000 - count)/50000000);
                    end if;
                when 2 =>  -- green1 and red2
                    if count = (clk_frequency * 500) then
                        count <= 0;
                        state <= 3;
                    else
                        count <= count + 1;
                        red1 <= '0';
                        green1 <= '1';
                        yellow1 <= '0';
                        green2 <= '0';
                        red2 <= '1';
                        yellow2 <= '0';
                        HEX0 <= bcd((312500000 - count)/50000000);
                    end if;
                when 3 =>  -- yellow1 and red2
                    if count = (clk_frequency * 125) then
                        count <= 0;
                        state <= 0;
                    else
                        count <= count + 1;
                        red1 <= '0';
                        green1 <= '0';
                        yellow1 <= '1';
                        green2 <= '0';
                        red2 <= '1';
                        yellow2 <= '0';
                        HEX0 <= bcd((62500000 - count)/50000000);
                    end if;
                when others =>
                    state <= 0;
                    count <= 0;
            end case;
        end if;
    end process;
end Behavioral;
