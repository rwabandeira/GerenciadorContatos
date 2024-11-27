Gerenciador de Contatos

Descrição
O Gerenciador de Contatos é um aplicativo desenvolvido em Flutter para gerenciamento de contatos, permitindo realizar operações de CRUD (Criar, Ler, Atualizar e Deletar). Ele foi desenvolvido para utiliza o banco de dados local SQLite para armazenar os dados de forma eficiente e persistente.

Funcionalidades
    • Cadastro de contatos: Adiciona novos contatos com nome, telefone e e-mail.
    • Listagem de contatos: Visualiza os contatos cadastrados com detalhes expandidos.
    • Edição de contatos: Atualiza as informações de contatos já existentes.
    • Exclusão de contatos: Remoção de contatos selecionado e que não são mais necessários.

Tecnologias Utilizadas
    • Flutter: Framework para o desenvolvimento da aplicação.
    • SQLite: Banco de dados local para persistência dos dados.
    • sqflite_ffi: Biblioteca para integração do SQLite com o Flutter.

Estrutura do Projeto
    • lib/main.dart: Arquivo principal que inicializa a aplicação.
    • lib/telas:
        ◦ menu_principal.dart: Tela inicial com as opções de cadastrar e listar do APP.
        ◦ listar_contato.dart: Tela para listar e gerenciar os contatos.
        ◦ gerenciar_contato.dart: Tela para cadastrar/editar um contato.
    • lib/modelos/contato.dart: Modelagem de dados para os contatos.
    • lib/banco_dados/db.dart: Gerenciador do banco de dados SQLite.

Pré-requisitos
    • Flutter SDK instalado (versão mínima: 3.0.0).
    • Dart SDK.
    • Editor de código (recomendado: Visual Studio Code ou Android Studio).