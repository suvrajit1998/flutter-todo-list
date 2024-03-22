import 'package:todo_list/app/splash_screen.dart';

import '../exports.dart';

List<GetPage> getPages() {
  return [
    GetPage(
      name: TodoListScreen.routeName,
      page: () => const TodoListScreen(),
    ),
    GetPage(
      name: SignInScreen.routeName,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: SignUpScreen.routeName,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
    ),
  ];
}
