import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toponomy_app/controller/place_controller.dart';
import 'package:toponomy_app/model/place.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GoogleMapController mapController;
  List<Marker> markers = [];
  String username = "";
  int id = 0;

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
    _getUserData();
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? "false";
    id = prefs.getInt('userId') ?? 0;
  }

  Future<void> _fetchPlaces() async {
    // Fetch places from the API
    List<Place> places = await PlaceController().getPlaces();

    // Create markers from places
    List<Marker> newMarkers = places.map((place) {
      return Marker(
        markerId: MarkerId(place.id.toString()),
        position: LatLng(place.latitude, place.longitude),
        onTap: () {
          // Handle marker tap
          _showPlaceDetailsDialog(place.id);
        },
      );
    }).toList();

    setState(() {
      markers = newMarkers;
    });
  }

  void _showPlaceDetailsDialog(int placeId) async {
    // Fetch details of a place by its ID
    Place placeDetails = await PlaceController().getPlace(placeId);

    // Show dialog with place details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Place Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${placeDetails.id}'),
              Text('Owner ID: ${placeDetails.ownerId}'),
              // Display other details as needed
            ],
          ),
          actions: [
            if (placeDetails.ownerId == 'yourUserId')
              TextButton(
                onPressed: () {
                  // Handle update action
                },
                child: Text('Update'),
              ),
            if (placeDetails.ownerId == 'yourUserId')
              TextButton(
                onPressed: () {
                  // Handle delete action
                },
                child: Text('Delete'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addMarker(LatLng position) {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          onTap: () {
            _showPlaceDetailsDialog(0); // Dummy placeId for adding marker
          },
        ),
      );
    });
  }

  void _addPlace(LatLng position) {
    // Implementasi logika untuk menambahkan tempat baru
    // misalnya, menampilkan dialog input data dan menambahkan marker ke peta
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Tempat Baru'),
          content: Column(
            children: [
              Text('Latitude: ${position.latitude}'),
              Text('Longitude: ${position.longitude}'),
              // Tambahkan input field atau widget lainnya sesuai kebutuhan
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Implementasi logika untuk menambahkan tempat baru
                // misalnya, kirim data ke API, simpan ke database lokal, dll.
                // Setelah berhasil, tambahkan marker ke peta dan tutup dialog
                _addMarker(position);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        onTap: (position) {
          // Tanggapi ketika peta ditekan
          _addPlace(position);
        },
        markers: Set<Marker>.of(markers),
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0),
          zoom: 2.0,
        ),
      ),
    );
  }
}
