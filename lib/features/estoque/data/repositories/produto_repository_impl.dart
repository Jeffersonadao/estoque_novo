import 'package:estoque_novo/features/estoque/domain/entities/produto.dart';
import 'package:estoque_novo/features/estoque/domain/repositories/produto_repository.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  final List<Produto> _produtos = [];

  @override
  Future<void> adicionarProduto(Produto produto) async {
    _produtos.add(produto);
  }

  @override
  Future<void> editarProduto(Produto produto) async {
    // vamos deixar vazio por enquanto
  }

  @override
  Future<void> deletarProduto(String id) async {
    // vamos deixar vazio por enquanto
  }

  @override
  Future<void> registrarEntrada(String id, int quantidade) async {
    // depois implementamos
  }

  @override
  Future<void> registrarSaida(String id, int quantidade) async {
    // depois implementamos
  }

  @override
  Future<List<Produto>> listarProdutos() async {
    return _produtos;
  }
}
