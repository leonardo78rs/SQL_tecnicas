--- Este select retorna 5714 registros 


Select Substr(Asso.FPosNuc,1,2)                                              AS POSTO,            
       m.fdlancto                                                            AS DT_INCLUSAO,      
       Asso.Fconta                                                           AS CONTA,            
       Asso.Fccarteira                                                       AS CARTEIRA,         
       Asso.fnome                                                            AS NOME,             
       Asso.Fcdiadeb                                                         AS DIA_DEBITO,       
       m.fcodlanc                                                            AS COD_LANC,         
       0                                                                     AS VALOR,            
       p.Cod_Pacote                                                          AS COD_PACOTE,       
       p.des_Pacote                                                          AS DESC_PACOTE,      
       m.fdlancto                                                            AS DT_MOV_TARI,      
       0                                                                     AS VLR_DESC_PERC,    
       0                                                                     AS VLR_DESCONTO,     
       0                                                                     AS VLR_COBRADO,      
       'N'                                                                   AS INADPL            
  From ag4501.ccr0asso asso,                                                                             
       ag4501.ccr1movi m,                                                                                
       saldo_moderador s,                                                                       
        pacote_tarifa_cadastro p                                                                   
 Where asso.fconta = m.fconta                                                                     
    and asso.fconta = s.num_conta                                                                
   and p.Cod_Lancamento = m.fcodlanc                                                              
--   and m.fconta = :1                                                                
   and m.fcodlanc = 'T20'                                                                         
   and p.cod_lancamento = 'T20'                                                                   
    and s.num_agencia = p.num_agencia(+)                                                         
   and p.cod_pacote = asso.fcpacote                                                               
   and m.fdlancto between trunc(sysdate)-30 and trunc(sysdate)                                                                                                                                       


union                                                                                             
Select Substr(Asso.FPosNuc,1,2)                                                AS POSTO,          
       t.fdinclusao                                                            AS DT_INCLUSAO,    
       Asso.Fconta                                                             AS CONTA,          
       Asso.Fccarteira                                                         AS CARTEIRA,       
       Asso.fnome                                                              AS NOME,           
       Asso.Fcdiadeb                                                           AS DIA_DEBITO,     
       t.fccodlanc                                                             AS COD_LANC,       
       0                                                                       AS VALOR,          
       p.Cod_Pacote                                                            AS COD_PACOTE,     
       p.des_Pacote                                                            AS DESC_PACOTE,    
       t.Fddebtari                                                             AS DT_MOV_TARI,    
       0                                                                       AS VLR_DESC_PERC,  
       0                                                                       AS VLR_DESCONTO,   
       0                                                                       AS VLR_COBRADO,    
       'S'                                                                     AS INADPL          
  From ag4501.ccr0asso asso,                                                                             
       ag4501.ccr1tari t,                                                                                
        saldo_moderador s,                                                                       
       pacote_tarifa_cadastro p                                                                   
 Where asso.fconta = t.fcconta                                                                    
   and asso.fconta = s.num_conta                                                                  
   and p.Cod_Lancamento =  t.fccodlanc                                                            
--   and t.fcconta = :1                                                                
   and t.fccodlanc = 'T20'                                                                        
   and p.cod_lancamento = 'T20'                                                                   
    and s.num_agencia = p.num_agencia(+)                                                         
   and p.cod_pacote = asso.fcpacote                                                               
   and t.fdprovisao between trunc(sysdate)-30 and trunc(sysdate)                                  
   and t.Fddebtari = To_date(1,'J')                                                               



------ 
Select * from saldo_moderador     where num_agencia = '4501'     and num_ano_mes = '2014/08' 
and num_conta in ('06691-5','06692-3','06750-4','06748-2','06737-7','06736-9','06719-9','06715-6','06711-3','05286-8','05281-7','05511-5','05863-7','05853-0','05854-8','05856-4','05451-8','05448-8','05445-3','05274-4','05507-7','05823-8','05441-0','05256-6','05504-2','05496-8','05830-0','03318-9','05993-5','06005-4','06008-9','05420-8','05142-0','06030-5','05730-4','05726-6','05724-0','05418-6','05627-8','05753-3','05397-0','05615-4','05580-8','05977-3','06002-0','05973-0','05780-0','05776-2','05684-7','05808-4')

Select fcdiadeb from ag4501.ccr0asso where 
fconta in ('06691-5','06692-3','06750-4','06748-2','06737-7','06736-9','06719-9','06715-6','06711-3','05286-8','05281-7','05511-5','05863-7','05853-0','05854-8','05856-4','05451-8','05448-8','05445-3','05274-4','05507-7','05823-8','05441-0','05256-6','05504-2','05496-8','05830-0','03318-9','05993-5','06005-4','06008-9','05420-8','05142-0','06030-5','05730-4','05726-6','05724-0','05418-6','05627-8','05753-3','05397-0','05615-4','05580-8','05977-3','06002-0','05973-0','05780-0','05776-2','05684-7','05808-4')

