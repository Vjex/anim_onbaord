import 'package:flutter/material.dart';

class SingleScreenDataWidget extends StatelessWidget {
  final Size size;
  final String imagePath;
  final String screenTitle;
  const SingleScreenDataWidget(
      {Key? key,
      required this.size,
      required this.imagePath,
      required this.screenTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.22,
            width: size.width * 0.35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          Text(screenTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: size.height * 0.32,
          )
        ],
      ),
    );
  }
}
