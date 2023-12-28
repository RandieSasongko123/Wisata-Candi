import 'package:flutter/material.dart';
import 'item_card.dart';
import 'package:wisata_candi/data/candi_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wisata Candi"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom dalam grid
        ),
        itemCount: candiList.length,
        itemBuilder: (context, index) {
          return ItemCard(
            candi: candiList[index],
          );
        },
      ),
    );
  }
}
