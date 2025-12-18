/*-----------------------------------------------------------------------------------------------
* File Name     :   agent_template.sv
* Author        :   Andrew Chen
* Date          :   8/9/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Instantiate your driver, monitor, and sequencer based on is_active
*   4. Connect your sequencer to your driver based on is_active
-------------------------------------------------------------------------------------------------*/

class gcd_agent extends uvm_agent;

    `uvm_component_utils(gcd_agent)
    gcd_driver driver;
    gcd_sequencer sequencer;
    gcd_monitor monitor;

    function new(string name = "gcd_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(get_is_active() == UVM_ACTIVE) begin
            driver = gcd_driver::type_id::create("driver", this);
            sequencer = gcd_sequencer::type_id::create("sequencer", this);
        end

        monitor = gcd_monitor::type_id::create("monitor", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end         
    endfunction : connect_phase

endclass : gcd_agent