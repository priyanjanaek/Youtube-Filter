import 'package:http/http.dart' as http;
import 'dart:convert';

class YouTubeService {
  Future<List<Map<String, String>>> fetchVideos(String accessToken) async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/videos?part=snippet&mine=true'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Map<String, String>> videos = [];

      for (var item in data['items']) {
        videos.add({
          'id': item['id'],
          'title': item['snippet']['title'],
          'link': 'https://www.youtube.com/watch?v=${item['id']}',
        });
      }

      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
