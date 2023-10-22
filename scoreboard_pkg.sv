package scoreboard_pkg;

import seq_item_pkg::*;
import uvm_pkg ::*;
import cfg_pkg ::*;
`include "uvm_macros.svh" 


class SCORE_BOARD extends uvm_scoreboard ;
`uvm_component_utils (SCORE_BOARD)

uvm_analysis_export #(SEQ_ITEM) sb_export;
uvm_tlm_analysis_fifo #(SEQ_ITEM) sb_fifo;

SEQ_ITEM seq_item_sb;

virtual GM_IF object_vif;
CFG cfg_obj ;

//bit [7:0] dout_ref;
//bit tx_valid_ref ;

int error_count = 0 ;
int corr_count = 0 ;

function new (string name = "scoreboard",uvm_component parent = null);

super.new(name,parent);

endfunction

function void build_phase (uvm_phase phase);

super.build_phase(phase);

sb_export =new ("sb_export" , this);
sb_fifo = new("sb_fifo", this );

if(!uvm_config_db #(CFG):: get(this , "" , "CFG" , cfg_obj))
`uvm_fatal ("build_phase" , "Driver -unable to get configuration object")

endfunction



function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);

object_vif = cfg_obj.scoreboard_vif;
sb_export.connect(sb_fifo.analysis_export);

endfunction


task run_phase (uvm_phase phase);
super.run_phase(phase );

forever
begin

sb_fifo.get(seq_item_sb);

if(seq_item_sb.dout != object_vif.dout )
begin
`uvm_error ("run_phase" , $sformatf ("comparison failed , transaction recieved by the DUT :%s while the reference out : 0b%0b " , seq_item_sb.convert2string , object_vif.dout));
 error_count++ ;
end

else
begin
`uvm_info ("run_phase" , $sformatf ("correct dout : %s ", seq_item_sb.convert2string()), UVM_HIGH);
 corr_count++;
end

end

endtask




function void report_phase (uvm_phase phase);
super.report_phase(phase);

`uvm_info ("report_phase" , $sformatf ("total successful transactions : %0d " , corr_count) , UVM_MEDIUM);
`uvm_info ("report_phase" , $sformatf ("total failed transactions : %0d " , error_count) , UVM_MEDIUM);

endfunction

endclass

endpackage
