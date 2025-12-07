// chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_ai_learn/repository/chat_repository.dart';
import 'package:flutter_ai_learn/viewmodel/chat_viewmodel.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // Importante para formatar
import 'package:provider/provider.dart'; // Assumindo que você usa provider


// Configuração simples do Provider na raiz (pode ser no main.dart)
class ChatPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(ChatRepository()),
      child: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Acessa o ViewModel
    final viewModel = context.watch<ChatViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Gemini ChatBot")),
      body: Column(
        children: [
          // Área da Lista de Mensagens
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.messages.length,
              itemBuilder: (context, index) {
                final msg = viewModel.messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Limita a largura do balão para não ocupar a tela toda
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: msg.isUser
                        ? Text(msg.message, style: const TextStyle(color: Colors.white))
                        // Se for o robô, usa Markdown para renderizar bonito
                        : MarkdownBody(data: msg.message),
                  ),
                );
              },
            ),
          ),

          // Área de Input
          if (viewModel.isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Digite sua mensagem...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => {
                      viewModel.sendMessage(_controller.text),
                      _controller.clear(),
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => viewModel.sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}