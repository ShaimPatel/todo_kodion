import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kodion_projects/Screen/google%20map/controller/google_map_provider.dart';

class GoogleMapPage extends StatelessWidget {
  GoogleMapPage({super.key});

  final googleProvider = Get.put(GoogleMapProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
                decoration: const BoxDecoration(
                    // color: Colors.purple[50],
                    ),
                child: Obx(
                  () => GoogleMap(
                    // mapType: MapType.hybrid,
                    initialCameraPosition: googleProvider.cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      print(googleProvider.cameraPosition);
                      googleProvider.mapController.complete(controller);
                    },
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    polylines: googleProvider.drawpolyline,
                    markers: {
                      Marker(
                        icon: BitmapDescriptor.defaultMarker,
                        markerId: const MarkerId('userLocation'),
                        position: LatLng(
                          double.parse(
                              googleProvider.userLat!.value.toString()),
                          double.parse(
                              googleProvider.userLng!.value.toString()),
                        ),
                      ),
                      const Marker(
                        icon: BitmapDescriptor.defaultMarker,
                        markerId: MarkerId('dropLocation'),
                        position: LatLng(30.7008, 76.7127),
                      ),
                    },
                  ),
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "User Currant Location",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "User Lat : ${googleProvider.userLat?.value.toString()}°",
                          ),
                          Text(
                              "User Lng : ${googleProvider.userLng?.value.toString()}°"),
                        ],
                      ),
                    ),
                    const Spacer(),
                    //! Get user Location Button ..
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await googleProvider.animateToUserLOcation();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
