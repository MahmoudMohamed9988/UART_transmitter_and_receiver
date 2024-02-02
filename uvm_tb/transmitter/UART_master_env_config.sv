
class UART_master_env_config extends uvm_object;
  `uvm_object_utils(UART_master_env_config)
   function new(string name = "UART_master_env_config");
      super.new(name);
   endfunction
   bit has_coverage ;
   bit has_scoreboard;
   UART_master_agt_config agt_cfg;
endclass




