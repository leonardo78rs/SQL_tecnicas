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
  cDataMax CHAR(10) := '';
  nquant number(5) := 0 ;   

begin

  dbms_output.put_line('====================================================================================================');
  dbms_output.put_line('| servidor - '||sys_context( 'userenv', 'db_name' )||'@'||sys_context( 'userenv', 'server_host' ) ||' - banco de dados: '||sys_context( 'userenv', 'current_schema'));
  dbms_output.put_line('| inicio do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line('| usuario: - '||sys_context( 'userenv','os_user') );
  dbms_output.put_line('====================================================================================================');

      
  execute immediate 'alter session set current_schema=ag'||cAgencia;
    
   For Ajus In (select schema, agencia
      from unify.schemas
     where tipo in ('C', 'B')     
     --and schema not in ('AG9900','AGESTRU','SGU','AG9804','AG9803') order by schema ) Loop
     and schema in ('AG0259') order by schema ) Loop
     
     execute immediate 'alter session set current_schema='||Ajus.schema;              
        
         dbms_output.put (ajus.agencia) ;
         For Procura In (
                            SELECT distinct B.FCAGENCIA||B.FCNROCOOP AGENtalao
                                 , B.FCCAF
                              FROM CCR1CHEQ A
                                 , AGPADRAO.CCROPOST B
                             WHERE A.IS_DELETED = 'N'
                              -- AND A.NUM_AG = ajus.agencia
                               AND B.IS_DELETED = 'N'
                               AND B.FCAGENCIA||B.FCNROCOOP != A.NUM_AG
                               AND TRIM(B.FCCAF) IS NOT NULL
                               AND A.FCAGENCIA = B.FCCAF                              
                         )   Loop 
                 
                 Select to_char(max(fdcadtalao),'dd/mm/yyyy'),count(*) into cDataMax,nQuant from ccr1cheq where fcagencia = procura.fccaf ;
                          
                 dbms_output.put_line (' | '||Procura.FcCAF||' |  '||Procura.AGENtalao||' | '||to_char(nquant)||' | '||cDataMax) ;

   
         End Loop ;
        dbms_output.put_line ('-----') ;
 
   End Loop; 


       dbms_output.put_line('-----------------------------------------------------------------------------------------------');

                   
--  dbms_output.put_line ( 'registros atualizados: ' || vs_count );
  
--   dbms_output.put_line( 'fim do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );

end;



