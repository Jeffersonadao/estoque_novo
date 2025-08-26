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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Meu Estoque')),
        body: ListView(children: [CardProduto()]),
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
