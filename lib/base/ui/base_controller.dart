import 'package:get/get.dart';

class ControllerError {
  final int? id;
  final String? message;
  bool managed = false;

  ControllerError({
    this.id,
    this.message,
    this.managed = false,
  });
}

abstract class BaseController extends GetxController {
  /// controller is busy, flag.
  var isLoading = false.obs;

  /// var to know when controller launches some error
  /// when it tried to do something.
  Rx<ControllerError?> error = Rx(null);
}
