import 'package:ageno_flutter_assessment_skills/core/di/injection.dart';
import 'package:ageno_flutter_assessment_skills/features/product/presentation/screens/product_list_screen.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await configureDependencies();

  runApp(DevicePreview(builder: (context) => const ProviderScope(child: App())));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1b39bc)),
        useMaterial3: true,
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 0),
      ),

      home: const ProductListScreen(),
    );
  }
}
