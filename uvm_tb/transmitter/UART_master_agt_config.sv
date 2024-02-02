

class UART_master_agt_config extends uvm_object;
  `uvm_object_utils(UART_master_agt_config)
   function new(string name = "UART_master_agt_config");
      super.new(name);
   endfunction
   uvm_active_passive_enum active = UVM_ACTIVE;
   virtual UART_master_interface vif;
   uvm_sequencer #(UART_master_seq_item) sqr;
endclass























