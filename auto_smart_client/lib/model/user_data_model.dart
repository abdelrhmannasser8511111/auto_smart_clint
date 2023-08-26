class UserDataModel{
  int? idNumb;
  String? name;
  int? phoneNumber;
  UserDataModel({this.name, this.idNumb, this.phoneNumber});
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      idNumb: json['idNumb'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],

    );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNumb'] = this.idNumb;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}