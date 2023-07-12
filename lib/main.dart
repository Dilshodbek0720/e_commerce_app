import 'package:flutter/material.dart';
import 'package:n8_default_project/ui/login/login_screen.dart';
import 'package:n8_default_project/ui/tab_box/tab_box.dart';
import 'data/local/storage_repository.dart';
import 'data/network/api_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StorageRepository.getString("token").length>0 ? TabBox(apiProvider: ApiProvider()) : LoginScreen(apiProvider: ApiProvider(),),
    );
  }
}

