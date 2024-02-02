class UART_master_sqr extends uvm_sequencer #(UART_master_seq_item);
  `uvm_component_utils(UART_master_sqr)
  function new(string name = "UART_master_sqr",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass
