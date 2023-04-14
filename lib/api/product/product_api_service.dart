import "package:retrofit/retrofit.dart";
import 'package:dio/dio.dart';
import "package:second_flutter_project/model/product/product_model.dart";

part 'product_api_service.g.dart';

@RestApi(baseUrl: "https://fakestoreapi.com/")

abstract class ProductApiService {
  
    factory ProductApiService(Dio dio) = _ProductApiService;

    @GET("products")
    Future<List<Product>> getProducts();

    @GET("products/{productId}")
    Future<Product> getDetailProduct(@Path() int productId);

    // Future<Product> getDetailProduct(@Path() int productId);

}

//Get All Country over the world

//If Detail api is return Object
// Add this code 
    //  var value = _result.data!.map((k, v) => MapEntry(k, v as dynamic)).cast<String, dynamic>();
//to g.dart


