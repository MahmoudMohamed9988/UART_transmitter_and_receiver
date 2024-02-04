interface UART_master_interface;
logic clk;
logic reset_n;
logic [7:0] data;
logic send;
logic ready;
logic TX;


task get_an_input(UART_master_seq_item tx_in);


tx_in.data = data;
tx_in.send = send;
repeat(5210) @(posedge clk); // baud timer for 5-MHZ clock freq. and 9600 bps baud rate

endtask




task  get_an_output(UART_master_seq_item tx_in);
//$monitor("at time = %0t , the out = %0d , the iqr = %0d",$time,  out , iqr);
for(int i = 0;i<8; i = i + 1) begin

repeat(521)@(posedge clk);
tx_in.ready= ready;
tx_in.TX= TX;

end

endtask




task transfer(UART_master_seq_item my_item);
                           

send = my_item.send;
data = my_item.data;
repeat(5210)@(posedge clk);

endtask






initial begin 
  clk = 1'b0; 
  forever begin
    #10 clk=~clk;    // 5-MHZ
  end
end







endinterface
