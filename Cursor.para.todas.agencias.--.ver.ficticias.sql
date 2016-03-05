---
DECLARE
  Vs_Cur     sys_refcursor;
  vs_Hnd_Arq     UTL_FILE.file_type;
  Vs_Esquema Varchar2(20);
  vs_conta varchar2(10);
  Vs_prod    sys_refcursor;
  fprepos    Varchar2(1);
  fcmoviib   Varchar2(1);
  faplic     Varchar2(20);
  agencia    Varchar2(4);
  consulta   NUMBER;
  aplicacao  NUMBER;
  resgate    NUMBER;
  priaplic   NUMBER;  
  barra      varchar2(100);
  datamov    date;
  vs_Sql     Varchar2(4000);
  vs_Tamanho number;
  vs_Linha       Varchar2(2000) := '';
  tabela EXCEPTION;
  PRAGMA EXCEPTION_INIT(tabela, -00942);
  
Begin
  
        
  Open Vs_Cur for
    select schema, agencia
      from unify.schemas
     where tipo in ('C', 'B')     
     and schema not in ('AG9900','AGESTRU','SGU','AG9804','AG9803');
       
       
  Loop
    Fetch Vs_Cur
      into Vs_Esquema, agencia;
    Exit when Vs_Cur%Notfound;            
        
/*                
    vs_Sql := 'SELECT A.FNOME,r.*' || chr(10) ||
'  FROM '||vs_esquema||'.ccr1risc r, '||vs_esquema||'.CCR0ASSO A' || chr(10) ||
' where  r.fconta = a.fconta   and r.fcanomes=''201309''' || chr(10) ||
'   AND A.FNOME LIKE ''CONTA FIC%'' UNION '; 
*/ 
    vs_Sql := 'SELECT count(1) FROM '||vs_esquema||'.CCR0ASSO where  FNOME LIKE ''CONTA FIC%'' UNION '; 
    
-- SELECT * FROM AG0321.CCR1MOVI WHERE FDLANCTO
    
    dbms_output.put_line(vs_sql);

 End Loop;
 CLOSE Vs_Cur;
   
   EXCEPTION
   WHEN tabela THEN
      RAISE_APPLICATION_ERROR(-20001, ' NÒo existe a tabela CCROMOVI no schema '||vs_esquema||'!');
--   WHEN OTHERS THEN
--      RAISE_APPLICATION_ERROR(-20002, 'Erro desconhecido! '||SQLCODE||' '||SQLERRM);

END;
