import 'package:animated_onboarding/animated_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  final _pages = [
    const OnboardingPage(
        child: Text("Title1",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        color: Color(0xffff1744)),
    const OnboardingPage(
        child: Text("Title2",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        color: Color(0xffff9100)),
    const OnboardingPage(
        child: Text("Title3",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        color: Color(0xff00695c)),
    const OnboardingPage(
        child: Text("Title4",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        color: Color(0xff5c6bc0)),
    const OnboardingPage(
        child: Text("Title5",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        color: Color(0xff37474f)),
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedOnboarding(
      pages: _pages,
      pageController: pageController,
      onFinishedButtonTap: () {
        debugPrint("FINISHED!!");
      },
      topLeftChild: const Text(
        "Storief",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      topRightChild: MaterialButton(
        child: const Text(
          "Skip",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          pageController.animateToPage(4,
              curve: Curves.bounceIn, duration: const Duration(seconds: 1));
          debugPrint('Tapppppp');
        },
      ),
    );
  }
}
