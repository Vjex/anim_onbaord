import 'package:anim_onboard/single_screen_data_widget.dart';

import './animated_onboard.dart';
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
  List<OnboardingPage> _pages = [];
  bool _isInstantiated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInstantiated) {
      _isInstantiated = true;
      Size size = MediaQuery.of(context).size;
      _pages = [
        OnboardingPage(
            child: SingleScreenDataWidget(
                size: size,
                imagePath: 'assets/p1.jpeg',
                screenTitle: "Local news stories"),
            color: Colors.blue),
        OnboardingPage(
            child: SingleScreenDataWidget(
                size: size,
                imagePath: 'assets/p2.jpeg',
                screenTitle: "Choose your interests"),
            color: Colors.pink.shade100),
        OnboardingPage(
            child: SingleScreenDataWidget(
                size: size,
                imagePath: 'assets/p3.jpeg',
                screenTitle: "Drag and drop to move"),
            color: Colors.blueGrey),
      ];
    }
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
          pageController.animateToPage(2,
              curve: Curves.easeInBack, duration: const Duration(seconds: 1));
          debugPrint('Tapppppp');
        },
      ),
    );
  }
}
