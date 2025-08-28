import 'dart:io';

import 'package:estoque_novo/features/estoque/domain/entities/produto.dart';
import 'package:flutter/material.dart';

class CardProduto extends StatelessWidget {
  final Produto produto; // 🟢 receber produto

  const CardProduto({super.key, required this.produto});

  String unidadeParaString(UnidadeMedida unidade, String? unidadeOriginal) {
    switch (unidade) {
      case UnidadeMedida.unidade:
        if (unidadeOriginal == 'g') return 'gr';
        if (unidadeOriginal == 'ml') return 'ml';
        return 'un';
      case UnidadeMedida.quilo:
        return 'kg';
      case UnidadeMedida.litro:
        return 'L';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                produto.imagemPath != null
                    ? Image.file(
                      File(produto.imagemPath!),
                      height: 110,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                    : const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey,
                    ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.nome,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Quantidade: ${produto.quantidade} ${unidadeParaString(produto.unidadeMedida, produto.unidadeOriginal)}",
                  ),

                  Text(
                    "Validade: ${produto.validade!.day.toString().padLeft(2, '0')}/${produto.validade!.month.toString().padLeft(2, '0')}/${produto.validade!.year}",
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit_outlined, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_shopping_cart_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
