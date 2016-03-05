select * from ag0101.ccr1risc 


SELECT A.FNOME,r.* 
  FROM ag0101.ccr1risc r, AG0101.CCR0ASSO A 
 where  r.fconta = a.fconta   and r.fcanomes='201309' 
   AND A.FNOME LIKE 'CONTA FIC%'


'SELECT A.FNOME,BACEN.*' || chr(10) ||
'  FROM AUDITORIA_BACEN_CCRE BACEN, AG0101.CCR0ASSO A' || chr(10) ||
' where BACEN.num_agencia=''0101''' || chr(10) ||
'   AND SUBSTR(BACEN.NUM_CONTA,1,5)||''-''||SUBSTR(BACEN.NUM_CONTA,6,1)=A.FCONTA' || chr(10) ||
'   AND A.FNOME NOT LIKE ''CONTA FIC%''' || chr(10) ||
'';

'SELECT A.FNOME,r.*' || chr(10) ||
'  FROM ag0101.ccr1risc r, AG0101.CCR0ASSO A' || chr(10) ||
' where  r.fconta = a.fconta   and r.fcanomes>''201307'' and fsaldo>0' || chr(10) ||
'   AND A.FNOME LIKE ''CONTA FIC%''';
