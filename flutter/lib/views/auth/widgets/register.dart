import 'package:cooking/models/User.dart';
import 'package:cooking/providers/auth.dart';
import 'package:cooking/providers/users.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cooking/views/auth/widgets/password_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class RegisterWidget extends StatefulWidget {
  final VoidCallback onLogInClicked;
  const RegisterWidget({
    Key? key,
    required this.onLogInClicked,
  }) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final emailController =
      TextEditingController(text: "maxime-arnould@outlook.fr");
  final passwordController = TextEditingController(text: "test123");
  final confirmPasswordController = TextEditingController(text: "test123");
  final formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  register(BuildContext context) async {
    print(Provider.of<UsersProvider>(context, listen: false).connectedUser);
    final formIsValid = formKey.currentState!.validate();
    if (!formIsValid) return null;
    try {
      final response =
          await Provider.of<AuthProvider>(context, listen: false).register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
      final User user = await User.fromJson(response);
      Provider.of<UsersProvider>(context, listen: false).emptyArray();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Image.asset(
              "assets/cooking_logo.png",
              height: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome \n On Cooking !',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? "Enter a valid email"
                      : null,
              autocorrect: false,
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordField(controller: passwordController),
            const SizedBox(
              height: 20,
            ),
            PasswordField(
              controller: confirmPasswordController,
              label: "Confirm Password",
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                register(context);
              },
              icon: const Icon(Icons.login),
              label: const Text(
                "Register",
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            RichText(
              text: TextSpan(
                text: "Already have an account ? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onLogInClicked,
                    text: "Log In",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
