/*
6910598 

UA: 0307.19 - Santo Cristo
Conta: 32832-4
Valor R$ 6,99
Data: 10
*/
Select * from saldo_moderador  where num_agencia = '0307' and num_conta = '32832-4'
Select * from pacote_tarifa_associado where num_agencia = '0307' and num_conta = '328324'
SELECT * FROM HIST_TARIFA_CONTA  where num_agencia = '0307' and num_conta = '328324'
Select * from ag0307.ccr0asso where fconta = '32832-4'
Select * from ag0307.ccr1movi where fconta = '32832-4'
Select * from ag0307.ccr1tari where fcconta = '32832-4'

A alteracao ocorrida em 15/08 não foi efetivada, pois foi alterado novamente em 01/09/2014. 
Esta alteracao em 01/09/2014 foi anterior à troca de pacote (inicio de mes) por isto não chegou a ser efetivado. 
COD_PACOTE	DAT_FINAL	DAT_INICIAL	DIA_DEBITO	NUM_AGENCIA	NUM_CONTA
	A1	28/10/2014	15/08/2014	10	0307	328324
	A1	28/10/2014	01/09/2014	25	0307	328324



A conta já possui cesta. A alteração aconteceu em Setembro, para troca em Outubro. Até ai o racicínio está correto. 
Porém, o débito de outubro é referente ao mês de Setembro (que ainda não estava nesta cesta A1) 
Da mesma forma, em novembro ocorreu o débito de Outubro (Cesta A1 Valor R$ 7,40)  
- O pacote está cadastrado e a conta já possui utilizacao do pacote, e inclusive a tarifa B3 já tem uma utilizacao.  
COD_PACOTE	COD_TARIFA	NUM_AGENCIA	NUM_CONTA	QTD_UTILIZADO
1	A1	01	0307	328324	0
2	A1	A7	0307	328324	0
3	A1	B2	0307	328324	0
4	A1	B3	0307	328324	1
5	A1	B4	0307	328324	0
6	A1	D1	0307	328324	0
7	A1	D8	0307	328324	0
8	A1	D9	0307	328324	0
9	A1	G4	0307	328324	0



--Quanto ao relatório dos moderadores, este não trouxe nada pois o débito ainda não havia ocorrido (o debito T20 de 10/11 ocorreu em 11/11/2014 14:15:24) 



 


Causa Aparente: Resquicio da Incorporacao. Somatorio de valores de tarifas provisionadas e não debitadas não fecham com o "valor de tarifas a debitar" da tabela de saldos. 
--  
Solução de Contorno: Ajustadas todas as contas com este problema nesta cooperativa. 
Total de 268 contas. Valores foram ajustados de acordo com o somatorio de tarifas não debitadas.   
Será aberto uma melhoria de incorporacao e vinculado também a este incidente. 
A partir de agora, estas tarifas serão debitadas de acordo com a disponibilidade de saldo em cada conta. 
----
Para a conta em particular deste incidente, são 3 tarifas de R$ 8.98 (tarifa T20 de 20/08,20/09,20/10/2013) 



Select * from incorporacao_previa where num_cop_destino = '0307' and cod_conta_destino = '328324' 

Select * from ag0307.ccr1tari where fcconta = '32832-4';  
Select recno,fvalortari from ag0307.ccr1sald where fconta = '32832-4';

Select * from ag0307.ccr1tari where fcconta = '70243-2';  
Select fvalortari,s.* from ag0307.ccr1sald s where fconta = '70243-2';


---- para ver todas as contas de todas da 0307  
Select sald.fvalortari,sald.fconta,tar.somator,sald.fvalortari-tar.somator from agunico.ccr1sald sald, 
              (Select tari.num_ag,tari.fcconta,sum(fnvalor) as somator
                 from agunico.ccr1tari tari 
                where is_deleted='N' 
                  and fddebtari = to_date(1,'J') 
            group by tari.num_ag, tari.fcconta) tar  
where 
              sald.num_ag = tar.num_ag
and           sald.fconta = tar.fcconta
and           sald.num_ag = '0307' 
and              sald.is_deleted = 'N' 
              and fvalortari <> tar.somator;

/*
---- para ver todas as contas de todas as cooperativas 
Select sald.num_ag,count(0) from agunico.ccr1sald sald, 
              (Select tari.num_ag,tari.fcconta,sum(fnvalor) as somator
                 from agunico.ccr1tari tari 
                where is_deleted='N' 
                  and fddebtari = to_date(1,'J') 
            group by tari.num_ag, tari.fcconta) tar  
where 
              sald.num_ag = tar.num_ag
and           sald.fconta = tar.fcconta
and              sald.is_deleted = 'N' 
              and fvalortari <> tar.somator
group by sald.num_ag              ;*/





Select 'Update ag0307.ccr1sald set fvalortari = '||
       to_char(tar.somator,'9999.99') ||
       ' Where recno = ' || sald.recno ||
       ' and is_deleted=''N'' ; ' || 
       '--- Conta: fconta = ' || sald.fconta || 
       ', Valor anterior = ' || to_char(sald.fvalortari,'999')
  from agunico.ccr1sald sald 
Left Join               (Select tari.num_ag,tari.fcconta,sum(fnvalor) as somator
                 from agunico.ccr1tari tari 
                where is_deleted='N' 
                  and fddebtari = to_date(1,'J') 
            group by tari.num_ag, tari.fcconta) tar  
on 
              sald.num_ag = tar.num_ag
and           sald.fconta = tar.fcconta
where 
              sald.num_ag = '0307' 
and              sald.is_deleted = 'N' 
and          (    fvalortari <> tar.somator );



------ updates da 0307  (todos estes casos estavam com valortari  menor do que o somatório das tarifas (por isto não estava cobrando) 
Update ag0307.ccr1sald set fvalortari =     9.99 Where recno = 7016913 and is_deleted='N' ; --- Conta: fconta = 26091-6, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   163.93 Where recno = 7177185 and is_deleted='N' ; --- Conta: fconta = 69463-9, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   384.72 Where recno = 7084513 and is_deleted='N' ; --- Conta: fconta = 53270-3, Valor anterior =   53
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7163539 and is_deleted='N' ; --- Conta: fconta = 57333-8, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7228722 and is_deleted='N' ; --- Conta: fconta = 22213-6, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   187.54 Where recno = 7079843 and is_deleted='N' ; --- Conta: fconta = 50641-9, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   334.50 Where recno = 7169855 and is_deleted='N' ; --- Conta: fconta = 30153-1, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   222.95 Where recno = 7203018 and is_deleted='N' ; --- Conta: fconta = 74818-9, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7107576 and is_deleted='N' ; --- Conta: fconta = 67629-2, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   125.16 Where recno = 7120372 and is_deleted='N' ; --- Conta: fconta = 03809-3, Valor anterior =   23
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7222605 and is_deleted='N' ; --- Conta: fconta = 16895-3, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   144.76 Where recno = 7228654 and is_deleted='N' ; --- Conta: fconta = 22122-9, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7230852 and is_deleted='N' ; --- Conta: fconta = 23715-4, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    93.74 Where recno = 7212309 and is_deleted='N' ; --- Conta: fconta = 09074-7, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   135.54 Where recno = 7083783 and is_deleted='N' ; --- Conta: fconta = 50085-2, Valor anterior =   23
Update ag0307.ccr1sald set fvalortari =    79.35 Where recno = 7146405 and is_deleted='N' ; --- Conta: fconta = 39813-2, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   172.74 Where recno = 7223653 and is_deleted='N' ; --- Conta: fconta = 19092-8, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    30.00 Where recno = 7195460 and is_deleted='N' ; --- Conta: fconta = 75533-2, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7167783 and is_deleted='N' ; --- Conta: fconta = 62976-9, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7170989 and is_deleted='N' ; --- Conta: fconta = 65787-7, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   341.36 Where recno = 7147398 and is_deleted='N' ; --- Conta: fconta = 30627-6, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7164763 and is_deleted='N' ; --- Conta: fconta = 58595-3, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   199.50 Where recno = 7224535 and is_deleted='N' ; --- Conta: fconta = 20595-3, Valor anterior =   29
Update ag0307.ccr1sald set fvalortari =   244.30 Where recno = 7062410 and is_deleted='N' ; --- Conta: fconta = 42491-9, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =   487.50 Where recno = 7216330 and is_deleted='N' ; --- Conta: fconta = 12129-1, Valor anterior =   46
Update ag0307.ccr1sald set fvalortari =    65.37 Where recno = 7136799 and is_deleted='N' ; --- Conta: fconta = 33052-2, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   185.96 Where recno = 7129928 and is_deleted='N' ; --- Conta: fconta = 23501-1, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7224710 and is_deleted='N' ; --- Conta: fconta = 20805-9, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7110018 and is_deleted='N' ; --- Conta: fconta = 70180-7, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    58.79 Where recno = 7166681 and is_deleted='N' ; --- Conta: fconta = 61293-8, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    72.97 Where recno = 7116027 and is_deleted='N' ; --- Conta: fconta = 74262-7, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7111254 and is_deleted='N' ; --- Conta: fconta = 54438-8, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   209.40 Where recno = 6982566 and is_deleted='N' ; --- Conta: fconta = 17525-0, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =   171.00 Where recno = 7147365 and is_deleted='N' ; --- Conta: fconta = 40501-0, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    88.80 Where recno = 7218316 and is_deleted='N' ; --- Conta: fconta = 13682-8, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   305.91 Where recno = 7052416 and is_deleted='N' ; --- Conta: fconta = 28357-6, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   508.22 Where recno = 7009683 and is_deleted='N' ; --- Conta: fconta = 24129-6, Valor anterior =  105
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7224759 and is_deleted='N' ; --- Conta: fconta = 20867-5, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   376.26 Where recno = 7221472 and is_deleted='N' ; --- Conta: fconta = 16209-1, Valor anterior =   70
Update ag0307.ccr1sald set fvalortari =   374.35 Where recno = 7075569 and is_deleted='N' ; --- Conta: fconta = 48539-0, Valor anterior =   70
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7213006 and is_deleted='N' ; --- Conta: fconta = 09964-1, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   373.00 Where recno = 7200569 and is_deleted='N' ; --- Conta: fconta = 82211-5, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7225364 and is_deleted='N' ; --- Conta: fconta = 20856-1, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7229134 and is_deleted='N' ; --- Conta: fconta = 22568-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   204.96 Where recno = 7167713 and is_deleted='N' ; --- Conta: fconta = 61568-5, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7194826 and is_deleted='N' ; --- Conta: fconta = 74879-1, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   222.95 Where recno = 7194944 and is_deleted='N' ; --- Conta: fconta = 75047-3, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   252.95 Where recno = 7199463 and is_deleted='N' ; --- Conta: fconta = 80305-8, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   204.96 Where recno = 7209065 and is_deleted='N' ; --- Conta: fconta = 18396-3, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7114928 and is_deleted='N' ; --- Conta: fconta = 73702-0, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7212102 and is_deleted='N' ; --- Conta: fconta = 08703-7, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   203.95 Where recno = 7207599 and is_deleted='N' ; --- Conta: fconta = 05075-7, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   221.94 Where recno = 7213150 and is_deleted='N' ; --- Conta: fconta = 10162-4, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   172.74 Where recno = 7196776 and is_deleted='N' ; --- Conta: fconta = 77938-2, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   221.94 Where recno = 7166124 and is_deleted='N' ; --- Conta: fconta = 60362-2, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   158.75 Where recno = 7224787 and is_deleted='N' ; --- Conta: fconta = 20897-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   186.97 Where recno = 7200666 and is_deleted='N' ; --- Conta: fconta = 82488-0, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7224301 and is_deleted='N' ; --- Conta: fconta = 20290-7, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   130.77 Where recno = 7152519 and is_deleted='N' ; --- Conta: fconta = 45559-4, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   258.36 Where recno = 7055993 and is_deleted='N' ; --- Conta: fconta = 30934-6, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7229045 and is_deleted='N' ; --- Conta: fconta = 22480-1, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   168.98 Where recno = 7960244 and is_deleted='N' ; --- Conta: fconta = 69872-2, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7180745 and is_deleted='N' ; --- Conta: fconta = 59939-5, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7117105 and is_deleted='N' ; --- Conta: fconta = 39487-4, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   117.59 Where recno = 7199731 and is_deleted='N' ; --- Conta: fconta = 80799-3, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   149.57 Where recno = 7196228 and is_deleted='N' ; --- Conta: fconta = 70966-0, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7229278 and is_deleted='N' ; --- Conta: fconta = 22473-7, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7214506 and is_deleted='N' ; --- Conta: fconta = 71056-8, Valor anterior =    8
Update ag0307.ccr1sald set fvalortari =   150.99 Where recno = 7219721 and is_deleted='N' ; --- Conta: fconta = 14682-3, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   186.97 Where recno = 7221475 and is_deleted='N' ; --- Conta: fconta = 16244-8, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   233.37 Where recno = 7121553 and is_deleted='N' ; --- Conta: fconta = 05342-1, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    88.80 Where recno = 7224691 and is_deleted='N' ; --- Conta: fconta = 60765-8, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    29.60 Where recno = 7085518 and is_deleted='N' ; --- Conta: fconta = 54286-5, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   100.73 Where recno = 7220410 and is_deleted='N' ; --- Conta: fconta = 15383-8, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   240.94 Where recno = 7105354 and is_deleted='N' ; --- Conta: fconta = 65941-0, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   172.74 Where recno = 7203478 and is_deleted='N' ; --- Conta: fconta = 85177-6, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =  1088.00 Where recno = 7178486 and is_deleted='N' ; --- Conta: fconta = 70243-2, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   376.26 Where recno = 7209181 and is_deleted='N' ; --- Conta: fconta = 06086-6, Valor anterior =   70
Update ag0307.ccr1sald set fvalortari =   352.76 Where recno = 7128669 and is_deleted='N' ; --- Conta: fconta = 26711-3, Valor anterior =   53
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7222754 and is_deleted='N' ; --- Conta: fconta = 17202-1, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7223315 and is_deleted='N' ; --- Conta: fconta = 18460-1, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   187.54 Where recno = 7224390 and is_deleted='N' ; --- Conta: fconta = 41525-1, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   553.50 Where recno = 7166379 and is_deleted='N' ; --- Conta: fconta = 60812-7, Valor anterior =   48
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7220439 and is_deleted='N' ; --- Conta: fconta = 68176-9, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =    86.34 Where recno = 7172792 and is_deleted='N' ; --- Conta: fconta = 67683-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7112236 and is_deleted='N' ; --- Conta: fconta = 71913-7, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   100.36 Where recno = 7138417 and is_deleted='N' ; --- Conta: fconta = 15649-9, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7117149 and is_deleted='N' ; --- Conta: fconta = 74943-5, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7221042 and is_deleted='N' ; --- Conta: fconta = 07751-2, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    13.99 Where recno = 7027009 and is_deleted='N' ; --- Conta: fconta = 31614-8, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   116.78 Where recno = 7212712 and is_deleted='N' ; --- Conta: fconta = 09506-4, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7020223 and is_deleted='N' ; --- Conta: fconta = 24732-4, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   259.77 Where recno = 7181139 and is_deleted='N' ; --- Conta: fconta = 72616-9, Valor anterior =   26
Update ag0307.ccr1sald set fvalortari =    65.78 Where recno = 7225227 and is_deleted='N' ; --- Conta: fconta = 21355-9, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    65.78 Where recno = 7215978 and is_deleted='N' ; --- Conta: fconta = 11927-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   130.77 Where recno = 7144220 and is_deleted='N' ; --- Conta: fconta = 38373-7, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   308.37 Where recno = 7156857 and is_deleted='N' ; --- Conta: fconta = 51053-8, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    44.40 Where recno = 7193452 and is_deleted='N' ; --- Conta: fconta = 72837-1, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   491.79 Where recno = 7025353 and is_deleted='N' ; --- Conta: fconta = 30512-0, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   388.50 Where recno = 7158553 and is_deleted='N' ; --- Conta: fconta = 52622-0, Valor anterior =   86
Update ag0307.ccr1sald set fvalortari =   201.53 Where recno = 7221508 and is_deleted='N' ; --- Conta: fconta = 74383-2, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   388.50 Where recno = 7178164 and is_deleted='N' ; --- Conta: fconta = 70070-9, Valor anterior =   86
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7180332 and is_deleted='N' ; --- Conta: fconta = 26634-7, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7222428 and is_deleted='N' ; --- Conta: fconta = 16541-2, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7101320 and is_deleted='N' ; --- Conta: fconta = 28993-0, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   216.96 Where recno = 7193966 and is_deleted='N' ; --- Conta: fconta = 73549-1, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7224474 and is_deleted='N' ; --- Conta: fconta = 20514-2, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7010104 and is_deleted='N' ; --- Conta: fconta = 21650-0, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7223466 and is_deleted='N' ; --- Conta: fconta = 18776-1, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7229553 and is_deleted='N' ; --- Conta: fconta = 23002-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   204.96 Where recno = 7222289 and is_deleted='N' ; --- Conta: fconta = 16329-9, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   240.94 Where recno = 7224606 and is_deleted='N' ; --- Conta: fconta = 20677-1, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =    53.97 Where recno = 7225578 and is_deleted='N' ; --- Conta: fconta = 21719-6, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7211818 and is_deleted='N' ; --- Conta: fconta = 08020-8, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   222.95 Where recno = 7148305 and is_deleted='N' ; --- Conta: fconta = 16924-4, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7108491 and is_deleted='N' ; --- Conta: fconta = 51391-1, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7158789 and is_deleted='N' ; --- Conta: fconta = 53414-0, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   222.95 Where recno = 7106488 and is_deleted='N' ; --- Conta: fconta = 66944-0, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7222608 and is_deleted='N' ; --- Conta: fconta = 16902-5, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7143685 and is_deleted='N' ; --- Conta: fconta = 37770-6, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7208926 and is_deleted='N' ; --- Conta: fconta = 05973-2, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7209275 and is_deleted='N' ; --- Conta: fconta = 06177-3, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   222.95 Where recno = 7155229 and is_deleted='N' ; --- Conta: fconta = 48994-9, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   221.94 Where recno = 7018034 and is_deleted='N' ; --- Conta: fconta = 21979-7, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   135.54 Where recno = 7162933 and is_deleted='N' ; --- Conta: fconta = 57179-6, Valor anterior =   23
Update ag0307.ccr1sald set fvalortari =   144.76 Where recno = 7208683 and is_deleted='N' ; --- Conta: fconta = 05736-7, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   131.58 Where recno = 7211403 and is_deleted='N' ; --- Conta: fconta = 07431-1, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   195.57 Where recno = 7180234 and is_deleted='N' ; --- Conta: fconta = 71358-8, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    72.36 Where recno = 7223493 and is_deleted='N' ; --- Conta: fconta = 18876-6, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   335.97 Where recno = 7165821 and is_deleted='N' ; --- Conta: fconta = 57282-7, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    58.38 Where recno = 7218722 and is_deleted='N' ; --- Conta: fconta = 14025-3, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   158.40 Where recno = 7153513 and is_deleted='N' ; --- Conta: fconta = 46801-8, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    37.00 Where recno = 7230214 and is_deleted='N' ; --- Conta: fconta = 54695-0, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    29.60 Where recno = 7228592 and is_deleted='N' ; --- Conta: fconta = 62342-2, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   321.75 Where recno = 7046521 and is_deleted='N' ; --- Conta: fconta = 25692-7, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    77.71 Where recno = 7242260 and is_deleted='N' ; --- Conta: fconta = 65613-5, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    27.00 Where recno = 7218737 and is_deleted='N' ; --- Conta: fconta = 14086-1, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    27.98 Where recno = 7159715 and is_deleted='N' ; --- Conta: fconta = 54660-8, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   201.53 Where recno = 7225544 and is_deleted='N' ; --- Conta: fconta = 48616-7, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7211757 and is_deleted='N' ; --- Conta: fconta = 21277-6, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7198759 and is_deleted='N' ; --- Conta: fconta = 78645-2, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   172.74 Where recno = 7199396 and is_deleted='N' ; --- Conta: fconta = 80216-7, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7143712 and is_deleted='N' ; --- Conta: fconta = 37823-3, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   204.96 Where recno = 7075688 and is_deleted='N' ; --- Conta: fconta = 48624-8, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =    72.36 Where recno = 7228872 and is_deleted='N' ; --- Conta: fconta = 22326-2, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   222.95 Where recno = 7164248 and is_deleted='N' ; --- Conta: fconta = 57977-4, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   414.50 Where recno = 7166726 and is_deleted='N' ; --- Conta: fconta = 60080-0, Valor anterior =   86
Update ag0307.ccr1sald set fvalortari =   204.96 Where recno = 7202892 and is_deleted='N' ; --- Conta: fconta = 84156-1, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   136.15 Where recno = 7146425 and is_deleted='N' ; --- Conta: fconta = 33215-6, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =   185.96 Where recno = 7176939 and is_deleted='N' ; --- Conta: fconta = 69210-4, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7222329 and is_deleted='N' ; --- Conta: fconta = 16391-4, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7193491 and is_deleted='N' ; --- Conta: fconta = 72949-4, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7135777 and is_deleted='N' ; --- Conta: fconta = 01144-5, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    93.74 Where recno = 7208448 and is_deleted='N' ; --- Conta: fconta = 05481-5, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   187.54 Where recno = 7159932 and is_deleted='N' ; --- Conta: fconta = 54413-1, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   158.75 Where recno = 7223877 and is_deleted='N' ; --- Conta: fconta = 19746-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   117.59 Where recno = 7208612 and is_deleted='N' ; --- Conta: fconta = 05669-5, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   186.97 Where recno = 7162629 and is_deleted='N' ; --- Conta: fconta = 56946-0, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   233.37 Where recno = 7148126 and is_deleted='N' ; --- Conta: fconta = 41733-8, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   275.38 Where recno = 7121328 and is_deleted='N' ; --- Conta: fconta = 07142-3, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   144.76 Where recno = 7143049 and is_deleted='N' ; --- Conta: fconta = 37575-0, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7213659 and is_deleted='N' ; --- Conta: fconta = 10714-9, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   130.77 Where recno = 7222850 and is_deleted='N' ; --- Conta: fconta = 50923-4, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   144.76 Where recno = 7169833 and is_deleted='N' ; --- Conta: fconta = 64523-6, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   682.20 Where recno = 7017241 and is_deleted='N' ; --- Conta: fconta = 22909-1, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    65.37 Where recno = 7132260 and is_deleted='N' ; --- Conta: fconta = 30417-1, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   150.99 Where recno = 7214877 and is_deleted='N' ; --- Conta: fconta = 11330-4, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   149.98 Where recno = 7179120 and is_deleted='N' ; --- Conta: fconta = 70707-8, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =    58.79 Where recno = 7201174 and is_deleted='N' ; --- Conta: fconta = 82918-7, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   226.50 Where recno = 7016799 and is_deleted='N' ; --- Conta: fconta = 26051-7, Valor anterior =   29
Update ag0307.ccr1sald set fvalortari =   209.40 Where recno = 7084200 and is_deleted='N' ; --- Conta: fconta = 50235-9, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   209.40 Where recno = 7180426 and is_deleted='N' ; --- Conta: fconta = 71884-3, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    38.00 Where recno = 7200255 and is_deleted='N' ; --- Conta: fconta = 81790-0, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   333.33 Where recno = 7180385 and is_deleted='N' ; --- Conta: fconta = 71834-8, Valor anterior =   26
Update ag0307.ccr1sald set fvalortari =   100.73 Where recno = 7166589 and is_deleted='N' ; --- Conta: fconta = 61309-3, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7052724 and is_deleted='N' ; --- Conta: fconta = 26679-5, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7220515 and is_deleted='N' ; --- Conta: fconta = 15413-7, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   199.54 Where recno = 7215844 and is_deleted='N' ; --- Conta: fconta = 11729-9, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7219837 and is_deleted='N' ; --- Conta: fconta = 14766-6, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7223935 and is_deleted='N' ; --- Conta: fconta = 14810-2, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7223380 and is_deleted='N' ; --- Conta: fconta = 18597-1, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   409.25 Where recno = 7224713 and is_deleted='N' ; --- Conta: fconta = 20828-6, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =   204.96 Where recno = 7009950 and is_deleted='N' ; --- Conta: fconta = 21623-2, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7229222 and is_deleted='N' ; --- Conta: fconta = 22636-5, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   376.26 Where recno = 7109189 and is_deleted='N' ; --- Conta: fconta = 69735-4, Valor anterior =   70
Update ag0307.ccr1sald set fvalortari =   187.54 Where recno = 7163603 and is_deleted='N' ; --- Conta: fconta = 44351-5, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7193728 and is_deleted='N' ; --- Conta: fconta = 48211-7, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7088958 and is_deleted='N' ; --- Conta: fconta = 54259-8, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   347.50 Where recno = 7114916 and is_deleted='N' ; --- Conta: fconta = 73641-4, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7108523 and is_deleted='N' ; --- Conta: fconta = 68826-6, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7222136 and is_deleted='N' ; --- Conta: fconta = 63200-1, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   185.96 Where recno = 7202387 and is_deleted='N' ; --- Conta: fconta = 83903-7, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7223886 and is_deleted='N' ; --- Conta: fconta = 19759-5, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   158.75 Where recno = 7212318 and is_deleted='N' ; --- Conta: fconta = 09088-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   360.50 Where recno = 7196270 and is_deleted='N' ; --- Conta: fconta = 76657-9, Valor anterior =   29
Update ag0307.ccr1sald set fvalortari =   310.28 Where recno = 7159840 and is_deleted='N' ; --- Conta: fconta = 54786-2, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7222898 and is_deleted='N' ; --- Conta: fconta = 17490-6, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7228579 and is_deleted='N' ; --- Conta: fconta = 21933-4, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   259.77 Where recno = 7155705 and is_deleted='N' ; --- Conta: fconta = 34075-3, Valor anterior =   26
Update ag0307.ccr1sald set fvalortari =   130.77 Where recno = 7217824 and is_deleted='N' ; --- Conta: fconta = 13453-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    51.80 Where recno = 7202109 and is_deleted='N' ; --- Conta: fconta = 83635-6, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7165857 and is_deleted='N' ; --- Conta: fconta = 60008-2, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    37.00 Where recno = 7219687 and is_deleted='N' ; --- Conta: fconta = 14644-2, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    44.40 Where recno = 7203120 and is_deleted='N' ; --- Conta: fconta = 84461-4, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   244.30 Where recno = 6959009 and is_deleted='N' ; --- Conta: fconta = 08465-4, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =    44.40 Where recno = 7207337 and is_deleted='N' ; --- Conta: fconta = 04871-6, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    29.60 Where recno = 7179904 and is_deleted='N' ; --- Conta: fconta = 63766-1, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    37.00 Where recno = 6988665 and is_deleted='N' ; --- Conta: fconta = 17698-2, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    93.00 Where recno = 7208884 and is_deleted='N' ; --- Conta: fconta = 84236-1, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   114.71 Where recno = 7025057 and is_deleted='N' ; --- Conta: fconta = 28115-8, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7216437 and is_deleted='N' ; --- Conta: fconta = 12238-5, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7217706 and is_deleted='N' ; --- Conta: fconta = 13290-7, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   184.56 Where recno = 7218865 and is_deleted='N' ; --- Conta: fconta = 14195-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7222395 and is_deleted='N' ; --- Conta: fconta = 16490-2, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   204.96 Where recno = 7208366 and is_deleted='N' ; --- Conta: fconta = 05352-7, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7229100 and is_deleted='N' ; --- Conta: fconta = 22504-4, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   240.94 Where recno = 7180683 and is_deleted='N' ; --- Conta: fconta = 28151-4, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   185.96 Where recno = 7224150 and is_deleted='N' ; --- Conta: fconta = 20151-3, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   409.25 Where recno = 7083552 and is_deleted='N' ; --- Conta: fconta = 34585-7, Valor anterior =   70
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7169884 and is_deleted='N' ; --- Conta: fconta = 60358-1, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   222.95 Where recno = 7201926 and is_deleted='N' ; --- Conta: fconta = 83426-9, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   309.75 Where recno = 7081110 and is_deleted='N' ; --- Conta: fconta = 51122-6, Valor anterior =   79
Update ag0307.ccr1sald set fvalortari =   448.26 Where recno = 7177129 and is_deleted='N' ; --- Conta: fconta = 69395-4, Valor anterior =   70
Update ag0307.ccr1sald set fvalortari =    93.74 Where recno = 7181069 and is_deleted='N' ; --- Conta: fconta = 72556-7, Valor anterior =   22
Update ag0307.ccr1sald set fvalortari =   136.15 Where recno = 7199017 and is_deleted='N' ; --- Conta: fconta = 79313-4, Valor anterior =   23
Update ag0307.ccr1sald set fvalortari =   158.75 Where recno = 7207489 and is_deleted='N' ; --- Conta: fconta = 04962-3, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7223373 and is_deleted='N' ; --- Conta: fconta = 18601-9, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    86.75 Where recno = 7195882 and is_deleted='N' ; --- Conta: fconta = 74435-1, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   187.54 Where recno = 7110607 and is_deleted='N' ; --- Conta: fconta = 70766-0, Valor anterior =   44
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7211087 and is_deleted='N' ; --- Conta: fconta = 06999-6, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   203.95 Where recno = 7155535 and is_deleted='N' ; --- Conta: fconta = 49464-1, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7217096 and is_deleted='N' ; --- Conta: fconta = 12590-9, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   258.36 Where recno = 6992254 and is_deleted='N' ; --- Conta: fconta = 13405-8, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7168940 and is_deleted='N' ; --- Conta: fconta = 63631-8, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   144.76 Where recno = 7169475 and is_deleted='N' ; --- Conta: fconta = 64096-3, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7225095 and is_deleted='N' ; --- Conta: fconta = 19848-6, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7228537 and is_deleted='N' ; --- Conta: fconta = 22010-2, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   186.97 Where recno = 7220993 and is_deleted='N' ; --- Conta: fconta = 15729-7, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =    65.37 Where recno = 7162009 and is_deleted='N' ; --- Conta: fconta = 56565-8, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =   252.00 Where recno = 7172382 and is_deleted='N' ; --- Conta: fconta = 66369-2, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    76.00 Where recno = 8829423 and is_deleted='N' ; --- Conta: fconta = 62886-7, Valor anterior =   38
Update ag0307.ccr1sald set fvalortari =   603.00 Where recno = 7196545 and is_deleted='N' ; --- Conta: fconta = 70072-5, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   276.92 Where recno = 7086988 and is_deleted='N' ; --- Conta: fconta = 54505-8, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   276.92 Where recno = 7207558 and is_deleted='N' ; --- Conta: fconta = 59040-7, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =   384.72 Where recno = 7092835 and is_deleted='N' ; --- Conta: fconta = 48064-9, Valor anterior =   53
Update ag0307.ccr1sald set fvalortari =   173.55 Where recno = 7214409 and is_deleted='N' ; --- Conta: fconta = 11010-4, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7216320 and is_deleted='N' ; --- Conta: fconta = 12122-6, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7225479 and is_deleted='N' ; --- Conta: fconta = 21597-3, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   409.25 Where recno = 7220144 and is_deleted='N' ; --- Conta: fconta = 15155-3, Valor anterior =   70
Update ag0307.ccr1sald set fvalortari =   159.56 Where recno = 7199627 and is_deleted='N' ; --- Conta: fconta = 55987-3, Valor anterior =   30
Update ag0307.ccr1sald set fvalortari =   284.76 Where recno = 7009459 and is_deleted='N' ; --- Conta: fconta = 21608-9, Valor anterior =   26
Update ag0307.ccr1sald set fvalortari =   307.50 Where recno = 7220242 and is_deleted='N' ; --- Conta: fconta = 15258-2, Valor anterior =   57
Update ag0307.ccr1sald set fvalortari =   136.15 Where recno = 7204611 and is_deleted='N' ; --- Conta: fconta = 04191-1, Valor anterior =   35
Update ag0307.ccr1sald set fvalortari =    79.76 Where recno = 7199230 and is_deleted='N' ; --- Conta: fconta = 79742-5, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   286.75 Where recno = 7207657 and is_deleted='N' ; --- Conta: fconta = 05113-7, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   284.76 Where recno = 7091194 and is_deleted='N' ; --- Conta: fconta = 57072-9, Valor anterior =   26
Update ag0307.ccr1sald set fvalortari =   158.75 Where recno = 7222722 and is_deleted='N' ; --- Conta: fconta = 17139-9, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7172754 and is_deleted='N' ; --- Conta: fconta = 67653-8, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   145.57 Where recno = 7222971 and is_deleted='N' ; --- Conta: fconta = 52326-8, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =   186.97 Where recno = 7201870 and is_deleted='N' ; --- Conta: fconta = 83377-4, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7224883 and is_deleted='N' ; --- Conta: fconta = 70856-9, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   186.97 Where recno = 7042504 and is_deleted='N' ; --- Conta: fconta = 28280-4, Valor anterior =   19
Update ag0307.ccr1sald set fvalortari =    72.77 Where recno = 7199352 and is_deleted='N' ; --- Conta: fconta = 80092-1, Valor anterior =   15
Update ag0307.ccr1sald set fvalortari =    37.00 Where recno = 7140083 and is_deleted='N' ; --- Conta: fconta = 35850-8, Valor anterior =    7
Update ag0307.ccr1sald set fvalortari =   102.79 Where recno = 7214992 and is_deleted='N' ; --- Conta: fconta = 11321-5, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    88.80 Where recno = 7161590 and is_deleted='N' ; --- Conta: fconta = 56314-9, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    69.80 Where recno = 7038108 and is_deleted='N' ; --- Conta: fconta = 09849-3, Valor anterior =    0
Update ag0307.ccr1sald set fvalortari =    95.00 Where recno = 7152249 and is_deleted='N' ; --- Conta: fconta = 45030-4, Valor anterior =   38




Select *  from agunico.ccr1tari where recno > (select max(recno)-2218 from agunico.ccr1tari ) 
