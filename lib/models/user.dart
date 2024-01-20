import 'dart:convert';

class UserX {
  final String id;
  final String nama;
  final String createdAt;
  final int umur;

  UserX({
    this.id = '',
    this.nama = '',
    this.createdAt = '',
    this.umur = 0,
  });

  UserX copyWith({
    String? id,
    String? nama,
    String? createdAt,
    int? umur,
  }) {
    return UserX(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      createdAt: createdAt ?? this.createdAt,
      umur: umur ?? this.umur,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'nama': nama});
    result.addAll({'created_at': createdAt});
    result.addAll({'umur': umur});

    return result;
  }

  factory UserX.fromMap(Map<String, dynamic> map) {
    return UserX(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      createdAt: map['created_at'] ?? '',
      umur: map['umur']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserX.fromJson(String source) => UserX.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserX(id: $id, nama: $nama, createdAt: $createdAt, umur: $umur)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserX && other.id == id && other.nama == nama && other.createdAt == createdAt && other.umur == umur;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nama.hashCode ^ createdAt.hashCode ^ umur.hashCode;
  }
}
