package cov_collector_pkg ;
 
 import seq_item_pkg ::*;
import uvm_pkg ::*;
`include "uvm_macros.svh"  

class COVERAGE extends uvm_component ;
`uvm_component_utils(COVERAGE)

uvm_analysis_export #(SEQ_ITEM) cov_export;
uvm_tlm_analysis_fifo #(SEQ_ITEM) cov_fifo; 

SEQ_ITEM seq_item_cov;

covergroup COV_GRP ;

///////////////////////////  coverage for din[9:8] ////////////////////////////////

din_2_MSB : coverpoint seq_item_cov.din[9:8] iff (seq_item_cov.rst_n) {

bins W_ADD = {2'b00};
bins W_DATA = {2'b01};
bins R_ADD = {2'b10};
bins R_DATA = {2'b11};
bins W_ADD_W_DATA = (2'b00 => 2'b01) ;
bins R_ADD_R_DATA = (2'b10 => 2'b11);
}
/////////////////////////// coverage rx_valid ///////////////////////////////////

RX_V : coverpoint seq_item_cov.rx_valid iff (seq_item_cov.rst_n) ;

////////////////////////// coverage for data and address //////////////////////////

din_8_LSB : coverpoint seq_item_cov.din[7:0] iff (seq_item_cov.rst_n){

 bins data_addresses_array[] = {[0:255]};

}

//////////////////////// coverage of tx_valid transitions //////////////////////////

tx_valid_cov: coverpoint seq_item_cov.tx_valid {

bins Transition_0_1 = (0=>1);
bins Transition_1_0 = (1=>0);

}

////////////////////////// coverage for dout /////////////////////////////////////

DOUT_COV : coverpoint seq_item_cov.dout ;
/*{
 bins dout_array[] = {[0:255]};
} */

////////////////////////// cross coverage ///////////////////////////////////////

CROSS_COV : cross din_8_LSB , din_2_MSB ;


endgroup


function new (string name = "cov",uvm_component parent = null);

super.new(name,parent);
COV_GRP = new;

endfunction

function void build_phase (uvm_phase phase);

super.build_phase(phase);

cov_export =new ("cov_export" , this);
cov_fifo = new("cov_fifo", this );

endfunction


function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);

cov_export.connect(cov_fifo.analysis_export);

endfunction

task run_phase (uvm_phase phase);
super.run_phase(phase );

forever
begin
cov_fifo.get(seq_item_cov);

COV_GRP.sample();

end

endtask


endclass

endpackage

