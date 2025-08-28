import 'package:estoque_novo/features/estoque/data/repositories/produto_repository_impl.dart';
import 'package:estoque_novo/features/estoque/domain/usecases/adicionar_produto_usecase.dart';
import 'package:estoque_novo/features/estoque/presentation/controllers/produto_controller.dart';
import 'package:estoque_novo/features/estoque/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final repository = ProdutoRepositoryImpl();
  final usecase = AdicionarProdutoUsecase(repository);

  Get.put(ProdutoController(
    adicionarProdutoUsecase: usecase,
    repository: repository,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meu Estoque App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Colors.lightBlueAccent),
      ),
      home: HomePage(),
    );
  }
}
