// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:estoque_novo/features/estoque/domain/entities/produto.dart';
import 'package:estoque_novo/features/estoque/domain/repositories/produto_repository.dart';

class AdicionarProdutoUsecase {
  final ProdutoRepository repository;
  AdicionarProdutoUsecase(this.repository);

  Future<void> adicionarProduto(Produto produto) async {
    if (produto.nome.isEmpty) throw Exception("Nome não pode ser vazio");
    if (produto.quantidade < 0)
      throw Exception("Quantidade não pode ser negativa");

    await repository.adicionarProduto(produto);
  }
}
