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
  /// ScrollController to manage scroll down on incoming new message.
  final ScrollController _scrollController = ScrollController();

  /// TextEditingController to get message text from TextField.
  final TextEditingController _textEditingController = TextEditingController();

  /// FocusNode to request focus on message send
  final FocusNode _focusNodeTextField = FocusNode();

  /// TextEditing controller to get alias name from Dialog.
  final TextEditingController _aliasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => _showAliasDialog());
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
            Container(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
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
        return _buildMessageItem(
          userId: m.user.id,
          userName: m.user.nickName,
          message: m.message,
        );
      },
    );
  }

  Widget _buildMessageItem({
    required int userId,
    required String userName,
    required String message,
  }) {
    final chatterId = widget.controller.user.value.id;
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: chatterId == userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  chatterId == userId
                      ? const SizedBox(width: 0)
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            userName,
                            style: const TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                  Text(
                    message,
                    textAlign: userId == widget.controller.user.value.id
                        ? TextAlign.end
                        : TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// builds a row with [TextField] and send [MaterialButton]
  Widget _textingSection() {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
              height: 60,
              minWidth: 60,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.send),
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  _onSendMessage(message: _textEditingController.text);
                } else {
                  _focusNodeTextField.requestFocus();
                }
              }),
        ),
      ],
    );
  }

  Future<void> _showAliasDialog() async {
    await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        actionsPadding: const EdgeInsets.only(bottom: 10),
        actions: [
          TextButton(
            child: Text(
              getAppLocalizationsOf(context).ok,
            ),
            onPressed: () {
              widget.controller.initChat(_aliasController.text);
              Navigator.pop(context);
              _focusNodeTextField.requestFocus();
            },
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getAppLocalizationsOf(context).alias_dialog_title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            TextField(
              style: TextStyle(
                color: Colors.grey[900],
              ),
              focusNode: FocusNode()..requestFocus(),
              controller: _aliasController,
            ),
          ],
        ),
      ),
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

  /// CAlled when user sends message from textfield
  Future<void> _onSendMessage({required String message}) async {
    final wasOk = await widget.controller.sendMeesage(message);
    if (wasOk) {
      _textEditingController.clear();
      _scrollToLast();
      _focusNodeTextField.requestFocus();
    }
  }
}
