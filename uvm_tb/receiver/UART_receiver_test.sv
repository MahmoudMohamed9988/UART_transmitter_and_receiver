
class UART_receiver_test extends uvm_test;
  `uvm_component_utils(UART_receiver_test)
   function  new(string name = "UART_receiver_test",uvm_component parent = null);
         super.new(name,parent);
   endfunction
   UART_receiver_env_config env_cfg;
   UART_receiver_agt_config agt_cfg;
   UART_receiver_env env;
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = UART_receiver_env::type_id::create("env",this);
      env_cfg = UART_receiver_env_config::type_id::create("env_cfg");
      agt_cfg = UART_receiver_agt_config::type_id::create("agt_cfg");
      env_cfg.has_coverage=1;
      env_cfg.has_scoreboard=1;
     if(!uvm_config_db#(virtual UART_receiver_interface)::get(null,"UART_receiver_test","vif",agt_cfg.vif))  `uvm_fatal("NO_IF","there is no interface");
       agt_cfg.active = UVM_ACTIVE;
       env_cfg.agt_cfg = this.agt_cfg;
     uvm_config_db#(UART_receiver_env_config)::set(null,"my_env","env_cfg",env_cfg);
   endfunction
   virtual task run_phase(uvm_phase phase);
     UART_receiver_virtual_sequence vseq = UART_receiver_virtual_sequence::type_id::create("vseq");
     phase.raise_objection(this);
     vseq.start(agt_cfg.sqr);
     phase.drop_objection(this); 
     phase.phase_done.set_drain_time(this,100);
    endtask
endclass 
