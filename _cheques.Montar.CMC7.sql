
declare
  BCO CHAR(3) := '748';
  AGE CHAR(4) := '8003';
  CPE CHAR(3) := '018' ; 
  CHE CHAR(6) := '000021' ; 
  TIP CHAR(1) := '5'  ;  --- 5 NORMAL
  CTA CHAR(10):= '0000141844' ; 
  DV1 CHAR(1) := ' ';
  DV2 CHAR(1) := ' ';
  DV3 CHAR(1) := ' ';  
  SUMDV1 NUMBER := 0;
  SUMDV2 NUMBER := 0;
  SUMDV3 NUMBER := 0;    
  I1 NUMBER :=0;
  I2 NUMBER :=0;
  I3 NUMBER :=0;    
  temp NUMBER :=0;

begin
  
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
       
   For i1 in 1 .. 7 loop      
       If round(i1/2,0)=(i1/2)   then temp:=substr(bco||age,i1,1); else temp:=substr(bco||age,i1,1)*2; end if;   --- impar*1, par*2
       If length(to_char(temp))>1 then temp:=to_number(substr(to_char(temp),1,1))+ to_number(substr(to_char(temp),2,1)); END IF; -- se dois caracter soma os dois
       sumdv1 := sumdv1 + temp ;                                 
   End loop; 
   
   If to_char(10 - Mod(sumdv1,10)) = 10 then dv1 := 0; else dv1:=to_char(10 - Mod(sumdv1,10)); end if; 
 
   
   For i2 in 1 .. 10 loop      
       If round(i2/2,0)<>(i2/2)   then temp:=substr(cpe||che||tip,i2,1); else temp:=substr(cpe||che||tip,i2,1)*2; end if;   --- contrario dv1
       If length(to_char(temp))>1 then temp:=to_number(substr(to_char(temp),1,1))+ to_number(substr(to_char(temp),2,1)); END IF; -- se dois caracter soma os dois
       sumdv2 := sumdv2 + temp ;                                 
   End loop; 
   
   If to_char(10 - Mod(sumdv2,10)) = 10 then dv2 := 0; else dv2:=to_char(10 - Mod(sumdv2,10)); end if;
 
   For i3 in 1 .. 10 loop      
       If round(i3/2,0)<>(i3/2)   then temp:=substr(cta,i3,1); else temp:=substr(cta,i3,1)*2; end if;   --- contrato dv1
       If length(to_char(temp))>1 then temp:=to_number(substr(to_char(temp),1,1))+ to_number(substr(to_char(temp),2,1)); END IF; -- se dois caracter soma os dois
       sumdv3 := sumdv3 + temp ;                                 
   End loop; 
   
   If to_char(10 - Mod(sumdv3,10)) = 10 then dv3 := 0; else dv3:=to_char(10 - Mod(sumdv3,10)); end if; 
            

   dbms_output.put_line('dv1.:'||dv1||', dv2:'||dv2||' ,dv3:'||DV3); 
   dbms_output.put_line('CMC7:'||BCO||AGE||DV2||CPE||CHE||TIP||DV1||CTA||DV3);
   dbms_output.put_line('---> BCO AGEN   CPE CHEQUE     CONTA');
   dbms_output.put_line('CMC7:'||BCO||' '||AGE||' '||DV2||' '||CPE||' '||CHE||' '||TIP||' '||DV1||' '||CTA||' '||DV3);

   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
     

end;
