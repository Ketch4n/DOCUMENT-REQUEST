class User3 {
  String id;
  final String name;
  final String year;
  final String status;
  final String copies;
  // final String birth;

  User3({
    this.id = '',
    required this.name,
    required this.year,
    required this.status,
    required this.copies,
    // required this.birth,
  });

  Map<String, dynamic> toJson() => {
        'student_id': id,
        'document_name': name,
        'year_level': year,
        'status': status,
        'no_of_copies': copies,
      };

  static User3 fromJson(Map<String, dynamic> json) => User3(
        id: json['student_id'],
        name: json['document_name'],
        year: json['year_level'],
        status: json['status'],
        copies: json['no_of_copies'],
      );
}
