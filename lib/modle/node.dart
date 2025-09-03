class Notemdl {
  final int? id;
  final String title;
  final String description;

  Notemdl({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Notemdl.fromMap(Map<String, dynamic> map) {
    return Notemdl(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

//   Notemdl copyWith({
//     int? id,
//     String? title,
//     String? description,
//   }) {
//     return Notemdl(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//     );
//   }
// }
}
