import 'package:injectable/injectable.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import 'logger.dart';

@LazySingleton(as: ErrorHandler)
class ErrorHandlerImpl extends ErrorHandler {
  @override
  void handleError(Object err, StackTrace? st) {
    logger.e(err, err, st);
  }
}
