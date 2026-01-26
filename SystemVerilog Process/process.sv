module test;
    process proc1, proc2;

    int i;
    int j = 1;

    task thread1();
        proc1 = process::self(); //Gets the handle of the thread and assigns it to the handle
        forever #2 i++;// 0 1   2   3   4.........  
    endtask

    task thread2();
        proc2 = process::self();
        repeat(7) #4 j *= 2; // 1   2   4   8   16  32  64  128
    endtask
    /*
    suspend() paused the thread
    resume()    resumes the thread
    await() blocks the flow of the code till that thread finishes
    status() //RUNNING, SUSPENDED, FINISHED 
    kill() // disable fork....kilss the the thread
    */
    initial begin
        $monitor("Time : %0t\ti=%0d\tj=%0d", $time, i, j);
        fork 
            thread1();
            thread2();
        join
    end

    initial begin
        #3 proc1.suspend(); //Thread 1 paused at 3 time units
        #10 proc2.suspend(); //At 13 time units, thread 2 pauses
        #5 proc1.resume(); //At time slot 18, thread 1 continues
        $display("%s", proc1.status());
        $display("%s", proc2.status());
        #2 proc2.resume(); //At 20 time units, thread2 is resumed
        #1 proc2.await(); //At 21 time units, Block the flow of the code here(line 38), 
        //and the later statements will not be executed until the proc(which is proc2 finises)
        $display("%s", proc2.status());
        #1 proc1.kill(); 
    end
endmodule
