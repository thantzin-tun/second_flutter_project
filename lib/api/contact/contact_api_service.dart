import "package:retrofit/retrofit.dart";
import 'package:dio/dio.dart';
import "package:second_flutter_project/model/contact/contact_model.dart";
import "package:second_flutter_project/model/product/product_model.dart";

part 'contact_api_service.g.dart';

@RestApi(baseUrl: "https://6436315c3e4d2b4a12cc9e4b.mockapi.io/api/")

abstract class ContactApiService {
  
    factory ContactApiService(Dio dio) =>  _ContactApiService(dio);

    @GET("contact")
    Future<List<Contact>> getContacts();

    @GET("contact/{contactId}")
    Future<Contact> getContact(@Path() String contactId);

    @POST("contact")
    Future<Contact> addContact(@Body() Contact contact);

    @PUT("contact/{contactId}")
    Future<Contact> updateContact(@Path() String contactId,@Body() Contact contact);

    @DELETE("contact/{contactId}")
    Future<Contact> deleteContact(@Path() String contactId);

    // Future<Product> getDetailProduct(@Path() int productId);

}

//Get All Country over the world

//If Detail api is return Object
// Add this code 
    //  var value = _result.data!.map((k, v) => MapEntry(k, v as dynamic)).cast<String, dynamic>();
//to g.dart


