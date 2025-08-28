import 'package:get/get.dart';
import 'package:estoque_novo/features/estoque/domain/entities/produto.dart';
import 'package:estoque_novo/features/estoque/domain/usecases/adicionar_produto_usecase.dart';
import 'package:estoque_novo/features/estoque/domain/repositories/produto_repository.dart';

class ProdutoController extends GetxController {
  final AdicionarProdutoUsecase adicionarProdutoUsecase;
  final ProdutoRepository repository;

  ProdutoController({
    required this.adicionarProdutoUsecase,
    required this.repository,
  });

  var produtos = <Produto>[].obs;

  Future<void> adicionarProduto(Produto produto) async {
    await adicionarProdutoUsecase.adicionarProduto(produto);
    produtos.assignAll(await repository.listarProdutos());
  }

  Future<void> carregarProdutos() async {
    produtos.assignAll(await repository.listarProdutos());
  }
}
