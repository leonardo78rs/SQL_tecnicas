/*
begin
  PKGL_INFRA_UTIL.PRCL_SET_CURRENT_SCHEMA('AG0226') ;
  dbms_output.put_line(PKGL_INFRA_UTIL.FNCL_GET_CURRENT_SCHEMA());
end;
*/ 
declare
  vs_reg_esperados number := 5000;
  cConta CHAR(7) := '35816-9';
  cAgencia CHAR(4) := '0230';

begin

  dbms_output.put_line('====================================================================================================');
  dbms_output.put_line('| servidor - '||sys_context( 'userenv', 'db_name' )||'@'||sys_context( 'userenv', 'server_host' ) ||' - banco de dados: '||sys_context( 'userenv', 'current_schema'));
  dbms_output.put_line('| inicio do processo: '||to_char(sysdate, 'dd  vs_count number(6) := 0;
/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line('| usuario: - '||sys_context( 'userenv','os_user') );
  dbms_output.put_line('====================================================================================================');

      
  execute immediate 'alter session set current_schema=ag'||cAgencia;
    

 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
   dbms_output.put_line('Consulta CCF '); 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
  
   For CCF in (Select DISTINCT FCCOOP,FCCONTA,fcagencia,FCCPFCGC   from AG9900.CCR1CCF  WHERE FCTIPOREG = 4 and is_deleted='N' and fcagencia in ('0801','0806') ) Loop 
   
           For Ajus In (select schema, agencia  from unify.schemas
             where tipo in ('C', 'B')     
             and schema not in ('AG9900','AGESTRU','SGU','AG9804','AG9803') 
--             and schema not in (Select distinct ) 
             order by schema ) Loop
             
             execute immediate 'alter session set current_schema='||Ajus.schema;              
  
             For Procura In (select fconta as CONTA  from ccr0asso where replace(replace(fcpf_cgc,'.'),'-') = CCF.FCCPFCGC and is_deleted='N'   )  Loop 

                 For UmCada In (Select count(0) as QuantCada from AG9900.CCR1CADA Cada Where Cada.Fccpf_Cgc = ccf.fccpfcgc and is_deleted= 'N' ) Loop 
                     If UmCada.QuantCada = 0 Then 
                        dbms_output.put_line ('CCF:'||ccf.FCCOOP||'+'||ccf.FCAGENCIA||'+'||'Agencia/Conta Asso:'||ajus.agencia||':  ' || Procura.CONTA  ) ;
                     Else  
                        Vs_count := vs_count +1 ;
                     End If; 
                 End Loop;
             End Loop ;    
             --dbms_output.put_line ('  ' ) ;
          
           End Loop; 
           
     End Loop; 
   
   
     dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
     dbms_output.put (vs_count) ;
     dbms_output.put_line(' total registros com 1cada');
     dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
     

end;


   
Select count(0) as QuantCada from AG9900.CCR1CADA Cada Where Cada.Fccpf_Cgc = ccf.fccpfcgc and is_deleted= 'N' 
Select DISTINCT FCCOOP,FCCONTA,fcagencia,FCCPFCGC   from AG9900.CCR1CCF  WHERE FCTIPOREG = 4 and is_deleted='N' and fcagencia in ('0801','0806')


Select ASSO.FCPF_CGC,  
       CADA.FCCOOP,
       CADA.FCAGENCIA,
       CADA.FCCONTA,
       CADA.NUM_AG,
       ASSO.FCONTA
  from ag0806.ccr0asso ASSO , 
       AG9900.CCR1CADA Cada  
Where  
       replace(replace(ASSO.FCPF_CGC,'.'),'-') = CADA.FCCPF_CGC 
 --  AND  REPLACE(ASSO.FCONTA,'-') = CADA.FCCONTA
  and  ASSO.is_deleted='N'
  AND  CADA.IS_DELETED='N' 

15083 IGUAIS 
 6657 DIFERENTES 
21740 TOTAIS 

 




