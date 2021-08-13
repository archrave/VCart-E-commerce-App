class HttpException implements Exception {
  final String message;
  HttpException(this.message);

// Overriding toString cuz otherwise it would just return 'Instance of Exception'
  @override
  String toString() {
    return message;
  }
}
