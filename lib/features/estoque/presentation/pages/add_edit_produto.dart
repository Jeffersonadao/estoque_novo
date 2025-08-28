import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:estoque_novo/features/estoque/domain/entities/produto.dart';
import 'package:estoque_novo/features/estoque/presentation/controllers/produto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddEditProduto extends StatefulWidget {
  const AddEditProduto({super.key});

  @override
  State<AddEditProduto> createState() => _AddEditProdutoState();
}

class _AddEditProdutoState extends State<AddEditProduto> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final TextEditingController validadeController = TextEditingController();
  String unidadeSelecionada = 'un';

  final controller = Get.find<ProdutoController>();

  File? imagemSelecionada;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  String? imagemPath;

  UnidadeMedida converterUnidade(String valor) {
    switch (valor) {
      case 'un':
        return UnidadeMedida.unidade;
      case 'kg':
        return UnidadeMedida.quilo;
      case 'L':
        return UnidadeMedida.litro;
      default:
        return UnidadeMedida
            .unidade; // padrão para valores que não existem no enum
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Produto')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Produto',
                    hintText: 'Digite o nome do Produto',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira o nome do produto";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),

                Row(
                  children: [
                    // Campo numérico
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: quantidadeController,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade',
                          hintText: 'Digite a quantidade',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Dropdown de unidade
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Unidade',
                          border: OutlineInputBorder(),
                        ),
                        value: 'un', // valor inicial
                        items: const [
                          DropdownMenuItem(value: 'un', child: Text('Un')),
                          DropdownMenuItem(value: 'kg', child: Text('Kg')),
                          DropdownMenuItem(value: 'g', child: Text('g')),
                          DropdownMenuItem(value: 'L', child: Text('L')),
                          DropdownMenuItem(value: 'ml', child: Text('ml')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            // Aqui você pode salvar a unidade escolhida em uma variável
                            unidadeSelecionada = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                TextFormField(
                  controller: validadeController,
                  decoration: InputDecoration(
                    labelText: 'Validade',
                    hintText: 'dd/mm/aaaa',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira a data de validade';
                    }

                    try {
                      final date = DateFormat('dd/MM/yyyy').parseStrict(value);
                      final hoje = DateTime.now();

                      if (date.isBefore(hoje)) {
                        return 'A validade deve ser futura';
                      }
                    } catch (e) {
                      return 'Data inválida';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 35),

                Column(
                  children: [
                    // Preview da imagem
                    if (imagemSelecionada != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          imagemSelecionada!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Nenhuma imagem selecionada"),
                        ),
                      ),
                    const SizedBox(height: 10),

                    // Botão escolher imagem
                    ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder:
                              (context) => Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text("Tirar Foto"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text("Escolher da Galeria"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                        );
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("Selecionar Imagem"),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    // 1. Pegar valores dos controllers
                    final nome = nomeController.text;
                    final quantidadeTexto = quantidadeController.text;
                    final unidade = converterUnidade(unidadeSelecionada);

                    // 2. Validar campos obrigatórios
                    if (nome.isEmpty || quantidadeTexto.isEmpty) {
                      Get.snackbar(
                        'Erro',
                        'Preencha todos os campos obrigatórios',
                      );
                      return;
                    }

                    // 3. Converter quantidade para int
                    final quantidade = int.tryParse(quantidadeTexto);
                    if (quantidade == null) {
                      Get.snackbar('Erro', 'Quantidade inválida');
                      return;
                    }

                    // 4. Converter validade para DateTime
                    DateTime? validade;
                    try {
                      validade = DateFormat(
                        'dd/MM/yyyy',
                      ).parseStrict(validadeController.text);
                    } catch (e) {
                      Get.snackbar('Erro', 'Data de validade inválida');
                      return;
                    }

                    final hoje = DateTime.now();
                    if (validade.isBefore(hoje.add(Duration(days: 1)))) {
                      Get.snackbar(
                        'Erro',
                        'A validade deve ser uma data futura',
                      );
                      return;
                    }

                    // 5. Criar objeto Produto
                    final produto = Produto(
                      nome: nome,
                      quantidade: quantidade,
                      unidadeMedida: unidade,
                      unidadeOriginal: unidadeSelecionada,
                      validade: validade,
                      imagemPath: imagemSelecionada?.path,
                    );

                    // 6. Chamar o controller para adicionar
                    controller.adicionarProduto(produto);

                    // 7. Fechar a tela e voltar para a Home
                    Navigator.pop(context);
                  },
                  child: const Text('Salvar Produto'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
