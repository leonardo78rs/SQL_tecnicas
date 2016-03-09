
Select  * from saldo_moderador where num_agencia = '4501'

Select sum(VLR_CAPTACAO_DEPOSITO_PRZ) , sum(VLR_CAPITAL_SOCIAL)    from saldo_moderador where num_agencia = '4501' and num_ano_mes = '2014/07'
 

Select           count(NUM_CONTA),
                 sum(VLR_CAPITAL_MENSAL),
                 sum(VLR_CAPITAL_SOCIAL),
                 sum(VLR_CAPTACAO_DEPOSITO_PRZ),
                 sum(VLR_CHEQUE_ESPECIAL),
                 sum(VLR_PERCENTUAL_DESCONTO),
                 sum(VLR_APLICACAO_POUPANCA),
                 sum(VLR_FUNDOS_INVESTIMENTO)
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07'

/*  
COUNT(NUM_CONTA)	6487
SUM(VLR_CAPITAL_MENSAL)	0
SUM(VLR_CAPITAL_SOCIAL)	55602993,81
SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	0
SUM(VLR_CHEQUE_ESPECIAL)	0
SUM(VLR_PERCENTUAL_DESCONTO)	171600
SUM(VLR_APLICACAO_POUPANCA)	0
SUM(VLR_FUNDOS_INVESTIMENTO)	0
*/
/* -- coredbrep (conferencia) 
COUNT(NUM_CONTA)	6487
SUM(VLR_CAPITAL_MENSAL)	0
SUM(VLR_CAPITAL_SOCIAL)	55602993,81
SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	0
SUM(VLR_CHEQUE_ESPECIAL)	0
SUM(VLR_PERCENTUAL_DESCONTO)	171600
SUM(VLR_APLICACAO_POUPANCA)	0
SUM(VLR_FUNDOS_INVESTIMENTO)	0
*/
  

--- 'backup' dos valores para outras colunas e fazer conferencia depois 
update saldo_moderador  
   set vlr_aplicacao_poupanca = VLR_CAPTACAO_DEPOSITO_PRZ, 
       vlr_fundos_investimento = VLR_CAPITAL_SOCIAL    ,
       VLR_CHEQUE_ESPECIAL = VLR_PERCENTUAL_DESCONTO 
 where num_agencia = '4501' and num_ano_mes = '2014/07'
 
--- ALTERADO EM 6487 LINHAS 


 
Select           count(NUM_CONTA),
                 sum(VLR_CAPITAL_MENSAL),
                 sum(VLR_CAPITAL_SOCIAL),
                 sum(VLR_CAPTACAO_DEPOSITO_PRZ),
                 sum(VLR_CHEQUE_ESPECIAL),
                 sum(VLR_PERCENTUAL_DESCONTO),
                 sum(VLR_APLICACAO_POUPANCA),
                 sum(VLR_FUNDOS_INVESTIMENTO)
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07'
 


-------- 
---> Não esquecer de ajustar o FSMEDIO2 OU OUTRO ---> TABELAS CCRMSALD, CCRGSALD 

--- Após recalculo moderadores
COUNT(NUM_CONTA)	7523
SUM(VLR_CAPITAL_MENSAL)	0
SUM(VLR_CAPITAL_SOCIAL)	68468649,2
SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	181295717,05
SUM(VLR_CHEQUE_ESPECIAL)	171600
SUM(VLR_PERCENTUAL_DESCONTO)	216200
SUM(VLR_APLICACAO_POUPANCA)	0
SUM(VLR_FUNDOS_INVESTIMENTO)	55602993,81

---> Alterou também o capital social 
---> vou fixar o valor igual ao antigo e rodar novamente. 

update saldo_moderador  
   set  VLR_CAPITAL_SOCIAL  = vlr_fundos_investimento 
 where num_agencia = '4501' and num_ano_mes = '2014/07'

--- 7523 registros alterados 

--- Após rodar novamente, os totais ficaram assim (não mudou total de desconto, porém garantiu que a mudança não foi em função do capital: 
/*
COUNT(NUM_CONTA)	7523
SUM(VLR_CAPITAL_MENSAL)	0
SUM(VLR_CAPITAL_SOCIAL)	55602993,81
SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	181295717,05
SUM(VLR_CHEQUE_ESPECIAL)	171600
SUM(VLR_PERCENTUAL_DESCONTO)	216200
SUM(VLR_APLICACAO_POUPANCA)	0
SUM(VLR_FUNDOS_INVESTIMENTO)	55602993,81
*/

--- ver se alguem dimunui desconto    (tem 18 registros) --- verificar 
Select * 
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07' and vlr_percentual_desconto < vlr_cheque_especial 

--- ver os iguais  --- 6486 iguais --- 2ª 6904 
Select count(0)  
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07' and vlr_percentual_desconto = vlr_cheque_especial 

-- Contas com desconto maior (1019 CONTAS)  601 contas 
Select *   
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07' and vlr_percentual_desconto > vlr_cheque_especial 
  
------> NÃO FICOU CONFIAVEL --> REFAZER 
---> VERIFICAR AS TABELAS GSALD E MSALD 
----> Select * from ag4501.ccrgsald 
Update ag4501.ccrgsald set fsmedio6 = fsmedio2, fsmedio5 = fsmedio1 ; --- 16798 registros 
Update ag4501.ccrmsald set fsmedio6 = fsmedio2, fsmedio5 = fsmedio1 ; --- 12395 registros  
COMMIT;
Update ag4501.ccrgsald set fsmedio1 = 0, fsmedio2 = 0 ;  --- 
Update ag4501.ccrmsald set fsmedio1 = 0, fsmedio2 = 0 ;
COMMIT; 
--- carregar valores já atualizados da SMES  (
Update ag4501.ccrgsald MS 
   set fsmedio3 = (Select SM.FNSLDMEDIO from ag4501.ccrmsmes SM WHERE SM.FCTAAPLI = MS.FCTAAPLI AND IS_DELETED = 'N' and FCANOMES = '201407' ) WHERE IS_DELETED = 'N' ; 
COMMIT; --- 12395    
Update ag4501.ccrmsald MS 
   set fsmedio3 = (Select SM.FNSLDMEDIO from ag4501.ccrmsmes SM WHERE SM.FCTAAPLI = MS.FCTAAPLI AND IS_DELETED = 'N' and FCANOMES = '201407' ) WHERE IS_DELETED = 'N' ; 
COMMIT; --- 16798    


---- REAVALIAR SALDO_MODERADOR   

Select           count(NUM_CONTA),
                 sum(VLR_CAPITAL_MENSAL),
                 sum(VLR_CAPITAL_SOCIAL),
                 sum(VLR_CAPTACAO_DEPOSITO_PRZ),
                 sum(VLR_CHEQUE_ESPECIAL),
                 sum(VLR_PERCENTUAL_DESCONTO),
                 sum(VLR_APLICACAO_POUPANCA),
                 sum(VLR_FUNDOS_INVESTIMENTO)
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07'

/*COUNT(NUM_CONTA)	7523
SUM(VLR_CAPITAL_MENSAL)	0
SUM(VLR_CAPITAL_SOCIAL)	68468649,2
SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	83478148,08
SUM(VLR_CHEQUE_ESPECIAL)	171600
SUM(VLR_PERCENTUAL_DESCONTO)	
SUM(VLR_APLICACAO_POUPANCA)	0
SUM(VLR_FUNDOS_INVESTIMENTO)	55602993,81



*/
