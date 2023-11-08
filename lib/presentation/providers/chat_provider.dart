import 'package:chat_app/config/helpers/get_chat_app_answer.dart';
import 'package:chat_app/domain/entities/message.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final chatScrollController = ScrollController();
  final getChatAppAnswer = GetChatAppAnswer();

  List<Message> messages = [];

  Future<void> herReply() async {
    final herMessage = await getChatAppAnswer.getAnswer();
    messages.add(herMessage);
    notifyListeners();
    _moveScrollToButton();
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messages.add(newMessage);

    notifyListeners();
    _moveScrollToButton();

    if (text.endsWith('?')) herReply();
  }

  Future<void> _moveScrollToButton() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
