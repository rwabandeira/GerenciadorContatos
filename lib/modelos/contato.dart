class Contato {
  // Identificador único do contato (pode ser nulo para novos registros)
  final int? id;
  // Nome do contato
  final String nome;
  // Número de telefone do contato
  final String telefone;
  // Endereço de email do contato
  final String email;

  /* 
    Construtor da classe Contato
    Os parâmetros 'nome', 'telefone' e 'email' são obrigatórios.
    O 'id' é atribuído pelo banco de dados.
  */
  Contato({
    this.id,
    required this.nome,
    required this.telefone,
    required this.email,
  });

  /*
    Converte um objeto Contato em um mapa para ser inserido ou atualizado no banco de dados.
    Cada chave do mapa corresponde a um campo da tabela no banco de dados.
  */
  Map<String, dynamic> paraMapa() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  /*
    Cria uma instância de Contato a partir de um mapa.
    Útil para converter os dados retornados do banco de dados em objetos Contato.
  */
  factory Contato.deMapa(Map<String, dynamic> mapa) {
    return Contato(
      id: mapa['id'],
      nome: mapa['nome'],
      telefone: mapa['telefone'],
      email: mapa['email'],
    );
  }
}