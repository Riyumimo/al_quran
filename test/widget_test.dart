import 'dart:convert';

import 'package:al_quran/app/data/moduls/surah_detail.dart';
import 'package:http/http.dart' as http;

void main() async {
  int juz =1 ;
  List<Map<String,dynamic>> penampungayat =[];
  List <Map<String,dynamic>> allJuz = [];
  for (var i = 1; i < 114; i++) {
    var res =
        await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));
       Map<String,dynamic> rawData =  json.decode(res.body)['data'];
       SurahDetail data = SurahDetail.fromJson(rawData);

      if (data.verses != null) {
        data.verses?.forEach((ayat) {
          /* ex: surah alfatihah => 7 ayat */
          if (ayat.meta?.juz == juz) {
            penampungayat.add({
              'nama':data.name?.transliteration?.id ??"",
              "ayat"  :ayat
            });
          }else{
            //jika jumlah ayat bertambah
            print('================');
            print('Berhasil Memasukkan Juz $juz');
            print('START');
            print((penampungayat[0]["ayat"]as Verse).number!.inSurah);
            print('END');
            print((penampungayat[penampungayat.length -1]["ayat"] as Verse).number?.inSurah);

            allJuz.add({
              "juz":juz,
              "start":penampungayat[0],
              "end": penampungayat[penampungayat.length-1],
              "verses": penampungayat
            });
            juz++;
            penampungayat.clear();
            penampungayat.add({
              "surah":data.name?.transliteration?.id??"",
              "ayat":ayat,
            });
          }


         });
        
      }

  }
    print('================');
            print('Berhasil Memasukkan Juz $juz');
            print('START');
            print((penampungayat[0]["ayat"]as Verse).text?.arab);
            print('END');
            print((penampungayat[penampungayat.length -1]["ayat"] as Verse).number?.inSurah);

            allJuz.add({
              "juz":juz,
              "start":penampungayat[0],
              "end": penampungayat[penampungayat.length-1],
              "verses": penampungayat
            });
}
