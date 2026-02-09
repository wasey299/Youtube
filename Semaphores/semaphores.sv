module test;
  semaphore a;
  int count = 0;

  initial $monitor("count = %0d [%0t]", count, $time);
  initial begin
    a = new(4); //O Keys by default
  end
  /*
  a.get(6) //The entire process will get blocked at that staement //Blocking
  if(a.try_get(6)) count++; //Non blocking
  a.put(10)
  */
  //Process A
  initial begin
    #6 a.get(2); //#6, Keys: 2
    #5 a.get(1); //#11 -> #16, Keys: 1
    count++; //count == 1
    #2 if(a.try_get(2)) count++; //#18
  end

  //Process B
  initial begin
    #7 a.get(2); //#7, Keys: 0
    #9 a.put(2); //#16, Keys: 2
  //  #3 a.put(3); //#19
    #2 a.put(3); //#17 -> #18
  end
endmodule
