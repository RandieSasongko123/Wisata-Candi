import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import '../models/candi.dart';
import 'package:wisata_candi/widgets/profile_info_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen(this.candi, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: [
        DetailPage(
          candi,
          onFavoriteChange: (isFavorite) {
            candi.isFavorite = isFavorite;
          },
        ),
      ],
    ));
  }
}

class DetailPage extends StatefulWidget {
  final Candi candi;
  final Function(bool) onFavoriteChange;

  const DetailPage(this.candi, {Key? key, required this.onFavoriteChange})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Background Image with Favorite Button
            Positioned(
              left: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.candi.imageAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details Container
            Positioned(
              top: 260,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.candi.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                widget
                                    .onFavoriteChange(!widget.candi.isFavorite);
                                setState(() {});
                              },
                              icon: Icon(
                                widget.candi.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.candi.isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Location
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const SizedBox(
                              width: 70,
                              child: Text(
                                'Lokasi',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Text(
                              ': ${widget.candi.location}',
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Built Year
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const SizedBox(
                              width: 70,
                              child: Text(
                                'Dibangun',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Text(
                              ': ${widget.candi.built}',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Type
                        Row(
                          children: [
                            const Icon(
                              Icons.house,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const SizedBox(
                              width: 70,
                              child: Text(
                                'Tipe',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Text(
                              ': ${widget.candi.type}',
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Galery",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: widget.candi.imageUrls.length,
                            itemBuilder: (context, index) {
                              final imageUrl = widget.candi.imageUrls[index];
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FullScreenImageGallery(
                                          initialIndex: index,
                                          imageUrls: widget.candi.imageUrls,
                                        ),
                                      ),
                                    );
                                    // Implement logic to enlarge the image here
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Description
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.candi.description,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = true;
  String fullName = 'Randie Sasongko';
  String userName = 'randies';
  int favoriteCandiCount = candiList.where((candi) => candi.isFavorite).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.amber,
          ),

          // User Information
          Column(
            children: [
              // Avatar and Camera Button
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200 - 50),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepPurple, width: 2),
                            shape: BoxShape.circle),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('images/placeholder_image.png'),
                        ),
                      ),
                      if (isSignedIn)
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.deepPurple[50],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // User Profile Information
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // User Lock Information
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ProfileInfoItem(
                      icon: Icons.lock,
                      label: 'Pengguna',
                      value: userName,
                      iconColor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // User Name Information
                    ProfileInfoItem(
                        icon: Icons.person,
                        label: 'Nama',
                        value: fullName,
                        showEditIcon: isSignedIn,
                        onEditPressed: () {
                          debugPrint('Icon edit ditekan ...');
                        },
                        iconColor: Colors.blue),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // User Favorite Candi Count Information
                    ProfileInfoItem(
                        icon: Icons.favorite,
                        label: 'Favorit',
                        value: favoriteCandiCount > 0
                            ? '$favoriteCandiCount'
                            : '0',
                        iconColor: Colors.red),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Sign In/Out Button
                    isSignedIn
                        ? TextButton(
                            onPressed: () {},
                            child: Text('Sign Out'),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.amber,
                                padding: const EdgeInsets.all(20),
                                elevation: 5),
                          )
                        : TextButton(
                            onPressed: () {},
                            child: Text('Sign In'),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.amber,
                                padding: const EdgeInsets.all(20),
                                elevation: 5),
                          )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FullScreenImageGallery extends StatelessWidget {
  final int initialIndex;
  final List<String> imageUrls;

  const FullScreenImageGallery({
    Key? key,
    required this.initialIndex,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}
