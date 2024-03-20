import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/Home/Controller/home_provider.dart';
import 'package:kodion_projects/Screen/Home/Widget/user_card_widget.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/add_update_user_page.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/controller/add_update_profile_provider.dart';

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
                  return userListData != null
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) async {
                                  if (direction ==
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
                                      var d =
                                          controller.dropdownvalue!.value = '';
                                      print("orF Clear :: $d");
                                    });
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    //! Delete the UserDetails Based His Id
                                    await DataBaseHelper.dataBaseHelper
                                        .deleteUser(int.parse(snapshot
                                            .data[index]['id']
                                            .toString()));
                                    Get.snackbar("User Details",
                                        "${snapshot.data[index]['id'].toString()} Deleted successfully",
                                        backgroundColor: Colors.green.shade50);
                                  }
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
                          })
                      : const Expanded(
                          child: Center(
                            child: Text("No user data found"),
                          ),
                        );
                } else if (snapshot.hasError) {
                  return const Text("Error Occure");
                } else {
                  return const Center(
                    child: Text("Loading Field"),
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
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey[100],
        label: const Text("Create Details"),
        onPressed: () {
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
      ),
    );
  }
}
