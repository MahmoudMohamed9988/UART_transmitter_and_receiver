

class UART_master_scb extends uvm_scoreboard;
        `uvm_component_utils(UART_master_scb)
          function  new(string name = "UART_master_scb",uvm_component parent);
                super.new(name,parent);
          endfunction
          UART_master_predictor predictor;
          UART_master_evaluator evaluator;
          uvm_analysis_export #(UART_master_seq_item) predictor_tx_export;
          uvm_analysis_export #(UART_master_seq_item) evaluator_tx_export;
	  virtual function void build_phase(uvm_phase phase);
		predictor = UART_master_predictor::type_id::create("predictor",this);
		evaluator=UART_master_evaluator::type_id::create("evaluator",this);
		predictor_tx_export=new("predictor_tx_export",this);
		evaluator_tx_export=new("evaluator_tx_export",this);	
	  endfunction
	  virtual function void connect_phase(uvm_phase phase);
		predictor_tx_export.connect(predictor.analysis_export);
		evaluator_tx_export.connect(evaluator.actual_export);
        predictor.expected_port.connect(evaluator.expected_export);
          endfunction
endclass
















