import 'package:flutter/material.dart';
import 'package:wisata_candi/screens/detail_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/search_screen.dart';
import 'screens/home_screen.dart';
import 'screens/favorite_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wisata Candi',
      theme: ThemeData(
        // scaffoldBackgroundColor: const Color.fromRGBO(26, 29, 39, 1),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(26, 29, 39, 1)),
        useMaterial3: true,
      ),
      home: SignInSreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    SearchCandi(),
    FavoriteCandi(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.deepPurple[50],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.deepPurple,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.deepPurple),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.deepPurple),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.deepPurple),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.deepPurple),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
