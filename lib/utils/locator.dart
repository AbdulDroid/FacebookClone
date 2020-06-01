import 'package:facebook_clone/services/authservice.dart';
import 'package:facebook_clone/services/cloudstorageservice.dart';
import 'package:facebook_clone/services/dialog_service.dart';
import 'package:facebook_clone/services/firestoreservice.dart';
import 'package:facebook_clone/utils/imageselector.dart';
import 'package:facebook_clone/utils/navigator.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigatorService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FireStoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelectorService());
}