class APIResponse {
  String? status;
  String? message;
  Object? data;

  APIResponse({this.status, this.message, this.data});
  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}

class APIAuthenResponse {
  String? status;
  String? message;
  String? data;

  APIAuthenResponse({this.status, this.message, this.data});
  factory APIAuthenResponse.fromJson(Map<String, dynamic> json) {
    return APIAuthenResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
