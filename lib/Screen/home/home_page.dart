import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Common/widget/error_page.dart';
import 'package:kodion_projects/Screen/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/Home/Controller/home_provider.dart';
import 'package:kodion_projects/Screen/Home/Widget/user_card_widget.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/add_update_user_page.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/controller/add_update_profile_provider.dart';
import 'package:kodion_projects/Screen/google%20map/google_map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getSearchController = Get.put(HomeController());
  final controller = Get.put(AddUpdateUserProfileController());

  late dynamic userListData;
  dynamic item;

  @override
  void initState() {
    userListData = DataBaseHelper.dataBaseHelper.fetchUser();
    item = userListData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User's Data"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              item = DataBaseHelper.dataBaseHelper
                                  .searchUser(value);
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: getSearchController
                              .searchTextEditController.value,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                    getSearchController
                            .searchTextEditController.value.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                getSearchController
                                    .searchTextEditController.value
                                    .clear();
                                item =
                                    DataBaseHelper.dataBaseHelper.fetchUser();
                              });
                            },
                            child: const Icon(Icons.cancel),
                          )
                        : const Icon(Icons.search)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          //! This is using FutureBuilder
          Expanded(
              child: FutureBuilder(
            future: item,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  print("Snapshot Data :: ${snapshot.hasData}");
                  return snapshot.data.isEmpty
                      ? const ErrorPage()
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                                key: UniqueKey(),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            content: const Text(
                                                "Are you sure you want to delete this data ?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    await DataBaseHelper
                                                        .dataBaseHelper
                                                        .deleteUser(int.parse(
                                                            snapshot.data[index]
                                                                    ['id']
                                                                .toString()))
                                                        .then((value) =>
                                                            setState(() {
                                                              userListData =
                                                                  DataBaseHelper
                                                                      .dataBaseHelper
                                                                      .fetchUser();
                                                              item =
                                                                  userListData;
                                                            }));
                                                    Get.back();
                                                    Get.snackbar("User Details",
                                                        "${snapshot.data[index]['id'].toString()} Deleted successfully",
                                                        backgroundColor: Colors
                                                            .green.shade50);
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(Colors
                                                                  .green)),
                                                  child: const Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(
                                                                  Colors.red)),
                                                  child: const Text(
                                                    "No",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ],
                                            title: const Text(
                                              "Delete User Data ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            elevation: 2.0,
                                          );
                                        });
                                  } else if (direction ==
                                      DismissDirection.startToEnd) {
                                    Get.to(
                                      AddUpdateUserProfilePage(
                                        userData: snapshot.data[index],
                                      ),
                                    )!
                                        .then((value) {
                                      setState(
                                        () {
                                          userListData = DataBaseHelper
                                              .dataBaseHelper
                                              .fetchUser();
                                          item = userListData;
                                        },
                                      );
                                      controller.nameController.value.clear();
                                      controller.emailController.value.clear();
                                      controller.numberController.value.clear();
                                      controller.selectedItem.clear();
                                      controller.dropdownvalue!.value = '';
                                    });
                                  }
                                  return null;
                                },
                                onDismissed: (direction) async {
                                  // else if (direction ==
                                  //     DismissDirection.endToStart) {
                                  //   //! Delete the UserDetails Based His Id
                                  //   await DataBaseHelper.dataBaseHelper
                                  //       .deleteUser(int.parse(snapshot
                                  //           .data[index]['id']
                                  //           .toString()))
                                  //       .then((value) => setState(() {
                                  //             userListData = DataBaseHelper
                                  //                 .dataBaseHelper
                                  //                 .fetchUser();
                                  //             item = userListData;
                                  //           }));
                                  //   Get.snackbar("User Details",
                                  //       "${snapshot.data[index]['id'].toString()} Deleted successfully",
                                  //       backgroundColor: Colors.green.shade50);
                                  // }
                                },
                                behavior: HitTestBehavior.opaque,
                                secondaryBackground: Container(
                                  color: Colors.deepPurple.shade50,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 18.0),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: CircleAvatar(
                                            child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),
                                  ),
                                ),
                                background: Container(
                                  color: Colors.deepPurple.shade50,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 18.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CircleAvatar(
                                            child: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ))),
                                  ),
                                ),
                                child: UserListCardWidget(
                                  userNameFirstLetter: snapshot.data[index]
                                          ['userName'][0]
                                      .toString()
                                      .toUpperCase(),
                                  userEmail: snapshot.data[index]['userEmail']
                                      .toString(),
                                  userName: snapshot.data[index]['userName']
                                      .toString()
                                      .capitalize,
                                ));
                          });
                } else if (snapshot.hasError) {
                  return const Expanded(child: Text("Error Occure"));
                } else {
                  return const Center(
                    child: Expanded(child: Text("Loading Data")),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Center(child: Text("No Record Found"));
              } else {
                return const Text("No Record");
              }
            },
          ))
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.grey[100],
      //   label: const Text("Create Details"),
      //   onPressed: () {
      //     Get.to(AddUpdateUserProfilePage(
      //       userData: null,
      //     ))!
      //         .then((value) {
      //       setState(() {
      //         userListData = DataBaseHelper.dataBaseHelper.fetchUser();
      //         item = userListData;
      //       });
      //       controller.nameController.value.clear();
      //       controller.emailController.value.clear();
      //       controller.numberController.value.clear();
      //       controller.selectedItem.clear();
      //       controller.dropdownvalue!.value = '';
      //     });
      //   },
      // ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        useRotationAnimation: true,
        childPadding: const EdgeInsets.all(5),
        buttonSize: const Size(50, 50),
        switchLabelPosition: false,
        children: [
          SpeedDialChild(
            label: "Add User",
            onTap: () {
              Get.to(AddUpdateUserProfilePage(
                userData: null,
              ))!
                  .then((value) {
                setState(() {
                  userListData = DataBaseHelper.dataBaseHelper.fetchUser();
                  item = userListData;
                });
                controller.nameController.value.clear();
                controller.emailController.value.clear();
                controller.numberController.value.clear();
                controller.selectedItem.clear();
                controller.dropdownvalue!.value = '';
              });
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
          SpeedDialChild(
              label: "Google Map",
              shape: const CircleBorder(),
              child: const Icon(Icons.share_location),
              onTap: () {
                Get.to(GoogleMapPage());
              }),
        ],
      ),
    );
  }
}
