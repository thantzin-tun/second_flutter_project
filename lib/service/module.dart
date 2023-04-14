import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import "package:second_flutter_project/api/contact/contact_api_service.dart";
import "package:second_flutter_project/bloc/contac%20cubit/contact_cubit.dart";
import "package:second_flutter_project/repository/contact_repository.dart";

GetIt getIt = GetIt.instance;

void locator() {
  
  Dio dio = Dio();

  getIt.registerLazySingleton(() => dio);

  ContactApiService contactApiService = ContactApiService(getIt.call()); 
  getIt.registerLazySingleton<ContactApiService>(() => contactApiService);

  ContactRepository contactRepository = ContactRepository(getIt.call());
  getIt.registerLazySingleton<ContactRepository>(() => contactRepository);

  ContactCubit contactCubit = ContactCubit(contactRepository);
  getIt.registerLazySingleton<ContactCubit>(() => contactCubit);
  

}