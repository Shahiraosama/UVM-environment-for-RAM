module golden_ref (GM_IF.DUT_GM gm_if);
/*
input	bit					gm_if.rst_n , gm_if.clk,
input	bit [9:0]			gm_if.din,
input	bit					gm_if.rx_valid,	
output	bit 				gm_if.tx_valid,
output	bit	[ADDR_SIZE-1:0]	gm_if.dout	
*/
parameter MEM_DEPTH = 256 ;
parameter ADDR_SIZE = 8 ;

localparam				W_ADD 	= 0,
						W_DATA 	= 1,
						R_ADD 	= 2,
						R_DATA 	= 3 ;


bit 	[ADDR_SIZE-1:0] write_address;
bit 	[ADDR_SIZE-1:0] read_address; 

reg		[ADDR_SIZE-1:0]		RAM		[MEM_DEPTH-1:0];


					
always@(posedge gm_if.clk or negedge gm_if.rst_n)
begin

if(!gm_if.rst_n)
begin

write_address <= 'd0;
gm_if.tx_valid <= 'd0;
gm_if.dout <= 'd0;
read_address <='d0;


end

else 
begin

case(gm_if.din[9:8])

W_ADD : 
begin
if (gm_if.rx_valid) 
begin
write_address <= gm_if.din[7:0] ;  
end
gm_if.tx_valid <= 'd0;

end

W_DATA :

begin
if (gm_if.rx_valid) 
begin
RAM[write_address] <= gm_if.din[7:0] ; 
end
gm_if.tx_valid <= 'd0; 
end

R_ADD :
begin
if (gm_if.rx_valid) 
begin
read_address <= gm_if.din[7:0] ;
end
gm_if.tx_valid <= 'd0;
  
end

R_DATA:
begin
gm_if.tx_valid <= 'd1;
gm_if.dout <= RAM[read_address] ;  
end

endcase


end


end




endmodule