import 'package:todo_list/app/splash_screen.dart';

import './exports.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _putAllServices() {
    Get.put(UserService());
  }

  @override
  void initState() {
    _putAllServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO list',
      initialRoute: SplashScreen.routeName,
      getPages: getPages(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      scrollBehavior: MyCustomScrollBehavior(),
      themeMode: ThemeMode.light,
    );
  }
}
