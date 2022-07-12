import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repository/cache_repository.dart';

@injectable
class FileCubit extends Cubit<File?> {
  final CacheRepository _cacheRepository;

  FileCubit(
    this._cacheRepository,
  ) : super(null);

  Future<void> getFile(String fileUrl) async {
    final file = await _cacheRepository.loadFile(fileUrl);
    emit(file);
  }
}
