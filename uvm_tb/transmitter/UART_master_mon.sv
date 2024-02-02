
class UART_master_mon extends uvm_monitor;
    `uvm_component_utils(UART_master_mon)
     function  new(string name = "UART_master_mon", uvm_component parent);
         super.new(name,parent);
      endfunction
      virtual UART_master_interface vif;
      UART_master_agt_config agt_cfg;
      uvm_analysis_port #(UART_master_seq_item) mon_tx_port;

      UART_master_seq_item tx_n;
      virtual function void build_phase(uvm_phase phase);
             
              mon_tx_port=new("mon_tx_port",this);

              if(!uvm_config_db#(UART_master_agt_config)::get(this,"","agt_cfg",agt_cfg))
                   `uvm_fatal("NO_AGT_CFG","failing to get agt_cfg");
                vif = agt_cfg.vif;
      endfunction
      virtual task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("my_monitor","hello from my_monitor", UVM_LOW );
           tx_n  =  UART_master_seq_item::type_id::create("tx_n");
           fork
              get_input(tx_n);
              get_output(tx_n);
           join

       endtask
       virtual task get_input(UART_master_seq_item tx_n);
           
         forever begin 
                  
                    `uvm_info("my_monitor","Get an input", UVM_LOW );
                    vif.get_an_input(tx_n);                   
                     mon_tx_port.write(tx_n);

             end
       endtask
       virtual task get_output(UART_master_seq_item tx_n);           
         forever begin 
                 
                    `uvm_info("my_monitor","Get an output", UVM_LOW );
                  vif.get_an_output(tx_n);
                //  dut_out_tx_port.write(tx_n);
                 end
       endtask
endclass














