import 'dart:convert';

import 'package:al_quran/app/data/moduls/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../contans/color.dart';
import '../../../data/moduls/juz.dart';
import '../../../data/moduls/surah_detail.dart';

class HomeController extends GetxController {
  RxBool isDark = false.obs;
  List<Surah> allSurah = [];

  void changeTheme() {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    

    final box = GetStorage();
    if (Get.isDarkMode) {
      //dark mode -> light mode
      box.remove("themeDark");

    }else{
      //light mode -> dark mode
    box.write("themeDark", true);
    
    }

  }

  Future<List<Surah>> getAllSurah() async {
    final res =
        await http.get(Uri.parse("https://api.quran.sutanlab.id/surah"));
    List data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();

      return allSurah;
    }
  }

  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;
    List<Map<String, dynamic>> penampungayat = [];
    List<Map<String, dynamic>> allJuz = [];
    for (var i = 1; i < 114; i++) {
      var res =
          await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));
      Map<String, dynamic> rawData = json.decode(res.body)['data'];
      SurahDetail data = SurahDetail.fromJson(rawData);

      if (data.verses != null) {
        data.verses?.forEach((ayat) {
          /* ex: surah alfatihah => 7 ayat */
          if (ayat.meta?.juz == juz) {
            penampungayat.add({'surah': data, "ayat": ayat});
          } else {
            allJuz.add({
              "juz": juz,
              "start": penampungayat[0],
              "end": penampungayat[penampungayat.length - 1],
              "verses": penampungayat
            });
            juz++;
            penampungayat = [];
            penampungayat.add({
              "surah": data,
              "ayat": ayat,
            });
          }
        });
      }
    }
    allJuz.add({
      "juz": juz,
      "start": penampungayat[0],
      "end": penampungayat[penampungayat.length - 1],
      "verses": penampungayat
    });

    return allJuz;
  }
}
