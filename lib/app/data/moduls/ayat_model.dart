// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';


class Ayat {
  Ayat({
    this.number,
    this.meta,
    this.text,
    this.translation,
    this.audio,
    this.tafsir,
    this.surah,
  });

  Number? number;
  Meta? meta;
  Text? text;
  Translation? translation;
  Audio? audio;
  Tafsir? tafsir;
  Surah ?surah;

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        number: json["number"] == null ? null : Number.fromJson(json["number"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        text: json["text"] == null ? null : Text.fromJson(json["text"]),
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
        tafsir: json["tafsir"] == null ? null : Tafsir.fromJson(json["tafsir"]),
        surah: json["surah"] == null ? null : Surah.fromJson(json["surah"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number?.toJson(),
        "meta": meta?.toJson(),
        "text": text?.toJson(),
        "translation": translation?.toJson(),
        "audio": audio?.toJson(),
        "tafsir": tafsir?.toJson(),
        "surah": surah?.toJson(),
      };
}

class Audio {
  Audio({
    this.primary,
    this.secondary,
  });

  String? primary;
  List<String>? secondary;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary:json["secondary"]== null ? null: List<String>.from(json["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": List<dynamic>.from(secondary!.map((x) => x)),
      };
}

class Meta {
  Meta({
    this.juz,
    this.page,
    this.manzil,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  int? juz;
  int? page;
  int? manzil;
  int? ruku;
  int? hizbQuarter;
  Sajda? sajda;

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
        juz: json?["juz"],
        page: json?["page"],
        manzil: json?["manzil"],
        ruku: json?["ruku"],
        hizbQuarter: json?["hizbQuarter"],
        sajda: Sajda.fromJson(json?["sajda"]),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda?.toJson(),
      };
}

class Sajda {
  Sajda({
    this.recommended,
    this.obligatory,
  });

  bool? recommended;
  bool? obligatory;

  factory Sajda.fromJson(Map<String, dynamic>? json) => Sajda(
        recommended: json?["recommended"],
        obligatory: json?["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

class Number {
  Number({
    this.inQuran,
    this.inSurah,
  });

  int? inQuran;
  int? inSurah;

  factory Number.fromJson(Map<String, dynamic>? json) => Number(
        inQuran: json?["inQuran"],
        inSurah: json?["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Surah {
  Surah();

  factory Surah.fromJson(Map<String, dynamic> json) => Surah();

  Map<String, dynamic> toJson() => {};
}

class Tafsir {
  Tafsir({
    this.id,
  });

  Id? id;

  factory Tafsir.fromJson(Map<String, dynamic>? json) => Tafsir(
        id: Id.fromJson(json?["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id!.toJson(),
      };
}

class Id {
  Id({
    this.short,
    this.long,
  });

  String? short;
  String? long;

  factory Id.fromJson(Map<String, dynamic>? json) => Id(
        short: json?["short"],
        long: json?["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}

class Text {
  Text({
    this.arab,
    this.transliteration,
  });

  String ?arab;
  Transliteration? transliteration;

  factory Text.fromJson(Map<String, dynamic> ?json) => Text(
        arab: json?["arab"],
        transliteration: Transliteration.fromJson(json?["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration!.toJson(),
      };
}

class Transliteration {
  Transliteration({
    this.en,
  });

  String ?en;

  factory Transliteration.fromJson(Map<String, dynamic>? json) =>
      Transliteration(
        en: json?["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Translation {
  Translation({
    this.en,
    this.id,
  });

  String? en;
  String? id;

  factory Translation.fromJson(Map<String, dynamic>? json) => Translation(
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}
