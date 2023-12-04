

import 'package:get_it/get_it.dart';

import 'CartService.dart';


final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<CartService>(CartService());
}
