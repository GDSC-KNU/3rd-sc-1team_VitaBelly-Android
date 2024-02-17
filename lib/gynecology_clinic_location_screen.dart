import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/place_services.dart';

class GynecologyClinicLocationScreen extends StatefulWidget {
  @override
  _GynecologyClinicLocationScreenState createState() =>
      _GynecologyClinicLocationScreenState();
}

class _GynecologyClinicLocationScreenState
    extends State<GynecologyClinicLocationScreen> {
  final Location location = Location();
  LatLng? _initialPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // 위치 서비스 활성화 및 권한 확인
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // 현재 위치 데이터 가져오기
    _locationData = await location.getLocation();
    setState(() {
      _initialPosition =
          LatLng(_locationData.latitude!, _locationData.longitude!);
    });

    // 산부인과 위치 검색 및 마커 추가
    _searchGynecologyClinics(_initialPosition!);
  }

  Future<void> _searchGynecologyClinics(LatLng currentPosition) async {
    final String apiKey = dotenv.env['GOOGLE_API_KEY']!;
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    final String requestUrl =
        '$baseUrl?key=$apiKey&location=${currentPosition.latitude},${currentPosition.longitude}&radius=5000&type=doctor&keyword=gynecologist';

    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _addMarkers(data['results']);
    } else {
      throw Exception('Failed to load places');
    }
  }

  void _addMarkers(List<dynamic> places) {
    setState(() {
      _markers.clear();
      for (var place in places) {
        final marker = Marker(
          markerId: MarkerId(place['place_id']),
          position: LatLng(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']),
          infoWindow: InfoWindow(
            title: place['name'],
            snippet: place['vicinity'],
            onTap: () {
              _onMarkerTapped(place['place_id']);
            },
          ),
        );
        _markers.add(marker);
      }
    });
  }

  void _onMarkerTapped(String placeId) async {
    final String apiKey = dotenv.env['GOOGLE_API_KEY']!;
    try {
      final Map<String, dynamic> placeDetails =
          await PlaceService.fetchPlaceDetail(placeId, apiKey, language: 'ko');
      int reviewsCount = placeDetails['reviews']?.length ?? 0;
      final Map<String, dynamic> placeDetailsEn =
          await PlaceService.fetchPlaceDetail(placeId, apiKey, language: 'en');

      List<Widget> dialogContent = [
        Text('주소: ${placeDetails['formatted_address']}'),
        Text('${placeDetailsEn['formatted_address']}'),
        SizedBox(height: 10),
        Text('리뷰: $reviewsCount개'),
      ];

      if (reviewsCount > 0) {
        dialogContent.add(SizedBox(height: 10));
        dialogContent.addAll(placeDetails['reviews'].map<Widget>((review) {
          return ListTile(
            title: Text(review['author_name']),
            subtitle: Text(review['text']),
            trailing: Text('${review['rating']} ★'),
          );
        }).toList());
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(placeDetails['name']),
          content: SingleChildScrollView(
            child: ListBody(children: dialogContent),
          ),
          actions: [
            TextButton(
              child: Text('닫기'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('산부인과 위치 정보'),
      ),
      body: _initialPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition!,
                zoom: 14.4746,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
