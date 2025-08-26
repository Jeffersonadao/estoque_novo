import 'package:flutter/material.dart';

class ImageCardWidget extends StatefulWidget {
  const ImageCardWidget({super.key});

  @override
  State<ImageCardWidget> createState() => _ImageCardWidgetState();
}

class _ImageCardWidgetState extends State<ImageCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(200, 200, 200, 0.50),

        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.network(
        "https://cdn.awsli.com.br/600x1000/618/618763/produto/3043229703ef0414bc.jpg",
        width: 85,
      ),
    );
  }
}
