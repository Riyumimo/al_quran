import 'dart:convert';

import 'package:al_quran/app/data/moduls/surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class HomeController extends GetxController {
RxBool isDark = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    
  }
  void increment() => count.value++;

  Future<List<Surah>> getAllSurah()async {
    final res = await  http.get(Uri.parse("https://api.quran.sutanlab.id/surah"));
    List data = (jsonDecode(res.body) as Map<String,dynamic>)["data"];


    if (data == null || data.isEmpty) {
      return[];

      
    }else{
      return data.map((e) => Surah.fromJson(e)).toList();
    }
    

  }
}
