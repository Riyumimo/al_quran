import 'package:al_quran/app/contans/color.dart';
import 'package:al_quran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Center(
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Al-quran Apps',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 1,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child:
                    Text('Sesibuk apakah kamu belum membaca al-quran ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        )),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Lottie.asset("assets/images/animations.json"),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: () => Get.offAllNamed(Routes.HOME),
               child:Text('Get Started',style:TextStyle(color:Get.isDarkMode ?appPurple:appWhite)),
               style: ElevatedButton.styleFrom(
                  primary: Get.isDarkMode?appWhite:appPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10)
               ),)
            ],
          ),
        ),
      ),
    );
  }
}
