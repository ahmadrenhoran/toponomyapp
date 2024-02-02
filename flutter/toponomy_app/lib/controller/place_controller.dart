import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toponomy_app/model/place.dart';

class PlaceController {
  final String baseUrl = "http://127.0.0.1:5207/api/places";

  Future<List<Place>> getPlaces() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<Place> places = list.map((model) => Place.fromJson(model)).toList();
      return places;
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<Place> getPlace(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/show?id=$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Place place = Place.fromJson(data);
      return place;
    } else {
      throw Exception('Failed to load place');
    }
  }

  Future<void> addPlace(Place place) async {
    final response = await http.post(
      Uri.parse('$baseUrl/places/store'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(place.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add place');
    }
  }

  Future<void> updatePlace(Place place) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(place.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update place');
    }
  }

  Future<void> deletePlace(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete?id=$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete place');
    }
  }
}
