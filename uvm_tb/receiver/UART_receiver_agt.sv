

class UART_receiver_agt extends uvm_agent;
   `uvm_component_utils(UART_receiver_agt)
   function new(string name = "UART_receiver_agt",uvm_component parent);
     super.new(name,parent);
   endfunction
   UART_receiver_mon mon;
   UART_receiver_drv drv;
   UART_receiver_sqr sqr;
   UART_receiver_agt_config agt_cfg;
   uvm_analysis_port #(UART_receiver_seq_item) agt_tx_port;

   virtual function void build_phase(uvm_phase phase);
         `uvm_info("my_agent","hello from my_agent", UVM_LOW );
        if(!uvm_config_db#(UART_receiver_agt_config)::get(this,"","agt_cfg",agt_cfg))
               `uvm_fatal("NO_AGT_CFG","the getting of agt_cfg is failed");
        
        if(agt_cfg.active == UVM_ACTIVE) begin
                drv = UART_receiver_drv::type_id::create("drv",this);
                sqr = new("sqr",this);
        end
        agt_cfg.sqr = sqr;
        mon = UART_receiver_mon::type_id::create("mon",this);
        agt_tx_port=new("agt_tx_port",this);

   endfunction
   virtual function void connect_phase(uvm_phase phase);
          mon.mon_tx_port.connect(this.agt_tx_port);

          if(agt_cfg.active == UVM_ACTIVE)
               drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass

















