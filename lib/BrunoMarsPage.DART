import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';  // Importation nécessaire pour lancer des URLs

class BrunoMarsPage extends StatefulWidget {
  @override
  _BrunoMarsPageState createState() => _BrunoMarsPageState();
}

class _BrunoMarsPageState extends State<BrunoMarsPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? playingUrl;

  List<Music> getBrunoMarsSongs() {
    return [
      Music(
        'Bruno Mars - Uptown Funk',
        'images/bruno_uptownfunk.jpg',
        'Uptown Funk',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview126/v4/62/e1/98/62e19826-cd13-6eff-390e-dbca502bb7b5/mzaf_8006535252627949661.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - 24K Magic',
        'images/bruno_24kmagic.jpg',
        '24K Magic',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/72/77/cd/7277cdca-1387-1c7a-529e-72f3c2ed070d/mzaf_3495320363426981496.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - Just The Way You Are',
        'images/bruno_justthewayyouare.jpg',
        'Just The Way You Are',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/0c/9d/26/0c9d266f-632d-dbda-770d-55cdded795f8/mzaf_18078867637438469059.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - Treasure',
        'images/bruno_treasure.jpg',
        'Treasure',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview121/v4/d5/6e/4f/d56e4fa5-4509-350e-3e3d-ef9d22d03dc3/mzaf_12190432734018927345.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - Grenade',
        'images/bruno_grenade.jpg',
        'Grenade',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview111/v4/b7/49/5e/b7495e3b-4f3e-e41d-1b72-59d87467cd17/mzaf_17260757496214202736.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - Locked Out of Heaven',
        'images/bruno_lockedoutofheaven.jpg',
        'Locked Out of Heaven',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview121/v4/24/11/65/241165eb-3e2c-b16e-87fc-8bb0c1f72956/mzaf_13762872614126284590.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - When I Was Your Man',
        'images/bruno_wheniwasyourman.jpg',
        'When I Was Your Man',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview121/v4/3a/7c/02/3a7c0251-cccf-76ff-b4d7-d324015f74f5/mzaf_13341782165089747121.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - Finesse',
        'images/bruno_finesse.jpg',
        'Finesse',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/bd/a6/2d/bda62d14-0de6-852d-6b2b-0c66d8577bd8/mzaf_5851120955139354098.plus.aac.p.m4a",
      ),
      Music(
        'Bruno Mars - Marry You',
        'images/bruno_marryyou.jpg',
        'Marry You',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview111/v4/cd/bd/13/cdbd139f-c762-16ee-335f-68a7b120f662/mzaf_17130877360451802063.plus.aac.p.m4a",
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
          'Bruno Mars Songs',
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
                      'images/BrunoMars.jpg', // Image de l'artiste
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Bruno Mars',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ed Sheeran est un chanteur, compositeur et producteur britannique. Il est connu pour ses chansons populaires comme "Shape of You" et "Perfect".',
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
                          _launchURL('https://www.instagram.com/brunomars/p/DFqXuJVSC9f/?hl=en&img_index=1');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.music_note, color: Colors.white),
                        onPressed: () {
                          _launchURL('https://open.spotify.com/intl-fr/artist/0du5cEVh5yTK9QJze8zA0C');
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
                children: getBrunoMarsSongs().map((music) {
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
