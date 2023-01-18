import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/song.dart';

class FireStoreDB {
  static Future<void> addSong(String uid, Song song) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('AllSongs').doc(uid).set({
      'title': song.title,
      'isFavourite': song.isFavourite ?? false,
      'createdAt': song.createdAt,
      'uid': song.uid,
    });
  }
}
