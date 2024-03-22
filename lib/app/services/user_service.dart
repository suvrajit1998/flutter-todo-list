import 'package:todo_list/app/exports.dart';

class UserService extends GetxController {
  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  Rx<UserModel?> get user => _user;
  GetStorage storage = GetStorage();

  Future<UserModel?> getUserByid() async {
    try {
      final id = storage.read('id');
      print('userid $id');
      final userdoc =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      print('${userdoc.data()}');
      if (userdoc.exists) {
        _user.value = UserModel.formMap(userdoc.data()!);
        print('User ${userdoc.data()}');
        return UserModel.formMap(userdoc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('error on get user by token $e');
    }
    return null;
  }

  Future<List<UserModel>> getUsersList() async {
    try {
    final users = await FirebaseFirestore.instance.collection('users').get();

    final result = users.docs.map((e) => UserModel.formMap(e.data())).toList();
    return result;
    } catch (e) {
      print('error on fetching users list $e');
      return [];
    }
  }

  void signOut() {
    _user.value = null;
    storage.remove('id');
  }

  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Sign-in successful
      User? user = userCredential.user;
      
        storage.write('id', user!.uid);

        print('Signed in user: $user');
        return true;
    } catch (e) {
      // Handle sign-in errors
      print('Error signing in: $e');
      return false;
    }
  }

  Future<void> signUpWithEmailPassword({required String email, required String password, required String userName}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Signup successful
      User? user = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'email': user.email,
        'id': user.uid,
        'userName': userName,
      });
      print('Signed up user: $user');
    } catch (e) {
      // Handle signup errors
      print('Error signing up: $e');
    }
  }
}
