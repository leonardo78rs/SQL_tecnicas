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
  xConta CHAR(7) := '';
  cmens  CHAR(14) := '';
  xAgencia CHAR(4) := '';
  xrecno number(10) := 0 ; 
  xsomatari number(12) := 0 ;
  xAntigoValorTari number(12) := 0 ;
  cAgencia CHAR(4) := '0230';

begin

  dbms_output.put_line('====================================================================================================');
  dbms_output.put_line('| servidor - '||sys_context( 'userenv', 'db_name' )||'@'||sys_context( 'userenv', 'server_host' ) ||' - banco de dados: '||sys_context( 'userenv', 'current_schema'));
  dbms_output.put_line('| inicio do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line('| usuario: - '||sys_context( 'userenv','os_user') );
  dbms_output.put_line('====================================================================================================');
   
  execute immediate 'alter session set current_schema=ag'||cAgencia;

 

-------------------- PRIMEIRA parte INATIVAS
  dbms_output.put_line('        AGEN| CONTA |VLR ANTIGO|VLR ATUAL |RECNO SALD -- contas em prejuizo') ;      
  For Ajus In (select schema, agencia
     from unify.schemas
     where tipo in ('C', 'B')     
     and schema in ('AG0800')
     and schema not in ('AG9900','AGESTRU','SGU','AG9804','AG9803') order by schema ) Loop
     
     execute immediate 'alter session set current_schema='||Ajus.schema;              
     
         For Procura In (SELECT DISTINCT S.NUM_AG as xagencia,S.FCONTA as xconta
                           FROM CCR1TARI T 
                           JOIN CCR1SALD S ON (T.FCCONTA = S.FCONTA) AND (T.NUM_AG = S.NUM_AG) 
                          WHERE S.FCSITU = 'P' 
                            AND T.FDPROVISAO >= S.FDTRANPREJ 
--                            AND S.FDTRANPREJ < TO_DATE('18/02/2014') 
                            AND T.IS_DELETED = 'Y' 
                            AND S.IS_DELETED = 'N' )  Loop 
             
             vs_count := vs_count + 1; 
             xsomatari := 0 ; 
             XRECNO    := 0 ; 
             xAntigoValorTari  := 0 ; 

             dbms_output.put (to_char(vs_count,'00009')||') ');

             BEGIN              
                  Select sum(fnvalor) into xsomatari from ccr1tari where fcconta = procura.xconta AND FDDEBTARI = TO_DATE(1,'J') AND IS_DELETED='N'; 
                  Select recno,fvalortari   into xrecno,xAntigoValorTari from ccr1sald where fconta  = procura.xconta  and is_deleted = 'N' and fcsitu = 'P';

                  If xsomatari is null then xsomatari := 0;  End if ;            
                  
                  If xAntigoValorTari = xsomatari or (xrecno is null or xrecno = 0)  then 
                     cmens := ' Not Updated';
                  Else 
                     Update ccr1sald set fvalortari = xsomatari where recno = xrecno ;    
                     cmens := '' ; 
                     rollback;      
                  End if ; 
 
                  dbms_output.put_LINE (ajus.agencia   ||'|'||
                                        procura.xconta ||'|'||
                                        to_char(xAntigoValorTari,'9,999.99') ||'|'||
                                        to_char(xsomatari,'9,999.99')        ||'|'||
                                        to_char(xrecno,'00000009')            ||'|'||
                                        cmens);     
             Exception     
             When no_data_found then            
                  dbms_output.put_LINE ('Erro na Consulta tari/sald!') ;             
             END ; 
             
         End Loop ;        
  End Loop ; 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
   
-------------------- segunda parte INATIVAS 
  dbms_output.put_line('        AGEN| CONTA |VLR ANTIGO|VLR ATUAL |RECNO INAT -- contas inativas') ;
  VS_COUNT := 0 ;  
  
  For Ajus In (select schema, agencia
     from unify.schemas
     where tipo in ('C', 'B')     
     and schema in ('AG0915','AG0908','AG0749','AG0140','AG0106','AG3024','AG3029','AG0900','AG3023','AG0700','AG0157','AG0202','AG0800')
     and schema not in ('AG9900','AGESTRU','SGU','AG9804','AG9803') order by schema ) Loop
     
     execute immediate 'alter session set current_schema='||Ajus.schema;              
        
              
            
        For Procura In (SELECT DISTINCT i.NUM_AG as xagencia,i.FCONTA as xconta
                 FROM CCR1TARI T 
                 JOIN CCR1INAT I ON (T.FCCONTA = I.FCONTA) -- AND (T.NUM_AG = I.NUM_AG) 
                WHERE T.FDPROVISAO  >= I.FDENVINAT                          
                  AND T.IS_DELETED = 'Y' 
                  AND I.IS_DELETED = 'N' )  Loop 
                 
             vs_count := vs_count + 1; 
             xsomatari := 0 ; 
             XRECNO    := 0 ; 
             xAntigoValorTari  := 0 ; 

             dbms_output.put (to_char(vs_count,'00009')||') ');

             BEGIN              
                  Select sum(fnvalor) into xsomatari from ccr1tari where fcconta = procura.xconta AND FDDEBTARI = TO_DATE(1,'J') AND IS_DELETED='N'; 
                                    
                  Select recno,fnvlrtari   into xrecno,xAntigoValorTari from ccr1inat where fconta  = procura.xconta  and is_deleted = 'N' ;

                  If xsomatari is null then xsomatari := 0;  End if ;            
                  
                  If xAntigoValorTari = xsomatari or (xrecno is null or xrecno = 0)  then 
                     cmens := ' Not Updated';
                  Else 
                     Update ccr1INAT set fnvlrtari = xsomatari where recno = xrecno ;    
                     cmens := '' ; 
                     rollback;      
                  End if ; 
 
                  dbms_output.put_LINE (ajus.agencia   ||'|'||
                                        procura.xconta ||'|'||
                                        to_char(xAntigoValorTari,'9,999.99') ||'|'||
                                        to_char(xsomatari,'9,999.99')        ||'|'||
                                        to_char(xrecno,'00000009')            ||'|'||
                                        cmens);     
             Exception     
             When no_data_found then            
                  dbms_output.put_LINE ('Erro na Consulta tari/inat!') ;             
             END ; 
             
        End Loop ;        

         
   End Loop; 
       dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
       dbms_output.put_line(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'));
end;
