import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'cubit/login_cubit.dart';

/// Forgot password page where user can reset their password if their full name and username provided right.
/// AUTHOR: Yogendra J Pai

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static Route<ForgotPasswordPage> createRoute() =>
      MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/forgot_pwd_bg.jpg",
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
                    //Image.asset("assets/techcloud_logo.png"),
                    const SizedBox(height: 16.0),
                    Text(
                      "Forgot Password",
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
                              "Please enter the below details to reset your password"),
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
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "* Required"),
                              FormBuilderValidators.minLength(6,
                                  errorText: "Atleast 6 characters required")
                            ]),
                          ),
                          const SizedBox(height: 16.0),
                          _titleWidget("New Password"),
                          const SizedBox(height: 8.0),
                          FormBuilderTextField(
                            name: 'new_password',
                            maxLength: 20,
                            decoration: const InputDecoration(
                              counterText: "",
                            ),
                            obscureText: true,
                            controller: newPwdController,
                            validator: passwordValidator,
                          ),
                          const SizedBox(height: 16.0),
                          _titleWidget("Confirm Password"),
                          const SizedBox(height: 8.0),
                          FormBuilderTextField(
                            name: 'confrm_password',
                            maxLength: 20,
                            decoration: const InputDecoration(
                              counterText: "",
                            ),
                            obscureText: true,
                            controller: confirmPwdController,
                            validator: cnfrmPasswordValidator,
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
                                            .resetPassword(
                                      name: nameController.text.trim(),
                                      username: usernameController.text.trim(),
                                      password: newPwdController.text.trim(),
                                    );

                                    if (result) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: const Text("Reset"),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            "* Password must be alphanumeric.\n Min characters = 8. Max characters = 20",
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

  /// Password validator. Checks if the value provided has the desired length and characters allowed
  String? passwordValidator(String? text) {
    if ((text?.length ?? 0) < 8) {
      return "Please provide atleast 8 characters";
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text!)) {
      return "Only Alphabets and Numbers allowed";
    }

    return null;
  }

  /// Confirm password validator.
  /// Checks if the value is same as the new password field and then validates it
  String? cnfrmPasswordValidator(String? text) {
    if (newPwdController.text != confirmPwdController.text) {
      return "Passwords do not match";
    }

    return passwordValidator(text);
  }

  /// Title widget for textfields
  _titleWidget(String title) => Text(
        title,
        textAlign: TextAlign.center,
      );
}
