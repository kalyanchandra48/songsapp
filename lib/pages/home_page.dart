import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:songs_app/models/song.dart';
import 'package:songs_app/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 101, 227),
        title: const Text('AllSongs'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return BottomSheetWidget();
            },
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      body: AllSongsPage(),
    );
  }
}

class AllSongsPage extends StatelessWidget {
  final Stream<QuerySnapshot> _songs = FirebaseFirestore.instance
      .collection('AllSongs')
      .orderBy('createdAt')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _songs,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, int index) {
              bool isFavourited = snapshot.data?.docs[index]['isFavourite'];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  iconColor: Colors.black,
                  style: ListTileStyle.list,
                  trailing: GestureDetector(
                    onTap: () async {
                      CollectionReference songs =
                          FirebaseFirestore.instance.collection('AllSongs');
                      await songs
                          .doc(snapshot.data?.docs[index]['uid'])
                          .update({
                        'isFavourite': isFavourited == false ? true : false,
                      });
                    },
                    child: !isFavourited
                        ? const Icon(
                            Icons.favorite_outline,
                            color: Colors.blue,
                          )
                        : const Icon(
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
              );
            });
      },
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({
    Key? key,
  }) : super(key: key);
  TextEditingController songTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        height: keyboardIsOpen
            ? MediaQuery.of(context).size.height / 1.198
            : MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: keyboardIsOpen
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/music.png'),
              TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add title for your song"),
                controller: songTitleController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String uid = const Uuid().v4();

                    await FireStoreDB.addSong(
                        uid,
                        Song(
                          title: songTitleController.text,
                          createdAt: DateTime.now(),
                          uid: uid,
                        ));
                    songTitleController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add Song')),
            ],
          ),
        ),
      ),
    );
  }
}
