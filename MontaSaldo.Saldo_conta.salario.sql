declare
  vs_count number(6) := 0;
  Saldo  number(15,2) := 0;
  saldo_grav number(15,2) := 0;

--  
begin

Select vlr_saldo_cs into saldo_grav from ag0710.saldo_conta_salario where num_conta_salario = '540714'  ; 
   dbms_output.put_line('Saldo conta salario');
   dbms_output.put_line(saldo_grav);

--   execute immediate 'alter session set current_schema=ag'||cAgencia;   
   dbms_output.put_line('Movimento conta salario'); 
   dbms_output.put_line('Conta Salário;Data Lcto;Hora Lcto;Cod Lanc;Tipo;Descr Lcto;Num Doc;Valor Lcto;Saldo;Usuario;Sist' ) ;
   For Busca In (
                 Select cod_lancamento,dat_lancamento,
                        ftipo,fdes_cor,
                        num_conta_salario,num_documento,
                        vlr_lancamento,hor_lancamento, 
                        nom_usuario, num_sis_origem  --- select *
                   from ag0710.movimento_conta_salario mov,
                        ag0710.ccr1lanc lan 
                  where mov.num_conta_salario = 540714 
                    and lan.fcodlanc = mov.cod_lancamento
                    and lan.is_deleted = 'N' 
               order by oid_mov_conta_salario)
   Loop
     
        If Busca.Ftipo <= 2 
        then 
          Saldo := Saldo - Busca.Vlr_lancamento; 
        else 
          Saldo := Saldo + Busca.Vlr_lancamento;  
        end if ; 
                            
 
 
          dbms_output.put_line(  Busca.num_conta_salario||' ; '||
                                 Busca.dat_lancamento||' ; '||
                                 Busca.hor_lancamento||' ; '||
                                 Busca.cod_lancamento||' ; '||
                                 Busca.ftipo||' ; '||
                                 rpad(Busca.fdes_cor,25,' ')||' ; '||
                                 rpad(Busca.num_documento,9,' ')||' ; '||
                                 to_char(Busca.vlr_lancamento,'999999.99')||' ; '||
                                 to_char(Saldo,'999999.99')||' ; '||
                                 Busca.nom_usuario||' ; '||
                                 Busca.num_sis_origem
                                  ) ;                             
  
   End Loop; 
   

   
   
     dbms_output.put_line('------------------------------------------------------------------------------------------------------------------------');
 

end;

-- Select * from ag0663.rtctrl where fnsistorig = 176 and fdprocessa >= to_date('18/09/2015','dd/mm/yyyy') and fdprocessa < to_date('21/09/2015','dd/mm/yyyy')
-- Select * from agendamento_conta_salario where num_agencia = '0663' and num_conta_salario = '448338' 
