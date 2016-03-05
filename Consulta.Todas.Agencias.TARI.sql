/*
begin
  PKGL_INFRA_UTIL.PRCL_SET_CURRENT_SCHEMA('AG0226') ;
  dbms_output.put_line(PKGL_INFRA_UTIL.FNCL_GET_CURRENT_SCHEMA());
end;
*/ 
declare
  vs_reg_esperados number := 5000;
  vs_count number(6) := 0;
  cConta CHAR(7) := '35816-9';
  cAgencia CHAR(4) := '0230';

begin

  dbms_output.put_line('====================================================================================================');
  dbms_output.put_line('| servidor - '||sys_context( 'userenv', 'db_name' )||'@'||sys_context( 'userenv', 'server_host' ) ||' - banco de dados: '||sys_context( 'userenv', 'current_schema'));
  dbms_output.put_line('| inicio do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line('| usuario: - '||sys_context( 'userenv','os_user') );
  dbms_output.put_line('====================================================================================================');

      
  execute immediate 'alter session set current_schema=ag'||cAgencia;
    

 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
   dbms_output.put_line('PROVISIONADAS E DEBITADAS      PROVISIONADAS E NAO DEBITADAS'); 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
  
   For Ajus In (select schema, agencia
      from unify.schemas
     where tipo in ('C', 'B')     
     and schema not in ('AG9900','AGESTRU','SGU','AG9804','AG9803') order by schema ) Loop
     
     execute immediate 'alter session set current_schema='||Ajus.schema;              
         For Procura In (Select COUNT(*) AS CONTAG FROM CCR1TARI TARI WHERE
                        TARI.FDDEBTARI = TO_DATE('03/12/2013') and TARI.FDprovisao = TO_DATE('03/12/2013') and tari.fdinclusao < to_date('03/12/2013')  )  Loop 
          dbms_output.put ('Agencia:'||ajus.agencia||':  ' || Procura.CONTAG  ) ;
         End Loop ;    

        For Procura In (Select COUNT(*) AS CONTAG FROM CCR1TARI TARI WHERE
                        TARI.FDDEBTARI = TO_DATE(1,'J') and TARI.FDprovisao = TO_DATE('03/12/2013') and tari.fdinclusao < to_date('03/12/2013')  )  Loop 
             dbms_output.put_line ('                  ' || Procura.CONTAG ) ;
         End Loop ;
  
   End Loop; 
   
 
   
   
     dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
 

end;
