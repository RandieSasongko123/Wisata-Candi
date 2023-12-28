import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/screens/detail_screen.dart';

class ListCandi extends StatelessWidget {
  const ListCandi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Candis'),
      ),
      body: ListView.builder(
        itemCount: candiList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(35, 39, 52, 1),
              borderRadius: BorderRadius.circular(3),
            ),
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                candiList[index].name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(148, 155, 167, 1),
                ),
              ),
              subtitle: Text(
                candiList[index].location,
                style: const TextStyle(
                  color: Color.fromRGBO(148, 155, 167, 1),
                ),
              ),
              leading: Image.asset(
                candiList[index].imageAsset,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(candiList[index]),
                  ),
                ); // Tindakan yang akan dijalankan saat item di klik
              },
            ),
          );
        },
      ),
    );
  }
}

class GridCandi extends StatelessWidget {
  const GridCandi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid of Candis'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Jumlah kolom dalam grid
        ),
        itemCount: candiList.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(candiList[index]),
                  ),
                );
              },
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      candiList[index].imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(candiList[index].name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
