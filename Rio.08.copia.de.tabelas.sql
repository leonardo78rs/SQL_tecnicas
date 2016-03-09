--- Copiar de um banco para outro 


--executar no prompt:  sqlplus developer/developer@coreperf2.sicredi.com.br

---- Para recuperar a base anterior de COREPERF2: y são os que já estavam deletados, Y são os normais.
update ag4501.ccr1sald set is_deleted = 'y' where is_deleted ='Y' ;
update ag4501.ccr1sald set is_deleted = 'Y' where is_deleted ='N' ;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccr1sald USING select * from  AG4501.ccr1sald where is_deleted = 'N' ;
commit ; 

---update ag4501.ccr1tari set is_deleted = 'y' where is_deleted ='Y' ;   --- feito duas vezes 
---update ag4501.ccr1tari set is_deleted = 'Y' where is_deleted ='N' ;
delete ag4501.ccr1tari where is_deleted ='N' ;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccr1tari USING select * from  AG4501.ccr1tari where is_deleted = 'N' ;
commit;

update ag4501.ccr1inat set is_deleted = 'y' where is_deleted ='Y' ;
update ag4501.ccr1inat set is_deleted = 'Y' where is_deleted ='N' ;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccr1inat USING select * from  AG4501.ccr1inat where is_deleted = 'N' ;
commit; 

--->update ag4501.ccr0asso set is_deleted = 'y' where is_deleted ='Y' ;
---> update ag4501.ccr0asso set is_deleted = 'Y' where is_deleted ='N' ;
delete ag4501.ccr0asso ; 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccr0asso USING select * from  AG4501.ccr0asso where is_deleted = 'N' ;
commit;

--- update ag4501.ccr1movi set is_deleted = 'y' where is_deleted ='Y' ;
--- update ag4501.ccr1movi set is_deleted = 'Y' where is_deleted ='N' ;

delete ag4501.ccr1movi where is_deleted ='N' ;    
commit;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccr1movi USING select * from  AG4501.ccr1movi where is_deleted = 'N' ; 
commit; 

Select count(0) from ag4501.ccr1movi 

 
update ag4501.extr1407 set is_deleted = 'y' where is_deleted ='Y' ;
commit;
update ag4501.extr1407 set is_deleted = 'Y' where is_deleted ='N' ;
commit;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.extr1407 USING select * from  AG4501.ccr1extr where is_deleted = 'N' ; 
commit; 


select * from produto_moderador 
select * from parametro_moderador  where num_agencia = '4501' for update 



delete from parametro_moderador  where num_agencia = '4501' ; 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append parametro_moderador   USING select * from parametro_moderador   where  num_agencia = '4501'  ;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append parametro_moderador   USING select * from parametro_moderador   where  num_agencia = '4501'  ;

Select max(fdata) from parametro_moderador  where num_agencia = '4501' ;


Select * from pacote_tarifa_cadastro where num_agencia = '4501' 

delete from saldo_moderador where num_agencia = '4501'
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append saldo_moderador_bkp   USING select * from saldo_moderador   where  num_agencia = '4501'  ;


Select max(fdata)  from ag4501.ccrmmovi 



-------------------- consultando coredbrep 
Select * from pacote_tarifa_cadastro where num_agencia = '4501' 
Select count(0) from ag4501.ccrgsald  ; 
Select count(0) from ag4501.ccrmsald  ;
Select count(0) from ag4501.ccrhsald  ;
Select *  from ag4501.ccrgsmes  ;
Select *  from ag4501.ccrmsmes  where fcanomes < '201408' ;
Select * from ag4501.ccrgsald ; 
-------------------- 

------ Pegar Saldo Anterior 
Select fctaapli,
       'INI' as fcodhis,
       to_date('30/06/2014') as fdata, 
       fnsldbruto as fvalor_A, 
       31 as ndias, 
       fnsldbruto * 31 as FTotalZero 
  from ag4501.ccrgsmes 
 where fcanomes >= '201406' 
   and fctaapli = '2006500127-9' 
   AND IS_DELETED = 'N'   union   
------ Unindo com as movimentacoes do mês    
Select GM.fctaapli,
       GM.fcodhis,
       GM.fdata,
       (CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) AS FVALOR_A, 
       (to_date('31/07/2014') - GM.fdata) as ndias, 
       ((CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) * (to_date('31/07/2014') - GM.fdata)) as FTotalZero   
  from ag4501.ccrgmovi GM,
       ag4501.ccrghist GH 
 where gm.fcodhis = GH.FCODHIS                                 
   and GM.fctaapli = '2006500127-9'                            -- conta (aqui só uma) 
   and (GM.fdata  between '01/07/2014' and '31/07/2014' )      -- periodo de calculo
   AND GM.FCODHIS NOT IN ('901','902','921','922','942','944') -- codigos de provisao 
   AND GM.IS_DELETED = 'N'
   AND GH.IS_DELETED = 'N'



Select distinct (ftplanc) from ag4501.ccrghist  --- d, c, a
Select * from ag4501.ccrghist  where ftplanc not in ('A','C') ---  A- C+  D+? 
Select * from ag4501.ccrghist  WHERE FDESC LIKE '%PRO%' ---- PROVISOES 901,902,921,922,942,944 
--- sELECT DISTINCT(FCODHIS) FROM AG4501.CCRGMOVI WHERE FCODHIS IN ('901','902','921','922','942','944')  
--- UTILIZAR SUM(CASE WHEN FTPLANC in ('A','B') THEN -MV.FVALOR ELSE MV.FVALOR END)



-------- Para todas as contas 

------ Pegar Saldo Anterior 
Select fctaapli,
       'INI' as fcodhis,
       to_date('30/06/2014') as fdata, 
       fnsldbruto as fvalor_A, 
       31 as ndias, 
       fnsldbruto * 31 as FTotalZero 
  from ag4501.ccrgsmes 
 where fcanomes >= '201406' 
   and fctaapli = '2006500127-9' 
   AND IS_DELETED = 'N'   union   
------ Unindo com as movimentacoes do mês    
Select GM.fctaapli,
       GM.fcodhis,
       GM.fdata,
       (CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) AS FVALOR_A, 
       (to_date('31/07/2014') - GM.fdata) as ndias, 
       ((CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) * (to_date('31/07/2014') - GM.fdata)) as FTotalZero   
  from ag4501.ccrgmovi GM,
       ag4501.ccrghist GH 
 where gm.fcodhis = GH.FCODHIS                                 
   and GM.fctaapli = '2006500127-9'                            -- conta (aqui só uma) 
   and (GM.fdata  between '01/07/2014' and '31/07/2014' )      -- periodo de calculo
   AND GM.FCODHIS NOT IN ('901','902','921','922','942','944') -- codigos de provisao 
   AND GM.IS_DELETED = 'N'
   AND GH.IS_DELETED = 'N'






delete ag4501.ccrMmovi ;    
commit;
delete ag4501.ccrGmovi ;
commit;

COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrMmovi USING select * from  AG4501.ccrMmovi where is_deleted = 'N' ; 
commit; 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrGmovi USING select * from  AG4501.ccrGmovi where is_deleted = 'N' ;
commit; 


delete ag4501.ccrMsmes ;    
commit;
delete ag4501.ccrGsmes ;
commit;

COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrMsmes USING select * from  AG4501.ccrMsMes where is_deleted = 'N' ; 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrMsmes USING select * from  AG4501.ccrMsMes_BKP where is_deleted = 'N' ;
commit; 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrGsMes USING select * from  AG4501.ccrGsMes where is_deleted = 'N' ;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrGsmes USING select * from  AG4501.ccrGsMes_BKP where is_deleted = 'N' ;
commit; 

delete ag4501.ccrMsald ;    
commit;
delete ag4501.ccrGsald ;
commit;


COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrMsald USING select * from  AG4501.ccrMsald where is_deleted = 'N' ; 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrMsald_bkp USING select * from  AG4501.ccrMsald where is_deleted = 'N' ;
commit; 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrGsald USING select * from  AG4501.ccrGsald where is_deleted = 'N' ;
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br  TO developer/developer@coreperf2.sicredi.com.br append AG4501.ccrGsald_bkp USING select * from  AG4501.ccrGsald where is_deleted = 'N' ;
commit; 





Delete saldo_moderador where num_agencia = '4501'   and num_ano_mes = '2014/07'   ---- 7523 apagados 
COPY FROM leonardo_mendes/1@coredbrep.sicredi.com.br TO developer/developer@coreperf2.sicredi.com.br append saldo_moderador USING select * from  saldo_moderador    where num_agencia = '4501'   and num_ano_mes = '2014/07'  ;
---- 6487 
   
commit ; 



Select * from ag4501.ccrgsmes  for update 
Select * from ag4501.ccrmsmes  for update 
Select sum(fsmedio1),sum(fsmedio3) from ag4501.ccrmsald 
