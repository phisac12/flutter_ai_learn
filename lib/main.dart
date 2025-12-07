import 'package:flutter/material.dart';
import 'package:flutter_ai_learn/presentation/chat_screen.dart';
import 'package:flutter_ai_learn/repository/chat_repository.dart';
import 'package:flutter_ai_learn/viewmodel/chat_viewmodel.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(ChatRepository()),
      child:  MaterialApp(
      title: 'Gemini Chat',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const ChatScreen(),
    )
    );
  }
}
