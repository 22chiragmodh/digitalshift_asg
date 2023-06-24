import 'package:http/http.dart' as http;
import 'dart:convert';

class UserData {
  final String _accessToken =
      'EAAC6U2xUWPABAHHvv7LuTdgYSVpONm6pS5lPLZChX49qxV6otegRMMuWZB0h0MyaPNAZB156W4teSNUKZCzT0BTyYhhV8SWWqMQiPJM39eoZBjSL6y3V1NsHIMWWogf0bOdhg2ZA6HXKzEkZAd5BJs2oDbr5SZC5fHZA9Vc0ywv7wqooeIgmZBwJhQ1kPmGtk23ZBjQZBddJasYbfprpCeIOOp9iyU8RuzqDScKNvdBofcMrVZAOtZAcxu6Elj'; // Replace with your Instagram Graph API access token
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        "Authorization": "Bearer $_accessToken",
      };
  Future<List> getReq(value) async {
    // var url = Uri.parse('https://www.instagram.com/$value/?__a=1');
    var url = Uri.parse(
        'https://graph.instagram.com/v11.0/$value/media?access_token=${_accessToken}');

    // final apiUrl =
    //     'https://graph.instagram.com/$value?fields=followers_count,follows_count,media_count&access_token=$_accessToken';

    var res = await http.get(url);

    // Successful response, parse the JSON data
    var jsonData = json.decode(res.body);
    print(jsonData);
    String bio = jsonData['graphql']['user']['biography'];
    String imgUrl = jsonData['graphql']['user']['profile_pic_url_hd'];
    int followers = jsonData['graphql']['user']['edge_followed_by']['count'];
    int followings = jsonData['graphql']['user']['edge_follow']['count'];
    int posts =
        jsonData['graphql']['user']['edge_owner_to_timeline_media']['count'];

    return [bio, followers, followings, imgUrl, posts];
    // Process the data as needed

    // Error response, handle accordingly
  }

  Future<Map<String, dynamic>> fetchUserData(String username) async {
    final url = Uri.parse('http://10.0.2.2:3000/user/$username');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      print(userData);
      return userData;
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}
