--- Copiei tudo da produção e tem um Titulo que está duplicado desde sempre (Sicredi RIO) 03/2013 a 07/2014; 
Select FCTAAPLI, fcanomes, COUNT(0) from AG4501.CCRMSMES SM WHERE IS_DELETED = 'N'  GROUP BY FCTAAPLI,fcanomes HAVING COUNT(0) > 1 ;
SELECT * FROM AG4501.CCRMSMES WHERE FCTAAPLI = '1403500001-9' and fcanomes = '201407'  ; 

Select FCTAAPLI, fcanomes, COUNT(0) from AG4501.CCRMSMES SM WHERE IS_DELETED = 'N'  GROUP BY FCTAAPLI,fcanomes HAVING COUNT(0) > 1 ;
SELECT * FROM AG4501.CCRMSMES WHERE FCTAAPLI = '1403500001-9' ;  

Update AG4501.CCRMSMES SET IS_DELETED  = 'Y' WHERE FCTAAPLI = '1403500001-9' and recno in (300585959, 300546051, 300546052, 300546053, 300586196);

sELECT * FROM AG4501.CCRMSMES WHERE FCTAAPLI = '1403500001-9' and recno in (300585959, 300546051, 300546052, 300546053, 300586196);






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
  
  
  
 
