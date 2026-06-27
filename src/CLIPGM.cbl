       IDENTIFICATION DIVISION.                            
       PROGRAM-ID. CLIPGM.                                 
                                                           
       ENVIRONMENT DIVISION.                               
                                                           
       DATA DIVISION.                                      
       WORKING-STORAGE SECTION.                            
                                                           
       01  WS-CLIENTE-REG.                                 
           05 WS-CODCLI     PIC X(06).                     
           05 WS-NOME       PIC X(30).                     
           05 WS-TELEFONE   PIC X(15).                     
           05 WS-CIDADE     PIC X(20).                     
                                                           
       01  WS-COMMAREA      PIC X(06).                     
       01  WS-RESP          PIC S9(8) COMP.                
       01  WS-MSG-ERRO.                                    
           05 FILLER      PIC X(11) VALUE 'ERRO VSAM: '.   
           05 WS-COD-ERRO PIC 9(08).                                                                           
        COPY MAPCLIE.                                                    
        COPY DFHAID.                                                     
                                                                         
        LINKAGE SECTION.                                                 
        01  DFHCOMMAREA      PIC X(06).                                  
                                                                         
        PROCEDURE DIVISION.                                              
        000-MAIN.                                                        
            IF EIBCALEN = 0                                              
               PERFORM 100-INICIALIZA-TELA                               
            ELSE                                                         
               PERFORM 200-PROCESSA-TELA.                                
                                                                         
            EXEC CICS RETURN END-EXEC.                                   
                                                                         
        100-INICIALIZA-TELA.                                             
            MOVE LOW-VALUES TO TELACLIO.                                 
            EXEC CICS SEND                                               
                     MAP('TELACLI')                                     
                     MAPSET('MAPCLIE')                                  
                     ERASE                                              
           END-EXEC.                                                    
                                                                        
           EXEC CICS RETURN                                             
                     TRANSID('CLIE')                                    
                     COMMAREA(WS-COMMAREA)                              
                     LENGTH(6)                                          
           END-EXEC.                                                    
                                                                        
       200-PROCESSA-TELA.                                               
           EXEC CICS RECEIVE                                            
                     MAP('TELACLI')                                     
                     MAPSET('MAPCLIE')                                  
                     RESP(WS-RESP)                                      
           END-EXEC.                                                    
                                                                        
           IF EIBAID = DFHPF3                                           
              EXEC CICS RETURN END-EXEC.                                
           IF EIBAID = DFHPF5
              PERFORM 300-CONSULTAR.                                
           IF EIBAID = DFHPF6                                       
              PERFORM 400-SALVAR.                                   
                                                                    
           IF EIBAID NOT = DFHPF3 AND EIBAID NOT = DFHPF5           
              AND EIBAID NOT = DFHPF6                               
              MOVE 'TECLA INVALIDA.' TO MENSAGMO                    
              PERFORM 900-ENVIA-TELA.                               
       300-CONSULTAR.                                               
                                                                    
           MOVE CODCLII TO WS-CODCLI.                               
           MOVE CODCLII TO WS-COMMAREA.                             
           EXEC CICS READ                                           
                     DATASET('CLIENTES')                            
                     INTO(WS-CLIENTE-REG)                           
                     RIDFLD(WS-CODCLI)                              
                     RESP(WS-RESP)                                  
           END-EXEC.                                                
                                                               
           IF WS-RESP = DFHRESP(NORMAL)                       
              MOVE WS-NOME     TO NOMEO                       
              MOVE WS-TELEFONE TO TELEFONO                    
              MOVE WS-CIDADE   TO CIDADEO                     
              MOVE 'CLIENTE ENCONTRADO.' TO MENSAGMO          
           ELSE                                               
              MOVE WS-RESP TO WS-COD-ERRO                     
              MOVE WS-MSG-ERRO TO MENSAGMO.                   
           PERFORM 900-ENVIA-TELA.                            
                                                              
       400-SALVAR.                                            
                                                              
           MOVE KIKCOMMAREA TO WS-CODCLI.                     
           MOVE KIKCOMMAREA TO WS-COMMAREA.                   
           EXEC CICS READ                                     
                     DATASET('CLIENTES')                      
                     INTO(WS-CLIENTE-REG)                     
                     RIDFLD(WS-CODCLI)                        
                     UPDATE                                   
                     RESP(WS-RESP)
           END-EXEC.                                                    
                                                                        
           IF WS-RESP = DFHRESP(NORMAL)                                 
              PERFORM 450-GRAVAR                                        
           ELSE                                                         
              MOVE 'CLIENTE NAO ENCONTRADO P/ ATUALIZAR.' TO MENSAGMO.  
           PERFORM 900-ENVIA-TELA.                                      
                                                                        
       450-GRAVAR.                                                      
           IF NOMEI NOT = LOW-VALUES                                    
           IF NOMEI NOT = SPACES                                        
              MOVE NOMEI TO WS-NOME.                                    
           IF TELEFONI NOT = LOW-VALUES                                 
           IF TELEFONI NOT = SPACES                                     
              MOVE TELEFONI TO WS-TELEFONE.                             
           IF CIDADEI NOT = LOW-VALUES                                  
           IF CIDADEI NOT = SPACES                                      
              MOVE CIDADEI TO WS-CIDADE.                                
                                                                        
           EXEC CICS REWRITE
                     DATASET('CLIENTES')                                
                     FROM(WS-CLIENTE-REG)                               
                     RESP(WS-RESP)                                      
           END-EXEC.                                                    
           IF WS-RESP = DFHRESP(NORMAL)                                 
              MOVE 'ALTERACAO REALIZADA COM SUCESSO.' TO MENSAGMO       
           ELSE                                                         
              MOVE 'ERRO AO GRAVAR.' TO MENSAGMO.                       
                                                                        
       900-ENVIA-TELA.                                                  
           EXEC CICS SEND                                               
                     MAP('TELACLI')                                     
                     MAPSET('MAPCLIE')                                  
                     DATAONLY                                           
           END-EXEC.                                                    
                                                                        
           EXEC CICS RETURN                                             
                     TRANSID('CLIE')                                    
                     COMMAREA(WS-COMMAREA)
                     LENGTH(6)                                         
           END-EXEC.                                                   
                                                                       

                                                           
