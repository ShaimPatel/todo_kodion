import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                child: Obx(() => Stack(
                      children: [
                        GoogleMap(
                          // mapType: MapType.hybrid,
                          initialCameraPosition: googleProvider.cameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            print(googleProvider.cameraPosition);
                            googleProvider.mapController.complete(controller);
                            googleProvider.customInfoWindowController
                                .googleMapController = controller;
                          },
                          onTap: (position) {
                            googleProvider
                                .customInfoWindowController.hideInfoWindow!();
                          },
                          onCameraMove: (position) {
                            googleProvider
                                .customInfoWindowController.onCameraMove!();
                          },
                          myLocationEnabled: true,
                          zoomControlsEnabled: true,
                          myLocationButtonEnabled: true,
                          // polylines: {
                          //   Polyline(
                          //     polylineId: const PolylineId("route"),
                          //     points: googleProvider.polyLineCordinate,
                          //     color: Colors.red,
                          //     width: 3,
                          //   )
                          // },
                          polylines: googleProvider.drawpolyline,
                          markers: {
                            Marker(
                                icon: BitmapDescriptor.defaultMarker,
                                markerId: const MarkerId('userLocation'),
                                position: LatLng(googleProvider.userLat!.value,
                                    googleProvider.userLng!.value),
                                onTap: () {
                                  googleProvider.customInfoWindowController
                                          .addInfoWindow!(
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Row(
                                            children: [
                                              Expanded(
                                                child: Image(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS84JVXPQA4K6-W9qcYYgxbWUIEZiBMbKZ0KI1k5L1-Vg&s",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Kodion",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text("Jr. Flutter Developer",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16)),
                                                  Text("Shivam Patel",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16)),
                                                ],
                                              )
                                            ],
                                          )),
                                      LatLng(googleProvider.userLat!.toDouble(),
                                          googleProvider.userLng!.toDouble()));
                                }),
                            Marker(
                              icon: BitmapDescriptor.defaultMarker,
                              markerId: const MarkerId('dropLocation'),
                              position: const LatLng(30.7008, 76.7127),
                              onTap: () {
                                googleProvider.customInfoWindowController
                                        .addInfoWindow!(
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        // width: 500,
                                        // height: 500,
                                        child: const Row(
                                          children: [
                                            Expanded(
                                              child: Image(
                                                width: 120,
                                                height: 200,
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSVfNjMJsjy6yZFoAPFAhRMyl2SoHBy864KMirxgW0Hg&s",
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Mattur",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text("Dash Meash Atta Chakki",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16)),
                                                Text("Near ZimmiDara Dhaba",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16)),
                                              ],
                                            )
                                          ],
                                        )),
                                    const LatLng(30.7008, 76.7127));
                              },
                            ),
                            const Marker(
                              markerId: MarkerId("3"),
                              position: LatLng(30.710504, 76.712889),
                            )
                          },
                        ),
                        CustomInfoWindow(
                          controller: googleProvider.customInfoWindowController,
                          height: 140,
                          width: 300,
                          offset: 40,
                        ),
                      ],
                    ))),
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
                        onTap: () {
                          googleProvider.animateToUserLOcation();
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
