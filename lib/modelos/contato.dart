class Contato {
  final int? id;
  final String nome;
  final String telefone;
  final String email;

  Contato({
    this.id,
    required this.nome,
    required this.telefone,
    required this.email,
  });

  // Converte o Contato para Map (para inserção no banco)
  Map<String, dynamic> paraMapa() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  // Converte Map para Contato
  factory Contato.deMapa(Map<String, dynamic> mapa) {
    return Contato(
      id: mapa['id'],
      nome: mapa['nome'],
      telefone: mapa['telefone'],
      email: mapa['email'],
    );
  }
}
