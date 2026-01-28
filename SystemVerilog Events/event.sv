//event e1;

//Two ways to trigger an event.
//1. Blocking(->e1)
//2. Non-Blocking (->>e1)

//To detect events
//1. @(e1)
//2. wait(e1.triggered)

module test;
    event e1;
    initial begin
        //Generator
       // #10;
        $display("[%0t] Generator: The event e1 is triggering", $time);
        //-> e1; //Blocking one acts as a pulse
        ->> e1; //the event to trigger in the NBA region
    end

    initial begin
        //Receiver
        $display("[%0t] Receiver: Waiting for the event e1 to trigger", $time);
       // @(e1);
       #1;
       wait(e1.triggered); //remain true for the entire time slot/ time step
        $display("[%0t] Receiver: Received event e1", $time);
    end

    initial begin #100 $stop(); end

endmodule 

/*
-> e1;
@(e1): This is edge sensitive. If this is happening in the same time slot as the blocking(->) one, it will get stucked
    This should be in the earlier time slots, or it should be used with non blocking (->>)

wait(e1.triggered): Level sensitive. It could be used with "->" in the same or earlier time slot.
->> e1: Non-Blocking (Occurs in NBA region). 

Note: That the detection (both edge and level sensitive one) should be done either in the same time slot or in the earlier time slots
not in the later time slots (only for non blocking triggering)
*/
