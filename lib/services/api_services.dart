import 'package:http/http.dart' as http;

class ApiServices {
  Future<http.Response> get(String path) async {
      return await http.get(
        Uri.parse(path),
      );
  }
}