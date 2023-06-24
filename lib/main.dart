import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_insta/flutter_insta.dart';

void main() {
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterInsta flutterInsta = FlutterInsta();
  TextEditingController usernameController = TextEditingController();

  String? username, followers = " ", following, bio, profileimage;
  bool pressed = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Image.network(
          "https://internshala.com/cached_uploads/logo%2F61854ab3343981636125363.png",
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter Insta Username to get Info....",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                  controller: usernameController,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                child: const Text("Get Insta Info"),
                onPressed: () async {
                  setState(() {
                    pressed = true;
                  });

                  await printDetails(usernameController.text); //get Data
                },
              ),
              pressed
                  ? SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    "$profileimage",
                                    width: 120,
                                  ) as Image,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Text(
                                  "$username",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "$followers\nFollowers",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "$following\nFollowing",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Text(
                                  "$bio",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future printDetails(String username) async {
    await flutterInsta.getProfileData(username);
    setState(() {
      this.username = flutterInsta.username; //username
      followers = flutterInsta.followers; //number of followers
      following = flutterInsta.following; // number of following

      bio = flutterInsta.bio; // Bio

      profileimage = flutterInsta.imgurl; // Profile picture URL
      print(followers);
    });
  }
}

 // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Color.fromARGB(255, 93, 121, 135),
      //     onPressed: () {
      //       showModalBottomSheet(
      //         context: context,
      //         isScrollControlled: true,
      //         builder: (context) {
      //           return Padding(
      //             padding: EdgeInsets.only(
      //                 bottom: MediaQuery.of(context).viewInsets.bottom),
      //             child: SizedBox(
      //               height: 60,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: TextField(
      //                   autofocus: false,
      //                   focusNode: _searchFocusNode,
      //                   controller: _searchController,
      //                   decoration: InputDecoration(
      //                     prefixIcon: IconButton(
      //                       icon: const Icon(
      //                         Icons.search,
      //                       ),
      //                       onPressed: () {
      //                         print(_searchController.text);
      //                         if (_searchController.text != null) {
      //                           UserData()
      //                               .getReq(_searchController.text)
      //                               .then((profiles) {
      //                             profile = Profile(profiles[0], profiles[1],
      //                                 profiles[2], profiles[3], profiles[4]);

      //                             setState(() {
      //                               isProfile = true;
      //                             });
      //                           });
      //                         } else {
      //                           profile = Profile('-', 0, 0, '', 0);
      //                         }
      //                       },
      //                     ),
      //                     hintText: 'Type Insta User Name here...',
      //                     border: OutlineInputBorder(
      //                         borderSide: const BorderSide(color: Colors.grey),
      //                         borderRadius: BorderRadius.circular(20)),
      //                     focusedBorder: OutlineInputBorder(
      //                         borderSide: const BorderSide(color: Colors.grey),
      //                         borderRadius: BorderRadius.circular(20)),
      //                   ),
      //                   onSubmitted: (value) {
      //                     if (value != null) {
      //                       UserData().getReq(value).then((profiles) {
      //                         profile = Profile(profiles[0], profiles[1],
      //                             profiles[2], profiles[3], profiles[4]);

      //                         setState(() {
      //                           isProfile = true;
      //                         });
      //                       });
      //                     } else {}
      //                   },
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     },
      //     child: Icon(Icons.search, color: Color.fromARGB(255, 244, 221, 219))),