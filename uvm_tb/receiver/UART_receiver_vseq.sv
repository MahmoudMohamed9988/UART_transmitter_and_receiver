
class UART_receiver_virtual_sequence extends uvm_sequence ;
        `uvm_object_utils(UART_receiver_virtual_sequence)
        function new(string name = "UART_receiver_virtual_sequence");
                  super.new(name);
        endfunction
        UART_receiver_seq seq_1;
        virtual task body();
             seq_1 = UART_receiver_seq::type_id::create("seq_1");
                seq_1.start(get_sequencer(),this);
        endtask
endclass






















