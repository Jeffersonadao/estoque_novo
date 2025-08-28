import 'package:estoque_novo/features/estoque/domain/entities/produto.dart';
import 'package:estoque_novo/features/estoque/presentation/controllers/produto_controller.dart';
import 'package:estoque_novo/features/estoque/presentation/pages/add_edit_produto.dart';
import 'package:estoque_novo/features/estoque/presentation/widgets/barra_navegacao.dart';
import 'package:estoque_novo/features/estoque/presentation/widgets/card_produto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<ProdutoController>();

  @override
  void initState() {
    super.initState();
    controller.carregarProdutos(); // carregar produtos existentes
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Meu Estoque')),
        body: Obx(() {
          if (controller.produtos.isEmpty) {
            return Center(child: Text('Nenhum produto Cadastrado'));
          }
          return ListView.builder(
            itemCount: controller.produtos.length,
            itemBuilder: (context, index) {
              final produto = controller.produtos[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CardProduto(produto: produto),
              );
            },
          );
        }),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddEditProduto());
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
