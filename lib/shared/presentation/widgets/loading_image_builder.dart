import 'package:flutter/material.dart';

class LoadingImageBuilder extends StatelessWidget {
  final double size;
  final ImageChunkEvent? loadingProgress;
  final Widget child;
  const LoadingImageBuilder({super.key, required this.size, this.loadingProgress, required this.child});

  @override
  Widget build(BuildContext context) {
    if (loadingProgress == null) return child;

    return SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: CircularProgressIndicator(
          value:
              loadingProgress?.expectedTotalBytes != null
                  ? loadingProgress!.cumulativeBytesLoaded /
                      loadingProgress!.expectedTotalBytes!
                  : null,
          strokeWidth: 2,
        ),
      ),
    );
  }
}