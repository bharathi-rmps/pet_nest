import 'package:flutter/material.dart';
import 'futureFeature.dart';

class squareTileImage extends StatelessWidget{
  final String imgPath;
  const squareTileImage({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          futureFeature();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),

          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
                imgPath,
                height: 60,
            ),
          ),
        ),
      ),
    );
  }
}