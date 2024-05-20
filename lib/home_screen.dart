import 'dart:convert';

import 'package:assignment_004/photo_details_screen.dart';
import 'package:assignment_004/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPhotoListInProgress = true;
  List<PhotoModel> photoList = [];

  @override
  void initState() {
    super.initState();
    _getAllPhotoList();
    print(photoList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Photo Gallery App"),
        ),
        body: Visibility(
          visible: _isPhotoListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: photoList.length,
                    itemBuilder: (context, index) {
                      // print(allPhotos[index].thumbnailUrl);
                      return Card(
                        elevation: 0,
                        // shadowColor: Colors.black,
                        color: Colors.transparent,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PhotoDetailsScreen(
                                          photoData: photoList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    child: Image.network(
                                      photoList[index].thumbnailUrl.toString(),
                                      width: 100,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            photoList[index].title.toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _getAllPhotoList() async {
    _isPhotoListInProgress = true;
    setState(() {});
    photoList.clear();
    const String photoListUrl = "https://jsonplaceholder.typicode.com/photos";
    Response response = await get(Uri.parse(photoListUrl));
    if (response.statusCode == 200) {
      final allPhotos = jsonDecode(response.body);
      for (Map<String, dynamic> photo in allPhotos) {
        if (photoList.length > 25) {
          break;
        }
        photoList.add(PhotoModel.fromJson(photo));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Get photo list failed, try again."),
      ));
    }
    _isPhotoListInProgress = false;
    setState(() {});
  }
}
