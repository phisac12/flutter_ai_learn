import 'package:flutter/material.dart';
import 'package:flutter_ai_learn/constants/constants.dart';
import 'package:flutter_ai_learn/model/chat_message_model.dart';
import 'package:flutter_ai_learn/repository/chat_repository.dart';


class ChatViewModel extends ChangeNotifier {
  late final ChatRepository _chatRepository;

  final List<ChatMessageModel> _messages = [];
  List<ChatMessageModel> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ChatViewModel(this._chatRepository);

  Future<void> sendMessage(String message) async {
    if(message.trim().isEmpty) return;

    _messages.add(ChatMessageModel(message: message, isUser: true));
    _isLoading = true;
    notifyListeners();

    final responseText = await _chatRepository.sendMessage(message);

    _messages.add(ChatMessageModel(message: responseText, isUser: false));
    _isLoading = false;
    notifyListeners();
    
  }

}