import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/helper/utils.dart';

class CustomUploadPic extends StatefulWidget {
  const CustomUploadPic(
      {super.key, required this.productImage, required this.radius});
  final String productImage;
  final double radius;

  @override
  State<CustomUploadPic> createState() => _CustomUploadPicState();
}

class _CustomUploadPicState extends State<CustomUploadPic> {
  Uint8List? image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          image != null
              ? CircleAvatar(
                  radius: widget.radius,
                  backgroundImage: MemoryImage(image!),
                )
              : CircleAvatar(
                  radius: widget.radius,
                  backgroundImage: NetworkImage(widget.productImage),
                ),
          Positioned(
            bottom: -10,
            right: -10,
            child: IconButton(
              onPressed: () {
                selectImage();
              },
              icon: const Icon(
                Icons.add_a_photo_rounded,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
