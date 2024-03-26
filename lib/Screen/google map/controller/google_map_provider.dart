import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kodion_projects/Common/global_data.dart';

class GoogleMapProvider extends GetxController {
  //!

  RxDouble? userLat = 0.0.obs;
  RxDouble? userLng = 0.0.obs;

  Completer<GoogleMapController> mapController = Completer();
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(30.6756, 76.7403), zoom: 14.0);
  List<LatLng> polyLineCordinate = [];
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

//! move position ..

  void moveUser() async {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
    print("positionStream :: $positionStream");
  }

//! get PolyPointe for draw the line
  Future getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult polylineRessult =
        await polylinePoints.getRouteBetweenCoordinates(
            GlobalData.mapKey,
            const PointLatLng(30.6756, 76.7403),
            const PointLatLng(30.7008, 76.7127));
    print("polylineRessult :: $polylineRessult");

    if (polylineRessult.points.isNotEmpty) {
      for (var points in polylineRessult.points) {
        polyLineCordinate.add(LatLng(points.latitude, points.longitude));
      }
    }
  }

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
      desiredAccuracy: LocationAccuracy.high,
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
    // await getPolyPoints();
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

  // final Set<Polyline> drawpolyline = {};

  // void drawPolyLine() {
  //   drawpolyline.add(
  //     Polyline(
  //       polylineId: const PolylineId("1"),
  //       color: Colors.blue,
  //       points: [
  //         LatLng(double.parse(userLat!.value.toString()),
  //             double.parse(userLng!.value.toString())),
  //         const LatLng(30.7008, 76.7127),
  //         const LatLng(30.710504, 76.712889),
  //       ],
  //     ),
  //   );
  // }

  //!onInit

  @override
  void onInit() async {
    determinePosition();
    var userLocationDetails = await determinePosition();
    userLat = userLocationDetails.latitude.obs;
    userLng = userLocationDetails.longitude.obs;
    addCustomMarker();
    print("User Location Details :: ${userLocationDetails.toString()}");
    getPolyPoints();
    super.onInit();
  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }
}
