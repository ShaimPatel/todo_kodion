import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapProvider extends GetxController {
  //!

  RxString? userLat = ''.obs;
  RxString? userLng = ''.obs;

  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  // Rx<Completer<GoogleMapController>> newmapController =
  //     Completer<GoogleMapController>().obs;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(
      30.6756,
      76.7403,
    ),
    zoom: 14.0,
  );

  // Getting the user Currant location ..

  FutureOr<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;
    serviceEnabled = (await Geolocator.isLocationServiceEnabled());
    print(serviceEnabled);
    if (!serviceEnabled) {
      Get.snackbar(
        "Error",
        "Location service are disabled.",
        backgroundColor: const Color.fromARGB(255, 187, 39, 29),
        colorText: Colors.white,
      );
      return Future.error("Location service are disabled.");
    }

    //! Lets take Permisson for enable the location .
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        Get.snackbar(
          "Location Denied",
          "Location permission are denied",
          backgroundColor: const Color.fromARGB(255, 187, 39, 29),
          colorText: Colors.white,
        );
        return Future.error("Location permission are denied");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request permissions.");
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

//! Animate the camera

  animateToUserLOcation() async {
    GoogleMapController controller = await mapController.future;

    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng latLngPosition = LatLng(cPosition.latitude, cPosition.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 18.0);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // userLat = cPosition.latitude as RxString;
    // userLng = cPosition.longitude as RxString;
    drawPolyLine();
  }
//! Add Custom Marker ..

  BitmapDescriptor imageIcon = BitmapDescriptor.defaultMarker;
  void addCustomMarker() async {
    await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      "assets/icons/gender.png",
    ).then((icon) {
      imageIcon = icon;
    });
  }

//! Draw  the polyLine

  final Set<Polyline> drawpolyline = {};

  void drawPolyLine() {
    drawpolyline.add(
      Polyline(
        polylineId: const PolylineId("1"),
        color: Colors.blue,
        points: [
          LatLng(double.parse(userLat!.value.toString()),
              double.parse(userLng!.value.toString())),
          const LatLng(30.7008, 76.7127),
        ],
      ),
    );
  }

  //!onInit

  @override
  void onInit() async {
    var userLocationDetails = await determinePosition();
    userLat = userLocationDetails.latitude.toString().obs;
    userLng = userLocationDetails.longitude.toString().obs;
    addCustomMarker();
    print("User Location Details :: ${userLocationDetails.toString()}");
    super.onInit();
  }
}
