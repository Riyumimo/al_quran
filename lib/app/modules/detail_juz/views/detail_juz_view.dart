// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../contans/color.dart';
import '../../../data/moduls/surah_detail.dart' as surah;
import '../controllers/detail_juz_controller.dart';

// ignore: use_key_in_widget_constructors
class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapPerJuz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${dataMapPerJuz['juz']}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: (dataMapPerJuz['verses'] as List).length,
        itemBuilder: (BuildContext context, index) {
          // ignore: unrelated_type_equality_checks
          if ((dataMapPerJuz['verses'] as List).isEmpty) {
            return Center(
              child: Text("Data Tidak Ada"),
            );
          }
          Map<String, dynamic> ayat = dataMapPerJuz["verses"][index];
          surah.SurahDetail surahDetail = ayat["surah"];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if ((ayat['ayat'] as surah.Verse).number?.inSurah == 1)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(colors: [
                          Get.isDarkMode ? appPurple : appPurpleDark,
                          appPurpleLight1.withOpacity(0.5)
                        ]),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            Get.defaultDialog(
                                onConfirm: () => Get.back(),
                                title: "Tafsir",
                                titleStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    child: Text(
                                        '${surahDetail.tafsir!.id ?? 'Tidak Ada Tafsir'}',
                                        textAlign: TextAlign.justify),
                                  ),
                                ));
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    "${surahDetail.name!.transliteration?.id}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: appWhite),
                                  ),
                                  Text(
                                    "${surahDetail.name!.translation?.id ?? 'Error...'}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: appWhite),
                                  ),
                                  Text(
                                    " Ayat ${surahDetail.numberOfVerses?? 'Error'} | ${surahDetail.revelation?.id?? 'Error..'}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: appWhite),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appPurpleLight2.withOpacity(0.30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/octagon.png'))),
                            child: Center(
                                child: Text(
                              "${(ayat['ayat'] as surah.Verse).number!.inSurah}",
                              style: TextStyle(color: appPurpleDark),
                            )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${(ayat['surah'] as surah.SurahDetail).name?.transliteration?.id}",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_add_outlined,
                              color: Get.isDarkMode ? appWhite : appPurpleDark,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.play_arrow,
                                  color: Get.isDarkMode
                                      ? appWhite
                                      : appPurpleDark))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${(ayat['ayat'] as surah.Verse).text!.arab}',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${(ayat['ayat'] as surah.Verse).translation?.id}',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${(ayat['ayat'] as surah.Verse).text!.transliteration!.en}',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 50,
              )
            ],
          );
        },
      ),
    );
  }
}
