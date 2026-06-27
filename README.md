# Sistema de Consulta de Clientes (KICKS/Mainframe)

Este é um projeto de demonstração desenvolvido para o ambiente KICKS (emulador CICS) em um sistema mainframe (z/OS). O objetivo é realizar a consulta e atualização de registros de clientes armazenados em um arquivo VSAM.

## Estrutura do Projeto

* **`src/`**: Código-fonte do programa (`CLIPGM.cbl`) e definição do mapa BMS (`MAPSP7.bms`).
* **`jcl/`**: Jobs JCL necessários para automação da compilação e criação do ambiente.

## Pré-requisitos

* Ambiente Hercules/TK5 configurado.
* Acesso ao TSO/ISPF.
* Biblioteca de cópia (Copybook) configurada corretamente.

## Como Executar

1.  **Preparar VSAM**: Submeta o job `VSAMP7.jcl` para criar o cluster VSAM necessário para armazenar os dados.
2.  **Compilar Mapa**: Submeta o job de compilação do mapa (`MAPSP7`) para gerar o binário da tela e o arquivo de cópia (Copybook).
3.  **Compilar Programa**: Submeta o job `COMPCOB.jcl` para realizar a pré-compilação, compilação COBOL e Link-Edit do programa.
4.  **Executar**: No terminal KICKS, execute a transação correspondente (ex: `CLIE`).