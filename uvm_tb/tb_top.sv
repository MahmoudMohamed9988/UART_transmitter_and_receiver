import pkg::*;

import uvm_pkg::*;

`include "transmitter_assertion.sv"
`include "UART_master_interface.sv"

`timescale 1ns/1ps



module tb_top;


UART_master_interface my_if();

// instantiate the dut 
UART_transmitter trans_1 (my_if.clk,my_if.reset_n,my_if.send,my_if.data,my_if.ready,my_if.TX);

initial begin

  uvm_config_db #(virtual UART_master_interface)::set(uvm_root::get(),"UART_master_test","vif",my_if);

run_test("UART_master_test");
end



// binding assertions with design module
bind trans_1  transmitter_assertion transmitter_assertion_bind (.*);




endmodule

