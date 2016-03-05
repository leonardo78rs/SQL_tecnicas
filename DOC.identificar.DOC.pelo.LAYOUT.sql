/*
begin
  PKGL_INFRA_UTIL.PRCL_SET_CURRENT_SCHEMA('AG0226') ;
  dbms_output.put_line(PKGL_INFRA_UTIL.FNCL_GET_CURRENT_SCHEMA());
end;
*/ 
declare
  vs_reg_esperados number := 5000;
  vs_count number(6) := 0;
  cConta CHAR(7) := '35816-9';
  cAgencia CHAR(4) := '0230';
  total integer := 0 ; 
  cLinha CHAR(256) := '0187480315 0000000105562481457000000000000200000ROGERIO BALBINO DOS SANTOS              000010055921280107           0483990638 0006380074973DISVECO LTDA                            0297136000032801MT   4     02720520140509018001400000000000045    00000002';
0187480315 0000000105562481457000000000000200000ROGERIO BALBINO DOS SANTOS              000010055921280107           0483990638 0006380074973DISVECO LTDA                            0297136000032801MT   4     02720520140509018001400000000000045    00000002
  
--Select to_number('00000123456')/100 from dual 
/*
--- Doc Valor: 2000,00 Data 09/05/2014.   
--- De: DISVECO LTDA      Cnpj 02971360000328, MT, Do Banco: 399 Ag: 0638  Conta: 0006380074973
--- Para: ROGERIO BALBINO DOS SANTOS   CPF 010.055.921-28
--- Para Ag/Conta inexistentes: AG0315 Cta 10556-2
*/ 

begin
  dbms_output.put_line ('Identificação de Docs:' ) ;
  dbms_output.put ('Doc Valor: R$ ' ) ;
  dbms_output.put_line (to_number(substr(cLinha,34,15)/100)) ;
  dbms_output.put_line ('Data: '||substr(clinha,221,2)||'/'||substr(clinha,219,2)||'/'||substr(clinha,215,4));
  dbms_output.put_line ('De..: '||substr(cLinha,49,40)||'CPF/CNPJ: '||Substr(cLinha,182,14)||' UF: '||Substr(Clinha,198,2)||' Do Banco: '||Substr(cLinha,121,3)||' ; 
   

 

   
     dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
 
    dbms_output.put_line ('Total:'||to_char(total)  ) ;
end;


