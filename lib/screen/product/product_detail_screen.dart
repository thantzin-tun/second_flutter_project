import "package:flutter/material.dart";
import "package:second_flutter_project/model/product/product_model.dart";

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(product.title),
      ),
    );
  }
}