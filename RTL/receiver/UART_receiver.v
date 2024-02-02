module UART_receiver (input clk , reset, rx , output reg ready , [1:0] state , [7:0] data  );

parameter RDY = 2'b00,
          START = 2'b01,
          WAIT = 2'b10,
          RECEIVE = 2'b11;

reg [7:0] data_reg;

reg [1:0] current_state  , next_state;
reg [15:0] baud_timer = 8; // this the number of clock cycle needed by devided clock frequency = 10 MHZ by baud rate = 9600 bps
reg [15:0] timer_reg;
wire [15:0] timer_reg_next;
reg load;

reg [2:0] count_bit = 0 ;
reg [2:0] count_bit_next = 0;
// timer register
always@(posedge clk or negedge reset) begin
if(~reset)
         timer_reg <= 0;
else 
          timer_reg <= timer_reg_next;

end
// timer continous assignment
assign timer_reg_next = (load) ? baud_timer : timer_reg - 1;


//-------------------------------------------
// state register
always@(posedge clk or negedge reset) begin
if(~reset)begin


         count_bit <= 0;
         current_state <= 0;
          end
else begin


          count_bit <= count_bit_next;
          current_state <= next_state;
      end
end

//------------------------------------------
//------------------------------------------

always@(*)begin
case(current_state)
RDY : begin
          ready = 1'b1;
          load = 1'b1;
          state = 0;
          if (rx == 1'b0) begin
                     next_state = START;
                   end

       end
START : begin
          ready = 1'b0;
          load = 1'b0;
          state = 1;
          if( timer_reg == (baud_timer/2) ) begin
                            load = 1'b1;
                            next_state = WAIT;

              end          
       end
WAIT : begin
          ready = 1'b0;
          load = 1'b0;
          state = 2;
          if( timer_reg == 0 ) begin
                           data_reg = {rx,data_reg[7:1]};
                          if(count_bit == 3'b111) begin
                                  next_state = RECEIVE;
                                end
                           else begin
                                  count_bit_next = count_bit + 1'b1;
                                  next_state = WAIT;
                                  load = 1'b1; 
                              end           
            end          
       end
RECEIVE : begin
              data = data_reg;
              ready = 1'b1;
              state = 3;
              count_bit_next = 0;
              next_state = RDY;

            end

endcase


end





endmodule
