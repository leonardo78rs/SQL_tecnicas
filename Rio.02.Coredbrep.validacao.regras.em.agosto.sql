Select sum(ftotalzero) from (
------ Pegar Saldo Anterior 
Select fctaapli,
       'INI' as fcodhis,
       to_date('31/07/2014') as fdata, 
       fnsldbruto as fvalor_A, 
       31 as ndias, 
       fnsldbruto * 31 as FTotalZero 
  from ag0116.ccrgsmes 
 where fcanomes = '201407' 
   and fctaapli in ('2301546753-7')
   and is_deleted = 'N'         union  
------ Unindo com as movimentacoes do mês    
Select GM.fctaapli,
       GM.fcodhis,
       GM.fdata,
       (CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) AS FVALOR_A, 
       (to_date('31/08/2014') - GM.fdata) as ndias, 
       ((CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) * (to_date('31/08/2014') - GM.fdata)) as FTotalZero   
  from ag0116.ccrgmovi GM,
       ag0116.ccrghist GH 
 where gm.fcodhis = GH.FCODHIS                                 
   and GM.fctaapli in ('2301546753-7') 
   and (GM.fdata  between '01/08/2014' and '31/08/2014' )      -- periodo de calculo
--   AND GM.FCODHIS NOT IN ('901','902','921','922','942','944') -- codigos de provisao 
   AND GM.IS_DELETED = 'N'
   AND GH.IS_DELETED = 'N'
)

--- Teste 1 
--- Select * from ag0116.ccrgmovi    where fdata > '01/08/2014' 
select 61152.98 / 31 from dual ;  ---- 1972,67677 (precisa arredondar) 
Select fnsldmedio from ag4501.ccrgsmes where fcanomes = '201408' and  fctaapli = '2004500354-9'                  
--- fnsldmedio = 1972,68

--- Teste 2  '2308500047-7'  --- select 769768.71 / 31 from dual  === 24831,2487096774 
Select fnsldmedio from ag4501.ccrgsmes where fcanomes = '201408' and  fctaapli = '2308500047-7'  ---> 24831,25 

--- Teste 3   com 4 contas ('2307500174-0','2307500278-0','2307500726-9','2307500827-3')
select 1501717.62 / 31 from dual --> 48442,5038709677
Select sum(fnsldmedio) from ag4501.ccrgsmes where fcanomes = '201408' and  fctaapli in ('2307500174-0','2307500278-0','2307500726-9','2307500827-3') 
--- 48442,50 

--- Teste 4   com 13 contas ('2303500845-1','2303500846-0','2303500847-8','2303500848-6','2303500849-4','2303500850-8','2303500851-6','2303500852-4','2303500853-2','2303500854-0','2303500855-9','2303500856-7','2303500857-5')
select 5188880.73 / 31 from dual --> 167383,249354839
Select sum(fnsldmedio) from ag4501.ccrgsmes where fcanomes = '201408' and  fctaapli in ('2303500845-1','2303500846-0','2303500847-8','2303500848-6','2303500849-4','2303500850-8','2303500851-6','2303500852-4','2303500853-2','2303500854-0','2303500855-9','2303500856-7','2303500857-5') 
--- 167383,27
 
-- Teste 5 com todas contas  (total de 52414 lancamentos) 
--- select 3620625216.56 / 31 from dual --> 	116794361.824516
Select sum(fnsldmedio) from ag4501.ccrgsmes where fcanomes = '201408'  and is_deleted = 'N' 
--- 
Select 116794361.824516 - 116730104.5 from dual 

--- validando com outra agencia 
Select fctaapli from ag0116.ccrgmovi    where fdata > '01/08/2014' group by fctaapli having count(0) > 12 
select 4183.14 / 31 from dual;   --- 134.94 
Select sum(fnsldmedio) from ag0116.ccrgsmes where fcanomes = '201408'  and is_deleted = 'N'    and fctaapli in ('2301535771-5')  --- 134,97 

'2301546753-7'
select 3258764.78/31 from dual    --- 	1	105121.444516129
Select sum(fnsldmedio) from ag0116.ccrgsmes where fcanomes = '201408'  and is_deleted = 'N'    and fctaapli in ('2301546753-7') -- 1	105121,44
