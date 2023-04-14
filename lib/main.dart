
import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import "package:pretty_dio_logger/pretty_dio_logger.dart";
import "package:second_flutter_project/api/contact/contact_api_service.dart";
import "package:second_flutter_project/api/product/product_api_service.dart";
import "package:get/get.dart";
import "package:second_flutter_project/bloc/contac%20cubit/contact_cubit.dart";
import "package:second_flutter_project/screen/contact/contact_screen.dart";
import "package:second_flutter_project/screen/product/product_home_screen.dart";
import "package:second_flutter_project/service/module.dart";
import "package:second_flutter_project/splash_screen.dart";
import 'package:flutter_slidable/flutter_slidable.dart';

import "package:flutter_bloc/flutter_bloc.dart";

import "repository/contact_repository.dart";

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
// Contact Project not included product
    Dio dio = Dio();
    ProductApiService productApiService = ProductApiService(dio);
    ContactApiService contactApiService = ContactApiService(dio);
    ContactRepository contactRepository = ContactRepository(contactApiService);
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      error: true,
      compact: true,
      requestHeader: true,
    ));

    Get.put(productApiService);
    Get.put(contactApiService);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Testing Flutter Project",
      home: BlocProvider<ContactCubit>(
        create: (context) => ContactCubit(contactRepository),
        child: const ContactScreen(),
      ),
    );
  }
}
