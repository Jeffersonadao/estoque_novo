import 'package:estoque_novo/domain/entities/produto.dart';

class ProdutoModel extends Produto {
  ProdutoModel({
    required super.nome,
    required super.quantidade,
    required super.unidadeMedida,
    super.validade,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'quantidade': quantidade,
      'unidadeMedida': unidadeMedida.name,
      'validade': validade?.millisecondsSinceEpoch,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      nome: map['nome'],
      quantidade: map['quantidade'],
      unidadeMedida: UnidadeMedida.values
          .firstWhere((e) => e.name == map['unidadeMedida']),
      validade: map['validade'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['validade'])
          : null,
    );
  }


}
