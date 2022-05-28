import 'dart:io';

abstract class CacheRepository {
  Future<File> loadFile(String uri, {String? key});
}
