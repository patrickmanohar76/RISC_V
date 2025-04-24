`timescale 1ns / 1ps

module Instructionmem(
        input [31:0] PC,//program counter
        input reset,
        output [31:0] Instructioncode
        );
        
        reg [7:0] Mem [99:0]; // byte addressable memory locations
        assign Instructioncode={Mem[PC+3],Mem[PC+2],Mem[PC+1],Mem[PC]}; // Instruction code 
        always@(reset)
        begin
        if(reset==1 )
        begin
        //loading the memory after reset
        //r and i type 
        
        //12 instructions
//        Mem[3]=8'h00;Mem[2]=8'h32;Mem[1]=8'hE3;Mem[0]=8'h33;//or r6,r5,r3

//    // Mem[3]= 8'h00; Mem[2]=8'h20; Mem[1]=8'hC1; Mem[0]=8'hB3; //Add r7,r1,r2
//      Mem[7]= 8'h40; Mem[6]=8'h11; Mem[5]=8'h82; Mem[4]=8'h33; //Sub r4,r7,r1
//        Mem[11]=8'h00; Mem[10]=8'h22; Mem[9]=8'h11; Mem[8]=8'hB3; //Sll r3,r4,r2
//        Mem[15]=8'h00; Mem[14]=8'h32; Mem[13]=8'hA0; Mem[12]=8'hB3; //slt r1,r5,r3
//        Mem[19]=8'h00; Mem[18]=8'h20; Mem[17]=8'hC1; Mem[16]=8'hB3; //xor r3,r1,r2
//        Mem[23]=8'h00;Mem[22]=8'h31; Mem[21]=8'h52;Mem[20]=8'hB3;//srl r5,r2,r3*/
//                    Mem[27]= 8'h00; Mem[26]=8'h20; Mem[25]=8'hC1; Mem[24]=8'hB3; //Add r7,r1,r2

//        //Mem[27]=8'h00;Mem[26]=8'h32;Mem[25]=8'hE3;Mem[24]=8'h33;//or r6,r5,r3
//       Mem[31]=8'h00;Mem[30]=8'h33;Mem[29]=8'h72;Mem[28]=8'hB3;//and r5,r6,r3

//          Mem[35]= 8'h00; Mem[34]=8'h20; Mem[33]=8'hC1; Mem[32]=8'hB3; //Add r7,r1,r2
//            Mem[39]= 8'h40; Mem[38]=8'h13; Mem[37]=8'h82; Mem[36]=8'h33; //Sub r4,r7,r1
//              Mem[43]=8'h00; Mem[42]=8'h22; Mem[41]=8'h11; Mem[40]=8'hB3; //Sll r3,r4,r2
//              Mem[47]=8'h00; Mem[46]=8'h32; Mem[45]=8'hA0; Mem[44]=8'hB3; //slt r1,r5,r3
//              Mem[51]=8'h00; Mem[50]=8'h20; Mem[49]=8'hC1; Mem[48]=8'hB3; //xor r3,r1,r2
//              Mem[55]=8'h00;Mem[54]=8'h31; Mem[53]=8'h52;Mem[52]=8'hB3;//srl r5,r2,r3
//              Mem[59]=8'h00;Mem[58]=8'h32;Mem[57]=8'hE3;Mem[56]=8'h33;//or r6,r5,r3
//              Mem[63]=8'h00;Mem[62]=8'h33;Mem[61]=8'h72;Mem[60]=8'hB3;//and r5,r6,r3
//                Mem[67]= 8'h00; Mem[66]=8'h20; Mem[65]=8'hC1; Mem[64]=8'hB3; //Add r7,r1,r2
//                  Mem[71]= 8'h40; Mem[70]=8'h13; Mem[69]=8'h82; Mem[68]=8'h33; //Sub r4,r7,r1
//                    Mem[75]=8'h00; Mem[74]=8'h22; Mem[73]=8'h11; Mem[72]=8'hB3; //Sll r3,r4,r2
//                    Mem[79]=8'h00; Mem[78]=8'h32; Mem[77]=8'hA0; Mem[76]=8'hB3; //slt r1,r5,r3
//                    Mem[83]=8'h00; Mem[82]=8'h20; Mem[81]=8'hC1; Mem[80]=8'hB3; //xor r3,r1,r2
//                    Mem[87]=8'h00;Mem[86]=8'h31; Mem[85]=8'h52;Mem[84]=8'hB3;//srl r5,r2,r3
//                    Mem[91]=8'h00;Mem[90]=8'h32;Mem[89]=8'hE3;Mem[88]=8'h33;//or r6,r5,r3
//                    Mem[95]=8'h00;Mem[94]=8'h33;Mem[93]=8'h72;Mem[92]=8'hB3;//and r5,r6,r3
                    
                    
                    
                    
       /* Mem[35]=8'h00; Mem[34]=8'h40; Mem[33]=8'h00; Mem[32]=8'h6F;// jal x0, 40
        Mem[39]=8'h80; Mem[38]=8'h03; Mem[37]=8'hA4; Mem[36]=8'h93; //slt1 r9,r7,fffff800
        Mem[43]=8'h00;Mem[42]=8'h24; Mem[41]=8'h03;Mem[40]=8'h63;//beq x2,x8,52
        Mem[47]=8'h0F;Mem[46]=8'hF4;Mem[45]=8'h63;Mem[44]=8'h13;//ori r6,r8,000000ff
        Mem[51]=8'hFF;Mem[50]=8'hF3;Mem[49]=8'h73;Mem[48]=8'h93;////andi r7,r6,ffffffff
        Mem[55]= 8'h00; Mem[54]=8'h01; Mem[53]=8'h22; Mem[52]=8'h83;// lw r5 ,0($t2)
        Mem[59]= 8'h00; Mem[58]=8'h50; Mem[57]=8'hA1; Mem[56]=8'hA3;//sw r5,3($t1)*/

            
            

////application - GCD of two given numbers x2 - input 2 , x1 - input 1, x5 -00000001 required for comparision loaded from memory loactions 0,4,8 respectively 

//        Mem[3]= 8'h00; Mem[2]=8'h00; Mem[1]=8'h21; Mem[0]=8'h03;       //      This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[7]= 8'h00; Mem[6]=8'h40; Mem[5]=8'h20; Mem[4]=8'h83;      //       This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[11]= 8'h00; Mem[10]=8'h80; Mem[9]=8'h22; Mem[8]=8'h83;    //       This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[15]= 8'h00; Mem[14]=8'h00; Mem[13]=8'h89; Mem[12]=8'h63;   //      This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[19]= 8'h00; Mem[18]=8'h20; Mem[17]=8'hA2; Mem[16]=8'h33;  //       This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[23]=8'h00; Mem[22]=8'h52; Mem[21]=8'h03; Mem[20]=8'h63;   //       This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[27]=8'h40; Mem[26]=8'h20; Mem[25]=8'h80; Mem[24]=8'hB3; //         This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[31]=8'hFF; Mem[30]=8'h9F; Mem[29]=8'hF0; Mem[28]=8'h6F; //         This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[35]=8'H00;Mem[34]=8'h00; Mem[33]=8'h81;Mem[32]=8'h93;//            This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[39]=8'h00;Mem[38]=8'h01;Mem[37]=8'h00;Mem[36]=8'h93;//             This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[43]=8'h00;Mem[42]=8'h01;Mem[41]=8'h81;Mem[40]=8'h13;//             This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[47]=8'hFF; Mem[46]=8'h1F; Mem[45]=8'hF0; Mem[44]=8'h6F; //         This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
//        Mem[51]= 8'h00; Mem[50]=8'h20; Mem[49]=8'h26; Mem[48]=8'h23;//         This code is looping itself indefinitely--tested the code in rars tool.--looping indefinitely there too
        













//       Mem[3]= 8'h00; Mem[2]=8'h00; Mem[1]=8'h20; Mem[0]=8'h83;     // lw x1,0(x0)        
//       Mem[7]= 8'h00; Mem[6]=8'h40; Mem[5]=8'h21; Mem[4]=8'h03;     // lw x2,4(x0)
//       Mem[11]= 8'h00; Mem[10]=8'h80; Mem[9]=8'h21; Mem[8]=8'h83;   // lw x3,8(x0)    
//       Mem[15]= 8'h02; Mem[14]=8'h20; Mem[13]=8'h80; Mem[12]=8'hb3; // mul x1,x1,x2 
//       Mem[19]=8'h00;Mem[18]=8'h30;Mem[17]=8'h84;Mem[16]=8'h63;     // beq x1,x3,done     
//       Mem[23]=8'h00; Mem[22]=8'h00; Mem[21]=8'h21; Mem[20]=8'h03;  // lw x2,0(x0)
//       Mem[27]=8'h00; Mem[26]=8'h20; Mem[25]=8'h26; Mem[24]=8'h23;   //  done:sw x2,12 (x0)                            
       //we can see that the 12 address in data memory is changed to 4 .
       
       
       
       
       
       Mem[12]= 8'h00; Mem[13]=8'h00; Mem[14]=8'h20; Mem[15]=8'h83;     // lw x1,0(x0)        
       Mem[16]= 8'h00; Mem[17]=8'h40; Mem[18]=8'h21; Mem[19]=8'h03;     // lw x2,4(x0)
       Mem[20]= 8'h00; Mem[21]=8'h80; Mem[22]=8'h21; Mem[23]=8'h83;   // lw x3,8(x0)    
       Mem[24]= 8'h02; Mem[25]=8'h20; Mem[25]=8'h80; Mem[27]=8'hb3; // mul x1,x1,x2 
       Mem[28]=8'h00;Mem[29]=8'h30;Mem[30]=8'h84;Mem[31]=8'h63;     // beq x1,x3,done     
       Mem[32]=8'h00; Mem[33]=8'h00; Mem[34]=8'h21; Mem[35]=8'h03;  // lw x2,0(x0)
       Mem[36]=8'h00; Mem[37]=8'h20; Mem[38]=8'h26; Mem[39]=8'h23;   //  done:sw x2,12 (x0) 
       
       
////          Matrix operation 
//           LMA at address 0 (bytes 0-3)
//        {Mem[3], Mem[2], Mem[1], Mem[0]} = 32'h00000077; // 00_000_0000_1110111

//        // LMB at address 4 (bytes 4-7)
//        {Mem[7], Mem[6], Mem[5], Mem[4]} = 32'h00041077; // 00_001_0001_1110111

      

//        // MAT MUL at address 12 (bytes 12-15)
//        {Mem[15], Mem[14], Mem[13], Mem[12]} = 32'h80001077; // 10_001_1000_1110111
        
        
        
//          // MAT INV at address 8 (bytes 8-11)
//        {Mem[11], Mem[10], Mem[9], Mem[8]} = 32'h80000077; // 10_000_0010_1110111







//    Mem[3]= 8'h00; Mem[2]=8'h00; Mem[1]=8'h20; Mem[0]=8'h83;       //lw x1,0(x0)
//    Mem[7]= 8'h00; Mem[6]=8'h40; Mem[5]=8'h21; Mem[4]=8'h03;    //lw x2,4(x0)
//    Mem[11]= 8'h00; Mem[10]=8'h80; Mem[9]=8'h21; Mem[8]=8'h83;  //lw x3,8(x0)
//    Mem[15]= 8'h00; Mem[14]=8'hc0; Mem[13]=8'h22; Mem[12]=8'h03;  //lw x4,12(x0)
//    Mem[19]= 8'h00; Mem[18]=8'h41; Mem[17]=8'h84; Mem[16]=8'h63;//beq x3,x4,addition              //    add x2,x2,x3
//    Mem[23]= 8'h40; Mem[22]=8'h11; Mem[21]=8'h00; Mem[20]=8'hb3;  //sub x1,x2,x1
//    Mem[27]= 8'h00; Mem[26]=8'h11; Mem[25]=8'h00; Mem[24]=8'hb3; //addition: add x1,x2,x1
   
   
   

 
 
 
 
 
 
         end 
         end 
     endmodule
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
 