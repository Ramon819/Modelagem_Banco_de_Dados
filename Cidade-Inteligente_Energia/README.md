?? Banco de Dados de Energia e Linhas de Transmissão
Este projeto define o modelo de banco de dados responsável por organizar informações sobre fontes de energia, linhas de transmissão, falhas, níveis de tensão e seus respectivos status operacionais.
O objetivo é criar uma estrutura robusta, normalizada e clara para análise e manutenção do sistema elétrico.

??? 1. Estrutura do Banco de Dados
Abaixo estão todas as tabelas do sistema, com seus campos e relações apresentadas de forma visual.

?? Tabela: tipo_energia
CampoTipoDescriçãoid_tipoINTEGER (PK)Identificador único do tiponome_tipoVARCHAR(50)Nome do tipo de energia
?? Tabela: categoria_energia
CampoTipoDescriçãoid_categoriaINTEGER (PK)Identificador da categorianome_categoriaVARCHAR(50)Nome da categoriaid_tipoINTEGER (FK)Relaciona com tipo_energiaRelação:
? 1 Tipo de Energia ? N Categorias

?? Tabela: status_fonte
CampoTipoDescriçãoid_statusINTEGER (PK)ID do statusdescricaoVARCHAR(30)Ex: Operacional, Em manutenção
?? Tabela: fonte_energia
CampoTipoDescriçãoid_fonteINTEGER (PK)Identificador da fontenome_fonteVARCHAR(100)Nome da usina/fonte de energiacapacidade_mwDECIMAL(10,2)Capacidade instaladaid_categoriaINTEGER (FK)Categoria da fonteid_statusINTEGER (FK)Status operacionalRelações:
? Categoria Energia (1:N) Fontes
? Status Fonte (1:N) Fontes

?? Tabela: status_linha
CampoTipoDescriçãoid_statusINTEGER (PK)IdentificadordescricaoVARCHAR(30)Situação da linha
?? Tabela: linha_transmissao
CampoTipoDescriçãoid_linhaINTEGER (PK)Identificador da linhatensao_kvDECIMAL(10,2)Tensão da linha (kV)comprimento_kmDECIMAL(10,2)Extensão da linha (km)capacidade_mwDECIMAL(10,2)Capacidade máximaid_statusINTEGER (FK)Situação da linha
?? Tabela: falha_linha
CampoTipoDescriçãoid_falhaINTEGER (PK)Identificador da falhadescricaoVARCHAR(100)Tipo de falha registrada? Erro corrigido: substituído 4G ? 4

?? Tabela: linha_falha
CampoTipoDescriçãoid_linhaINTEGER (FK)Linha que sofreu falhaid_falhaINTEGER (FK)Tipo de falhadata_registroTIMESTAMPData e hora do registro da falhaChave Primária Composta:
(id_linha, id_falha, data_registro)
Relação:
? N Falhas ? N Linhas

?? Tabela: nivel_tensao
CampoTipoDescriçãoid_nivelINTEGER (PK)Identificador do níveldescricaoVARCHAR(50)Ex: AT, MT, BT, EAT
?? Tabela: linha_nivel_tensao
CampoTipoDescriçãoid_linhaINTEGER (FK)Linha registradaid_nivelINTEGER (FK)Nível de tensão associadoChave Primária:
(id_linha, id_nivel)

?? 2. Dados Inseridos (População Inicial)
O script já inclui dados padrão para:
? Tipos de energia
? Categorias
? Status de fontes
? Status de linhas
? Tipos de falhas (corrigido)
? Níveis de tensão
? Fontes de energia cadastradas
? Linhas de transmissão
? Falhas registradas
? Relação linha ? nível de tensão
Todos usando:
ON CONFLICT DO NOTHING
Para evitar erro ao rodar o script mais de uma vez.

?? 3. Objetivo do Sistema
Este banco foi construído para:
* Gerenciar usinas e suas categorias
* Registrar o status operacional das fontes
* Controlar linhas de transmissão e suas falhas
* Categorizar linhas por nível de tensão
* Criar uma base sólida para dashboards, relatórios e análises
É um modelo útil para sistemas de monitoramento elétrico, supervisão energética, smart grid e estudos acadêmicos.


