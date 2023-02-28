import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techcloudpro_demo/pages/cubit/login_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<HomePage> createRoute() =>
      MaterialPageRoute(builder: (_) => const HomePage());

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<LoginCubit>(context).state.user;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/app_bg.jpg",
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
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
              height: 240.0,
              width: 240.0,
              child: Text(
                "Welcome \n ${user?.name},\n to TechCloudPro dashboard",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
