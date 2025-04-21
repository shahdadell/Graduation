import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'dart:ui' as ui;

class SelectLocationScreen extends StatefulWidget {
  final LatLng initialLocation;
  static const String routeName = '/select-location';

  const SelectLocationScreen({super.key, required this.initialLocation});

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late LatLng _selectedLocation;
  double _currentZoom = 15.0;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation.latitude == 0.0 &&
        widget.initialLocation.longitude == 0.0) {
      _selectedLocation = LatLng(30.0444, 31.2357); // إحداثيات القاهرة
      print("Using default location (Cairo): $_selectedLocation");
    } else {
      _selectedLocation = widget.initialLocation;
      print("Initial Location: ${widget.initialLocation}");
    }
  }

  void _updateMarker(LatLng location) {
    setState(() {
      _selectedLocation = location;
      print("Selected Location Updated: $_selectedLocation");
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: MyTheme.whiteColor,
              size: 20.w,
            ),
          ),
        ),
        title: Text(
          "Select Location",
          style: textTheme.displayLarge?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: MyTheme.whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.orangeColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedLocation,
              initialZoom: _currentZoom,
              onTap: (tapPosition, point) {
                _updateMarker(point);
              },
              onMapReady: () {
                print("Map is ready!");
              },
              onPositionChanged: (position, hasGesture) {
                print(
                    "Map position changed: Center = ${position.center}, Zoom = ${position.zoom}");
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // بدون Subdomains
                userAgentPackageName: 'com.example.graduation_project',
                errorTileCallback: (tile, error, stackTrace) {
                  print("Error loading tile: $error");
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 16.h,
            left: 16.w,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: MyTheme.whiteColor,
              onPressed: () {
                setState(() {});
              },
              child: Icon(
                Icons.satellite,
                color: MyTheme.orangeColor,
                size: 20.w,
              ),
            ),
          ),
          Positioned(
            top: 16.h,
            right: 16.w,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: MyTheme.whiteColor,
                  onPressed: () {
                    setState(() {
                      _currentZoom += 1;
                      _mapController.move(_mapController.center, _currentZoom);
                      print("Zoom In: $_currentZoom");
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: MyTheme.orangeColor,
                    size: 20.w,
                  ),
                ),
                SizedBox(height: 8.h),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: MyTheme.whiteColor,
                  onPressed: () {
                    setState(() {
                      _currentZoom -= 1;
                      _mapController.move(_mapController.center, _currentZoom);
                      print("Zoom Out: $_currentZoom");
                    });
                  },
                  child: Icon(
                    Icons.remove,
                    color: MyTheme.orangeColor,
                    size: 20.w,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedLocation.latitude != 0.0 &&
                    _selectedLocation.longitude != 0.0) {
                  Navigator.pop(context, _selectedLocation);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please select a location',
                        style: textTheme.bodyMedium?.copyWith(
                          color: MyTheme.whiteColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      backgroundColor: MyTheme.redColor,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyTheme.orangeColor,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 3,
                shadowColor: MyTheme.grayColor3.withOpacity(0.4),
                minimumSize: ui.Size(double.infinity, 40.h),
              ),
              child: Text(
                'Confirm Location',
                style: textTheme.displayMedium?.copyWith(
                  color: MyTheme.whiteColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
