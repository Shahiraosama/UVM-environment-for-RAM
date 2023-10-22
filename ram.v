module ram (RAM_IF.DUT ram_if);
	parameter MEM_DEPTH = 256;
	parameter ADDR_SIZE = 8;
/*
	input [9:0] ram_if.din;
	input ram_if.clk, ram_if.rst_n , ram_if.rx_valid;
	output reg [7:0] ram_if.dout;
	output reg ram_if.tx_valid;
*/
	reg [ADDR_SIZE-1:0] write_addr, read_addr;
	
	reg [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];


	//integer i ;
	always @(posedge ram_if.clk,negedge ram_if.rst_n) 
	begin
		if(~ram_if.rst_n) begin
		//	for (i=0; i < MEM_DEPTH; i=i+1) begin
				// mem[i] = 0; // bug1 he resets the memory regs and that wasn't required in the specs so there is no need for FOR LOOP  
				ram_if.tx_valid <= 'd0; // bug2 he didn't reset ram_if.tx_valid 
				ram_if.dout <= 'd0 ;  //bug3 he didn't reset ram_if.dout 
				write_addr <='d0; // bug5 the write_addr isn't reset
				read_addr <= 'd0; // bug6 the read_addr isn't reset
			//end
		end
		/*
		there was a bug where the write and the read operations were dependent on ram_if.rx_valid signal and only when ram_if.rx_valid is asserted 
		it means that the data to be written or address to be written or the address to be read are sent correctly  		
		*/
		else 
		begin
			case (ram_if.din[9:8])
				2'b00: 
				begin
				if(ram_if.rx_valid)
					begin
					write_addr <= ram_if.din[7:0];
						end
					ram_if.tx_valid <=0;
				end
				2'b01: 
				begin
				
						if(ram_if.rx_valid)
						begin
				mem [write_addr] <= ram_if.din[7:0];
					end
					ram_if.tx_valid <=0;
				end	
				2'b10: begin
				if(ram_if.rx_valid)
				begin
					read_addr <= ram_if.din[7:0];
					end
				ram_if.tx_valid <=0;
				end
				2'b11: begin
					ram_if.dout <= mem[read_addr];
					ram_if.tx_valid <=1;
				end
			endcase
		end
		/* commented it as it's a bug 
		else 
			ram_if.tx_valid <=0; // bug4 it's not necessary condition 
		*/
	end


	
endmodule