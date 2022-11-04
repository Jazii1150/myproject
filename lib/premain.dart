
import 'package:flutter/material.dart';
import 'package:mobie1/mainfirst.dart';

class PreMainPage extends StatefulWidget {
  const PreMainPage({super.key});

  @override
  State<PreMainPage> createState() => _PreMainPageState();
}

class _PreMainPageState extends State<PreMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
        Ink(
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: AssetImage('assets/drink.jpg'),
                      fit: BoxFit.fitHeight
                    )
                  ),
                  child: InkWell(
                    onTap: (() {
                      Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainFirst()),
                  ModalRoute.withName('/'));
                    }),
                  )
      ),
      )
    );
  }
}