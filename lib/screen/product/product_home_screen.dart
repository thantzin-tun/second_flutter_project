import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_flutter_project/api/product/product_api_service.dart';
import 'package:second_flutter_project/model/product/product_model.dart';
import "package:dio/dio.dart";
import 'package:second_flutter_project/screen/product/product_detail_screen.dart';

class ProductHomeScreen extends StatelessWidget {
  ProductHomeScreen({super.key});

  ProductApiService productApiService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productApiService.getProducts().then((value) => print(value));
        },
        tooltip: "Show Api Data",
        child: const Icon(Icons.info),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Country"),
        leading: const Icon(Icons.menu),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Product>>(
            future: productApiService.getProducts(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Product> product = snapshot.data;
                return ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return productCard(context, product[index]);
                  },
                );
              } else if (snapshot.hasError)
                return Center(child: Text("Something Wrong!"));
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            },
          )),
    );
  }

  Card productCard(BuildContext context, product) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          Get.to(ProductDetailScreen(product: product),transition: Transition.fadeIn);
        },
        leading: CachedNetworkImage(
          imageUrl:product.image,
          width:100,
          height:100,
          placeholder: (_, __) => const Center (child: CircularProgressIndicator()),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
        title: Text(
          (product.title),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text("Price: ${product.price}"),
      ),
    );
  }
}
