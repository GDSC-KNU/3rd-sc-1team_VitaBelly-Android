import 'dart:convert';
import 'package:http/http.dart' as http;

class PlaceService {
  static Future<Map<String, dynamic>> fetchPlaceDetail(
      String placeId, String apiKey,
      {String language = 'en'}) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey&language=$language';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['result'];
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
