import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/home/Controller/search_user_provider.dart';
import 'package:kodion_projects/Screen/profile/add/add_users.dart';
import 'package:kodion_projects/Screen/profile/add/widget/user_list_widget.dart';
import 'package:kodion_projects/Screen/profile/update/update_user_details.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getSearchController = Get.put(SearchUserProvider());
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
    print(item.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB394C9),
        title: const Text(
          "User List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.black26,
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
                          controller:
                              getSearchController.searchController.value,
                          cursorColor: Colors.black,
                        ),
                      ),
                    ),
                    getSearchController.searchController.value.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                getSearchController.searchController.value
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

          //! This is using FutureBuilder
          Expanded(
              child: FutureBuilder(
            future: item,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                Get.snackbar("Edit", "message");
                                Get.to(
                                  UserUpdateDataPage(
                                      userData: snapshot.data[index]),
                                )!
                                    .then((value) => setState(() {
                                          item;
                                        }));
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                //! Delete the UserDetails Based His Id
                                await DataBaseHelper.dataBaseHelper.deleteUser(
                                    int.parse(
                                        snapshot.data[index]['id'].toString()));
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
                            child: CustomListTileWidget(
                              userNameFirstLetter: snapshot.data[index]
                                      ['userName'][0]
                                  .toString()
                                  .toUpperCase(),
                              userEmail:
                                  snapshot.data[index]['userEmail'].toString(),
                              userName: snapshot.data[index]['userName']
                                  .toString()
                                  .capitalize,
                            ));
                      });
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

          //! userList show using the StreamBuilder ..
          // Expanded(
          //   child: StreamBuilder(
          //     stream: item,
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator());
          //       } else if (snapshot.connectionState == ConnectionState.done) {
          //         if (snapshot.hasError) {
          //           return const Center(child: Text("Loading Error"));
          //         } else if (snapshot.hasData) {
          //           return ListView.builder(
          //               itemCount: snapshot.data.length,
          //               itemBuilder: (context, index) {
          //                 return CustomListTileWidget(
          //                   userEmail: snapshot.data[index]['userEmail'],
          //                   userName: snapshot.data[index]['userName'],
          //                 );
          //               });
          //         } else {
          //           return const Center(child: CircularProgressIndicator());
          //         }
          //       } else {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Create Details"),
        onPressed: () {
          Get.to(const RegisterationPage())!.then((value) => setState(() {
                userListData = DataBaseHelper.dataBaseHelper.fetchUser();
                item = userListData;
              }));
        },
      ),
    );
  }
}
