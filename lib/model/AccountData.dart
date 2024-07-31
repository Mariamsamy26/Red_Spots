class AccountData {
  String? id;
  String? fNAME;
  String? lNAME;
  String email;
  int age;
  String gender;
  String location;

  AccountData({
    required this.id,
    required this.fNAME,
    required this.lNAME,
    required this.email,
    required this.age,
    required this.gender,
    required this.location,
  });

  AccountData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          fNAME: json['Frist name'],
          lNAME: json['Last name'],
          email: json['email'],
          age: json['age'],
          gender: json['Gender type'],
          location: json['location'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Frist name": fNAME,
      "Last name": lNAME,
      "email": email,
      "age": age,
      "Gender type": gender,
      "location": location,
    };
  }
}
