import test_pkg ::*;
import uvm_pkg ::*;
`include "uvm_macros.svh" 

module TOP;


bit clk;

always
begin
#1 clk= ~clk ;
end

RAM_IF ram_if (clk);

ram DESIGN (ram_if);

//RAM_TB TB (ram_if);

GM_IF gm_if (clk);
assign gm_if.din = ram_if.din;
assign gm_if.rst_n = ram_if.rst_n ;
assign gm_if.rx_valid = ram_if.rx_valid;

golden_ref GM (gm_if);
 
 
initial
begin

uvm_config_db #(virtual RAM_IF)::set(null , "uvm_test_top" , "RAM_IF" , ram_if);
uvm_config_db #(virtual GM_IF)::set(null , "uvm_test_top" , "GM_IF" , gm_if);
run_test ("TEST");

end

///////////////////////// binding Assertions //////////////////////////////////

bind ram RAM_SVA SVA (ram_if.din,ram_if.clk,ram_if.rst_n,ram_if.rx_valid,ram_if.dout,ram_if.tx_valid); 

endmodule