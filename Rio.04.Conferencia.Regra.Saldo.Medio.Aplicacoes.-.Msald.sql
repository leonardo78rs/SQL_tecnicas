/*
begin
  PKGL_INFRA_UTIL.PRCL_SET_CURRENT_SCHEMA('AG0226') ;
  dbms_output.put_line(PKGL_INFRA_UTIL.FNCL_GET_CURRENT_SCHEMA());
end;
*/ 
declare
  vs_reg_esperados number := 5000;
  vs_count number(6) := 0;
  VS_MEDIOTEMP number := 0;
  VS_SALDOSMES number := 0;   
  cConta CHAR(7) := '35816-9';
  cAgencia CHAR(4) := '0230';

begin

  dbms_output.put_line('====================================================================================================');

      

 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
  
   For Ajus In (select distinct FCTAAPLI FROM AG4501.CCRMMOVI WHERE IS_DELETED='N'  ) Loop
     
    
------ Pegar Saldo Anterior 
             Select sum(ftotalzero) / 31  INTO VS_MEDIOTEMP  from (
                        Select fctaapli,
                               'INI' as fcodhis,
                               to_date('31/07/2014') as fdata, 
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
                               (to_date('31/08/2014') - GM.fdata) as ndias, 
                               ((CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) * (to_date('31/08/2014') - GM.fdata)) as FTotalZero   
                          from ag4501.ccrMMOVI GM,
                               ag4501.ccrghist GH 
                         where gm.fcodhis = GH.FCODHIS                                 
                           and GM.fctaapli = AJUS.FCTAAPLI 
                           and (GM.fdata  between '01/08/2014' and '31/08/2014' )      -- periodo de calculo
                         --  AND GM.FCODHIS NOT IN ('901','902','921','922','942','944') -- codigos de provisao                          
                           AND GM.IS_DELETED = 'N'
                           AND GH.IS_DELETED = 'N' ) ;

            --- este count é só pra evitar erro dos que estao zerados 
            Select COUNT(0) INTO VS_SALDOSMES from AG4501.CCRMSMES SM WHERE  SM.FCTAAPLI = AJUS.FCTAAPLI AND IS_DELETED = 'N' and sm.fcanomes = '201408' ;
            
            If vs_SaldoSMes > 0 then 
               Select FNSLDMEDIO INTO VS_SALDOSMES from AG4501.CCRMSMES SM WHERE  SM.FCTAAPLI = AJUS.FCTAAPLI AND IS_DELETED = 'N' and sm.fcanomes = '201408' ;
            Else 
               Vs_SaldoSMes := -1111 ; 
            End if;
            
                                    
--            If (vs_mediotemp > 0 or vs_saldosmes > 0 ) then                 --- listar com e sem diferenca 
            If ABS(vs_mediotemp - vs_saldosmes) >= 0.01  and vs_saldosmes >= 0  then     --- listando so a diferença 
               dbms_output.put('C Apli.:');
               dbms_output.put(AJUS.FCTAAPLI);
               dbms_output.put(' SM: ' );
               dbms_output.put(to_char(VS_MEDIOTeMP,'99999999.99'));
               dbms_output.put(' SMES: ' );
               If Vs_saldosmes >= 0 then 
                  dbms_output.put(to_char(VS_saldosmes,'99999999.99'));
               Else 
                  dbms_output.put('** Nao encontrado');               
               End If; 
               dbms_output.put('  Dif: ' );
               dbms_output.put_LINE(to_char(VS_saldosmes - VS_MEDIOTeMP,'99999999.99'));                              

            End if;
            
            vs_mediotemp := 0 ;
            vs_saldosmes := 0 ; 
   End Loop; 
   
 
   
   
     dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
 

end;


/*sELECT * FROM AG4501.CCRMMOVI WHERE FCTAAPLI = '2302500015-9' AND FDATA >= '01/08/2014' 

select distinct FCTAAPLI FROM AG4501.CCRMMOVI WHERE IS_DELETED='N'  AND FDATA >= '01/08/2014' 
  
*/ 
