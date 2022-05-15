import 'dart:convert';

import 'package:al_quran/app/data/moduls/surah_detail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();
  Verse? lastVerse;
  Future<SurahDetail> getDetailSurah(String surah) async {
    final res = await http
        .get(Uri.parse("https://api.quran.sutanlab.id/surah/${surah}"));
    Map<String, dynamic> data =
        (jsonDecode(res.body) as Map<String, dynamic>)["data"];

    return SurahDetail.fromJson(data);
  }

  void stopAudio(Verse ayat) async {
    try {
      ayat.konsidiAudio = "stop";
      await player.stop();
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: e.message.toString());
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: "Tidak Dapat Memutar audio");
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.konsidiAudio = "playing";
      update();
      await player.play();
      ayat.konsidiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: e.message.toString());
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: "Tidak Dapat Memutar audio");
    }
    // Fallback for all errors
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.konsidiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: e.message.toString());
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: "Tidak Dapat Memutar audio");
    }
    // Fallback for all errors
  }

  void playAdio(Verse ayat) async {  
    if (ayat?.audio?.primary != null) {
      try {
        if(lastVerse == null){
          lastVerse = ayat;
        }
        lastVerse!.konsidiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.konsidiAudio = "stop";
        update();
        


       
        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.konsidiAudio = "playing";
        update();
        await player.play();
        ayat.konsidiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            onConfirm: () => print("Ok"),
            title: "Terjadi kesalahan ",
            middleText: e.message.toString());
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
            onConfirm: () => print("Ok"),
            title: "Terjadi kesalahan ",
            middleText: e.message.toString());
      } catch (e) {
        Get.defaultDialog(
            onConfirm: () => print("Ok"),
            title: "Terjadi kesalahan ",
            middleText: "Tidak Dapat Memutar audio");
      }
      // Fallback for all errors

    } else {
      Get.defaultDialog(
          onConfirm: () => print("Ok"),
          title: "Terjadi kesalahan ",
          middleText: "Audio Tidak Dapat diakses");
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
