/*
begin
  PKGL_INFRA_UTIL.PRCL_SET_CURRENT_SCHEMA('AG0226') ;
  dbms_output.put_line(PKGL_INFRA_UTIL.FNCL_GET_CURRENT_SCHEMA());
end;
*/ 
declare
  vs_reg_esperados number := 5000;
  vs_count number(6) := 0;
  vs_recno  number := 0 ; 
  VS_MEDIOTEMP number := 0;
  VS_SALDOSMES number := 0;   
  cConta CHAR(7) := '35816-9';
  cAgencia CHAR(4) := '0230';

begin

/*  dbms_output.put_line('====================================================================================================');
  dbms_output.put_line('| servidor - '||sys_context( 'userenv', 'db_name' )||'@'||sys_context( 'userenv', 'server_host' ) ||' - banco de dados: '||sys_context( 'userenv', 'current_schema'));
  dbms_output.put_line('| inicio do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line('| usuario: - '||sys_context( 'userenv','os_user') );
  dbms_output.put_line('====================================================================================================');
*/
        
 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
   dbms_output.put_LINE('Recno APLI ;  Conta Aplicacao ; Saldo médio Calculado ; Quantidade Movimentos + Saldo Ini');            
  
   For Ajus In (select distinct FCTAAPLI FROM AG4501.CCRMMOVI WHERE IS_DELETED='N'  ) Loop
     
    
------ Pegar Saldo Anterior 
             Select (sum(ftotalzero) / 31), count(1)   INTO VS_MEDIOTEMP, VS_COUNT  from (
                        Select fctaapli,
                               'INI' as fcodhis,
                               to_date('30/06/2014') as fdata, 
                               fnsldbruto as fvalor_A, 
                               31 as ndias, 
                               fnsldbruto * 31 as FTotalZero 
                          from ag4501.ccrMSMES 
                         where fcanomes = '201407' 
                           and fctaapli = AJUS.FCTAAPLI 
                           AND IS_DELETED = 'N'   union   
                        ------ Unindo com as movimentacoes do mês    
                        Select GM.fctaapli,
                               GM.fcodhis,
                               GM.fdata,
                               (CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) AS FVALOR_A, 
                               (to_date('31/07/2014') - GM.fdata) as ndias, 
                               ((CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) * (to_date('31/07/2014') - GM.fdata)) as FTotalZero   
                          from ag4501.ccrMMOVI GM,
                               ag4501.ccrghist GH 
                         where gm.fcodhis = GH.FCODHIS                                 
                           and GM.fctaapli = AJUS.FCTAAPLI 
                           and (GM.fdata  between '01/07/2014' and '31/07/2014' )      -- periodo de calculo
                         --  AND GM.FCODHIS NOT IN ('901','902','921','922','942','944') -- codigos de provisao                          
                           AND GM.IS_DELETED = 'N'
                           AND GH.IS_DELETED = 'N' ) ;

            --- este count é só pra evitar erro dos que estao zerados 
            Select COUNT(0) INTO VS_recno from AG4501.CCRMSMES SM WHERE  SM.FCTAAPLI = AJUS.FCTAAPLI AND IS_DELETED = 'N' and sm.fcanomes = '201407' ;
            
            If vs_Recno > 0 then 
               Select sm.recno  INTO VS_Recno from AG4501.CCRMSMES SM WHERE SM.FCTAAPLI = AJUS.FCTAAPLI AND IS_DELETED = 'N' and sm.fcanomes = '201407' ;
               --- Select FCTAAPLI, COUNT(0) from AG4501.CCRMSMES SM WHERE IS_DELETED = 'N' and SM.fcanomes = '201407' GROUP BY FCTAAPLI HAVING COUNT(0) > 1 ;
               ---- SELECT * FROM AG4501.CCRMSMES WHERE FCTAAPLI = '1403500001-9' and fcanomes = '201407'  for update 
            END IF ; 
            
            If (vs_mediotemp <> 0 AND VS_RECNO <> 0 ) then 

               dbms_output.put( VS_RECNO ||' ; ' || AJUS.FCTAAPLI ||' ; ' || to_char(VS_MEDIOTeMP,'99999999.99') ||' ; ' || to_char(VS_COUNT)  ||' ; '   );               

               update ag4501.ccrMSMES set fnsldmedio = vs_mediotemp where recno = vs_recno ;
               dbms_output.put_LINE(sql%rowcount) ;
               
               commit;              
                                             
            End If; 
            
            ------  Select sum(fnsldmedio) from ag4501.ccrMSMES where fcanomes = '201407' ; --- isto dava zero antes de rodar 

 
 
            
            vs_mediotemp := 0 ;
            vs_saldosmes := 0 ; 
            vs_recno := 0 ; 
   End Loop; 
   
 
   
   
     dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
 

end;


