import 'package:http/http.dart' as http;

void main() async {

  final res = await  http.get(Uri.parse("https://api.quran.sutanlab.id/surah"));

  print(res.body);
}