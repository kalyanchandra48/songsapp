import 'package:flutter/material.dart';
import 'package:songs_app/pages/favourites_page.dart';
import 'package:songs_app/pages/home_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarPage> {
  static final List<Widget> _screens = <Widget>[
    const HomePage(),
    const FavouritesPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
          backgroundColor: const Color.fromARGB(255, 114, 101, 227),
          onTap: (value) {
            _onItemTapped(value);
          },
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_music_rounded,
                color: Colors.white,
              ),
              label: 'AllSongs',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline_rounded,
                color: Colors.white,
              ),
              label: 'FavouriteSongs',
            ),
          ],
        ),
        body: Center(
          child: _screens.elementAt(_selectedIndex),
        ));
  }
}
