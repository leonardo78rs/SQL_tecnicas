---- Realizado nova copia da produção 

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
  

--- 'backup' dos valores para outras colunas e fazer conferencia depois 
update saldo_moderador  
   set vlr_aplicacao_poupanca = VLR_CAPTACAO_DEPOSITO_PRZ, 
       vlr_fundos_investimento = VLR_CAPITAL_SOCIAL    ,
       VLR_CHEQUE_ESPECIAL = VLR_PERCENTUAL_DESCONTO 
 where num_agencia = '4501' and num_ano_mes = '2014/07'
 
--- ALTERADO EM 6487 LINHAS 


/*---- Totais apos busca de saldos  
COUNT(NUM_CONTA)	7523
SUM(VLR_CAPITAL_MENSAL)	0
SUM(VLR_CAPITAL_SOCIAL)	55602993,81
SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	83478148,08
SUM(VLR_CHEQUE_ESPECIAL)	0
SUM(VLR_PERCENTUAL_DESCONTO)	
SUM(VLR_APLICACAO_POUPANCA)	0
SUM(VLR_FUNDOS_INVESTIMENTO)	0

--- Totais apos recalcular os moderadores
COUNT(NUM_CONTA)	7523
SUM(VLR_CAPITAL_MENSAL)	0
SUM(VLR_CAPITAL_SOCIAL)	55602993,81
SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	83478148,08
SUM(VLR_CHEQUE_ESPECIAL)	0
SUM(VLR_PERCENTUAL_DESCONTO)	189270
SUM(VLR_APLICACAO_POUPANCA)	0
SUM(VLR_FUNDOS_INVESTIMENTO)	0

*/ 

-------- 
---> Não esquecer de ajustar o FSMEDIO2 OU OUTRO ---> TABELAS CCRMSALD, CCRGSALD 


--- ver se alguem dimunui desconto    (ok - nenhum registro diminuiu)  
Select * 
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07' and vlr_percentual_desconto < vlr_cheque_especial 

--- ver os iguais  --- 4102 iguais (na outra vez foi 6486 iguais // 2ª 6904  )
Select count(0)  
-- Select * 
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07' and vlr_percentual_desconto = vlr_cheque_especial 
  and VLR_CAPITAL_MENSAL+VLR_CAPITAL_SOCIAL+VLR_CAPTACAO_DEPOSITO_PRZ+VLR_CHEQUE_ESPECIAL+VLR_PERCENTUAL_DESCONTO+VLR_APLICACAO_POUPANCA <> 0 


--------> Exportar os resultados abaixo para excel 

-- Contas com desconto maior (3421 Contas)   ---> (outra vez tinham sido 1019 CONTAS, mas faltavam registros) 
Select *   
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07' and vlr_percentual_desconto > vlr_cheque_especial 
  

-----> Contas que tem captacao e não tiveram desconto  (82 contas, todas com valor captacao menor do que 1.000,00 ) 
Select count(0)  
-- Select * 
 from saldo_moderador 
where num_agencia = '4501' 
  and num_ano_mes = '2014/07' and vlr_percentual_desconto = vlr_cheque_especial 
  and VLR_PERCENTUAL_DESCONTO = 0 
  and VLR_CAPTACAO_DEPOSITO_PRZ <> 0

----> Comparação com anterior  (7523 registros novos X  6487 antigos) 
   Select * 
     from  saldo_moderador SM
inner JOIN  ag4501.moderador AM 
       ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
    where SM.num_agencia = '4501' 
      and SM.num_ano_mes = '2014/07' 

  
----> 7523 TOTAL REGISTROS 
----> 6093 COM PERCENTUAL IGUAL 
---->  1430 com percentual diferente (394 MUDARAM PERCENTUAL + 1036 QUE NÃO ESTAVAM NA MODERADOR E TIVERAM DESCONTO  ) 
----> Dos 1036, 10 tiveram desconto 
---> Impacto no desconto de tarifas igual a 404 contas 

   Select sm.cod_pacote, sm.num_agencia, sm.num_conta,
          sm.vlr_capital_social, am.vlr_capital_social as Cap_social_antigo, 
          sm.vlr_captacao_deposito_prz, am.vlr_captacao_deposito_prz as Capt_Dep_prz_Antigo, 
          sm.vlr_percentual_desconto, am.vlr_percentual_desconto as Perc_Desc_Antigo, 
          sm.flg_percentual_calculado, am.flg_percentual_calculado as Flg_perc_CalC_Antigo      
     from  saldo_moderador SM
left  JOIN  ag4501.moderador AM 
       ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
    where SM.num_agencia = '4501' 
      and SM.num_ano_mes = '2014/07' 
--      and (am.vlr_percentual_desconto < sm.vlr_percentual_desconto  ) 
      AND (am.vlr_percentual_desconto is null) 
--      and (am.vlr_percentual_desconto = sm.vlr_percentual_desconto  )
--      and (am.vlr_percentual_desconto = sm.vlr_percentual_desconto /* or (am.vlr_percentual_desconto+1 is null) */ )


---> Abaixo então as 404 contas a estornar ou mudar provisao de tarifas 

   Select sm.cod_pacote, sm.num_agencia, sm.num_conta,
          sm.vlr_capital_social, am.vlr_capital_social as Cap_social_antigo, 
          sm.vlr_captacao_deposito_prz, am.vlr_captacao_deposito_prz as Capt_Dep_prz_Antigo, 
          sm.vlr_percentual_desconto, am.vlr_percentual_desconto as Perc_Desc_Antigo, 
          sm.flg_percentual_calculado, am.flg_percentual_calculado as Flg_perc_CalC_Antigo      
     from  saldo_moderador SM
left  JOIN  ag4501.moderador AM 
       ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
    where SM.num_agencia = '4501' 
      and SM.num_ano_mes = '2014/07' 
      and (am.vlr_percentual_desconto < sm.vlr_percentual_desconto or (am.vlr_percentual_desconto+1 is null) )
      and sm.vlr_percentual_desconto > 0 


----> Movimentos conta corrente  

Select * from ag4501.ccr1movi MOVI 
        where MOVI.fcodlanc = 'T20'  
          AND MOVI.IS_DELETED = 'N' 
          AND MOVI.FDLANCTO > '01/08/2014' 
          AND MOVI.FDLANCTO < '06/09/2014'
          AND MOVI.FDINCLUSAO < '01/10/2014' 
          AND MOVI.FCONTA IN (   ------ Consulta das 404 contas acima 
                                 Select sm.num_conta
                                   from  saldo_moderador SM
                              left  JOIN  ag4501.moderador AM 
                                     ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
                                  where SM.num_agencia = '4501' 
                                    and SM.num_ano_mes = '2014/07' 
                                    and (am.vlr_percentual_desconto < sm.vlr_percentual_desconto or (am.vlr_percentual_desconto+1 is null) )
                                    and sm.vlr_percentual_desconto > 0 
                         )
                         
----

------ Da consulta das 404 contas acima, 378 tem tarifas de 01/08 a 05/09 
   Select SM.NUM_ANO_MES, 
          SM.COD_PACOTE, 
          SM.NUM_CONTA, 
          MOVI.FCODLANC,
          MOVI.FDLANCTO,
          MOVI.FCIDUSUAR,
          MOVI.FVALOR, 
          SM.VLR_CAPITAL_SOCIAL,
          SM.VLR_PERCENTUAL_DESCONTO AS Perc_Desc_Novo,
          AM.VLR_PERCENTUAL_DESCONTO AS Perc_Desc_Antigo,
          MOVI.FVALOR / (1-(AM.VLR_PERCENTUAL_DESCONTO/100)) AS Valor_Total_Tarifa,
          MOVI.FVALOR * (1-(SM.VLR_PERCENTUAL_DESCONTO/100)) / (1-(AM.VLR_PERCENTUAL_DESCONTO/100)) AS Valor_Correto_Tarifa, 
          (MOVI.FVALOR - (MOVI.FVALOR * (1-(SM.VLR_PERCENTUAL_DESCONTO/100)) / (1-(AM.VLR_PERCENTUAL_DESCONTO/100)) ) ) as Valor_Estorno                
     from  saldo_moderador SM  
INNER JOIN  ag4501.ccr1movi MOVI  ON  MOVI.FCONTA = SM.NUM_CONTA  
left  JOIN  ag4501.moderador AM   ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
     where MOVI.fcodlanc = 'T20'  
       AND MOVI.IS_DELETED = 'N' 
       AND MOVI.FDLANCTO > '01/08/2014' 
       AND MOVI.FDLANCTO < '06/09/2014'
       AND MOVI.FDINCLUSAO < '01/10/2014'  --- outros registros coreperf2 
       AND   SM.num_agencia = '4501' 
       AND   SM.num_ano_mes = '2014/07' 
       AND  (am.vlr_percentual_desconto < sm.vlr_percentual_desconto or (am.vlr_percentual_desconto+1 is null) )
       AND   sm.vlr_percentual_desconto > 0 

---- Conferido se não tem conta duplicada  (ok    "Select distinct movi.fconta ..... " do select acima retorna mesmas 378 contas)     

---- Conferindo as diferentes tarifas e seus valores total de tarifa cobrada
   Select distinct  
          SM.COD_PACOTE, 
          MOVI.FVALOR / (1-(AM.VLR_PERCENTUAL_DESCONTO/100)) AS Valor_Total_Tarifa
     from  saldo_moderador SM  
INNER JOIN  ag4501.ccr1movi MOVI  ON  MOVI.FCONTA = SM.NUM_CONTA  
left  JOIN  ag4501.moderador AM   ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
     where MOVI.fcodlanc = 'T20'  
       AND MOVI.IS_DELETED = 'N' 
       AND MOVI.FDLANCTO > '01/08/2014' 
       AND MOVI.FDLANCTO < '06/09/2014'
       AND MOVI.FDINCLUSAO < '01/10/2014'  --- outros registros coreperf2 
       AND   SM.num_agencia = '4501' 
       AND   SM.num_ano_mes = '2014/07' 
       AND  (am.vlr_percentual_desconto < sm.vlr_percentual_desconto or (am.vlr_percentual_desconto+1 is null) )
       AND   sm.vlr_percentual_desconto > 0 

/* Parece ter tarifa b1 estranha aqui 
B1	10
B1	4
E1	18
M1	10
S1	17
T1	20
U1	25

SELECT * FROM AG4501.CCR1MOVI WHERE FCONTA = '00856-7' AND FCODLANC = 'T20'  AND FDINCLUSAO < '01/10/2014' 
Esta conta tem tarifa de R$ 38,00 e de R$ 4,00  ----> reavaliar para esta conta. 

*/
           
---- Gerar os estornos no TXT 

   Select '4501'       as Agencia, 
          SM.NUM_CONTA as Conta, 
          '742'        as CodLanc, 
          'i6543210'   as Docum, 
          Trunc(Sysdate)+11 as Data,  
          (MOVI.FVALOR - (MOVI.FVALOR * (1-(SM.VLR_PERCENTUAL_DESCONTO/100)) / (1-(AM.VLR_PERCENTUAL_DESCONTO/100)) ) ) as Valor_Estorno                
     from  saldo_moderador SM  
INNER JOIN  ag4501.ccr1movi MOVI  ON  MOVI.FCONTA = SM.NUM_CONTA  
left  JOIN  ag4501.moderador AM   ON    SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
     where MOVI.fcodlanc = 'T20'  
       AND MOVI.IS_DELETED = 'N' 
       AND MOVI.FDLANCTO > '01/08/2014' 
       AND MOVI.FDLANCTO < '06/09/2014'
       AND MOVI.FDINCLUSAO < '01/10/2014'  --- outros registros copiados para o coreperf2 
       AND   SM.num_agencia = '4501' 
       AND   SM.num_ano_mes = '2014/07' 
       AND  (am.vlr_percentual_desconto < sm.vlr_percentual_desconto or (am.vlr_percentual_desconto+1 is null) )
       AND   sm.vlr_percentual_desconto > 0 



                          

Select * from ag4501.ccr1TARI TARI 
        where TARI.fCcodlanc = 'T20'  
          AND TARI.IS_DELETED = 'N' 
          AND TARI.FDINCLUSAO < '01/09/2014' 
          AND TARI.FCCONTA IN (   ------ Consulta das 404 contas acima 
                                 Select sm.num_conta
                                   from  saldo_moderador SM
                              left  JOIN  ag4501.moderador AM 
                                     ON   SM.NUM_AGENCIA = AM.NUM_AGENCIA  AND SM.NUM_CONTA   = AM.NUM_CONTA
                                  where SM.num_agencia = '4501' 
                                    and SM.num_ano_mes = '2014/07' 
                                    and (am.vlr_percentual_desconto < sm.vlr_percentual_desconto or (am.vlr_percentual_desconto+1 is null) )
                                    and sm.vlr_percentual_desconto > 0 
                         )
                         
