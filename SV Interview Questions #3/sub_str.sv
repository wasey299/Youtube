module test;
  function automatic int get_substr_pos(string str, string sub);
    int str_len = str.len();
    int sub_len = sub.len();

    if (sub_len > str_len) return -1;

    for (int i = 0; i <= str_len - sub_len; i++) begin
      if (str.substr(i, i + sub_len - 1) == sub) begin
        return i;
      end

    end   
    return -1;
    //[DATA_SIZE - 1: 0] data_b; 
    // abcdef (6)
    //ef (2)
    /*
    s = "abcd"
    s.substr(1,2) = "bc"
    */
  endfunction

  task comp(int a, string str, string sub);
    if (a != -1) $display("Found '%s' at index: %0d in the target:%s", sub, a, str);
    else $display("'%s' not found in the target:%s", sub, str);
  endtask
  
  initial begin
      string my_str;
      string target;
      int pos;

      //Test 1:      
      my_str = "Hello SystemVerilog World";
      target = "System";
      pos = get_substr_pos(my_str, target);
      comp(pos, my_str, target);

      //Test 2:
      target = "Python";
      pos = get_substr_pos(my_str, target);
      comp(pos, my_str, target);

      //Test 3:
      target =  "Welcome back to another video";
      pos = get_substr_pos(my_str, target);
      comp(pos, my_str, target);  

  end

endmodule
