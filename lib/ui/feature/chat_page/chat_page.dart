import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:grpc_chat_flutter/ui/theme/theme.dart';

import 'chat_page_controller.dart';

class ChatPage extends StatefulWidget {
  final ChatPageController controller;

  const ChatPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNodeTextField = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.initChat("flutterUser");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          getAppLocalizationsOf(context).chat_page_title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              //reactive ListView from controller updates.
              child: Obx(() => _buildListView()),
            ),
            SizedBox(
              height: 80,
              child: _textingSection(),
            )
          ],
        ),
      ),
    );
  }

  /// builds messages list with info from controller.
  Widget _buildListView() {
    final messagesLenght = widget.controller.messages.length;
    return ListView.builder(
      reverse: true,
      controller: _scrollController,
      itemCount: messagesLenght,
      itemBuilder: (context, index) {
        final m = widget.controller.messages[(messagesLenght - 1) - index];
        return Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(m.user.id.toString()),
              Text(
                m.message,
                textAlign: m.user.id == widget.controller.user.value.id
                    ? TextAlign.end
                    : TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// builds a row with [TextField] and send [MaterialButton]
  Widget _textingSection() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _focusNodeTextField,
            controller: _textEditingController,
            cursorColor: Colors.black,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onSubmitted: (text) => _onSendMessage(message: text),
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
              height: 60,
              color: Colors.indigoAccent,
              child: Text(
                getAppLocalizationsOf(context).send_button_text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _onSendMessage(message: _textEditingController.text);
              }),
        ),
      ],
    );
  }

  /// Scrolls message list to last item.
  void _scrollToLast() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.bounceIn,
    );
  }

  Future<void> _onSendMessage({required String message}) async {
    final wasOk = await widget.controller.sendMeesage(message);
    if (wasOk) {
      _textEditingController.clear();
      _scrollToLast();
    }
  }
}
