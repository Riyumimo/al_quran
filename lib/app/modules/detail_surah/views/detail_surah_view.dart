// ignore_for_file: avoid_unnecessary_containers, prefer_is_empty

import 'package:al_quran/app/contans/color.dart';
import 'package:al_quran/app/data/moduls/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/moduls/surah_detail.dart' as detail;
import '../controllers/detail_surah_controller.dart';

// ignore: must_be_immutable
class DetailSurahView extends GetView<DetailSurahController> {
  Surah surah = Get.arguments;

  DetailSurahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Surah, ${surah.name!.transliteration!.id?.toUpperCase() ?? 'Error...'}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
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
                      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Text(
                              surah.tafsir?.id ?? 'Tidak Ada Tafsir',
                              textAlign: TextAlign.justify),
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        surah.name!.transliteration!.id?.toUpperCase() ?? 'Error...',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: appWhite),
                      ),
                      Text(
                        surah.name!.translation!.id?.toUpperCase() ?? 'Error...',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: appWhite),
                      ),
                      Text(
                        " Ayat ${surah.numberOfVerses ?? 'Error'} | ${surah.revelation?.id ?? 'Error..'}",
                        style: const TextStyle(
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
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<detail.SurahDetail>(
              future: controller.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Tidak Ada Data"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.verses?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (snapshot.data?.verses?.length == 0) {
                      return const SizedBox();
                    }
                    detail.Verse ayat = snapshot.data!.verses![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: appPurpleLight2.withOpacity(0.30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/octagon.png'))),
                                    child: Center(
                                        child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(color: appPurpleDark),
                                    )),
                                  ),
                                ),
                                GetBuilder<DetailSurahController>(
                                  builder: (_controller) => Row(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.bookmark_add_outlined,
                                          color: Get.isDarkMode
                                              ? appWhite
                                              : appPurpleDark,
                                        ),
                                      ),

                                      // kondisi => stop => button Play
                                      // kondisi => playing => button pause & button stop
                                      // kondisi => pause => button resume & button stop
                                      (ayat.konsidiAudio == "stop")
                                          ? IconButton(
                                              onPressed: () {
                                                //play audio

                                                _controller.playAdio(ayat);
                                              },
                                              icon: Icon(Icons.play_arrow,
                                                  color: Get.isDarkMode
                                                      ? appWhite
                                                      : appPurpleDark),
                                            )
                                          : Row(
                                              children: <Widget>[
                                                (ayat.konsidiAudio == "playing")
                                                    ? IconButton(
                                                        onPressed: () {
                                                          _controller
                                                              .pauseAudio(ayat);
                                                        },
                                                        icon: Icon(
                                                            //icon for pause
                                                            Icons.pause,
                                                            color: Get
                                                                    .isDarkMode
                                                                ? appWhite
                                                                : appPurpleDark),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          _controller
                                                              .resumeAudio(
                                                                  ayat);
                                                        },
                                                        icon: Icon(
                                                            Icons.play_arrow,
                                                            color: Get
                                                                    .isDarkMode
                                                                ? appWhite
                                                                : appPurpleDark),
                                                      ),
                                                IconButton(
                                                  // ICON STOP AUDIO
                                                  onPressed: () {
                                                    _controller.stopAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.stop,
                                                      color: Get.isDarkMode
                                                          ? appWhite
                                                          : appPurpleDark),
                                                )
                                              ],
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${ayat.text!.arab}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${ayat.text!.transliteration!.en}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${ayat.translation?.id}',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
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
