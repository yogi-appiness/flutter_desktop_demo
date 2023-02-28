import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:techcloudpro_demo/pages/cubit/login_cubit.dart';
import 'package:techcloudpro_demo/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static Route<SignUpPage> createRoute() =>
      MaterialPageRoute(builder: (_) => const SignUpPage());

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/registration_bg.jpg",
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
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 36.0),
              width: 420.0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/techcloud_logo.png"),
                    const SizedBox(height: 16.0),
                    Text(
                      "User Registration",
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
                          _titleWidget(
                              "Please enter the below details to complete registration"),
                          const SizedBox(height: 16.0),
                          _titleWidget("Full Name"),
                          const SizedBox(height: 8.0),
                          FormBuilderTextField(
                            name: 'name',
                            controller: nameController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              counterText: "",
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "* Required"),
                              FormBuilderValidators.minLength(3,
                                  errorText: "Atleast 3 characters required")
                            ]),
                          ),
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
                            validator: usernameValidator,
                          ),
                          const SizedBox(height: 16.0),
                          _titleWidget("Password"),
                          const SizedBox(height: 8.0),
                          FormBuilderTextField(
                            name: 'password',
                            maxLength: 20,
                            decoration: const InputDecoration(
                              counterText: "",
                            ),
                            obscureText: true,
                            controller: passwordController,
                            validator: passwordValidator,
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
                                    final result =
                                        await BlocProvider.of<LoginCubit>(
                                                context)
                                            .registerNewUser(
                                      name: nameController.text.trim(),
                                      username: usernameController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );

                                    if (result) {
                                      Navigator.pushReplacement(
                                          context, LoginPage.createRoute());
                                    }
                                  }
                                },
                                child: const Text("Sign Up"),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            "* Password must be alphanumeric. Min characters = 8. Max characters = 20",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          const Text(
                            "* Full name: Min characters = 3. Max characters = 50",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          const Text(
                            "* Username: Min characters = 6. Max characters = 30",
                            style: TextStyle(fontSize: 12.0),
                          ),
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

  String? usernameValidator(String? text) {
    if ((text?.trim().length ?? 0) < 6) {
      return "Please provide atleast 6 characters";
    }

    if (!RegExp(r'^[a-zA-Z0-9\-\._]+$').hasMatch(text!)) {
      return "Special characters only - . and _ allowed";
    }

    return null;
  }

  String? passwordValidator(String? text) {
    if ((text?.trim().length ?? 0) < 8) {
      return "Please provide atleast 8 characters";
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text!)) {
      return "Only Alphabets and Numbers allowed";
    }

    return null;
  }
}
