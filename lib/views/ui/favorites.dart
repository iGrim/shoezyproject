import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/checkout_btn.dart';
import 'package:online_shop/views/ui/homepage.dart';
import 'package:online_shop/views/ui/mainscreen.dart';

class Favorites extends StatefulWidget {
  Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _favBox = Hive.box('fav_box');

  _deleteCart(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> fav = [];
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price']
      };
    }).toList();

    fav = favData.reversed.toList();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),

                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                                        "My Favorites",
                                        style: appstyle(36, Colors.white, FontWeight.bold),
                                      ),
                      ),
               
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 100),
                  itemCount: fav.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final shoe = fav[index];
                    return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: const Offset(0, 1)),
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: shoe['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, left: 20),
                                          child: Column(
                                           
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                shoe['name'],
                                                style: appstyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                shoe['category'],
                                                style: appstyle(
                                                    14,
                                                    Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${shoe['price']}",
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                 
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _deleteCart(shoe['key']);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                               MainScreen()));
                                                },
                                                child: const Icon(
                                                  Ionicons.md_heart_dislike,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                     ],
                                ),
                              ),
                            ),
                          );
                        
                  }),
            )
          ],
        ),
      ),
    );
  }
}
