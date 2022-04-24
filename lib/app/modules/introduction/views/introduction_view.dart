import 'package:al_quran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('IntroductionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            bottom: 100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Al-quran Apps',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child:
                    const Text('Sesibuk itukah kamu belum membaca al-quran ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: 300,
                child: Lottie.asset("assets/images/animations.json"),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () => Get.offAllNamed(Routes.HOME), child:Text('Get Started'))
            ],
          ),
        ),
      ),
    );
  }
}
