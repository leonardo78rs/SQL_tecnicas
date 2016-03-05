SELECT 'Tarifas Prej:',COUNT(0) FROM agunico.CCR1TARI T JOIN agunico.CCR1SALD S ON (T.FCCONTA = S.FCONTA) AND (T.NUM_AG = S.NUM_AG) WHERE S.FCSITU = 'P' AND T.FDPROVISAO >= S.FDTRANPREJ AND T.IS_DELETED = 'Y' 
union 
SELECT 'Tarifas Inat:',COUNT(0) FROM agunico.CCR1TARI T JOIN agunico.CCR1INAT I ON (T.FCCONTA = I.FCONTA) AND (T.NUM_AG = I.NUM_AG) WHERE T.FDPROVISAO >= I.FDENVINAT AND T.IS_DELETED = 'Y' 
union 
SELECT 'Qtd Contas Prej',COUNT(0) FROM (
SELECT DISTINCT S.NUM_AG||S.FCONTA FROM agunico.CCR1TARI T JOIN agunico.CCR1SALD S ON (T.FCCONTA = S.FCONTA) AND (T.NUM_AG = S.NUM_AG) WHERE S.FCSITU = 'P' AND T.FDPROVISAO >= S.FDTRANPREJ AND T.IS_DELETED = 'Y' ) 
union
SELECT 'Qtd Contas Inat',COUNT(0) FROM (
SELECT DISTINCT I.NUM_AG||I.FCONTA FROM agunico.CCR1TARI T JOIN agunico.CCR1INAT I ON (T.FCCONTA = I.FCONTA) AND (T.NUM_AG = I.NUM_AG) WHERE T.FDPROVISAO >= I.FDENVINAT AND T.IS_DELETED = 'Y' and I.IS_DELETED = 'N' ); 



Qtd Contas Inat	276511 --- 195944 
Qtd Contas Prej	105040
Tarifas Inat:	1452946
Tarifas Prej:	2595295



SELECT 'Qtd Contas Prej',num_ag,COUNT(0) FROM (
SELECT DISTINCT S.NUM_AG,S.FCONTA FROM agunico.CCR1TARI T JOIN agunico.CCR1SALD S ON (T.FCCONTA = S.FCONTA) AND (T.NUM_AG = S.NUM_AG) WHERE S.FCSITU = 'P' AND T.FDPROVISAO >= S.FDTRANPREJ AND T.IS_DELETED = 'Y' ) group by num_ag ; 

SELECT 'Qtd Contas Inat',num_ag,COUNT(0) FROM (
SELECT DISTINCT I.NUM_AG,I.FCONTA FROM agunico.CCR1TARI T JOIN agunico.CCR1INAT I ON (T.FCCONTA = I.FCONTA) AND (T.NUM_AG = I.NUM_AG) WHERE T.FDPROVISAO >= I.FDENVINAT AND T.IS_DELETED = 'Y' and I.IS_DELETED = 'N' )  group by num_ag ;  


 


