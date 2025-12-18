/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_driver.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Instantiate and connect the driver to the DUT virtual interface (connect_phase)
*   4. Define the logic to drive transaction signals onto the DUT (run_phase)
-------------------------------------------------------------------------------------------------*/

class gcd_driver extends uvm_driver #(gcd_seq_item);

    `uvm_component_utils(gcd_driver)
    
    virtual gcd_if vif;
    
    function new(string name = "gcd_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual gcd_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Interface not set in config_db")
    endfunction : build_phase        

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);        
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        gcd_seq_item req;

        // Wait for reset to be deasserted before driving
        wait(!vif.rst_i);

        forever begin
            seq_item_port.get_next_item(req);

            @(posedge vif.clk_i);
            vif.a_i <= req.data_a;
            vif.b_i <= req.data_b;
            vif.valid_i <= 1'b1;

            @(posedge vif.clk_i);
            vif.valid_i <= 1'b0;
            
            wait(vif.valid_o);
            @(posedge vif.clk_i);
            
            seq_item_port.item_done();
        end       
    endtask : run_phase
    
endclass : gcd_driver