abstract class BaseAPIReponse<T> {
  final bool isSuccess;
  final int statusCode;
  final String? message;

  BaseAPIReponse({
    required this.isSuccess,
    required this.statusCode,
    this.message,
  });
}
