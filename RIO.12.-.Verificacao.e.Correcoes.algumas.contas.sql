--- Contas saldo medio negativo: Verificar erro e corrigir 

Recno APLI ;  Conta Aplicacao ; Saldo médio Calculado ; Quantidade Movimentos + Saldo Ini
300585737 ; 1406500467-7 ;     -2180.72 ; 8 ; 1
300694340 ; 1804501983-6 ;    -36997.58 ; 20 ; 1
300685414 ; 1803500393-0 ;     -2447.26 ; 13 ; 1
300691591 ; 1804501721-3 ;    -20637.73 ; 8 ; 1
300678010 ; 1806500577-0 ;      -116.34 ; 13 ; 1
300680486 ; 1802500649-1 ;     -1982.10 ; 8 ; 1
300572418 ; 1404500450-2 ;     -5996.30 ; 8 ; 1
300646909 ; 1804500881-8 ;      -388.27 ; 8 ; 1
300656389 ; 1808500117-1 ;     -5240.98 ; 8 ; 1
300636334 ; 1803500309-3 ;     -3059.59 ; 8 ; 1
300673352 ; 1803500402-2 ;     -2617.04 ; 8 ; 1
300683361 ; 1804501335-8 ;      -239.76 ; 8 ; 1
300626317 ; 1809500103-1 ;      -855.10 ; 8 ; 1
300616754 ; 1804500203-8 ;     -2258.35 ; 7 ; 1


Select * from ag4501.ccrmsald where fctaapli in ('1406500467-7','1804501983-6','1803500393-0','1804501721-3','1806500577-0','1802500649-1',
'1404500450-2','1804500881-8','1808500117-1','1803500309-3','1803500402-2','1804501335-8','1809500103-1','1804500203-8') 

Select * from ag4501.ccrmmovi where fctaapli in ('1406500467-7','1804501983-6','1803500393-0','1804501721-3','1806500577-0','1802500649-1',
'1404500450-2','1804500881-8','1808500117-1','1803500309-3','1803500402-2','1804501335-8','1809500103-1','1804500203-8') 
and fdata > '30/06/2014' and fdata < '01/08/2014' 

Select * from ag4501.ccrmmovi where fctaapli in ('1406500467-7') 
and fdata > '30/06/2014' and fdata < '01/08/2014' 


   Select *    From (
                        Select fctaapli,
                               'INI' as fcodhis,
                               to_date('30/06/2014') as fdata, 
                               fnsldbruto as fvalor_A, 
                               31 as ndias, 
                               fnsldbruto * 31 as FTotalZero 
                          from ag4501.ccrmsmes 
                         where fcanomes = '201406' 
                           and fctaapli = '1406500467-7' 
                           AND IS_DELETED = 'N'   union   
                        ------ Unindo com as movimentacoes do mês    
                        Select GM.fctaapli,
                               GM.fcodhis,
                               GM.fdata,
                               (CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) AS FVALOR_A, 
                               (to_date('31/07/2014') - GM.fdata) as ndias, 
                               ((CASE WHEN GH.FTPLANC in ('A','B') THEN -GM.FVALOR ELSE GM.FVALOR END) * (to_date('31/07/2014') - GM.fdata)) as FTotalZero   
                          from ag4501.ccrmmovi GM,
                               ag4501.ccrmhist GH 
                         where gm.fcodhis = GH.FCODHIS                                 
                           and gm.fctaapli = '1406500467-7'
                           and (GM.fdata  between '01/07/2014' and '31/07/2014' )      -- periodo de calculo
                         --  AND GM.FCODHIS NOT IN ('901','902','921','922','942','944') -- codigos de provisao                          
                           AND GM.IS_DELETED = 'N'
                           AND GH.IS_DELETED = 'N' ) ;
                           
-- Select * from ag4501.ccrmhist where  fcodhis in ('105','901','903','905','921')                          

/*

----- teve resgate maior do que o saldo 
						
						
8	1406500467-7	INI	30/06/2014	3523,54	31	109229,74
1	1406500467-7	105	03/07/2014	-6275,79	28	-175722,12
2	1406500467-7	901	03/07/2014	4,95	28	138,6
5	1406500467-7	903	03/07/2014	208,71	28	5843,88
6	1406500467-7	905	03/07/2014	-46,96	28	-1314,88
7	1406500467-7	921	03/07/2014	-208,71	28	-5843,88
3	1406500467-7	901	27/07/2014	16,56	4	66,24
4	1406500467-7	901	31/07/2014	4,7	0	0
						
						
	105	RESGATE DEP. A PRAZO				
	901	PROVISAO DE RENDIMENTOS				
	903	CAPITALIZ. REND. TRIBUT.				
	905	ENCARGOS DE IRRF				
	921	ESTORNO PROV. REND. TRIBUTADOS				
*/

Select * from ag4501.ccrmsmes where substr(fcanomes,1,4) = '2014'  and fctaapli = '1406500467-7' AND IS_DELETED = 'N' ; 
