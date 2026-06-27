# Sistema de Consulta de Clientes (KICKS/Mainframe)

Este é um projeto de demonstração desenvolvido para o ambiente KICKS (emulador CICS) em um sistema mainframe (z/OS). O objetivo é realizar a consulta e atualização de registros de clientes armazenados em um arquivo VSAM.

## Estrutura do Projeto

* **`src/`**: Código-fonte do programa (`CLIPGM.cbl`) e definição do mapa BMS (`MAPSP7.bms`).
* **`jcl/`**: Jobs JCL necessários para automação da compilação e criação do ambiente.

## Pré-requisitos

* Ambiente Hercules/TK5 configurado.
* Acesso ao TSO/ISPF.
* Biblioteca de cópia (Copybook) configurada corretamente.
