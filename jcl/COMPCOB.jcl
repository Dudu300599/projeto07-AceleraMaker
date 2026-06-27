//COMPCOB  JOB CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1)                       
//*----------------------------------------------------------------*   
//* PASSO 1: TRADUTOR CICS (ROTEAMENTO DO CODIGO CORRIGIDO)            
//*----------------------------------------------------------------*   
//PP       EXEC PGM=KIKPPCOB                                           
//STEPLIB  DD DSN=HERC01.KICKSSYS.V1R5M0.SKIKLOAD,DISP=SHR             
//SYSLIB   DD DSN=HERC01.KICKS.V1R5M0.COBCOPY,DISP=SHR                 
//SYSUDUMP DD SYSOUT=*                                                 
//SYSTERM  DD SYSOUT=*                                                 
//SYSPRINT DD DSN=&&PPCOB,DISP=(,PASS),UNIT=SYSDA,                     
//            SPACE=(TRK,(90,15)),DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120) 
//SYSIN    DD DSN=HERC01.KICKS.V1R5M0.COB(CLIPGM),DISP=SHR             
//*----------------------------------------------------------------*   
//* PASSO 2: COMPILADOR COBOL NATIVO                                   
//*----------------------------------------------------------------*   
//COB      EXEC PGM=IKFCBL00,PARM='LOAD,NODECK,SIZE=2048K',COND=(5,LT) 
//STEPLIB  DD DSN=SYS1.LINKLIB,DISP=SHR                                
//SYSLIB   DD DSN=HERC01.KICKS.V1R5M0.COBCOPY,DISP=SHR                 
//SYSUT1   DD UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT2   DD UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT3   DD UNIT=SYSDA,SPACE=(CYL,(5,5))
//SYSUT4   DD UNIT=SYSDA,SPACE=(CYL,(5,5))                              
//SYSPUNCH DD DUMMY                                                     
//SYSPRINT DD SYSOUT=*                                                  
//SYSIN    DD DSN=&&PPCOB,DISP=(OLD,DELETE)                             
//SYSLIN   DD DSN=&&OBJ,DISP=(,PASS),UNIT=SYSDA,SPACE=(TRK,(15,15))     
//*----------------------------------------------------------------*    
//* PASSO 3: LINK-EDITOR                                                
//*----------------------------------------------------------------*    
//LKED     EXEC PGM=IEWL,PARM='LIST,XREF,LET',COND=(5,LT)               
//SYSLIN   DD DSN=&&OBJ,DISP=(OLD,DELETE)                               
//SYSUT1   DD UNIT=SYSDA,SPACE=(CYL,(5,5))                              
//SYSPRINT DD SYSOUT=*                                                  
//SYSLMOD  DD DSN=HERC01.KICKS.V1R5M0.KIKRPL(CLIPGM),DISP=SHR           
//                                                                                                   