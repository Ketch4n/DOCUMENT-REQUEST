class User2 {
  String id;
  final String name;
  final String role;
  final String pass;
  // final String birth;

  User2({
    this.id = '',
    required this.name,
    required this.role,
    required this.pass,
    // required this.birth,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,

        'role': role,
        'password': pass,
        // 'birth': birth,
      };

  static User2 fromJson(Map<String, dynamic> json) => User2(
        id: json['id'],
        name: json['name'],

        role: json['role'],
        pass: json['password'],
        // birth: json['birth'],
      );
}
