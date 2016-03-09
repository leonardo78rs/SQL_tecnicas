/*
begin
  PKGL_INFRA_UTIL.PRCL_SET_CURRENT_SCHEMA('AG0226') ;
  dbms_output.put_line(PKGL_INFRA_UTIL.FNCL_GET_CURRENT_SCHEMA());
end;
*/ 
declare
  vs_reg_esperados number := 5000;
  vs_count number(6) := 0;
  VS_MEDIOTEMP number := 0;
  VS_SALDOSMES number := 0;   
  cConta CHAR(7) := '35816-9';
  cAgencia CHAR(4) := '0230';

begin

  dbms_output.put_line('====================================================================================================');
  dbms_output.put_line('| servidor - '||sys_context( 'userenv', 'db_name' )||'@'||sys_context( 'userenv', 'server_host' ) ||' - banco de dados: '||sys_context( 'userenv', 'current_schema'));
  dbms_output.put_line('| inicio do processo: '||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') );
  dbms_output.put_line('| usuario: - '||sys_context( 'userenv','os_user') );
  dbms_output.put_line('====================================================================================================');

      
  execute immediate 'alter session set current_schema=ag'||cAgencia;
    

 
   dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
  
   For Ajus In (select distinct FCTAAPLI FROM AG4501.CCRGMOVI WHERE IS_DELETED='N'  ) Loop
     
    
------ Pegar Saldo Anterior 
             Select sum(ftotalzero) / 31  INTO VS_MEDIOTEMP  from (
                        Select fctaapli,
                               'INI' as fcodhis,
                               to_date('31/07/2014') as fdata, 
                               fnsldbruto as fvalor_A, 
                               31 as ndias, 
                               fnsldbruto * 31 as FTotalZero 
                          from ag4501.ccrgsmes 
                         where fcanomes = '201407' 
                           and fctaapli = AJUS.FCTAAPLI 
                           AND IS_DELETED = 'N'   union   
                        ------ Unindo com as movimentacoes do mês    
                        Select GM.fctaapli,
                               GM.fcodhis,
                               GM.fdata,
                               (CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) AS FVALOR_A, 
                               (to_date('31/08/2014') - GM.fdata) as ndias, 
                               ((CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) * (to_date('31/08/2014') - GM.fdata)) as FTotalZero   
                          from ag4501.ccrgmovi GM,
                               ag4501.ccrghist GH 
                         where gm.fcodhis = GH.FCODHIS                                 
                           and GM.fctaapli = AJUS.FCTAAPLI 
                           and (GM.fdata  between '01/08/2014' and '31/08/2014' )      -- periodo de calculo
                         --  AND GM.FCODHIS NOT IN ('901','902','921','922','942','944') -- codigos de provisao                          
                           AND GM.IS_DELETED = 'N'
                           AND GH.IS_DELETED = 'N' ) ;

            --- este count é só pra evitar erro dos que estao zerados 
            Select COUNT(0) INTO VS_SALDOSMES from AG4501.CCRGSMES SM WHERE  SM.FCTAAPLI = AJUS.FCTAAPLI AND IS_DELETED = 'N' and sm.fcanomes = '201408' ;
            
            If vs_SaldoSMes > 0 then 
               Select FNSLDMEDIO INTO VS_SALDOSMES from AG4501.CCRGSMES SM WHERE  SM.FCTAAPLI = AJUS.FCTAAPLI AND IS_DELETED = 'N' and sm.fcanomes = '201408' ;
            Else 
               Vs_SaldoSMes := -1111 ; 
            End if;
            
                                    
--            If (vs_mediotemp > 0 or vs_saldosmes > 0 ) then                 --- listar com e sem diferenca 
            If (vs_mediotemp <> vs_saldosmes) and vs_saldosmes >= 0  then     --- listando so a diferença 
               dbms_output.put('C Apli.:');
               dbms_output.put(AJUS.FCTAAPLI);
               dbms_output.put(' SM: ' );
               dbms_output.put(to_char(VS_MEDIOTeMP,'99999999.99'));
               dbms_output.put(' SMES: ' );
               If Vs_saldosmes >= 0 then 
                  dbms_output.put(to_char(VS_saldosmes,'99999999,99'));
               Else 
                  dbms_output.put('** Nao encontrado');               
               End If; 
               dbms_output.put('  Dif: ' );
               dbms_output.put_LINE(to_char(VS_saldosmes - VS_MEDIOTeMP,'99999999.99'));                              

            End if;
            
            vs_mediotemp := 0 ;
            vs_saldosmes := 0 ; 
   End Loop; 
   
 
   
   
     dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------');
 

end;


/*sELECT * FROM AG4501.CCRGMOVI WHERE FCTAAPLI = '2302500015-9' AND FDATA >= '01/08/2014' 

90114,18
21310,79
21310,79
3196,61
190,76
C Apli.:2302500015-9 SM:      24031 SMES:      21027  Dif: -3004


select distinct FCTAAPLI FROM AG0247.CCRGMOVI WHERE IS_DELETED='N' 

C Apli.:2306500179-1 SM:       3006 SMES:       3021  Dif: 15
C Apli.:2303502759-6 SM:       2004 SMES:       2005  Dif: 1
C Apli.:2303501422-2 SM:      13504 SMES:      13035  Dif: -469
C Apli.:2311500921-0 SM:      18826 SMES:      18827  Dif: 1
C Apli.:2311500923-7 SM:        495 SMES:        499  Dif: 4
C Apli.:2311500919-9 SM:        345 SMES:        349  Dif: 4
C Apli.:2311500925-3 SM:        522 SMES:        525  Dif: 3
C Apli.:2314501972-0 SM:        629 SMES:        630  Dif: 1
C Apli.:2304500296-8 SM:       3289 SMES:       3290  Dif: 1
C Apli.:2311500916-4 SM:        168 SMES:        174  Dif: 6
C Apli.:2311500929-6 SM:        711 SMES:        713  Dif: 2

select distinct FCTAAPLI FROM AG0 434.CCRGMOVI WHERE IS_DELETED='N'
-----------------------------------------------------------------------------------------------------------------
C Apli.:2315507125-0 SM:       1537 SMES:       1538  Dif: 1
C Apli.:2301600989-0 SM:        544 SMES:        545  Dif: 1
C Apli.:2317500868-0 SM:        132 SMES:        133  Dif: 1
C Apli.:2314504350-8 SM:       1063 SMES:       1064  Dif: 1
C Apli.:2301642105-7 SM:       1470 SMES:       1471  Dif: 1
C Apli.:2301651407-1 SM:         24 SMES:         25  Dif: 1
C Apli.:2301652963-0 SM:         36 SMES:         37  Dif: 1
C Apli.:2301655671-8 SM:       3555 SMES:       3556  Dif: 1
C Apli.:2301665163-0 SM:        503 SMES:        504  Dif: 1
C Apli.:2301669499-1 SM:       1614 SMES:       1615  Dif: 1
C Apli.:2301672867-5 SM:        860 SMES:        861  Dif: 1
C Apli.:2301671872-6 SM:       1053 SMES:       1054  Dif: 1
C Apli.:2314504627-2 SM:      16828 SMES:      16965  Dif: 137
C Apli.:2301676937-1 SM:       1239 SMES:       1240  Dif: 1
C Apli.:2305509333-5 SM:        602 SMES:        603  Dif: 1
C Apli.:2301677481-2 SM:      10248 SMES:      10249  Dif: 1
C Apli.:2301677912-1 SM:        310 SMES:        311  Dif: 1
C Apli.:2301680532-7 SM:       2664 SMES:       2665  Dif: 1
C Apli.:2301526269-2 SM:       1251 SMES:       1252  Dif: 1
C Apli.:2314502804-5 SM:         66 SMES:         53  Dif: -13
C Apli.:2313501131-2 SM:          5 SMES:          6  Dif: 1
C Apli.:2315506965-5 SM:        423 SMES:        424  Dif: 1
C Apli.:2301554324-1 SM:        270 SMES:        271  Dif: 1
C Apli.:2301617899-3 SM:        203 SMES:        204  Dif: 1
C Apli.:2301630431-0 SM:        521 SMES:        522  Dif: 1
C Apli.:2301643549-0 SM:        359 SMES:        360  Dif: 1
C Apli.:2301654556-2 SM:         93 SMES:         94  Dif: 1
C Apli.:2301657474-0 SM:        308 SMES:        309  Dif: 1
C Apli.:2301660635-9 SM:        817 SMES:        818  Dif: 1
C Apli.:2301665438-8 SM:         15 SMES:         16  Dif: 1
C Apli.:2301668740-5 SM:       3507 SMES:       3508  Dif: 1
C Apli.:2301667227-0 SM:        734 SMES:        735  Dif: 1
C Apli.:2301666849-4 SM:        235 SMES:        236  Dif: 1
C Apli.:2301669589-0 SM:       1045 SMES:       1046  Dif: 1
C Apli.:2301670658-2 SM:        682 SMES:        683  Dif: 1
C Apli.:2301673279-6 SM:        578 SMES:        579  Dif: 1
C Apli.:2301672631-1 SM:         73 SMES:         74  Dif: 1
C Apli.:2301672955-8 SM:       2337 SMES:       2338  Dif: 1
C Apli.:2314504626-4 SM:        350 SMES:        353  Dif: 3
C Apli.:2301676536-8 SM:       1356 SMES:       1357  Dif: 1
C Apli.:2301674840-4 SM:        204 SMES:        205  Dif: 1
C Apli.:2301678312-9 SM:         55 SMES:         56  Dif: 1
C Apli.:2307504618-3 SM:       1153 SMES:       1113  Dif: -40
C Apli.:2301560086-5 SM:        725 SMES:        726  Dif: 1
C Apli.:2305508117-5 SM:       1463 SMES:       1464  Dif: 1
C Apli.:2301598939-8 SM:       4508 SMES:       4509  Dif: 1
C Apli.:2301632824-3 SM:        350 SMES:        351  Dif: 1
C Apli.:2301652915-0 SM:        529 SMES:        530  Dif: 1
C Apli.:2311507546-9 SM:      15429 SMES:      15430  Dif: 1
C Apli.:2301659466-0 SM:         39 SMES:         40  Dif: 1
C Apli.:2301665805-7 SM:        735 SMES:        736  Dif: 1
C Apli.:2301663905-2 SM:        374 SMES:        375  Dif: 1
C Apli.:2301670976-0 SM:         74 SMES:         75  Dif: 1
C Apli.:2301671843-2 SM:      10714 SMES:      10715  Dif: 1
C Apli.:2301674207-4 SM:         14 SMES:         15  Dif: 1
C Apli.:2301676257-1 SM:        723 SMES:        724  Dif: 1
C Apli.:2305509334-3 SM:        701 SMES:        702  Dif: 1
C Apli.:2301674637-1 SM:        339 SMES:        340  Dif: 1
C Apli.:2301678759-0 SM:        397 SMES:        398  Dif: 1
C Apli.:2301644803-6 SM:        159 SMES:        160  Dif: 1
C Apli.:2301671336-8 SM:        302 SMES:        303  Dif: 1
C Apli.:2301667085-5 SM:        734 SMES:        735  Dif: 1
C Apli.:2301668145-8 SM:        405 SMES:        406  Dif: 1
C Apli.:2301675727-6 SM:        762 SMES:        763  Dif: 1
C Apli.:2301586985-6 SM:        648 SMES:        649  Dif: 1
C Apli.:2301614086-4 SM:       2703 SMES:       2704  Dif: 1
C Apli.:2301572954-0 SM:        710 SMES:        711  Dif: 1
C Apli.:2301647314-6 SM:        102 SMES:        103  Dif: 1
C Apli.:2301678455-9 SM:        597 SMES:        598  Dif: 1
C Apli.:2301633437-5 SM:       1131 SMES:       1132  Dif: 1
C Apli.:2301661283-9 SM:        266 SMES:        267  Dif: 1
C Apli.:2301671246-9 SM:      11888 SMES:      11889  Dif: 1
C Apli.:2301670842-9 SM:         18 SMES:         19  Dif: 1
C Apli.:2311507108-0 SM:        354 SMES:        355  Dif: 1
C Apli.:2301563283-0 SM:        721 SMES:        722  Dif: 1
C Apli.:2311507583-3 SM:       6040 SMES:       6041  Dif: 1
C Apli.:2314504628-0 SM:      30009 SMES:      30220  Dif: 211
C Apli.:2305509337-8 SM:        283 SMES:        284  Dif: 1
C Apli.:2301675681-4 SM:       3842 SMES:       3843  Dif: 1
C Apli.:2301625016-3 SM:          8 SMES:          9  Dif: 1
C Apli.:2301682025-3 SM:        280 SMES:        281  Dif: 1
C Apli.:2301667252-1 SM:       2588 SMES:       2589  Dif: 1
C Apli.:2301666356-5 SM:       2931 SMES:       2932  Dif: 1
C Apli.:2314504629-9 SM:       7882 SMES:       7979  Dif: 97
C Apli.:2305509309-2 SM:       1532 SMES:       1541  Dif: 9
C Apli.:2301609928-7 SM:        735 SMES:        736  Dif: 1
C Apli.:2305509316-5 SM:       2313 SMES:       2326  Dif: 13
C Apli.:2301665877-4 SM:         36 SMES:         37  Dif: 1
C Apli.:2301674022-5 SM:        553 SMES:        554  Dif: 1
C Apli.:2301670844-5 SM:        301 SMES:        302  Dif: 1
C Apli.:2315507702-0 SM:       2072 SMES:       2073  Dif: 1
C Apli.:2301640195-1 SM:        489 SMES:        490  Dif: 1
C Apli.:2314502826-6 SM:       1493 SMES:       1435  Dif: -58
C Apli.:2301667319-6 SM:        182 SMES:        183  Dif: 1
C Apli.:2301672083-6 SM:       1518 SMES:       1519  Dif: 1
C Apli.:2301677316-6 SM:         20 SMES:         21  Dif: 1
C Apli.:2314504622-1 SM:        300 SMES:        302  Dif: 2
C Apli.:2301572940-0 SM:         87 SMES:         88  Dif: 1
C Apli.:2301656830-9 SM:         28 SMES:         29  Dif: 1
C Apli.:2301652246-5 SM:         15 SMES:         16  Dif: 1
C Apli.:2314504633-7 SM:       7050 SMES:       7083  Dif: 33
C Apli.:2314504635-3 SM:      11243 SMES:      11304  Dif: 61
C Apli.:2301622192-9 SM:       1130 SMES:       1131  Dif: 1
C Apli.:2301644288-7 SM:         34 SMES:         35  Dif: 1
C Apli.:2301674018-7 SM:         16 SMES:         17  Dif: 1
C Apli.:2302501543-1 SM:       2595 SMES:       2596  Dif: 1
C Apli.:2301682000-8 SM:        390 SMES:        391  Dif: 1
C Apli.:2301617033-0 SM:       7985 SMES:       7986  Dif: 1
C Apli.:2314504632-9 SM:        700 SMES:        703  Dif: 3
C Apli.:2301677609-2 SM:        974 SMES:        975  Dif: 1
C Apli.:2301664691-1 SM:          7 SMES:          8  Dif: 1
C Apli.:2301675317-3 SM:         36 SMES:         37  Dif: 1
C Apli.:2301647388-0 SM:       4778 SMES:       4779  Dif: 1
C Apli.:2301660862-9 SM:        803 SMES:        804  Dif: 1
C Apli.:2301627443-7 SM:       1281 SMES:       1282  Dif: 1
C Apli.:2301652804-8 SM:        213 SMES:        214  Dif: 1
C Apli.:2301680226-3 SM:         96 SMES:         97  Dif: 1
C Apli.:2301682220-5 SM:        521 SMES:        522  Dif: 1
C Apli.:2301675378-5 SM:        602 SMES:        603  Dif: 1
C Apli.:2301624609-3 SM:       9384 SMES:       9385  Dif: 1
C Apli.:2301646480-5 SM:        600 SMES:        601  Dif: 1
C Apli.:2301671194-2 SM:          8 SMES:          9  Dif: 1
C Apli.:2301682075-0 SM:        176 SMES:        177  Dif: 1
C Apli.:2301669293-0 SM:        156 SMES:        157  Dif: 1
C Apli.:2301677775-7 SM:        298 SMES:        299  Dif: 1
C Apli.:2314504636-1 SM:       3089 SMES:       3105  Dif: 16
C Apli.:2305502818-5 SM:       2080 SMES:       2081  Dif: 1
C Apli.:2301627097-0 SM:        716 SMES:        717  Dif: 1
C Apli.:2301649973-0 SM:         38 SMES:         39  Dif: 1
C Apli.:2301669619-6 SM:        443 SMES:        444  Dif: 1
C Apli.:2315507550-7 SM:        421 SMES:        422  Dif: 1
C Apli.:2301676466-3 SM:       1597 SMES:       1598  Dif: 1
C Apli.:2301675195-2 SM:       1677 SMES:       1678  Dif: 1
C Apli.:2301672800-4 SM:        470 SMES:        471  Dif: 1
C Apli.:2314504637-0 SM:      10717 SMES:      10748  Dif: 31
C Apli.:2301672203-0 SM:       2332 SMES:       2333  Dif: 1
C Apli.:2314502807-0 SM:         47 SMES:         38  Dif: -9
C Apli.:2305508610-0 SM:       8736 SMES:       8737  Dif: 1
C Apli.:2301665350-0 SM:        634 SMES:        635  Dif: 1
C Apli.:2301660858-0 SM:      12985 SMES:      12986  Dif: 1
C Apli.:2305504846-1 SM:        126 SMES:        110  Dif: -16
select 266-125 from dual 
*/



-- sELECT * FROM AG4501.CCRGMOVI WHERE FCTAAPLI = '2006500041-8' AND FDATA >= '01/08/2014'


/*-----------------------------------------------------------------------------------------------------------------
C Apli.:2302500015-9 SM:     24030.98 SMES:     21027.10  Dif:     -3003.88
C Apli.:2310500016-7 SM:        29.28 SMES:          .00  Dif:       -29.28
C Apli.:2306500063-9 SM:      1445.15 SMES:          .00  Dif:     -1445.15
C Apli.:2002500021-3 SM:      2911.90 SMES:      2799.87  Dif:      -112.03
C Apli.:2306500020-5 SM:     10318.81 SMES:      9906.00  Dif:      -412.81
C Apli.:2003500005-1 SM:       680.70 SMES:       648.28  Dif:       -32.42
C Apli.:2006500044-2 SM:         4.02 SMES:          .00  Dif:        -4.02
C Apli.:2008500004-3 SM:       257.30 SMES:       214.41  Dif:       -42.89
C Apli.:2302500018-3 SM:     21347.69 SMES:     19924.51  Dif:     -1423.18
C Apli.:2006500041-8 SM:         8.03 SMES:          .00  Dif:        -8.03
C Apli.:2303500014-0 SM:      6620.67 SMES:      5793.09  Dif:      -827.58
C Apli.:2303500011-6 SM:      2670.09 SMES:      2336.32  Dif:      -333.77
C Apli.:2304500015-9 SM:      5158.66 SMES:      4519.16  Dif:      -639.50
C Apli.:2303500016-7 SM:      3866.55 SMES:      3663.05  Dif:      -203.50
C Apli.:2008500019-1 SM:      2747.45 SMES:      2667.48  Dif:       -79.97
C Apli.:2306500021-3 SM:     13938.06 SMES:     13401.83  Dif:      -536.23
C Apli.:2306500022-1 SM:    140372.71 SMES:    134972.23  Dif:     -5400.48
C Apli.:2304500021-3 SM:     12941.64 SMES:     12325.37  Dif:      -616.27
C Apli.:2303500055-8 SM:      4957.98 SMES:      4786.88  Dif:      -171.10
C Apli.:2006500040-0 SM:         4.02 SMES:          .00  Dif:        -4.02
C Apli.:2306500011-6 SM:      3163.22 SMES:      2899.62  Dif:      -263.60
C Apli.:2002500055-8 SM:        51.37 SMES:          .00  Dif:       -51.37
C Apli.:2008500018-3 SM:     11700.10 SMES:     11296.38  Dif:      -403.72
C Apli.:2304500022-1 SM:      3110.84 SMES:      2969.43  Dif:      -141.41
C Apli.:2306500023-0 SM:     42448.57 SMES:     40815.47  Dif:     -1633.10
C Apli.:2002500019-1 SM:       269.62 SMES:       254.64  Dif:       -14.98
C Apli.:2002500056-6 SM:        12.69 SMES:          .00  Dif:       -12.69
C Apli.:2308500002-7 SM:       633.88 SMES:       614.54  Dif:       -19.34
C Apli.:2302500045-0 SM:       250.48 SMES:          .00  Dif:      -250.48
C Apli.:2002500054-0 SM:       448.88 SMES:          .00  Dif:      -448.88
C Apli.:2309500001-9 SM:      1807.77 SMES:      1643.43  Dif:      -164.34
C Apli.:2008500007-8 SM:      4023.69 SMES:      3755.44  Dif:      -268.25
C Apli.:2304500016-7 SM:      1568.43 SMES:      1372.37  Dif:      -196.06
C Apli.:2008500006-0 SM:       606.19 SMES:       530.41  Dif:       -75.78
C Apli.:2006500014-0 SM:       480.89 SMES:       440.82  Dif:       -40.07
C Apli.:2306500010-8 SM:       384.12 SMES:       336.11  Dif:       -48.01
C Apli.:2306500015-9 SM:      2690.90 SMES:      2483.90  Dif:      -207.00
C Apli.:2302500019-1 SM:      3166.87 SMES:      2990.93  Dif:      -175.94
C Apli.:2006500015-9 SM:       189.39 SMES:       179.42  Dif:        -9.97
C Apli.:2306500017-5 SM:      3877.29 SMES:      3673.22  Dif:      -204.07
C Apli.:2307500011-6 SM:      4671.82 SMES:      4449.35  Dif:      -222.47
C Apli.:2306500016-7 SM:     11301.36 SMES:     10858.92  Dif:      -442.44
C Apli.:2304500072-8 SM:     13335.72 SMES:     12875.52  Dif:      -460.20
C Apli.:2303500054-0 SM:    701217.51 SMES:    677018.90  Dif:    -24198.61
C Apli.:2304500074-4 SM:      3067.71 SMES:      2961.85  Dif:      -105.86
C Apli.:2002500047-7 SM:       829.65 SMES:          .00  Dif:      -829.65
C Apli.:2002500048-5 SM:       134.99 SMES:          .00  Dif:      -134.99
C Apli.:2302500041-8 SM:        31.69 SMES:          .00  Dif:       -31.69
C Apli.:2306500012-4 SM:      2887.56 SMES:      2646.93  Dif:      -240.63
C Apli.:2304500019-1 SM:       528.07 SMES:       498.73  Dif:       -29.34
C Apli.:2009500004-3 SM:      1299.92 SMES:       974.94  Dif:      -324.98
C Apli.:2303500009-4 SM:       752.01 SMES:       601.61  Dif:      -150.40
C Apli.:2307500048-5 SM:       332.39 SMES:          .00  Dif:      -332.39
C Apli.:2306500064-7 SM:       128.80 SMES:          .00  Dif:      -128.80
C Apli.:2307500014-0 SM:     13956.01 SMES:     13397.68  Dif:      -558.33
C Apli.:2004500011-6 SM:       579.97 SMES:       559.96  Dif:       -20.01
C Apli.:2007500482-0 SM:          .17 SMES:          .00  Dif:         -.17
C Apli.:2306500066-3 SM:       498.37 SMES:       373.78  Dif:      -124.59
C Apli.:2303500015-9 SM:      2809.59 SMES:      2622.28  Dif:      -187.31
C Apli.:2304500018-3 SM:      2708.05 SMES:      2499.74  Dif:      -208.31
C Apli.:2002500013-2 SM:      2788.66 SMES:      2556.27  Dif:      -232.39
C Apli.:2309500003-5 SM:      2696.13 SMES:      2516.39  Dif:      -179.74
C Apli.:2306500009-4 SM:      1624.99 SMES:      1421.87  Dif:      -203.12
C Apli.:2002500014-0 SM:       224.85 SMES:       212.36  Dif:       -12.49
C Apli.:2303500012-4 SM:     12332.45 SMES:     10790.89  Dif:     -1541.56
C Apli.:2002500018-3 SM:      7816.44 SMES:      7382.20  Dif:      -434.24
C Apli.:2002500020-5 SM:      6518.50 SMES:      6222.19  Dif:      -296.31
C Apli.:2304500026-4 SM:      3278.35 SMES:      3165.32  Dif:      -113.03
C Apli.:2307500012-4 SM:      1352.30 SMES:      1287.90  Dif:       -64.40
C Apli.:2307500016-7 SM:      6381.29 SMES:      6161.08  Dif:      -220.21
C Apli.:2307500050-7 SM:      8377.57 SMES:      8088.47  Dif:      -289.10
C Apli.:2004500031-0 SM:      3987.62 SMES:      3850.03  Dif:      -137.59
C Apli.:2002500051-5 SM:       117.27 SMES:          .00  Dif:      -117.27
C Apli.:2304500020-5 SM:      2590.28 SMES:      2446.38  Dif:      -143.90
C Apli.:2302500046-9 SM:      4692.80 SMES:          .00  Dif:     -4692.80
C Apli.:2006500042-6 SM:         8.03 SMES:          .00  Dif:        -8.03
C Apli.:2307500009-4 SM:       950.78 SMES:       814.96  Dif:      -135.82
C Apli.:2306500024-8 SM:      5136.06 SMES:      4952.52  Dif:      -183.54
C Apli.:2002500015-9 SM:      1302.43 SMES:      1230.07  Dif:       -72.36
C Apli.:2306500019-1 SM:      4334.89 SMES:      4128.47  Dif:      -206.42
C Apli.:2310500005-1 SM:      7901.06 SMES:      7485.21  Dif:      -415.85
C Apli.:2304500071-0 SM:     20176.09 SMES:     19479.83  Dif:      -696.26
C Apli.:2304500023-0 SM:      1407.36 SMES:      1353.21  Dif:       -54.15
C Apli.:2303500052-3 SM:     10324.71 SMES:      9980.62  Dif:      -344.09
C Apli.:2307500049-3 SM:      1549.48 SMES:      1496.01  Dif:       -53.47
C Apli.:2307500015-9 SM:      7509.11 SMES:      7249.97  Dif:      -259.14
C Apli.:2304500076-0 SM:      6653.97 SMES:      6424.35  Dif:      -229.62
C Apli.:2002500050-7 SM:        28.59 SMES:          .00  Dif:       -28.59
C Apli.:2302500044-2 SM:      1886.59 SMES:          .00  Dif:     -1886.59
C Apli.:2306500065-5 SM:       266.63 SMES:          .00  Dif:      -266.63
C Apli.:2302500042-6 SM:       982.43 SMES:          .00  Dif:      -982.43
C Apli.:2304500024-8 SM:     11629.06 SMES:     11213.49  Dif:      -415.57
C Apli.:2004500030-2 SM:      8670.80 SMES:      8371.61  Dif:      -299.19
C Apli.:2004500008-6 SM:      3672.12 SMES:      3497.25  Dif:      -174.87
C Apli.:2306500018-3 SM:      3149.09 SMES:      2983.35  Dif:      -165.74
C Apli.:2004500009-4 SM:      7510.04 SMES:      7495.13  Dif:       -14.91
-----------------------------------------------------------------------------------------------------------------
*/
