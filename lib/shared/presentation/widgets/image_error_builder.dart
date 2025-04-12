import 'package:flutter/material.dart';

class ImageErrorBuilder extends StatelessWidget {
  const ImageErrorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey.shade200,
      child: const Icon(Icons.error_outline, color: Colors.red),
    );
  }
}