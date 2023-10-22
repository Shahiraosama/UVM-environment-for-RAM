package test_pkg;

import cfg_pkg ::*;
import env_pkg ::*;
import seq_rst_pkg::*;
import seq_main_pkg ::*;
import sequencer_pkg ::*;

import uvm_pkg ::*;
`include "uvm_macros.svh" 

class TEST extends uvm_test;
`uvm_component_utils(TEST)



ENV env;
CFG cfg;

SEQ_RST reset_seq;
SEQ_WRITE write_seq;
SEQ_READ read_seq;
SEQ_W_R seq_w_r;


function new (string name = "TEST" , uvm_component parent = null);

super.new(name,parent);

endfunction


function void build_phase (uvm_phase phase);

super.build_phase(phase);
env = ENV :: type_id :: create ("env", this);

cfg = CFG :: type_id :: create ("cfg");

reset_seq = SEQ_RST :: type_id :: create ("reset_seq");

write_seq = SEQ_WRITE :: type_id :: create ("write_seq");
read_seq = SEQ_READ :: type_id :: create ("read_seq");
seq_w_r = SEQ_W_R :: type_id :: create ("seq_w_r");


if(!uvm_config_db #(virtual RAM_IF) :: get(this,"","RAM_IF",cfg.config_vif))
`uvm_fatal ("build_phase", "Test - unable to get the virtual interface of the RAM from the uvm_config_db" );

uvm_config_db #(virtual GM_IF) :: get(this,"","GM_IF",cfg.scoreboard_vif);


uvm_config_db #(CFG) :: set(this , "*" , "CFG" ,cfg);


endfunction


task run_phase (uvm_phase phase);
super.run_phase(phase );
phase.raise_objection(this);

`uvm_info ("run_phase ", "Reset_Asserted " , UVM_LOW);

reset_seq.start (env.agt.sqr);

`uvm_info ("run_phase" , "Reset_Deasserted " , UVM_LOW);

// stimulus Generation 


`uvm_info ("run_phase" , "Stimulus Generation started " , UVM_LOW);

write_seq.start (env.agt.sqr);

`uvm_info ("run_phase" ,"stimulus Generation ended" , UVM_LOW);

read_seq.start (env.agt.sqr);

`uvm_info ("run_phase" ,"stimulus Generation ended" , UVM_LOW);


seq_w_r.start (env.agt.sqr);

`uvm_info ("run_phase" ,"stimulus Generation ended" , UVM_LOW);

#100 ;
`uvm_info ("run_phase", "welcome to the uvm env",UVM_MEDIUM)
phase.drop_objection (this);


endtask



endclass




endpackage
