import 'package:flutter/material.dart';
import 'package:movie_task_app/core/constant/navigator.dart';
import 'package:movie_task_app/view/ui/home_screen/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
      reverseDuration: const Duration(seconds: 1),
    );
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    opacityAnimation = CurvedAnimation(parent: controller, curve: Curves.slowMiddle);
    controller.addListener(() {setState(() {});});
    controller.forward();
    Future.delayed(
        const Duration(seconds: 3),
            () => mounted ? NextScreen.closeOthersAnimation(context, const HomeScreen()): null,
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaleTransition(
        scale: scaleAnimation,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: const Center(
            child: Text("Movie App",
              style: TextStyle(
                fontSize: 32
              ),
            ),
          ),
        ),
      ),
    );
  }
}
