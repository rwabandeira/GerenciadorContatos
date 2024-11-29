
# Gerenciador de Contatos

## Descrição
O **Gerenciador de Contatos** é um aplicativo desenvolvido em Flutter para gerenciamento de contatos, 
permitindo realizar operações de CRUD (Criar, Ler, Atualizar e Deletar). Ele foi desenvolvido para 
utiliza o banco de dados local SQLite para armazenar os dados de forma eficiente e persistente.

## Funcionalidades
    • Cadastro de contatos: Adiciona novos contatos com nome, telefone e e-mail.
    • Listagem de contatos: Visualiza os contatos cadastrados com detalhes expandidos.
    • Edição de contatos: Atualiza as informações de contatos já existentes.
    • Exclusão de contatos: Remoção de contatos selecionado e que não são mais necessários.

## Tecnologias Utilizadas
    • Flutter: Framework para o desenvolvimento da aplicação.
    • SQLite: Banco de dados local para persistência dos dados.
    • sqflite_ffi: Biblioteca para integração do SQLite com o Flutter.

## Estrutura do Projeto
    • lib/main.dart: Arquivo principal que inicializa a aplicação.
    • lib/telas:
        ◦ menu_principal.dart: Tela inicial com as opções de cadastrar e listar do APP.
        ◦ listar_contato.dart: Tela para listar e gerenciar os contatos.
        ◦ gerenciar_contato.dart: Tela para cadastrar/editar um contato.
    • lib/modelos/contato.dart: Modelagem de dados para os contatos.
    • lib/banco_dados/db.dart: Gerenciador do banco de dados SQLite.

## Pré-requisitos
    • Flutter SDK instalado (versão mínima: 3.0.0).
    • Dart SDK.
    • Editor de código (recomendado: Visual Studio Code ou Android Studio).

## Configuração do Ambiente
    1. Clone este repositório:
        ◦ git clone https://github.com/rwabandeira/GerenciadorContatos.git
       
    2. Navegue até a pasta do projeto:
        ◦ cd gerenciador-contatos

    3. Instale as dependências:
        ◦ flutter pub get

    4. Execute o aplicativo:
        ◦ flutter run

## Como Usar
    1. Abra o aplicativo.
    2. Na tela inicial, escolha uma das opções:
        ◦ Cadastrar: Adicione um novo contato preenchendo os campos obrigatórios.
        ◦ Listar: Visualize os contatos cadastrados e gerencie-os (editar ou excluir).
    3. Os dados serão armazenados localmente no dispositivo, utilizando SQLite.

## Contribuindo
Contribuições são bem-vindas! Para contribuir, faça um clone do repositório, crie uma nova branch para o desenvolvimento das novas funcionalidade, realize suas alterações e faça o commit. Envie as alterações feitas para o git. Não se esqueça de fazer um Pull Request descrevendo suas alterações.

## Licença
Este projeto está sob a licença MIT. Consulte o arquivo LICENSE para mais informações.

## Contato
Para dúvidas ou sugestões, entre em contato:

    • Nome do Desenvolvedor: Robson Araújo
    • E-mail: rwabandeira@gmail.com
    • GitHub: rwabandeira
