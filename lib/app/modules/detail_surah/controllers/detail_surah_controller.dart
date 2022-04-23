import 'dart:convert';

import 'package:al_quran/app/data/moduls/surah_detail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class DetailSurahController extends GetxController {

  //TODO: Implement DetailSurahController
 Future<SurahDetail> getDetailSurah(String surah )async {
    // ignore: unnecessary_brace_in_string_interps
    final res = await  http.get(Uri.parse("https://api.quran.sutanlab.id/surah/${surah}"));

    Map<String,dynamic> data = (jsonDecode(res.body) as Map<String,dynamic>)["data"];

      print(data);
  
      return SurahDetail.fromJson(data);
  
    

  }
}
