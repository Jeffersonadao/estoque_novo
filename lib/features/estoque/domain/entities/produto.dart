enum UnidadeMedida { unidade, quilo, litro }

class Produto {
  final String nome;
  final int quantidade;
  final UnidadeMedida unidadeMedida;
  final DateTime? validade;
  Produto({
    required this.nome,
    required this.quantidade,
    required this.unidadeMedida,
    this.validade,
  });
}
