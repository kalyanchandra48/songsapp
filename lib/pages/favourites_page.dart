import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> songs = FirebaseFirestore.instance
        .collection('AllSongs')
        .orderBy('createdAt')
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 101, 227),
        title: const Text('Favourite Songs'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: songs,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, int index) {
                bool isFavourited = snapshot.data?.docs[index]['isFavourite'];
                return isFavourited == true
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          iconColor: Colors.black,
                          style: ListTileStyle.list,
                          trailing: GestureDetector(
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.blue,
                            ),
                          ),
                          title: Text(
                            snapshot.data?.docs[index]['title'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              });
        },
      ),
    );
  }
}
