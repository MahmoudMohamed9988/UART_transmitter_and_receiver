

class UART_receiver_agt_config extends uvm_object;
  `uvm_object_utils(UART_receiver_agt_config)
   function new(string name = "UART_receiver_agt_config");
      super.new(name);
   endfunction
   uvm_active_passive_enum active = UVM_ACTIVE;
   virtual UART_receiver_interface vif;
   uvm_sequencer #(UART_receiver_seq_item) sqr;
endclass























