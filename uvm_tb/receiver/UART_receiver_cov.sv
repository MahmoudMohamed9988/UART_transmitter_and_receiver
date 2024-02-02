
// `uvm_analysis_imp_decl(_out) we use this macro if you want to use more than one write() function 
class UART_receiver_cov extends uvm_subscriber #(UART_receiver_seq_item);
  `uvm_component_utils(UART_receiver_cov)

   UART_receiver_seq_item cov_tx;

   covergroup  UART_receiver ;
       DATA: coverpoint cov_tx.data ;
       SEND: coverpoint cov_tx.rx ;   
       READY: coverpoint cov_tx.ready ;   
    endgroup


  function  new(string name = "UART_receiver_cov",uvm_component parent);
          super.new(name,parent);
    //      dut_out_tx_export =new("dut_out_tx_export",this);
          UART_receiver = new();
         
  endfunction
    

 virtual function void write (UART_receiver_seq_item t);
  cov_tx = UART_receiver_seq_item::type_id::create("cov_tx");
  if(! $cast(cov_tx,t)) `uvm_fatal("NO_CAST","the objects not compatable");
    cov_tx.do_copy(t);
    UART_receiver.sample();
  
endfunction




endclass







