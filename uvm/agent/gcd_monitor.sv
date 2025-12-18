/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_monitor.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Instantiate and connect the monitor to the DUT virtual interface (connect_phase)
*   4. Define the logic to monitor transaction signals from the DUT (run_phase)
*   5. Create a UVM analysis port that writes monitored transactions to the scoreboard
-------------------------------------------------------------------------------------------------*/

class gcd_monitor extends uvm_monitor;

    `uvm_component_utils(gcd_monitor)

    virtual gcd_if vif;
    uvm_analysis_port #(gcd_seq_item) item_collect_port;

    function new(string name = "gcd_monitor", uvm_component parent = null);
        super.new(name, parent);
        item_collect_port = new("item_collect_port", this);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual gcd_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Not set at top level")
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        gcd_seq_item tr;
        
        forever begin
            wait(!vif.rst_i);
            @(posedge vif.clk_i);
            
            if (vif.valid_i) begin
                tr = gcd_seq_item::type_id::create("tr");
                tr.data_a = vif.a_i;
                tr.data_b = vif.b_i;
                
                wait(vif.valid_o);
                @(posedge vif.clk_i);
                tr.result_gcd = vif.gcd_o;
                
                item_collect_port.write(tr);
            end
        end
    endtask : run_phase
    
endclass : gcd_monitor