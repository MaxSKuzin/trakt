import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/cache_repository.dart';

@LazySingleton(as: CacheRepository)
class CacheRepositoryImpl implements CacheRepository {
  final _cacheManager = DefaultCacheManager();

  @override
  Future<File> loadFile(String uri, {String? key}) async {
    var file = await _cacheManager.getFileFromCache(key ?? uri);
    file ??= await _cacheManager.downloadFile(
      uri,
      key: key,
    );
    return file.file;
  }
}
