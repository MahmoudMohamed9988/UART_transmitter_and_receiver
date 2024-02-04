module transmitter_assertion (input clk , reset , send , ready , TX , [7:0] data);

property start_transmission;
@(posedge clk) disable iff (reset)
(send) |->  ##[1:3](!TX);
endproperty

assert property (start_transmission);

//--------------------------------------------
property idle_mode;
@(posedge clk) disable iff (reset)
((!send) && ready) |-> $stable(TX);
endproperty
assert property (idle_mode);

//---------------------------------------------


endmodule
