import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:techcloudpro_demo/pages/cubit/login_cubit.dart';
import 'package:techcloudpro_demo/pages/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route<LoginPage> createRoute() =>
      MaterialPageRoute(builder: (_) => const LoginPage());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/login_bg.jpg",
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )
                ],
              ),
              padding: const EdgeInsets.all(24.0),
              width: 360.0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/techcloud_logo.png"),
                    const SizedBox(height: 16.0),
                    Text(
                      "User Login",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24.0),
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleWidget("Please enter login credentials"),
                          const SizedBox(height: 16.0),
                          _titleWidget("Username"),
                          const SizedBox(height: 8.0),
                          FormBuilderTextField(
                            name: 'username',
                            maxLength: 25,
                            decoration: const InputDecoration(
                              counterText: "",
                            ),
                            controller: usernameController,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "* Required"),
                            ]),
                          ),
                          const SizedBox(height: 16.0),
                          _titleWidget("Password"),
                          const SizedBox(height: 8.0),
                          FormBuilderTextField(
                            name: 'password',
                            maxLength: 25,
                            decoration: const InputDecoration(
                              counterText: "",
                            ),
                            obscureText: true,
                            controller: passwordController,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: "* Required"),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 24.0),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(ForgotPasswordPage.createRoute());
                                },
                                child: const Text("Forgot password?")),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(
                                      width: 1.0, color: Colors.red),
                                ),
                                child: const Text("Cancel"),
                              ),
                              const SizedBox(width: 12.0),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final result = await BlocProvider.of<
                                            LoginCubit>(context)
                                        .loginUser(
                                            username:
                                                usernameController.text.trim(),
                                            password:
                                                passwordController.text.trim());

                                    if (result) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: const Text("Login"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _titleWidget(String title) => Text(
        title,
        textAlign: TextAlign.center,
      );
}
