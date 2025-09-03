LPARAMETERS x 
*SET STEP ON
  IF USED('&x')
     SELECT &x
     USE
  ENDIF    
