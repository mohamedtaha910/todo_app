import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/get_started.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  late Animation<double> fadeAnimation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOutBack, //
          ),
        );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    animationController.forward();

    Future.delayed(Duration(seconds: 7)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            'assets/icons/Logo.svg',
            height: 160,

            color: const Color.fromARGB(255, 52, 49, 233).withAlpha(230),
          ),

          SizedBox(height: 32),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) => FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slidingAnimation,
                child: SvgPicture.asset(
                  'assets/icons/TODOLIST.svg',
                  height: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
