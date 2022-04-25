import 'package:al_quran/app/contans/color.dart';
import 'package:al_quran/app/data/moduls/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/moduls/surah_detail.dart' as detail;
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Surah, ${surah.name!.transliteration!.id?.toUpperCase() ?? 'Error...'}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "${surah.name!.transliteration!.id?.toUpperCase() ?? 'Error...'}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? appPurpleDark : appPurpleDark),
                  ),
                  Text(
                    "${surah.name!.translation!.id?.toUpperCase() ?? 'Error...'}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? appPurpleDark : appPurpleDark),
                  ),
                  Text(
                    " Ayat ${surah.numberOfVerses ?? 'Error'} | ${surah.revelation?.id ?? 'Error..'}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? appPurpleDark : appPurpleDark),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<detail.SurahDetail>(
              future: controller.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Tidak Ada Data"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.verses?.length ?? 0,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (snapshot.data?.verses?.length == 0) {
                      return SizedBox();
                    }
                    detail.Verse ayat = snapshot.data!.verses![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/octagon.png'))),
                                    child: Center(
                                        child: Text(
                                      "${index + 1}",
                                      style: TextStyle(color: appPurpleDark),
                                    )),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.bookmark_add_outlined,
                                        color: Get.isDarkMode
                                            ? appPurpleDark
                                            : appPurpleDark,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.play_arrow,
                                            color: Get.isDarkMode
                                                ? appPurpleDark
                                                : appPurpleDark))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${ayat.text!.arab}',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${ayat.text!.transliteration!.en}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${ayat.translation?.id}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
