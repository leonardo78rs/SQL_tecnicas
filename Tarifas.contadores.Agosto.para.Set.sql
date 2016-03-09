--- Prevencao Rotina 147 Agosto 
1. As que deram NP não tem qtd_utilizado. 

-- Consulta Coredbrep 02/09/2015 08:30 -- 29 coops não executaram 
-- Consulta Qbuilder 02/09/2015 09:00 
-- 0370,0102,3952,0811,3980,0754,0801,2605,0512 

Select * from agpadrao.ccrocred where in ('0370','0102','3952','0811','3980','0754','0801','2605','0512')
/*Select sum(qtd_utilizado),count(0),num_agencia from pacote_tarifa_associado  
where qtd_utilizado > 0 
group by num_agencia 
*/

----- Verificar qtde utilizado por agencia que não rodou OU verificar quais não rodaram rotina. 

/*Select sum(qtd_utilizado),count(0),num_agencia*/ 
/*Select 'Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag'
       ||num_agencia||'.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all' 
*/
Select num_agencia  from pacote_tarifa_associado  
 where qtd_utilizado > 0 
   and num_agencia not in (
        Select fcagencia from (
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0101.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0102.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0105.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0106.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0109.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0116.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0119.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0131.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0136.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0155.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0156.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0157.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0167.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0179.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0185.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0202.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0211.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0217.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0218.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0221.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0226.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0228.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0229.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0230.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0244.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0247.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0258.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0259.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0268.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0306.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0307.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0313.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0333.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0361.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0403.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0434.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0437.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0512.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0523.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0651.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0663.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0703.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0704.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0710.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0715.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0717.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0718.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0719.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0720.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0723.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0725.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0726.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0727.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0728.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0730.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0731.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0736.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0737.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0738.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0740.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0747.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0749.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0751.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0752.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0753.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0754.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0801.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0802.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0804.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0805.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0806.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0809.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0810.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0811.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0812.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0818.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0821.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0902.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0903.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0911.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0913.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0914.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag2602.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag2604.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag2606.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3003.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3004.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3009.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3013.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3021.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3022.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3027.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3031.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3032.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3033.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3828.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3830.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3950.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3952.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3955.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3954.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3953.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3980.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 union all  
              Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag4501.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-5 
            ))
            group by num_agencia
            
--- Select sum(qtd_utilizado),num_agencia from pacote_tarifa_associado where num_agencia in ('0105','0106','0157','0185','3032','0749') group by num_agencia ; 




            
/*
Cooperativas que não rodaram rotina..: ('3954','3033','3980','0102','0719','0167')
Cooperativas que deram NP............: ('0105','0106','0202','0749','0157','0185') 
Cooperativas que ainda nao executaram: ('0101','0307','0710','0718')

Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0119.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0102.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0116.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0217.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0258.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0307.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0333.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0370.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0434.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0512.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0710.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0718.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0725.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0726.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0737.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0754.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0801.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0804.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0811.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0812.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0818.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0914.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag2602.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag2604.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag2605.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag2606.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3003.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3952.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag3980.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 ;


Update pacote_tarifa_associado 
   set qtd_utilizado = 0 
 where qtd_utilizado > 0  
   and ( 
            num_agencia in ('3954','3033','3980','0102','0719','0167')  --- nao processaram 
        or  num_agencia in ('0105','0106','0202','0749','0157','0185')  --- deram NP (sem agendamento) 
        or  num_agencia in ('0101','0307','0710','0718')                --- cooperativas que nao viraram o mes 
        ) ; 
        
        rollback ;

Select num_ag,max(fdlancto) from agunico.ccr1movi where num_ag in ('3954','3033','3980','0102','0719','0167') group by num_ag 




Cooperativas que não rodaram rotina...: ('3954','3033','3980','0102','0719','0167')
Cooperativas que deram NP.............: ('0105','0106','0202','0749','0157','0185') 
Cooperativas que ainda nao executaram.: ('0101','0307','0710','0718')


Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0101.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0307.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0710.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 union all
Select IS_DELETED,FNSISTORIG,FNCODROT,FNCODTAR,FCAGENCIA,FDPROCESSA,FDSISTEMA,FCHORA,FCSTATUS,FCIDUSUAR,FCCRITICA,FCVERSAO from ag0718.rtctrl where fncodrot = 147 and fnsistorig = 2 and fdprocessa >= trunc(sysdate)-8 



Select sum(qtd_utilizado),count(0),num_agencia from pacote_tarifa_associado  
where qtd_utilizado > 0 --and num_agencia in ('0101','0307','0710','0718')
group by num_agencia 
*/
