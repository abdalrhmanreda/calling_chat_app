import 'package:calling_chat_app/features/chat/ui/widgets/receiver_row_view.dart';
import 'package:calling_chat_app/features/chat/ui/widgets/sender_row_view.dart';
import 'package:flutter/material.dart';
import '../../data/model/message_data_modal.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    // Access the message list from global members
    List<MessageData> messageList = [];
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      itemCount: messageList.length,
      itemBuilder: (context, index) => (messageList[index].isSender)
          ? SenderRowView(senderMessage: messageList[index].message)
          : ReceiverRowView(receiverMessage: messageList[index].message),
    );
  }
}
