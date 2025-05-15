import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';  // Importation nécessaire pour lancer des URLs

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TaylorPage extends StatefulWidget {
  @override
  _TaylorPageState createState() => _TaylorPageState();
}

class _TaylorPageState extends State<TaylorPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? playingUrl;


  List<Music> getTaylorSongs() {
    return [
      Music(
        'Taylor Swift - Blank Space',
        'images/blankspace.jpg',
        'Blank Space',
"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/0c/9d/26/0c9d266f-632d-dbda-770d-55cdded795f8/mzaf_18078867637438469059.plus.aac.p.m4a",      ),
      Music(
        'Taylor Swift - Love Story',
        'images/LOVESTORY.jpg',
        'Love Story',
"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview126/v4/01/b2/d3/01b2d3f4-d1ea-0a9e-3090-e6d609b33691/mzaf_17152798784953812339.plus.aac.p.m4a",      ),
      Music(
        'Taylor Swift - Enchanted',
        'images/ENCHANTED.jpg',
        'Enchanted',
"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/ed/cf/d1/edcfd196-0f68-155f-8ae6-d7b247ac04f3/mzaf_16633102013137197410.plus.aac.p.m4a",      ),
      Music(
        'Taylor Swift - Shake It Off',
        'images/ShakeItOff.jpg',
        'Shake It Off',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/90/a4/52/90a4528c-e7a7-99a0-94bb-d9073f80b845/mzaf_14804807849209193407.plus.aac.p.m4a",
      ),
      Music(
  'Taylor Swift - Cardigan',
  'images/Cardigan.jpg',
  'Cardigan',
  "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/0d/89/93/0d89934e-1963-7137-21db-d59f5124e208/mzaf_15222002092745217773.plus.aac.p.m4a",
),
Music(
  'Taylor Swift - Willow',
  'images/Willow.jpg',
  'Willow',
  "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/5f/36/a8/5f36a8fa-b8f1-7076-cd5c-cfb1792759d7/mzaf_785041702374134778.plus.aac.p.m4a",
),
Music(
  'Taylor Swift - All Too Well',
  'images/AllTooWell.jpeg',
  'All Too Well',
  "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/48/64/b7/4864b746-1f87-7f2b-24bc-c27e1f0d322d/mzaf_18304093100862008211.plus.aac.p.m4a",
),
Music(
  'Taylor Swift - Delicate',
  'images/Delicate.jpg',
  'Delicate',
  "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/d3/1e/a2/d31ea27b-bd7a-0bc3-54c3-0b81c1e9da99/mzaf_17944093171612718503.plus.aac.p.m4a",
),
Music(
  'Taylor Swift - The Archer',
  'images/TheArcher.jpg',
  'The Archer',
  "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/84/74/d5/8474d5d1-c4c7-2a37-30e1-4db6f8c5a4fa/mzaf_4854159879937845376.plus.aac.p.m4a",
),
Music(
  'Taylor Swift - Style',
  'images/Style.jpg',
  'Style',
  "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/1b/54/2b/1b542bdc-72b6-d896-2695-76481c9af3e8/mzaf_12165293126167853383.plus.aac.p.m4a",
),

    ];
  }


  Widget createMusic(Music music) {
    bool isPlaying = (playingUrl == music.url);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              if (isPlaying) {
                await _audioPlayer.pause();
                setState(() {
                  playingUrl = null;
                });
              } else {
                await _audioPlayer.setSource(UrlSource(music.url));
                await _audioPlayer.play(UrlSource(music.url));
                setState(() {
                  playingUrl = music.url;
                });
              }
            },
            child: SizedBox(
              height: 400,
              width: 400,
              child: Image.asset(
                music.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            music.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              if (isPlaying) {
                await _audioPlayer.pause();
                setState(() {
                  playingUrl = null;
                });
              } else {
                await _audioPlayer.setSource(UrlSource(music.url));
                await _audioPlayer.play(UrlSource(music.url));
                setState(() {
                  playingUrl = music.url;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // Méthode pour lancer les URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Taylor Swift Songs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Détails de l'artiste
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/TaylorSwift.jpg', // Image de l'artiste
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Taylor Swift',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Taylor Swift est une chanteuse, auteure-compositrice et productrice américaine, connue pour ses chansons introspectives et ses influences country et pop.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Liens vers les plateformes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.link, color: Colors.white),
                        onPressed: () {
                          _launchURL('https://www.instagram.com/taylorswift/');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.music_note, color: Colors.white),
                        onPressed: () {
                          _launchURL('https://open.spotify.com/artist/06HL4z0CvFAxyc27GXpf02');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Liste des chansons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:  getTaylorSongs().map((music) {
                  return createMusic(music);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Music {
  final String name;
  final String image;
  final String desc;
  final String url;

  Music(this.name, this.image, this.desc, this.url);
}
