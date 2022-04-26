import 'package:al_quran/app/contans/color.dart';
import 'package:al_quran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/moduls/juz.dart' as juz;
import '../../../data/moduls/surah.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran App'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.SEARCH);
              },
              icon: Icon(Icons.search))
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
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient:
                      LinearGradient(colors: [appPurpleDark, appPurpleLight1]),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Get.toNamed(Routes.LAST_READ);
                    },
                    child: Container(
                      width: Get.width,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -20,
                            right: 10,
                            top: 20,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
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
                                Text('Al-fatihah',
                                    style: TextStyle(
                                        color: appWhite, fontSize: 20)),
                                Text('Juz 1 Ayat 5',
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
                    tabs: [
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
                    JuzWidget(
                      controller: controller,
                    ),
                    Text("page 3"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isDark.toggle();
          Get.isDarkMode
              ? Get.changeTheme(themeLight)
              : Get.changeTheme(themeDark);
        },
        child: Obx(() => Icon(
              Icons.color_lens,
              color: controller.isDark.isFalse ? appPurpleDark : appWhite,
            )),
      ),
    );
  }
}

class JuzWidget extends StatelessWidget {
  const JuzWidget({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<juz.Juz>>(
        future: controller.getAllJuz(),
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
            itemCount: snapshot.data!.length,
            itemBuilder: ( context, index) {
              juz.Juz detailJuz = snapshot.data![index];
              return ListTile(
                onTap: (){},
                leading: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/octagon.png'))),
                  child: Center(
                      child: Text(
                    "${index + 1}",
                    style: TextStyle(color: appPurpleDark),
                  )),
                ),
                title: Text("Juz ${index + 1}"),
                isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Mulai Dari ${detailJuz.start}",
                    ),
                    Text(
                      "Sampai ${detailJuz.end}",
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}

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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
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
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/octagon.png'))),
                    child: Center(
                        child: Text(
                      "${surah.number}",
                      style: TextStyle(color: appPurpleDark),
                    )),
                  ),
                  title:
                      Text("${surah.name!.transliteration?.id ?? "Error.."}"),
                  subtitle: Text(
                      "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error'}"),
                  trailing: Text("${surah.name!.short ?? 'Error'}"),
                );
              },
            ),
          );
        });
  }
}
