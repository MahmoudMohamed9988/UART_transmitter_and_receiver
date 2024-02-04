module receive_assertion (input clk , reset, rx, ready, [7:0] data);
//*---------------------------------
property start_receiving;
@(posedge clk) disable iff (reset)
$fell(rx) |=> $fell(ready)[*10410];
endproperty

assert property (start_receiving);
//-----------------------------------
property receive_complete;
@(posedge clk) disable iff(reset)
$rose(ready) |-> (rx)
endproperty

assert property (receive_complete);

//-----------------------------------


endmodule
