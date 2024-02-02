
class UART_receiver_drv extends uvm_driver #(UART_receiver_seq_item);
  `uvm_component_utils(UART_receiver_drv)
  function  new(string name = "UART_receiver_drv",uvm_component parent);
           super.new(name,parent);
   endfunction

  virtual UART_receiver_interface vif;
  UART_receiver_agt_config agt_cfg;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    if(! uvm_config_db#(UART_receiver_agt_config)::get(this,"","agt_cfg",agt_cfg))
                      `uvm_fatal("NOVIF","failing to get agt_cfg");
        vif = agt_cfg.vif;
   endfunction
   virtual task run_phase(uvm_phase phase);
        `uvm_info("my_driver","hello from my_driver", UVM_LOW );
       forever begin
          UART_receiver_seq_item my_item;
          seq_item_port.get_next_item(my_item);           
          vif.transfer(my_item);
          seq_item_port.item_done();
       end
    endtask



endclass
















