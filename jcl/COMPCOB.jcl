//COBCOMP JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)                 
//STEP1   EXEC KIKCOBCL                                         
//COPY.SYSUT1 DD DSN=HERC01.KICKS.V1R5M0.COB(CLIPGM),DISP=SHR   
//LKED.SYSIN DD *                                               
 INCLUDE SKIKLOAD(KIKCOBGL)                                     
 NAME CLIPGM(R)                                                 
/*                                                              
