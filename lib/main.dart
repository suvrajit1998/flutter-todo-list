import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list/firebase_options.dart';

import './app/exports.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
