import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taxonetime/colors/colors.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/models/categories.dart';
import 'package:taxonetime/models/userData.dart';
import 'package:taxonetime/screens/scanners/cnicScanner.dart';
import 'package:taxonetime/widgets/category_widget.dart';
import 'package:taxonetime/widgets/drawer.dart';
import 'package:taxonetime/widgets/shimmers.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FirebaseFirestore.instance
          .collection('userinfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (!value.exists) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: const Text(
                  'Scan CNIC to continue',
                  style: TextStyle(
                      color: Color(kDarkGreyColor),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                content: Scanners(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  email: FirebaseAuth.instance.currentUser!.email,
                ),
              ),
            ),
          );
        } else {
          FirebaseFirestore.instance
              .collection('userinfo')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            AuthController.authInstance.userData.value =
                UsersData.fromSnapshot(value);
          }).onError((error, stackTrace) {
            Get.snackbar(
              'Error',
              error.toString(),
              borderRadius: 0,
              backgroundColor: Colors.red,
              margin: const EdgeInsets.all(0),
              colorText: Colors.white,
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
              drawer: DrawerWidget(),
              appBar: AppBar(
                title: const Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 20),
                ),
                centerTitle: false,
                backgroundColor: const Color(0xFF41729F),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('slider')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  CarouselSlider.builder(
                                    options: CarouselOptions(
                                      height: 250,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 10),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 500),
                                      autoPlayCurve: Curves.ease,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    itemBuilder: (BuildContext context,
                                        int index, int realIndex) {
                                      var url = snapshot.data!.docs[index];
                                      return Stack(
                                        children: [
                                          Container(
                                            height: 250,
                                            margin: const EdgeInsets.all(0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(0)),
                                                child: Image.network(
                                                  url['imageUrl'],
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                )),
                                          ),
                                          Container(
                                            height: 250,
                                            margin: const EdgeInsets.all(0),
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 150,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                url['name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            top: 170,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                url['desc'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: snapshot.data!.docs.length,
                                  ),
                                ],
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Something went wrong'),
                              );
                            } else {
                              return Center(child: shimmers(250, context));
                            }
                          }),
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Services',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.miscellaneous_services),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 425,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('categories')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CategoryWidget(
                                      category: Categories.fromSnapshot(
                                        snapshot.data!.docs[index],
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: SpinKitCubeGrid(color: Colors.blueGrey),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
