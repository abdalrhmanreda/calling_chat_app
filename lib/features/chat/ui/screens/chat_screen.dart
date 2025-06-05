import 'package:flutter/material.dart';

// Message data model
class MessageData {
  final String message;
  final bool isSentByMe;
  final DateTime timestamp;

  MessageData(this.message, this.isSentByMe)
      : timestamp = DateTime.now();
}

// Global message list
List<MessageData> messageList = [];

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add some sample messages if the list is empty
    if (messageList.isEmpty) {
      messageList.addAll([
        MessageData("Hey! How are you doing?", false),
        MessageData("I'm doing great! Thanks for asking 😊", true),
        MessageData("That's awesome to hear!", false),
        MessageData("What about you? How's your day going?", true),
      ]);
    }
  }

  Future<void> scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage() {
    if (textEditingController.text.trim().isNotEmpty) {
      setState(() {
        messageList.add(MessageData(textEditingController.text.trim(), true));
        textEditingController.clear();
      });
      scrollToBottom();
    }
  }

  void receiveMessage() {
    if (textEditingController.text.trim().isNotEmpty) {
      setState(() {
        messageList.add(MessageData(textEditingController.text.trim(), false));
        textEditingController.clear();
      });
      scrollToBottom();
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4D5482),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D5482),
        elevation: 0,
        leadingWidth: 50.0,
        titleSpacing: -8.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Color(0xFF90C953),
            child: Text(
              'X',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'XD Usama',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'online',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.videocam, color: Colors.white),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Icon(Icons.call, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatListView(
              scrollController: scrollController,
              messages: messageList,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Color(0xFF333D56),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12.0, right: 8.0, bottom: 12.0),
                  child: Transform.rotate(
                    angle: 0.785, // 45 degrees in radians
                    child: const Icon(
                      Icons.attach_file_sharp,
                      color: Colors.white70,
                      size: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 6,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8.0, right: 12.0, bottom: 8.0),
                  child: GestureDetector(
                    onTap: sendMessage,
                    onLongPress: receiveMessage,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF90C953),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<MessageData> messages;

  const ChatListView({
    Key? key,
    required this.scrollController,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return MessageBubble(
          message: message.message,
          isSentByMe: message.isSentByMe,
          timestamp: message.timestamp,
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final DateTime timestamp;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isSentByMe,
    required this.timestamp,
  }) : super(key: key);

  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
        isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByMe) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF90C953),
              child: Text(
                'X',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSentByMe
                    ? const Color(0xFF90C953)
                    : const Color(0xFF333D56),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isSentByMe ? 18 : 4),
                  bottomRight: Radius.circular(isSentByMe ? 4 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: isSentByMe ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatTime(timestamp),
                    style: TextStyle(
                      color: isSentByMe
                          ? Colors.black54
                          : Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSentByMe) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF6B73A1),
              child: Text(
                'Me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Main app to run the chat screen
