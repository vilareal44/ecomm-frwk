import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecomm/features/auth/data/authentication_client/firebase_authentication_client.dart';
import 'package:ecomm/features/auth/domain/repositories/user_repository.dart';
import 'package:ecomm/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:ecomm/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecomm/features/product/domain/repositories/product_repository.dart';
import 'package:ecomm/features/product/domain/usecases/find_all_products.dart';
import 'package:ecomm/features/product/domain/usecases/get_product.dart';
import 'package:ecomm/features/product/domain/usecases/search_product.dart';
import 'package:ecomm/features/shopping_cart/data/repositories/repositories.dart';
import 'package:ecomm/features/shopping_cart/domain/repositories/shopping_cart_repository.dart';
import 'package:ecomm/features/shopping_cart/domain/usecases/usecases.dart';
import 'package:ecomm/route_service.dart';
import 'package:ecomm/routes.dart';
import 'package:ecomm/features/auth/data/authentication_client/authentication_client.dart';
import 'package:ecomm/features/auth/data/repositories/user_repository_impl.dart';

GetIt sl = GetIt.instance;

Future setupLocator() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<AuthenticationClient>(() {
    return FirebaseAuthenticationClient();
  });

  sl.registerLazySingleton<UserRepository>(() {
    final authenticationClient = sl.get<AuthenticationClient>();
    return UserRepositoryImpl(authenticationClient: authenticationClient);
  });

  sl.registerLazySingleton<SignInWithEmail>(() {
    final userRepository = sl.get<UserRepository>();
    return SignInWithEmail(userRepository);
  });

  sl.registerLazySingleton<RouteService>(() {
    return RouteService(routes: routes);
  });

  sl.registerLazySingleton<ProductRepository>(() {
    return ProductRepositoryImpl();
  });
  sl.registerLazySingleton<GetProductUseCase>(() {
    final productRepository = sl.get<ProductRepository>();
    return GetProductUseCase(productRepository);
  });

  sl.registerLazySingleton<ShoppingCartRepository>(() {
    return ShoppingCartRepositoryImpl(prefs);
  });

  sl.registerLazySingleton<AddToCartUseCase>(() {
    final shoppingCartRepository = sl.get<ShoppingCartRepository>();
    return AddToCartUseCase(shoppingCartRepository);
  });

  sl.registerLazySingleton<ClearShoppingCartUseCase>(() {
    final shoppingCartRepository = sl.get<ShoppingCartRepository>();
    return ClearShoppingCartUseCase(shoppingCartRepository);
  });

  sl.registerLazySingleton<GetShoppingCartUseCase>(() {
    final shoppingCartRepository = sl.get<ShoppingCartRepository>();
    return GetShoppingCartUseCase(shoppingCartRepository);
  });

  sl.registerLazySingleton<SearchProductUseCase>(() {
    final productRepository = sl.get<ProductRepository>();
    return SearchProductUseCase(productRepository);
  });

  sl.registerLazySingleton<FindAllProductsUseCase>(() {
    final productRepository = sl.get<ProductRepository>();
    return FindAllProductsUseCase(productRepository);
  });
}
