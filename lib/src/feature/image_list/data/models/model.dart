abstract class Models<T> {
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json); //Map<String, dynamic>
}

class EmptyResponseModel extends Models<EmptyResponseModel> {
  int? code;
  String? status;
  String? msg;
  String? response;

  EmptyResponseModel({this.code, this.status, this.msg, this.response});
  @override
  EmptyResponseModel fromJson(json) {
    //Map<String, dynamic>
    return EmptyResponseModel(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    if (response != null) {
      data['response'] = response;
    }
    return data;
  }
}

class Response {
  Response.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
