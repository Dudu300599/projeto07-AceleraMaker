IDENTIFICATION DIVISION.
       PROGRAM-ID. CLIPGM.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-COMMAREA          PIC X(01).
       01  WS-RESP              PIC S9(8) COMP.
       
       01  REG-CLIENTE.
           05 REG-CODCLI        PIC 9(06).
           05 REG-NOME          PIC X(30).
           05 REG-TELEFONE      PIC X(15).
           05 REG-CIDADE        PIC X(20).

       COPY MAPCLIE. 

       LINKAGE SECTION.
       01  DFHCOMMAREA          PIC X(01).

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           IF EIBCALEN = 0
               PERFORM MANDA-TELA-VAZIA
           ELSE
               PERFORM RECEBE-TELA
               PERFORM AVALIA-TECLA.
           
           * O GOBACK garante que o programa encerre caso fuja do fluxo
           GOBACK.

       MANDA-TELA-VAZIA.
           EXEC CICS SEND 
                MAP('TELA1') MAPSET('MAPCLIE') ERASE
           END-EXEC.
           EXEC CICS RETURN 
                TRANSID('CLIE') COMMAREA(WS-COMMAREA) LENGTH(1)
           END-EXEC.

       RECEBE-TELA.
           EXEC CICS RECEIVE 
                MAP('TELA1') MAPSET('MAPCLIE')
           END-EXEC.

       AVALIA-TECLA.
           IF EIBAID = DFHPF3
               EXEC CICS RETURN END-EXEC
           ELSE
               IF EIBAID = DFHPF5
                   PERFORM FLUXO-CONSULTA
               ELSE
                   IF EIBAID = DFHPF6
                       PERFORM FLUXO-SALVAR
                   ELSE
                       MOVE 'TECLA INVALIDA.' TO MENSAGO
                       PERFORM REENVIA-TELA.

       FLUXO-CONSULTA.
           MOVE CODCLII TO REG-CODCLI.
           EXEC CICS READ 
                DATASET('CLIENTES')
                INTO(REG-CLIENTE)
                RIDFLD(REG-CODCLI)
                RESP(WS-RESP)
           END-EXEC.
           
           IF WS-RESP = DFHRESP(NORMAL)
               MOVE REG-NOME TO NOMEO
               MOVE REG-TELEFONE TO TELEFO
               MOVE REG-CIDADE TO CIDADEO
               MOVE 'CLIENTE ENCONTRADO.' TO MENSAGO
           ELSE
               MOVE 'CLIENTE NAO ENCONTRADO.' TO MENSAGO.
           
           PERFORM REENVIA-TELA.

       FLUXO-SALVAR.
           MOVE TELEFI TO REG-TELEFONE.
           MOVE CIDADEI TO REG-CIDADE.
           EXEC CICS REWRITE 
                DATASET('CLIENTES')
                FROM(REG-CLIENTE)
           END-EXEC.
           
           MOVE 'ALTERACAO REALIZADA.' TO MENSAGO.
           PERFORM REENVIA-TELA.

       REENVIA-TELA.
           EXEC CICS SEND 
                MAP('TELA1') MAPSET('MAPCLIE')
           END-EXEC.
           EXEC CICS RETURN 
                TRANSID('CLIE') COMMAREA(WS-COMMAREA) LENGTH(1)
           END-EXEC.