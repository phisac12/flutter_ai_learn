
import 'package:flutter_ai_learn/constants/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatRepository {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  
  ChatRepository() {
    _model = GenerativeModel(
      model: Constants.aiModel,
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    );
    _chatSession = _model.startChat(); 
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _chatSession.sendMessage(Content.text(message));
      return response.text ?? "Sem resposta.";
    } catch (e) {
      return "Erro: ${e.toString()}";
    }
  }
}