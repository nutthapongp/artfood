class Modeluser {
  String id;
  String role;
  String name;
  String username;
  String password;
  String nameshop;
  String address;
  String phone;
  String uriImage;
  String lat;
  String lng;
  String token;

  Modeluser(
      {this.id,
      this.role,
      this.name,
      this.username,
      this.password,
      this.nameshop,
      this.address,
      this.phone,
      this.uriImage,
      this.lat,
      this.lng,
      this.token});

  Modeluser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    nameshop = json['nameshop'];
    address = json['Address'];
    phone = json['Phone'];
    uriImage = json['UriImage'];
    lat = json['Lat'];
    lng = json['Lng'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['nameshop'] = this.nameshop;
    data['Address'] = this.address;
    data['Phone'] = this.phone;
    data['UriImage'] = this.uriImage;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['Token'] = this.token;
    return data;
  }
}