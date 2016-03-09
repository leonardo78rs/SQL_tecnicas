ATIVIDADE AVULSA


select * from saldo_moderador where num_agencia = '4501'  and num_ano_mes = '2014/07' ; 
-- select sum(vlr_captacao_deposito_prz),sum(vlr_percentual_desconto),sum(vlr_capital_social) from saldo_moderador where num_agencia = '4501'  and num_ano_mes = '2014/07' ;
--- 0	171600	55602993,81

--- Apos rodar busca de saldos 
----> 1	202723,80		55647533,71 
--- select * from saldo_moderador where num_agencia = '4501'  and num_ano_mes = '2014/07' and  vlr_captacao_deposito_prz > 0 
----> só um registro 
----> apos rodar recalculo moderadores
----> 	202723,8	171790	55647533,71
----> select 55647533.71 - 55602993.81 from dual ----> diferenca 44539,90


---- NO COREDBREP 

select COUNT(0),sum(vlr_captacao_deposito_prz),sum(vlr_percentual_desconto),sum(vlr_capital_social) from saldo_moderador where num_agencia = '4501'  and num_ano_mes = '2014/07' ;
-- COUNT(0)	SUM(VLR_CAPTACAO_DEPOSITO_PRZ)	SUM(VLR_PERCENTUAL_DESCONTO)	SUM(VLR_CAPITAL_SOCIAL)
--	6487	0	171600	55602993,81
