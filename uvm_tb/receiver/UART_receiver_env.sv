
class UART_receiver_env extends uvm_env;
  `uvm_component_utils(UART_receiver_env)
  function  new(string name = "UART_receiver_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  UART_receiver_agt agt;
  UART_receiver_scb scb;
  UART_receiver_cov cov;
  UART_receiver_env_config env_cfg;
  virtual function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(UART_receiver_env_config)::get(null,"my_env","env_cfg",env_cfg)) `uvm_fatal("NO_ENV_CFG","the getting of env_cfg is failed");
    uvm_config_db#(UART_receiver_agt_config)::set(this,"agt*","agt_cfg",env_cfg.agt_cfg);
	 agt=UART_receiver_agt::type_id::create("agt",this);
         if(env_cfg.has_coverage)
              cov=UART_receiver_cov::type_id::create("cov",this);
         if(env_cfg.has_scoreboard)
              scb=UART_receiver_scb::type_id::create("scb",this);
  endfunction
  virtual function void connect_phase(uvm_phase phase);
     if(env_cfg.has_scoreboard) begin
        agt.agt_tx_port.connect(scb.predictor_tx_export);
        agt.agt_tx_port.connect(scb.evaluator_tx_export);
     end
     if(env_cfg.has_coverage) begin
        agt.agt_tx_port.connect(cov.analysis_export);
        //agt.dut_out_tx_port.connect(cov.dut_out_tx_export);
     end
  endfunction
endclass
















