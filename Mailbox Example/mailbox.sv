module test;
  mailbox mail;
  
  string str;
  int i;

  string sv = "SystemVerilog";
  string py = "Python";
  string uv = "UVM";

  initial begin
    mail = new(); //Unbounded mailbox

    fork
      begin
        //Producer Thread (put)
        mail.put(sv); //#0, {"SystemVerilog"}
        #2 mail.put(7); //#2, {"SystemVerilog", 7}
        #4 mail.put(py); //#6, {"Python"}
        #3 mail.put(3);  //#9, {3}
        #3 mail.put(uv); //#12, {"UVM"}
        #2 mail.put(9); //#14, {9}
      end

      begin
        //Consumer Thread (get, try_get, peek, try_peek)
        mail.peek(str); //#0 str = "SystemVerilog", {"SystemVerilog"}
        #2 mail.get(str); //#2 str = "SystemVerilog", {7}
        #2 mail.get(i); //#4 i = 7, {} (Empty)
        #1 mail.peek(str); //#5 -> #6 str = "Python", {"Python"}
        #2 void'(mail.try_get(str));// #8, {}
        #1 void'(mail.try_get(i)); // #9, i = 3, {}
        #4 mail.get(str); //#13, str = "UVM", {}empty
        #2 mail.get(i); // #15, i = 9, {}empty
      end
    join

  end  

  initial $monitor("str = %s and i = %0d at time:%0t", str, i, $time);

endmodule
