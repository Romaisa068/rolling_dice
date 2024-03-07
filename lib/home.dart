import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int rightDice = 1;
  int leftDice = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();

    animate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animate() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {});
      // print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          rightDice = Random().nextInt(6) + 1;
          leftDice = Random().nextInt(6) + 1;
        });
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Rolling Dice',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: roll,
                child: Image(
                    height: (200 - (animation.value) * 200),
                    image: AssetImage(
                      'images/dice-$rightDice.png',
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onDoubleTap: roll,
                  child: Image(
                      height: (200 - (animation.value) * 200),
                      image: AssetImage('images/dice-$leftDice.png')))
            ],
          ),
          const Padding(padding: EdgeInsets.all(30)),
          ElevatedButton(
            onPressed: roll,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text(
              'Roll',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w100),
            ),
          )
        ],
      ),
      drawer: const Drawer(),
    );
  }
}
