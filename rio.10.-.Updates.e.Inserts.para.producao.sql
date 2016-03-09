--- Zerar valores da MSALD e GSALD antes de atualizar pelas SMES 
Update ag4501.ccrgsald GS SET FSMEDIO3 = 0     WHERE IS_DELETED = 'N' ; --- 16978 
Update ag4501.ccrMsald MS SET FSMEDIO3 = 0     WHERE IS_DELETED = 'N' ; --- 12395 


--- carregar valores já atualizados da SMES  (
Update ag4501.ccrgsald MS 
   set fsmedio3 = (Select SM.FNSLDMEDIO from ag4501.ccrgsmes SM WHERE SM.FCTAAPLI = MS.FCTAAPLI AND IS_DELETED = 'N' and FCANOMES = '201407' )
    WHERE IS_DELETED = 'N' ; 
COMMIT; ---  16798    
Update ag4501.ccrmsald MS 
   set fsmedio3 = (Select SM.FNSLDMEDIO from ag4501.ccrmsmes SM WHERE SM.FCTAAPLI = MS.FCTAAPLI AND IS_DELETED = 'N' and FCANOMES = '201407' ) WHERE IS_DELETED = 'N' ; 
COMMIT; --- 12395  

----- TESTES (maior, menor ou igual a zero) 
Update ag4501.ccrgsald MS 
   set fsmedio3 = (Select SM.FNSLDMEDIO from ag4501.ccrgsmes SM WHERE SM.FCTAAPLI = MS.FCTAAPLI AND IS_DELETED = 'N' and FCANOMES = '201407'
   and sm.fnsldmedio > 0  )
    WHERE IS_DELETED = 'N' ; 
rollback;     
Update ag4501.ccrmsald MS 
   set fsmedio3 = (Select SM.FNSLDMEDIO from ag4501.ccrmsmes SM WHERE SM.FCTAAPLI = MS.FCTAAPLI AND IS_DELETED = 'N' and FCANOMES = '201407'
   and sm.fnsldmedio > 0  ) 
   WHERE IS_DELETED = 'N' ; 
rollback;   



---- Gerar selects para aplicar em producao 
Select 'Update ag4501.ccrgsald set fsmedio3  =  '||to_CHAR(gs.fsmedio3,'999999999.99')||'   and fctaapli  =  '''||gs.fctaapli ||'''' || '   and  is_deleted = ''N''  ;  ' 
 from ag4501.ccrgsald gs where IS_DELETED = 'N'  and gs.fsmedio3 > 0 ;
--- 11480 LINHAS POSITIVAS ----> Porcaria tem 54 linhas negativas   (igual a zero nao tem) 

Select 'Update ag4501.ccrmsald set fsmedio3  =  '||to_CHAR(gs.fsmedio3,'999999999.99')||'   and fctaapli  =  '''||gs.fctaapli ||'''' || '   and  is_deleted = ''N''  ;  ' 
 from ag4501.ccrmsald gs where IS_DELETED = 'N'  and gs.fsmedio3 >  0 ; 
--- 8320 LINHAS POSITIVAS ----> Porcaria tem 14 linhas negativas  (igual a zero nao tem) 


Select 'Update ag4501.ccrGsald set fnsldmedio =  '||to_CHAR(fnsldmedio,'999999999.99')||
       '   WHERE  fctaapli  = '''||fctaapli ||'''' ||
       '   and  is_deleted = ''N''   and FCANOMES = ''201407'' ;  ' 
from ag4501.ccrGsmes SM WHERE FCANOMES = '201407' AND IS_DELETED = 'N' AND FNSLDMEDIO > 0 ; 
--- 11480 LINHAS POSITIVAS ----> Porcaria tem 54 linhas negativas  (igual a zero nao tem) 

Select 'Update ag4501.ccrmsald set fnsldmedio =  '||to_CHAR(fnsldmedio,'999999999.99')||
       '   WHERE  fctaapli =  '''||fctaapli ||'''' ||
       '   and   is_deleted = ''N''   and FCANOMES = ''201407'' ;  ' 
from ag4501.ccrmsmes SM WHERE FCANOMES = '201407' AND IS_DELETED = 'N' AND FNSLDMEDIO > 0  ; 
--- 8320 LINHAS POSITIVAS ----> Porcaria tem 14 linhas negativas  (igual a zero nao tem) 


----- Saldo moderador modificado 
/*  Select sm.cod_pacote, sm.num_agencia, sm.num_conta,
          sm.vlr_capital_social, am.vlr_capital_social as Cap_social_antigo, 
          sm.vlr_captacao_deposito_prz, am.vlr_captacao_deposito_prz as Capt_Dep_prz_Antigo, 
          sm.vlr_percentual_desconto, am.vlr_percentual_desconto as Perc_Desc_Antigo, 
          sm.flg_percentual_calculado, am.flg_percentual_calculado as Flg_perc_CalC_Antigo            
*/ 
        Select 'Update SALDO_MODERADOR ' ||
               ' SET  vlr_percentual_desconto    = ' ||to_char(SM.vlr_percentual_desconto,'999') ||   
               '     , vlr_capital_social        = ' ||to_char(SM.vlr_capital_social,'99999999999999.99') ||       
               '     , vlr_captacao_deposito_prz = ' ||to_char(SM.vlr_captacao_deposito_prz,'99999999999999.99') ||
               ' WHERE NUM_AGENCIA =  ''4501'' '  ||
               '   AND NUM_ANO_MES = ''2014/07'' ' ||
               '   AND NUM_CONTA = ''' || SM.NUM_CONTA  || ''' ;     vs_count := vs_count + sql%rowcount; '
      from  saldo_moderador SM
left  JOIN  ag4501.moderador AM 
       ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
    where SM.num_agencia = '4501' 
      and SM.num_ano_mes = '2014/07' 
--      and (am.vlr_percentual_desconto > sm.vlr_percentual_desconto  ) 
      and (sm.vlr_capital_social+sm.vlr_captacao_deposito_prz+sm.vlr_percentual_desconto
           <> 
           am.vlr_capital_social+am.vlr_captacao_deposito_prz+am.vlr_percentual_desconto )  ; 

---> 744 registros com valores diferentes (atualizar no moderador da produção)
---> 350 PERCENTUAL IGUAL, VALORES DIFERENTES 
---> 394 PERCENTUAL MAIOR, VALORES DIFERENTES 
---> 0 PERCENTUAL MENOR, VALORES DIFERENTES  (ok - ninguem apos o calculo ficou com percentual menor) 


---- inserts 
select * 
      from  saldo_moderador SM
left  JOIN  ag4501.moderador AM 
       ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
    where SM.num_agencia = '4501' 
      and SM.num_ano_mes = '2014/07' 
      and AM.NUM_CONTA IS NULL   --- SÃO 1036 NULOS --- VIROU 1037 
  --    AND SM.VLR_CAPITAL_MENSAL+SM.VLR_CAPITAL_SOCIAL+SM.VLR_CAPTACAO_DEPOSITO_PRZ+SM.VLR_PERCENTUAL_DESCONTO <> 0  --- APENAS 17 COM VALORES 
