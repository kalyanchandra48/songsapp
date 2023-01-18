import 'dart:convert';

class Song {
  String title;
  bool? isFavourite;
  DateTime createdAt;
  String uid;
  Song({
    required this.title,
    this.isFavourite,
    required this.createdAt,
    required this.uid,
  });

  Song copyWith({
    String? title,
    bool? isFavourite,
    DateTime? createdAt,
    String? uid,
  }) {
    return Song(
      title: title ?? this.title,
      isFavourite: isFavourite ?? this.isFavourite,
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'title': title});
    if(isFavourite != null){
      result.addAll({'isFavourite': isFavourite});
    }
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'uid': uid});
  
    return result;
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      title: map['title'] ?? '',
      isFavourite: map['isFavourite'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(title: $title, isFavourite: $isFavourite, createdAt: $createdAt, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Song &&
      other.title == title &&
      other.isFavourite == isFavourite &&
      other.createdAt == createdAt &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      isFavourite.hashCode ^
      createdAt.hashCode ^
      uid.hashCode;
  }
}
