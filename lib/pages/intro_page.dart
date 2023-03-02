import 'package:flutter/material.dart';
import 'package:flutter_desktop_demo/pages/login_page.dart';
import 'package:flutter_desktop_demo/pages/sign_up_page.dart';

/// IntroPage: The page which is shown at the start of the application
/// User can navigate to Login or register page from here
/// AUTHOR: Yogendra J Pai
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/intro_bg.jpg",
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
              height: 360.0,
              width: 360.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 24.0, vertical: 16.0),
                  //   child: Image.asset("assets/techcloud_logo.png"),
                  // ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Welcome to the demo desktop application",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Registered? "),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(LoginPage.createRoute());
                          },
                          child: const Text("Login"))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("New User? "),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(SignUpPage.createRoute());
                          },
                          child: const Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
