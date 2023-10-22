interface RAM_IF (clk);

input bit clk;

bit [9:0] din;
bit  rst_n , rx_valid;
bit tx_valid;
bit [7:0] dout;


modport DUT (input clk, rst_n, din, rx_valid, output tx_valid,dout);

modport TEST (input tx_valid, dout , clk , output  rst_n, din, rx_valid );

endinterface
