	fec='01/04/2018'
	fec2='31/05/2018'
	ssssi='SI'
	firmodebi=0
	cuar='45'
	bnf='03'
	bnf1='63'
	bnf2='46'
	actico='Activo'
	cerouno='01'
	obsv='AJUSTE CORRESPONDIENTE AL MES DE ABRIL/2018'
	conectar()
	   SQLEXEC(gncone,'select c.tipo_venta,c.nro_cont,x.tipo,x.nro_cuota,x.importe,x.saldo,x.fec_ven,x.cobrador,x.concepto,i.montonuevo,i.montoviejo,i.fecha_recepcion;
	      '+' from CONTRATOS c inner join IMPORTE_ANTERIOR i on c.nro_cont=i.nro_cont;
	      '+' inner join CUODETALLE x on c.nro_cont=x.nro_cont where c.estado=?actico and x.tipo_venta in (?bnf,?bnf1) and i.recepcionado=?ssssi;
	      '+' and i.firmo=?firmodebi and x.concepto=?cerouno  and x.fec_ven between ?fec and ?fec2 and x.saldo>0;
	      '+' order by i.fecha_recepcion','cur_modifi')
	      
*!*		     
*!*		     SQLEXEC(gncone,' SELECT nro_cont from CUODETALLE where obs=?obsv and nro_cont in (  select x.nro_cont;
*!*		      '+' from CONTRATOS c inner join IMPORTE_ANTERIOR i on c.nro_cont=i.nro_cont;
*!*		      '+' inner join CUODETALLE x on c.nro_cont=x.nro_cont where c.estado=?actico and x.tipo_venta in (?bnf,?bnf1,?bnf2) and i.recepcionado=?ssssi;
*!*		      '+' and i.firmo=?firmodebi and x.concepto=?cerouno and x.fec_ven between ?fec and ?fec2 ) group by nro_cont','cur_nose')
*!*		     
*!*		     
*!*		     
*!*		     SQLEXEC(gncone,'select a.*, c.tipo_venta,c.fec_ven from IMPORTE_ANTERIOR a inner join CUODETALLE c on a.nro_cont=c.nro_cont;
*!*	             '+' where  recepcionado = ?ssssi AND firmo = ?firmodebi and c.tipo_venta in (?bnf,?bnf1,?bnf2) and c.fec_ven between ?fec and ?fec2 and c.concepto=?cerouno','cur_nofirmaron')
*!*		     
*!*		    
	desconectar()
	
	
	
	
	
	
	***PARA ACTUALIZAR MONTO DE MAYO A LOS QUE NO FIRMARON DEBITOS
SELECT nro_cont,montoviejo,fec_ven,tipo,nro_cuota,cobrador,concepto,tipo_venta FROM cur_modifi INTO CURSOR cur_insert READWRITE 
	SET STEP ON
	conectar()
	
	  SELECT cur_insert
	  GO TOP 
	  
	  SCAN 
	     v_se=cur_insert.montoviejo
	     vcont=cur_insert.nro_cont
	     fevenci=cur_insert.fec_ven
	               SQLEXEC(gncone,'update cuodetalle set importe=?v_se, saldo=?v_se where nro_cont=?vcont and fec_ven=?fevenci')
	     SELECT cur_insert
	  ENDSCAN    
	desconectar()
	
SET STEP ON	
	
	
	hoy=DATE(2018,04,16)
	SELECT nro_cont,(montonuevo-montoviejo) as monto,fec_ven,tipo,nro_cuota,cobrador,concepto,tipo_venta FROM cur_modifi INTO CURSOR cur_insert READWRITE 
	SET STEP ON
	SELECT cur_insert 
	GO TOP
	conectar() 
		SCAN 
		   v_nrocon=cur_insert.nro_cont
		   v_monto=cur_insert.monto
		   
		   v_tipo=cur_insert.tipo
		   v_nrocuo=cur_insert.nro_cuota
		   v_fecven=TTOD(cur_insert.fec_ven)
		   v_conce=cur_insert.concepto
		   v_ventipo=cur_insert.tipo_venta
		   v_obs='AJUSTE CORRESPONDIENTE AL MES DE ABRIL/2018'
		   v_cobra=cur_insert.cobrador
		   DO case 
		      CASE  v_nrocuo<=10
		       
			        counter = 1
					maxi=2
					DO WHILE counter <= maxi
					   
					       dividido=ROUND((v_monto/2),0)
					       v_cuotnro=v_nrocuo+1
					       v_fecven=v_fecven+30
					       
					       SQLEXEC(gncone,'insert into cuodetalle (nro_cont,tipo,fec_ven,nro_cuota,importe,saldo,obs,cobrador,concepto,tipo_venta);
					         '+' values (?v_nrocon, ?v_tipo, ?v_fecven, ?v_cuotnro, ?dividido, ?dividido, ?v_obs, ?v_cobra, ?v_conce, ?v_ventipo)')
					         
					      counter = counter + 1  
					      *v_cuotnro=v_cuotnro +1
					       v_fecven=v_fecven
					ENDDO       
		       
		       
		       
              CASE v_nrocuo>10 AND v_nrocuo<=11  
                  
                  
		         counter = 1
				 maxi=2
					DO WHILE counter <= maxi
					   
					       dividido=ROUND((v_monto/2),0)
					       v_cuotnro=v_nrocuo+1
					       v_fecven=v_fecven+30
					       
					       SQLEXEC(gncone,'insert into cuodetalle (nro_cont,tipo,fec_ven,nro_cuota,importe,saldo,obs,cobrador,concepto,tipo_venta);
					         '+' values (?v_nrocon, ?v_tipo, ?v_fecven, ?v_cuotnro, ?dividido, ?dividido, ?v_obs, ?v_cobra, ?v_conce, ?v_ventipo)')
					         
					      counter = counter + 1  
					      
					      IF  v_cuotnro=12
					             v_cuotnro=0
					             v_tipo='1R'
					      ENDIF    
					      
					       v_fecven=v_fecven
					ENDDO   
              	
              
              
              
              CASE  v_nrocuo=12 
	              v_cuotnro = 0
                  v_tipo='1R'
		         counter = 1
				 maxi=2
				DO WHILE counter <= maxi
				   
				       dividido=ROUND((v_monto/2),0)
				        v_cuotnro=v_nrocuo+1
				       v_fecven=v_fecven+30
				       
				       SQLEXEC(gncone,'insert into cuodetalle (nro_cont,tipo,fec_ven,nro_cuota,importe,saldo,obs,cobrador,concepto,tipo_venta);
				         '+' values (?v_nrocon, ?v_tipo, ?v_fecven, ?v_cuotnro, ?dividido, ?dividido, ?v_obs, ?v_cobra, ?v_conce, ?v_ventipo)')
				         
				      counter = counter + 1  
				    
				       v_fecven=v_fecven
				ENDDO   
		      
		              
		       

		ENDCASE    

		     
		   
		   SELECT cur_insert 
		ENDSCAN 

	desconectar()