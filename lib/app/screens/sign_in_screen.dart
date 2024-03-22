import '../exports.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GetStorage storage = GetStorage();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleSingIn() async {
    if (_formKey.currentState!.validate()) {
      final result = await Get.find<UserService>().signInWithEmailPassword(
          emailController.text.trim(), passwordController.text.trim());

      if (result) Get.toNamed(TodoListScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: ValidationBuilder().required().email().build(),
                  autovalidateMode: AutovalidateMode.always,
                  controller: emailController,
                  decoration: CommonStyle.inputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.always,
                  controller: passwordController,
                  decoration:
                      CommonStyle.inputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _handleSingIn();
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(SignUpScreen.routeName);
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
