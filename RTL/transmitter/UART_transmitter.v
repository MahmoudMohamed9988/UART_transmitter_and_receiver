module UART_transmitter(input clk , reset , send , [7:0] data , output reg ready , wire TX);

parameter RDY = 2'b00,
          LOAD_BIT = 2'b01,
          SEND_BIT = 2'b10;



reg [1:0] current_state, next_state;
reg [8:0]tx_data;
reg tx_bit;
reg [4:0] count_bit = 4'b0;


reg [15:0] baud_timer = 4; // this the number of clock cycle needed by devided clock frequency = 5 MHZ by baud rate = 9600 bps
reg [15:0] timer_reg;
wire [15:0] timer_reg_next;
reg load;


// timer register
always@(posedge clk or negedge reset) begin
if(~reset)
         timer_reg <= baud_timer;
else 
          timer_reg <= timer_reg_next;

end
// timer continous assignment
assign timer_reg_next = (load) ? baud_timer : timer_reg - 1;


// current_state register
always @(posedge clk or negedge reset) begin
if(~reset)
        current_state <= 0;
else
          current_state <= next_state;

         end
//-------------------------------------
//-------------------------------------


always@(*) begin
case (current_state)
RDY : begin
            ready = 1'b1; 
            tx_bit = 1'b1; 
            count_bit = 0;
            load = 1'b1;
            if(send) begin
                      tx_data = {1'b1,data,1'b0};
                      next_state = LOAD_BIT;
                     end
       end
LOAD_BIT: begin
            ready = 1'b0;
            load = 1'b1;
            tx_bit = tx_data[count_bit];             
            count_bit = count_bit + 1'b1;
            next_state = SEND_BIT;

          end
SEND_BIT: begin
             ready = 1'b0;
             load = 1'b0;
             if (count_bit == 4'b1001) begin
                     next_state = RDY;
                      count_bit = 0;
                       end
            else begin
                       if (timer_reg == 0) begin
                                  next_state = LOAD_BIT ; 
                                   end
                       else  
                                next_state = SEND_BIT ;         
                 end

          end


default :  next_state = RDY;

endcase


end


assign TX = tx_bit;

endmodule
