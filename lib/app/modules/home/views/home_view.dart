// ignore_for_file: avoid_print

import 'package:al_quran/app/contans/color.dart';
import 'package:al_quran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/moduls/surah.dart';
import '../../../data/moduls/surah_detail.dart' as surah;
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran App'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.SEARCH);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Assalamualaikum ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient:
                      const LinearGradient(colors: [appPurpleDark, appPurpleLight1]),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Get.toNamed(Routes.LAST_READ);
                    },
                    child: SizedBox(
                      width: Get.width,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -20,
                            right: 10,
                            top: 20,
                            child: Opacity(
                              opacity: 0.7,
                              child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Image.asset(
                                    'assets/images/quran.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Terakhir Dibaca',
                                        style: TextStyle(
                                          color: appWhite,
                                          fontSize: 16,
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('Al-fatihah',
                                    style: TextStyle(
                                        color: appWhite, fontSize: 20)),
                                const Text('Juz 1 Ayat 5',
                                    style: TextStyle(
                                      color: appWhite,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => TabBar(
                    indicatorColor:
                        controller.isDark.isFalse ? appWhite : appPurpleDark,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                       Tab(
                        text: 'Surah',
                      ),
                      Tab(
                        text: 'Juz',
                      ),
                      Tab(
                        text: 'BookMark',
                      ),
                    ],
                  )),
              Expanded(
                child: TabBarView(
                  children: [
                    surahWidget(
                      controller: controller,
                    ),
                    juzWidget(controller: controller),
                    const Text("page 3"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         controller.changeTheme();
         controller.isDark.toggle();
        },
        child: Obx(() => Icon(
              Icons.color_lens,
              color: controller.isDark.isTrue ? appPurpleDark : appWhite,
            )),
      ),
    );
  }
}

// ignore: camel_case_types
class juzWidget extends StatelessWidget {
  const juzWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.getAllJuz(),
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
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> dataMapPerJuz =
                snapshot.data![index];
                print(dataMapPerJuz);
            return ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAIL_JUZ,
                    arguments: dataMapPerJuz);
              },
              leading: Container(
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
              title: Text("Juz ${index + 1}"),
              isThreeLine: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                  "Mulai Dari ${(dataMapPerJuz['start']['surah'] as surah.SurahDetail).name?.transliteration?.id} ayat ${(dataMapPerJuz['start']['ayat'] as surah.Verse).number!.inSurah}",
                  ),
                  Text(
                    "Sampai ${(dataMapPerJuz['end']['surah'] as surah.SurahDetail).name?.transliteration?.id} ayat ${(dataMapPerJuz['end']['ayat'] as surah.Verse).number!.inSurah}",
                  ),
                ],
              ),
            );
            
          },
        );
      },
    );
  }
}



// ignore: camel_case_types
class surahWidget extends StatelessWidget {
  const surahWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: controller.getAllSurah(),
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

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Surah surah = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                  },
                  leading: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/octagon.png'))),
                    child: Center(
                        child: Text(
                      "${surah.number}",
                      style: const TextStyle(color: appPurpleDark),
                    )),
                  ),
                  title:
                      Text(surah.name!.transliteration?.id ?? "Error.."),
                  subtitle: Text(
                      "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error'}"),
                  trailing: Text(surah.name!.short ?? 'Error'),
                );
              },
            ),
          );
        });
  }
}
