import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/screens/detail_screen.dart';
import 'package:wisata_candi/models/candi.dart';

class SearchCandi extends StatefulWidget {
  @override
  State<SearchCandi> createState() => _SearchCandiState();
}

class _SearchCandiState extends State<SearchCandi> {
  List<Candi> _filteredCandis = [];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Candis'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.deepPurple[50],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Cari Candi...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query.toLowerCase();
                    _filteredCandis = candiList
                        .where((candi) =>
                            candi.name.toLowerCase().contains(_searchQuery) ||
                            candi.location.toLowerCase().contains(_searchQuery))
                        .toList();
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchQuery.isEmpty
                  ? candiList.length
                  : _filteredCandis.length,
              itemBuilder: (context, index) {
                final candi = _searchQuery.isEmpty
                    ? candiList[index]
                    : _filteredCandis[index];

                return Container(
                  decoration: BoxDecoration(
                      // color: const Color.fromRGBO(35, 39, 52, 1),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: ListTile(
                    title: Text(
                      candi.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // color: Color.fromRGBO(148, 155, 167, 1),
                      ),
                    ),
                    subtitle: Text(
                      candi.location,
                      style: const TextStyle(
                        color: Color.fromRGBO(148, 155, 167, 1),
                      ),
                    ),
                    trailing: const Icon(Icons.navigate_next),
                    leading: Container(
                      width:
                          80, // Set the width to increase the size of the leading image
                      height:
                          80, // Set the height to increase the size of the leading image
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(candi.imageAsset),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(candi, onFavoriteChange: (isFavorite) {
                            candi.isFavorite = isFavorite;
                          }),
                        ),
                      ); // Tindakan yang akan dijalankan saat item di klik
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
