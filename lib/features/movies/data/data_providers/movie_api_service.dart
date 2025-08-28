import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieApiService {
  final String apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to load movies");
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetail(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load movie detail");
    }
  }
}
