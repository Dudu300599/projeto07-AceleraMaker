//DEFVSAM  JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1) 
//STEP0    EXEC PGM=IDCAMS                       
//SYSPRINT DD SYSOUT=*                           
//SYSIN    DD *                                  
  DELETE HERC01.KICKS.CLIENTES CLUSTER PURGE     
  SET MAXCC = 0                                  
/*                                               
//STEP1    EXEC PGM=IDCAMS                       
//SYSPRINT DD SYSOUT=*                           
//SYSIN    DD *                                  
  DEFINE CLUSTER (NAME(HERC01.KICKS.CLIENTES) -  
         VOLUMES(TSO002) -                       
         UNIQUE -                                
         TRACKS(1 1) -                           
         INDEXED -                               
         KEYS(6 0) -                             
         RECORDSIZE(71 71) ) -                   
    DATA (NAME(HERC01.KICKS.CLIENTES.DATA)) -    
    INDEX (NAME(HERC01.KICKS.CLIENTES.INDEX))    
/*                                               
//STEP2    EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*                                             
//SYSUT1   DD *                                                    
000001CARLOS EDUARDO                21999998888    RIO DE JANEIRO  
/*                                                                 
//SYSUT2   DD DSN=&&TEMP,DISP=(NEW,PASS),UNIT=SYSDA,               
//            SPACE=(TRK,(1,1)),DCB=(RECFM=FB,LRECL=71,BLKSIZE=71) 
//SYSIN    DD *                                                    
  GENERATE MAXFLDS=1                                               
  RECORD FIELD=(71,1,,1)                                           
/*                                                                 
//STEP3    EXEC PGM=IDCAMS                                         
//SYSPRINT DD SYSOUT=*                                             
//INFILE   DD DSN=&&TEMP,DISP=(OLD,DELETE)                         
//OUTFILE  DD DSN=HERC01.KICKS.CLIENTES,DISP=SHR                   
//SYSIN    DD *                                                    
  REPRO INFILE(INFILE) OUTFILE(OUTFILE)                            
/*                                                                 
//                                                                 
