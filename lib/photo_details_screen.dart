import 'package:assignment_004/photo_model.dart';
import 'package:flutter/material.dart';

class PhotoDetailsScreen extends StatelessWidget {
  final PhotoModel photoData;

  const PhotoDetailsScreen({super.key, required this.photoData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(photoData.url.toString()),
              const SizedBox(
                height: 20,
              ),
              Text(
                "TITLE: ${photoData.title.toString()}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "ID: ${photoData.id.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
