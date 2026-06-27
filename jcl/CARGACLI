//CARGACLI JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)                        
//STEP1    EXEC PGM=IEBGENER                                            
//SYSPRINT DD SYSOUT=*                                                  
//SYSUT1   DD *                                                         
000002CARLOS EDUARDO                21999998888    RIO DE JANEIRO      *
/*                                                                      
//SYSUT2   DD DSN=&&TEMP,DISP=(NEW,PASS),UNIT=SYSDA,                    
//            SPACE=(TRK,(1,1)),DCB=(RECFM=FB,LRECL=71,BLKSIZE=71)      
//SYSIN    DD *                                                         
  GENERATE MAXFLDS=1                                                    
  RECORD FIELD=(71,1,,1)                                                
/*                                                                      
//STEP2    EXEC PGM=IDCAMS                                              
//SYSPRINT DD SYSOUT=*                                                  
//IN1      DD DSN=&&TEMP,DISP=(OLD,DELETE)                              
//SYSIN    DD *                                                         
  REPRO INFILE(IN1) OUTDATASET(HERC01.KICKS.CLIENTES)                   
/*                                                                      
//                                                                      
