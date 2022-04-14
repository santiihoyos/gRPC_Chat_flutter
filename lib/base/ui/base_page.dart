import 'package:grpc_chat_flutter/base/ui/base_controller.dart';
import 'package:flutter/cupertino.dart';

abstract class BasePage<C extends BaseController> extends StatefulWidget {
  ///Controller
  final C controller;

  @mustCallSuper
  const BasePage({
    Key? key,
    required this.controller,
  }) : super(key: key);
}

abstract class BaseState<P extends BasePage> extends State<P> {
  /// initState
  @mustCallSuper
  @override
  void initState() {
    widget.controller.error.listen(onControllerError);
    super.initState();
  }

  ///Called by controllers when error happens.
  void onControllerError(final ControllerError? controllerError) {
    //Nothing to do on base.
  }
}
