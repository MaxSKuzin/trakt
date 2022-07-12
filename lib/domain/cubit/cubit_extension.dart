import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

extension StateStream<T> on Cubit<T> {
  StreamSubscription<T> listenStateAsSubject(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    onData?.call(state);
    return stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
