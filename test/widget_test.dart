import 'dart:convert';
import 'package:al_quran/app/data/moduls/surah.dart';
import 'package:al_quran/app/data/moduls/surah_detail.dart';
import 'package:http/http.dart' as http;

void main() async {

Future<SurahDetail> getDetailSurah(String surah )async {
    // ignore: unnecessary_brace_in_string_interps
    final res = await  http.get(Uri.parse("https://api.quran.sutanlab.id/surah/${surah}"));

    Map<String,dynamic> data = (jsonDecode(res.body) as Map<String,dynamic>)["data"];

      print(data);
  
      return SurahDetail.fromJson(data);
  
    

  }
   await getDetailSurah(1.toString());

  final res = await  http.get(Uri.parse("https://api.quran.sutanlab.id/surah"));
  List data = (jsonDecode(res.body) as Map<String,dynamic>)["data"];

  //1-114
  // print(data[113]);

//Data Api List<dynamic>(Raw data ) menjadi model (yang sudah di buat)

Surah surahAnnas = Surah.fromJson(data[113]); 
print(surahAnnas.name);

//Mencoba Masuk Ke nested  Model (Model dalam Model)

print(surahAnnas.name!.transliteration!.id);
print("========");

//Surah Detail 


final resAnnas = await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/${surahAnnas.number}"));

// print(resAnnas.body);

Map<String,dynamic> dataDetail = (jsonDecode(resAnnas.body) as Map<String,dynamic>)["data"]; 

// print(dataDetail["code"]);

// print(dataDetail);


//Memasukkan data raw ke dalam ke SurahDetail 
SurahDetail annas = SurahDetail.fromJson(dataDetail); 

print(annas.tafsir!.id);
print(annas.verses![0].text!.arab);

}


