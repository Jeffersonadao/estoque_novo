import 'package:estoque_novo/domain/entities/produto.dart';

abstract class ProdutoRepository {
  Future<void> adicionarProduto(Produto produto);
  Future<void> editarProduto(Produto produto);
  Future<void> deletarProduto(String id);
  Future<void> registrarEntrada(String id, int quantidade);
  Future<void> registrarSaida(String id, int quantidade);
  Future<List<Produto>> listarProdutos();
}
