import 'dart:convert';
import 'dart:io';

class PokeApiClient {
  PokeApiClient({
    this.baseUrl = 'https://pokeapi.co/api/v2/',
  });

  final String baseUrl;
  final HttpClient _client = HttpClient();

  // For now just wraps GET
  Future<dynamic> get(String path, {Map<String, String>? query}) async {
    final uri =
        Uri.parse(baseUrl).resolve(path).replace(queryParameters: query);
    final request = await _client.getUrl(uri);
    final response = await request.close();

    final body = await utf8.decodeStream(response);

    if (response.statusCode != 200) {
      throw HttpException(
        'GET $uri failed: ${response.statusCode}',
        uri: uri,
      );
    }

    return json.decode(body);
  }
}
