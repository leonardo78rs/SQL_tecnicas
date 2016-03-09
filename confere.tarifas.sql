f/*Incidente 6508153

Associados com saldo em depósitos a prazo não levou em conta para dar desconto nas cestas de relacionamento

Conta 06810-1 cesta E1   // Coop 4501

sELECT * FROM AG0136.CCR1PACO 
CcrTPaCo->FcDebiExtr 
Select fcdebiextr from ag0136 

08590-1  RENATA MAKSOUD BUSSUAN  T20 CESTA DE RELACIONAMENTO          R$   25,00   11/08/2014  23:16  R$                           661.638,50    R$                          185.740,40    R$             431,20 
17923-1  CARLA VALADAO DE FREITAS MARTI  T20 CESTA DE RELACIONAMENTO  R$   25,00   11/08/2014  23:16  R$                                             -      R$                            76.753,95    R$             137,91 
02822-3  CARLOS EDUARDO RODRIGUES SANTO  T20 CESTA DE RELACIONAMENTO  R$   22,50   11/08/2014  23:16  R$                           151.770,75    R$                                           -      R$          1.114,93 
18933-2  ABGAIL DIAS BUENO  T20 CESTA DE RELACIONAMENTO               R$   20,00   11/08/2014  23:16  R$                                             -      R$                            24.330,04    R$                10,40 
 
begin
  PKGL_INFRA_UTIL.PRCL_SET_CURRENT_SCHEMA('AG4501') ;
  dbms_output.put_line(PKGL_INFRA_UTIL.FNCL_GET_CURRENT_SCHEMA());
end;

Causa Aparente:  Dúvida
Solução de contorno: 
1- Os valores aplicados vão valer como desconto a partir do próximo m~es, de acordo com as faixas de desconto e os valores nas contas de aplicação/poupança/etc.
2- Os descontos do mês de agosto são calculados com base no mês de julho. 
3- Algumas contas tiveram aplicações em 31/07/2014 (possivelmente decorrente da migracao Sicredi Rio) e posteriormente. 


-------------------------------------------------------------------------------------------------------------------------------------------------           
Agencia/Conta:4501/06810-1 | Pacote: E1 | Ano_Mês: 2014/08         0.0 |      1,478.5 |          10% |          0.0 |          0.0 | 
Agencia/Conta:4501/06810-1 | Pacote: E1 | Ano_Mês: 2014/07         0.0 |      1,478.5 |          10% |          0.0 |          0.0 | 
-------------------------------------------------------------------------------------------------------------------------------------------------           
Agencia/Conta:4501/08590-1 | Pacote: U1 | Ano_Mês: 2014/08         0.0 |        431.2 |          0% |          0.0 |          0.0 | 
Agencia/Conta:4501/08590-1 | Pacote: U1 | Ano_Mês: 2014/07         0.0 |        431.2 |          0% |          0.0 |          0.0 | 
-------------------------------------------------------------------------------------------------------------------------------------------------           
Agencia/Conta:4501/17923-1 | Pacote: U1 | Ano_Mês: 2014/08         0.0 |        137.9 |          0% |          0.0 |          0.0 | 
Agencia/Conta:4501/17923-1 | Pacote: U1 | Ano_Mês: 2014/07         0.0 |        137.9 |          0% |          0.0 |          0.0 | 
-------------------------------------------------------------------------------------------------------------------------------------------------           
Agencia/Conta:4501/02822-3 | Pacote: U1 | Ano_Mês: 2014/08         0.0 |      1,114.9 |         10% |          0.0 |          0.0 | 
Agencia/Conta:4501/02822-3 | Pacote: U1 | Ano_Mês: 2014/07         0.0 |      1,114.9 |         10% |          0.0 |          0.0 | 
-------------------------------------------------------------------------------------------------------------------------------------------------           
Agencia/Conta:4501/18933-2 | Pacote: T1 | Ano_Mês: 2014/08         0.0 |         10.4 |          0% |          0.0 |          0.0 | 
Agencia/Conta:4501/18933-2 | Pacote: T1 | Ano_Mês: 2014/07         0.0 |         10.4 |          0% |          0.0 |          0.0 | 
-------------------------------------------------------------------------------------------------------------------------------------------------           

Por exemplo, a conta 02822-3, teve apenas 10% referente ao desconto de Capital Social. Os valores abaixo serão considerados para o cálculo no fim do mês de agosto, e o desconto sobre a tarifa que será cobrada em Setembro. 
------------------------------------------------------------------------------------------------------------------------------------------------
Aplic Agencia |   Saldo    |    Controle    |     Mes1       |      Mes2      |      Mes3      |       Mes4     |      Mes5      |      Mes6    
1802500324-7    128,171.86 |   3,568,212.83 |           0.00 |           0.00 |           0.00 |           0.00 |           0.00 |           0.00
1802500472-3     10,350.00 |     277,205.53 |           0.00 |           0.00 |           0.00 |           0.00 |           0.00 |           0.00
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -           
Somatorio:      138,521.86 |   3,845,418.36 |           0.00 |           0.00 |           0.00 |           0.00 |           0.00 |           0.00
-------------------------------------------------------------------------------------------------------------------------------------------------           

Outro exemplo é a conta 

*/ 


declare
--- Declaração das variaveis 
  clinha    CHAR(156) := '-------------------------------------------------------------------------------------------------------------------------------------------------';
  clinhasep CHAR(156) := ' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -';
  
  cPseudArray varCHAR2(70) := '';
  
  vs_reg_esperados number := 5000;
  vs_count number(6) := 0;
--  cConta CHAR(7)     := '06810-1';
--  cConta CHAR(7)     := '08590-1';
--  cConta CHAR(7)     := '17923-1';
  cConta CHAR(7)     := '02822-3';
--  cConta CHAR(7)     := '18933-2';
  
  cAgencia CHAR(4)   := '4501';   
  nSaldo number := 0;   
  nSaldo0 number := 0;
  nSaldo1 number := 0;
  nSaldo2 number := 0;
  nSaldo3 number := 0;
  nSaldo4 number := 0;
  nSaldo5 number := 0;
  nSaldo6 number := 0;

  nPoupa number := 0;   
  nPoupa0 number := 0;
  nPoupa1 number := 0;
  nPoupa2 number := 0;
  nPoupa3 number := 0;
  nPoupa4 number := 0;
  nPoupa5 number := 0;
  nPoupa6 number := 0;

  nPinteg number := 0;   
  nPinteg0 number := 0;
  nPinteg1 number := 0;
  nPinteg2 number := 0;
  nPinteg3 number := 0;
  nPinteg4 number := 0;
  nPinteg5 number := 0;
  nPinteg6 number := 0;
  

  nPoutro number := 0;   
  nPoutro0 number := 0;
  nPoutro1 number := 0;
  nPoutro2 number := 0;
  nPoutro3 number := 0;
  nPoutro4 number := 0;
  nPoutro5 number := 0;
  nPoutro6 number := 0;

begin
  -- Cabeçalho
  dbms_output.put_line('============================================================================================================================================');
  dbms_output.put_line('| servidor - '||sys_context( 'userenv', 'db_name' )||'@'||sys_context( 'userenv', 'server_host' ) ||' - banco de dados: '||sys_context( 'userenv', 'current_schema'));
  dbms_output.put_line('| inicio do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line('| usuario: - '||sys_context( 'userenv','os_user') );
  dbms_output.put_line('============================================================================================================================================');

  -- Dados Cadastrais 
  execute immediate 'alter session set current_schema=ag'||cAgencia;
  
  dbms_output.put_line(clinha);
  For Cadastro In (select FNome, FPosNuc, FdUltAtual, FdIniCapit, FcDiaDeb, FcPacote, Recno
                     from ccr0asso 
                    Where FConta = cConta and is_deleted='N')  Loop 

          dbms_output.put_line('Nome:'||cadastro.Fnome||' - Posto - '||cadastro.FPosNuc||' - Pacote: '||cadastro.FcPacote
                               ||' - Dia de Debito da Tarifa:'||cadastro.FcDiaDeb );  
          dbms_output.put_line('Ultima Atualização: '||to_char(cadastro.Fdultatual)||' - Recnoasso'||cadastro.Recno);                    

    cPseudArray :=   cPseudArray || cadastro.fcpacote || ',';
     
  End Loop ;
  
  
  -- Aplicacoes (fica no schema da agencia)
  dbms_output.put_line(' ');
  dbms_output.put_line(clinha);
  dbms_output.put_line('Aplic Agencia |   Saldo    |    Controle    |     Mes1       |      Mes2      |      Mes3      |       Mes4     |      Mes5      |      Mes6    ');
 
  For Saldo In ( Select  fconta,fctaapli,fsaldo,fsmedio0,fsmedio1, fsmedio2,fsmedio3,fsmedio4,fsmedio5,fsmedio6 
                      From CCRMSALD 
                     Where FConta=cConta and is_deleted='N') Loop 
          If saldo.fsaldo+saldo.fsmedio0+saldo.fsmedio1+saldo.fsmedio2+saldo.fsmedio3+saldo.fsmedio4+saldo.fsmedio5+saldo.fsmedio6 > 0 
          Then      
          dbms_output.put_line(Saldo.Fctaapli||
                             lpad(to_char(saldo.fsaldo   ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(saldo.fsmedio0 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(saldo.fsmedio1 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(saldo.fsmedio2 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(saldo.fsmedio3 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(saldo.fsmedio4 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(saldo.fsmedio5 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(saldo.fsmedio6 ,'9,999,990.00'),14) ) ;
 
          nSaldo  := nSaldo  + saldo.fsaldo;
          nSaldo0 := nSaldo0 + saldo.fsmedio0;
          nSaldo1 := nSaldo1 + saldo.fsmedio1;
          nSaldo2 := nSaldo2 + saldo.fsmedio2;
          nSaldo3 := nSaldo3 + saldo.fsmedio3;
          nSaldo4 := nSaldo4 + saldo.fsmedio4;
          nSaldo5 := nSaldo5 + saldo.fsmedio5;
          nSaldo6 := nSaldo6 + saldo.fsmedio6;     
          End If; 
          
  End Loop ;
  dbms_output.put_line(CLINHASEP);
  dbms_output.put_line('Somatorio:  '|| 
                       lpad(to_char(nSaldo   ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nSaldo0  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nSaldo1  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nSaldo2  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nSaldo3  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nSaldo4  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nSaldo5  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nSaldo6  ,'9,999,990.00'),14) );
  
  
  -- Poupança Tradicional (Schema é ag9900) e cooporig começa com 1.
  execute immediate 'alter session set current_schema=ag9900';
  dbms_output.put_line(' ');
  dbms_output.put_line(clinha);
  dbms_output.put_line('Poupanca Trad |   Saldo    |    Controle    |     Mes1       |      Mes2      |      Mes3      |       Mes4     |      Mes5      |      Mes6    ');

  For Poupa In ( Select  fconta,fctaapli,fsaldo,fsmedio0,fsmedio1, fsmedio2,fsmedio3,fsmedio4,fsmedio5,fsmedio6 
                      From ag9900.CCRMSALD 
                     Where FConta=cConta and FcCoopOrig='1.'||cAgencia and is_deleted='N') Loop 
    
          dbms_output.put_line(poupa.Fctaapli||
                             lpad(to_char(poupa.fsaldo   ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(poupa.fsmedio0 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(poupa.fsmedio1 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(poupa.fsmedio2 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(poupa.fsmedio3 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(poupa.fsmedio4 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(poupa.fsmedio5 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(poupa.fsmedio6 ,'9,999,990.00'),14) ) ;
 
          nPoupa  := nPoupa  + poupa.fsaldo;
          nPoupa0 := nPoupa0 + poupa.fsmedio0;
          nPoupa1 := nPoupa1 + poupa.fsmedio1;
          nPoupa2 := nPoupa2 + poupa.fsmedio2;
          nPoupa3 := nPoupa3 + poupa.fsmedio3;
          nPoupa4 := nPoupa4 + poupa.fsmedio4;
          nPoupa5 := nPoupa5 + poupa.fsmedio5;
          nPoupa6 := nPoupa6 + poupa.fsmedio6;
          
          
  End Loop ;
  dbms_output.put_line(clinhasep);

  dbms_output.put_line('Somatorio:  '|| 
                       lpad(to_char(nPoupa   ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoupa0  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoupa1  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoupa2  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoupa3  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoupa4  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoupa5  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoupa6  ,'9,999,990.00'),14) );


 ---- Poupanca Integrada (Schema é ag9900) e cooporig começa com 2.
  dbms_output.put_line(' ');
  dbms_output.put_line(clinha);
  dbms_output.put_line('Poup Integrada |   Saldo    |    Controle    |     Mes1       |      Mes2      |      Mes3      |       Mes4     |      Mes5      |      Mes6    ');

  For Pinteg In ( Select  fconta,fctaapli,fsaldo,fsmedio0,fsmedio1, fsmedio2,fsmedio3,fsmedio4,fsmedio5,fsmedio6 
                      From ag9900.CCRMSALD 
                     Where FConta=cConta and FcCoopOrig='2.'||cAgencia and is_deleted='N') Loop 
    
          dbms_output.put_line(Pinteg.Fctaapli||
                             lpad(to_char(Pinteg.fsaldo   ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Pinteg.fsmedio0 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Pinteg.fsmedio1 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Pinteg.fsmedio2 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Pinteg.fsmedio3 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Pinteg.fsmedio4 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Pinteg.fsmedio5 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Pinteg.fsmedio6 ,'9,999,990.00'),14) ) ;
 
          nPinteg  := nPinteg  + Pinteg.fsaldo;
          nPinteg0 := nPinteg0 + Pinteg.fsmedio0;
          nPinteg1 := nPinteg1 + Pinteg.fsmedio1;
          nPinteg2 := nPinteg2 + Pinteg.fsmedio2;
          nPinteg3 := nPinteg3 + Pinteg.fsmedio3;
          nPinteg4 := nPinteg4 + Pinteg.fsmedio4;
          nPinteg5 := nPinteg5 + Pinteg.fsmedio5;
          nPinteg6 := nPinteg6 + Pinteg.fsmedio6;
          
          
  End Loop ;
  dbms_output.put_line(clinhasep);

  dbms_output.put_line('Somatorio:  '|| 
                       lpad(to_char(nPinteg   ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPinteg0  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPinteg1  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPinteg2  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPinteg3  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPinteg4  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPinteg5  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPinteg6  ,'9,999,990.00'),14) ); 


 ---- Outras -- Apenas se aparecer alguma coisa (nem sei se tem)  
 ----                    (Schema é ag9900) e cooporig não começa com 1 nem 2.
  dbms_output.put_line(' ');
   dbms_output.put_line(clinha);
  dbms_output.put_line('Outros Poupanc |   Saldo    |    Controle    |     Mes1       |      Mes2      |      Mes3      |       Mes4     |      Mes5      |      Mes6    ');

  For Poutro In ( Select  fconta,fctaapli,fsaldo,fsmedio0,fsmedio1, fsmedio2,fsmedio3,fsmedio4,fsmedio5,fsmedio6 
                      From ag9900.CCRMSALD 
                     Where FConta=cConta and Substr(FcCoopOrig,3,4)=cAgencia and Substr(FcCoopOrig,1,1) not in ('1','2') and is_deleted='N') Loop 
    
          dbms_output.put_line(Poutro.Fctaapli||
                             lpad(to_char(Poutro.fsaldo   ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Poutro.fsmedio0 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Poutro.fsmedio1 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Poutro.fsmedio2 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Poutro.fsmedio3 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Poutro.fsmedio4 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Poutro.fsmedio5 ,'9,999,990.00'),14) ||' | '||
                             lpad(to_char(Poutro.fsmedio6 ,'9,999,990.00'),14) ) ;
 
          nPoutro  := nPoutro  + Poutro.fsaldo;
          nPoutro0 := nPoutro0 + Poutro.fsmedio0;
          nPoutro1 := nPoutro1 + Poutro.fsmedio1;
          nPoutro2 := nPoutro2 + Poutro.fsmedio2;
          nPoutro3 := nPoutro3 + Poutro.fsmedio3;
          nPoutro4 := nPoutro4 + Poutro.fsmedio4;
          nPoutro5 := nPoutro5 + Poutro.fsmedio5;
          nPoutro6 := nPoutro6 + Poutro.fsmedio6;
          
          
  End Loop ;
  dbms_output.put_line(clinhasep);

  dbms_output.put_line('Somatorio:  '|| 
                       lpad(to_char(nPoutro   ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoutro0  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoutro1  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoutro2  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoutro3  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoutro4  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoutro5  ,'9,999,990.00'),14)  ||' | '||
                       lpad(to_char(nPoutro6  ,'9,999,990.00'),14) ); 
                                      
  
  -- se o associado trocou de pacote de tarifas ou dia de débito de tarifas
  
  dbms_output.put_line(' ');
  dbms_output.put_line(clinha);       
  dbms_output.put_line('Mudanças pacote tarifas:');                 
  
  For Mudan In ( Select COD_PACOTE,DAT_FINAL,DAT_INICIAL,DIA_DEBITO,NUM_AGENCIA,NUM_CONTA 
                    From HIST_TARIFA_CONTA 
                   Where NUM_AGENCIA = cAgencia
                     AND NUM_CONTA = cConta ) Loop
                     
                 dbms_output.put('Pacote:'||Mudan.Cod_Pacote);
                 dbms_output.put(' | Data Inicial:'||to_char(Mudan.Dat_Final));
                 dbms_output.put(' | Data Final:'||to_char(Mudan.Dat_Inicial));
                 dbms_output.put(' | Dia Debito:'||Mudan.Dia_debito);
                 dbms_output.put(' | Num Agencia:'||Mudan.Num_Agencia);
            dbms_output.put_line(' | Num Conta:'||Mudan.Num_Conta);
            
            cPseudArray :=   cPseudArray || Mudan.Cod_pacote || ',';
  End Loop;   
  dbms_output.put_line(clinha);
  
--- Produto Moderador 
  dbms_output.put_line(' ');
  dbms_output.put_line(clinha);       
  dbms_output.put_line('Moderador para as tarifas:'||cPseudArray||':');                 

-- dbms_output.put_line(cPseudArray); 
 
 For Moderador In (Select a.COD_PRODUTO,a.DES_PRODUTO,b.COD_PACOTE,a.OID_PRODUTO_MODERADOR,b.VLR_DESCONTO,b.VLR_FIM,b.VLR_INICIO
                         ,b.DAT_FIM_VIGENCIA,b.DAT_INICIO_VIGENCIA
                     from produto_moderador a, parametro_moderador b
                    where b.num_agencia = cAgencia
                      and a.oid_produto_moderador = b.oid_produto_moderador
                      and b.vlr_fim > 0
                      and a.flg_ativo = 'S'
                      and cPseudArray LIKE b.cod_pacote||'%'  ) Loop  

   dbms_output.put_line('Produto:'||Moderador.COD_PRODUTO||'-'||lpad(Moderador.DES_PRODUTO,36)||
                        ' | Pacote: '||Moderador.COD_PACOTE||
                        ' Prod: '||Moderador.OID_PRODUTO_MODERADOR||
                        lpad(to_char(Moderador.VLR_DESCONTO ,'999'),4) ||'% | '|| 
                        lpad(to_char(Moderador.VLR_FIM      ,'9,999,990.00'),12) ||' | '||
                        lpad(to_char(Moderador.VLR_INICIO   ,'9,999,990.00'),12) ||' | '||
                        to_char(Moderador.DAT_FIM_VIGENCIA) ||' | '||
                        to_char(Moderador.DAT_INICIO_VIGENCIA));
  End Loop;
  
  -- dbms_output.put_line( 'fim do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line(' ');
  dbms_output.put_line(clinha);       

 For Saldo_Mod In (Select COD_PACOTE, NUM_AGENCIA,NUM_ANO_MES,NUM_CONTA,
                          VLR_CAPITAL_MENSAL as col1,
                          VLR_CAPITAL_SOCIAL as col2,
                          VLR_CAPTACAO_DEPOSITO_PRZ as col3,
                          VLR_CHEQUE_ESPECIAL as col4,
                          VLR_PERCENTUAL_DESCONTO as col5,
                          VLR_APLICACAO_POUPANCA as col6,
                          VLR_FUNDOS_INVESTIMENTO as col7
                     from SALDO_MODERADOR
                    where num_agencia = cAgencia and num_conta = cconta order by NUM_ANO_MES desc ) Loop  
--ACHO QUE MELHOR NÃO FILTRAR PELOS PACOTES QUE ELE TEVE, TRAZER TODOS   and cPseudArray LIKE b.cod_pacote||'%'  ) Loop  

   dbms_output.put_line('Agencia/Conta:'||Saldo_Mod.NUM_AGENCIA||'/'||Saldo_Mod.Num_conta||
                        ' | Pacote: '   ||Saldo_Mod.COD_PACOTE ||
                        ' | Ano_Mês: '  ||Saldo_Mod.NUM_ANO_MES||
                        lpad(to_char(Saldo_Mod.Col1,'9,999,990.00'),12) ||' | '||
                        lpad(to_char(Saldo_Mod.Col2,'9,999,990.00'),12) ||' | '||
                        lpad(to_char(Saldo_Mod.Col3,'9,999,990.00'),12) ||' | '||
                        lpad(to_char(Saldo_Mod.Col4,'9,999,990.00'),12) ||' | '||
                        lpad(to_char(Saldo_Mod.Col5,'999'),12) ||'% | '||
                        lpad(to_char(Saldo_Mod.Col6,'9,999,990.00'),12) ||' | '||
                        lpad(to_char(Saldo_Mod.Col7,'9,999,990.00'),12) ||' | '  );
  End Loop;
  
  dbms_output.put_line(' ');
  dbms_output.put_line(clinha);       

end;
/
--set serveroutput off
--spool off
--exit




/* TESTES
Select a.COD_PRODUTO,a.DES_PRODUTO,b.COD_PACOTE,a.OID_PRODUTO_MODERADOR,b.VLR_DESCONTO,b.VLR_FIM,b.VLR_INICIO
                         ,b.DAT_FIM_VIGENCIA,b.DAT_INICIO_VIGENCIA                      
                     from produto_moderador a, parametro_moderador b
                    where b.num_agencia ='4501'
                      and a.oid_produto_moderador = b.oid_produto_moderador
                      and b.vlr_fim > 0
                      and a.flg_ativo = 'S'
                      and cod_pacote in 'E1'



Select distinct oid_produto_moderador  from parametro_moderador where dat_fim_vigencia is null  and num_agencia = '4501'
delete parametro_moderador where  num_agencia = '4501' and oid_produto_moderador not in ('1','2') 

Select * from parametro_moderador where dat_fim_vigencia is null  and num_agencia = '4501'

Update parametro_moderador set dat_inicio_vigencia = to_date('01/06/2014','dd/mm/yyyy')  where set dat_inicio_vigencia = to_date('26/07/2014 17:20:00')


Select * from parametro_moderador 
--- Select * from produto_moderador 

Select COD_PACOTE, NUM_AGENCIA,NUM_ANO_MES,NUM_CONTA,
                          VLR_CAPITAL_MENSAL as col1,
                          VLR_CAPITAL_SOCIAL as col2,
                          VLR_CAPTACAO_DEPOSITO_PRZ as col3,
                          VLR_CHEQUE_ESPECIAL as col4,
                          VLR_PERCENTUAL_DESCONTO as col5,
                          VLR_APLICACAO_POUPANCA as col6,
                          VLR_FUNDOS_INVESTIMENTO as col7
                     from SALDO_MODERADOR
                    where num_agencia = '4501' and num_conta = '06810-1'  and rownum <= 8 order by NUM_ANO_MES desc 

  cConta CHAR(7)     := '06810-1';
--  cConta CHAR(7)     := '08590-1';
--  cConta CHAR(7)     := '17923-1';
--  cConta CHAR(7)     := '02822-3';
--  cConta CHAR(7)     := '18933-2';

Select * from ag4501.ccrmSALD  WHERE FCCARENCIA = 0 
Select COUNT(0) from ag4501.ccrMSALD  ;
Select COUNT(0) from ag4501.ccrMSALD WHERE FCCODBENE =' ' ; 
Select COUNT(0) from ag4501.ccrMSALD WHERE FCautentic =' ' ;
Update ag4501.ccrMSALD set fcautentic = to_char(fccarencia) 
Update ag4501.ccrMSALD set fccarencia = 0 ; 
Select * from ag4501.ccrmSALD  WHERE Fsmedio1 <> 0
Update ag4501.ccrMSALD set fsmedio1 = fsmedio0 ; 
Update ag4501.ccrMSALD set fsmedio1 = 0 ;

rollback ; 

sELECT * FROM AG4501.CCRGMOVI WHERE FCTAAPLI IN (
Select FCTAAPLI from ag4501.ccrgsald where fconta = '08590-1') ; 
Select * from ag4501.poupcada 

Select * from ag4501.ccrmsald where fconta = '08590-1'
Select distinct(substr(fctaapli,1,2))  from ag4501.ccrmsald  
--- 18,10,12,01,48,14


*/ 

--Select count(0) from ag4501.ccr0asso 

Select                    num_ano_mes ,
                          SUM(VLR_CAPITAL_MENSAL) ,
                          SUm(VLR_CAPITAL_SOCIAL) ,
                          SUM(VLR_CAPTACAO_DEPOSITO_PRZ),
                          SUM(VLR_CHEQUE_ESPECIAL) ,
                          AVG(VLR_PERCENTUAL_DESCONTO) ,
                          SUM(VLR_APLICACAO_POUPANCA) ,
                          SUM(VLR_FUNDOS_INVESTIMENTO) , count(*) 
                     from SALDO_MODERADOR
                    where num_agencia = '4501'  group by num_ano_mes ; 
                    
                    Select SUM(VLR_CAPTACAO_DEPOSITO_PRZ) 
                     from SALDO_MODERADOR
                    where num_agencia = '0131' 
                    group by num_ano_mes 


--- totais: 	0	111205987,62	0	0	26,4529058116232	0	0	12974

Select * from SALDO_MODERADOR where num_agencia = '4501'

---> A tabela Saldo_Moderador não apresenta valores nas seguintes colunas:  VLR_CAPTACAO_DEPOSITO_PRZ, VLR_CHEQUE_ESPECIAL, VLR_APLICACAO_POUPANCA, VLR_FUNDOS_INVESTIMENTO.                    

Select * from ag4501.ccr0asso asso, 
              Saldo_moderador saldo 
        where fconta = num_conta 
        and num_agencia = 4501 
        and fnpermod = VLR_PERCENTUAL_DESCONTO


Select * from ag4501.ccr0asso asso  where fcdiadeb > '25' 
Select COUNT(0) from ag4501.ccr1movi where fcodlanc =  'T20'



---------------------------------------------------------------------------------------------------------------------------------------------------
Select * from ag4501.rtctrl where fnsistorig = 2 and fncodrot in (90,91);
Select * from ag4501.rtctrl where fnsistorig = 2 and fncodrot in (127,128);
Select min(fdinclusao),max(fdinclusao) from ag4501.ccrmmovi where fdata < '01/08/2014' ; 
Select min(fdinclusao),max(fdinclusao) from ag4501.ccrgmovi where fdata < '01/08/2014' ; 

Select min(fdinclusao),max(fdinclusao) from ag4501.ccrmmovi where fdata = '01/08/2014' ;
Select min(fdinclusao),max(fdinclusao) from ag4501.ccrgmovi where fdata = '01/08/2014' ; 

select a.cod_produto,B.NUM_AGENCIA  as produto                    
                 from produto_moderador a, parametro_moderador b
                 where b.num_agencia IN (0131)                       
                 and a.oid_produto_moderador = b.oid_produto_moderador 
                 and b.vlr_fim > 0                                  
                 and a.flg_ativo = 'S'                              
                 group by a.cod_produto,B.NUM_AGENCIA 

Select * from PARAMETRO_MODERADOR WHERE NUM_AGENCIA = 4501  and oid_produto_moderador not in ('1'); 

Select * from PRODUTO_MODERADOR ;                 
Select * from SALDO_MODERADOR WHERE NUM_AGENCIA = '4501' 
Select distinct NUM_ANO_MES from SALDO_MODERADOR WHERE NUM_AGENCIA = '4501'
SELECT FDULTINIC FROM ag4501.CCR1PACO

select * from versoes_instaladas where cod_sist = 71  and schema = 'AG4501'

--------------------------------
SELECT ASSO.FCONTA, ASSO.FCPACOTE
  FROM ag4501.CCR0ASSO ASSO, PARAMETRO_MODERADOR M       
 WHERE M.COD_PACOTE = ASSO.FCPACOTE               
   AND M.NUM_AGENCIA = 4501                         
   AND SUBSTR(ASSO.FCONTA, -1) BETWEEN 0 AND 9    
   AND ASSO.FTARIFA <> '0'                        
   AND TRUNC(ASSO.FDENCRELAC) = TO_DATE(1, 'j')   
   AND M.DAT_FIM_VIGENCIA IS NULL                 
   AND ASSO.IS_DELETED = 'N'                      
   and (EXISTS (SELECT 1                          
                  FROM ag4501.CCR1SALD SALD              
                 WHERE SALD.FCSITU <> 'P'         
                   AND SALD.FDIASNEG <> -1        
                   AND SALD.IS_DELETED = 'N'      
                   And ASSO.FCONTA = SALD.FCONTA) 
     OR EXISTS (SELECT 1                          
           FROM ag4501.CCR1INAT INAT                     
          WHERE ASSO.FCONTA = INAT.FCONTA         
            AND INAT.IS_DELETED = 'N'))           
AND TO_DATE( '26/08/2014', 'DD/MM/YYYY' ) BETWEEN TRUNC( DAT_INICIO_VIGENCIA ) AND                       
NVL( DAT_FIM_VIGENCIA, TO_DATE( '01/01/5000', 'DD/MM/YYYY' )) 
GROUP BY ASSO.FCONTA, ASSO.FCPACOTE 

-- ok, retorna 7402 linhas 
FNC_Calcula_Saldo_Medio

----------------------------------------------------------------------------------------

Select                    SUM(VLR_CAPITAL_MENSAL) ,
                          SUm(VLR_CAPITAL_SOCIAL) ,
                          SUM(VLR_CAPTACAO_DEPOSITO_PRZ)  ,
                          NUM_ANO_MES 
                     from SALDO_MODERADOR
                    where num_agencia = '4501'  GROUP BY NUM_ANO_MES 

UPDATE SALDO_MODERADOR SET NUM_ANO_MES = '2014/06' WHERE NUM_AGENCIA = '4501' AND NUM_ANO_MES = '2014/07' 


SELECT COD_PACOTE  
          , NUM_AGENCIA 
          , NUM_ANO_MES 
          , NUM_CONTA   
          , DECODE('N', 'S', 0, VLR_CAPITAL_MENSAL) 
          , DECODE('S', 'S', 0, VLR_CAPITAL_SOCIAL) 
          , DECODE('S', 'S', 0, VLR_CAPTACAO_DEPOSITO_PRZ) 
          , VLR_CHEQUE_ESPECIAL 
          , DECODE('N' 'S', 0, VLR_APLICACAO_POUPANCA) 
          , DECODE('N', 'S', 0, VLR_FUNDOS_INVESTIMENTO) 
SELECT *           
       FROM SALDO_MODERADOR 
      WHERE NUM_ANO_MES = '2014/08' 
        AND NUM_AGENCIA = '4501'
        
------------------------------------------------------------------------------------------------------------------------------------------------------


Weber, 

Sobre a não aplicação de descontos: 
1. Foi realizado recálculo em produção (em 26/08) e o sistema gravou os mesmos valores, ou seja zerado para cap_dep_prazo e com valores para capital;
2. Não foi encontrado nenhum ponto onde o sistema falhou, pulou algum bloco de código por validação ou não tenha executado;
3. Em uma base de testes foi replicada toda a condição, o sistema busca as 7404 contas, e retorna valor zero para o saldo em captação;
4. Foram realizados debugs e não foi encontrada nenhuma falha ou desvio por falta de dados ou dados incorretos; 
5. As tabelas GSALD E MSALD estão populadas. 
6. Não há como calcular os moderadores para este primeiro mês.

- Como devemos proceder? 

B. Sobre o mês seguinte: 
1. Em 03/08/2014, com término as 17:52:27 e  17:53:43, foram rodadas as rotinas RECALCULO DE SALDO, e RECALCULO DESCONTO MODERADOR com competência 08/2014.
2. Isto irá causar erro na execução do próximo mês, ou seja, a BUSCA DE SALDOS, e o CALCULO DO DESCONTO MODERADOR de Agosto, que é a base para as tarifas cobradas em Setembro serão impactadas.
3. Nenhuma outra cooperativa tem registros de 08/2014 na tabela SALDO_MODERADOR.
4. O correto é apagar estes registros 08/2014 na SALDO_MODERADOR para evitar erros.  

-  Autoriza rodarmos um script para fazer esta correção ou existe alguma outra orientação para este caso? 




rdm:

DELETE SALDO_MODERADOR WHERE NUM_AGENCIA = '4501' AND NUM_ANO_MES = '2014/08' 
SELECT DISTINCT NUM_AGENCIA FROM SALDO_MODERADOR WHERE  NUM_ANO_MES = '2014/08'


Causa Aparente: Os associados não receberam aplicação de desconto porque não tem não foi enviado nos extratores as informações de saldos médios, que é utilizada para este cálculo.
Solução de Contorno: Orientar a cooperativa que a aplicação de desconto do Saldo Moderador nas cestas de relacionamento acontecerá a partir do momento em que todas informações forem processados pelo Sistema, e como o mês.
Pois apesar de todos os dados estarem cadastrados para ocorrerem, as tabelas de captação (deposito a prazo) não tem informações do processamento de meses anteriores. 
-
Observações: 
-- Conforme incidente filho encaminhado à area de negócios, "Favor conversar com o pessoal de Captação verificando se não temos como realizar o recalculo dos saldos médios, do mes 7 pelo menos, aqui no Sicredi.
Se não for possivel ai sim retornar o incidente para a cooperativa informando de que não foi enviado nos extratores as informações de saldos médios, que é utilizada para realizar o calculo dos moderadores.
Qualquer dúvida me contate.ATenciosamente Weber" 
-- Em contato com a equipe de investimentos, não há previsto uma opção no sistema que proporcione o recálculo, e também, uma outra intervenção pode gerar diferenças para o mês de agosto e meses futuros. 




--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

Farias.

Levantamos os procedimentos mínimos a serem tomados. 
A própria situação dos valores zerados nos impede de saber, sem uma análise mais profunda, se isto encerra todos os passos. 
-
Conversando com o pessoal de investimentos, chegamos à conclusão que para atendimento desta solicitação devem ser seguidos os seguintes passos:
1 - Verificar todas as regras que o sistema de investimento realiza diariamente, inclusive os tipos de lançamento que influenciam no saldo;
2 - Verificar as regras mensais;
3 - Criar um script que:
__3.1 - Leve em conta todas estas regras, e com o saldo inicial de 2014, incrementar a partir dos lançamentos para cada conta diariamente o FSMEDIO0 até o dia 31/01/2014;
__3.2 - Fazer o fechamento do mês de janeiro e carregar o FSMEDIO1 
__3.3 - Repetir os procedimentos para os outros meses (FEV a JUL), preservando o FSMEDIO1 de cada conta como FSMEDIO2 e assim por diante.
4 - Validar a execução deste script 
5 - Fazer outro scrit para colocar estes valores nas tabelas de produção;
---
Após ter os saldos médios, teria que fazer o análogo nas tarifas: 
1 - Verificar todas as regras que o sistema de conta corrente utiliza; 
2 - Criar um script que:
__2.1 - faça a busca de saldos de acordo com as regras do sistema; 
__2.2 - verifique a Cesta cadastrada, possíveis alterações de cesta, validade ou não da cesta, e o produto moderador junto com o parametro moderador;
__2.3 - verifique a faixa de desconto possível em que se enquadra, de acordo com saldo em captação
__2.4 - verificar alteração da faixa de desconto em função do calculo de desconto de outro produto (saldo em conta capital)
3 - Validar a execução deste script
4 - Fazer outro script para alterar os campos do Saldo_Moderador 
5 - Validar as regras e criar um script para estabelecer o valor total da tarifa sem desconto;
6 - Construir uma planilha com este valor total sem desconto, o desconto aplicado e o desconto calculado a partir do script.








