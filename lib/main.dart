import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_desktop_demo/pages/home_page.dart';

import 'pages/cubit/login_cubit.dart';
import 'pages/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// Root application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialise the state management at the root
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Desktop Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white70,
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: CupertinoColors.systemGrey6, width: 2.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
            filled: true,
            fillColor: Colors.blueGrey.shade50,
          ),
        ),
        home: Scaffold(body: _body()),
      ),
    );
  }

  Widget _body() {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) => current.errorMessage != null,
      // Listens for any error messages
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            state.errorMessage ?? "",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          backgroundColor: Colors.orange,
        ));
      },
      builder: (context, state) {
        // If it is a busy state.
        if (state.isBusy) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/app_bg.jpg",
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       color: Colors.white,
                  //     ),
                  //     margin: const EdgeInsets.only(bottom: 48.0),
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Image.asset("assets/techcloud_logo.png")),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          );
        }

        // Display home page if user is logged in
        if (state.user != null) {
          return const HomePage();
        }

        // Initial intro page
        return const IntroPage();
      },
    );
  }
}
