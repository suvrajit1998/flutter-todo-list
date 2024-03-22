import '../exports.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userName = TextEditingController();

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      await Get.find<UserService>().signUpWithEmailPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        userName: userName.text,
      );

      showToast('User successfully registered');
      emailController.text = '';
      userName.text = '';
      passwordController.text = '';
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
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.always,
                  controller: userName,
                  decoration:
                      CommonStyle.inputDecoration(labelText: 'User Name'),
                ),
                const SizedBox(height: 20),
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
                    _handleSignUp();
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(SignInScreen.routeName);
                  },
                  child: const Text('Sing in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
