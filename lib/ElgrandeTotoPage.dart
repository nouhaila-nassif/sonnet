import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart'; // Importation nécessaire pour lancer des URLs

class ElgrandeTotoPage extends StatefulWidget {
  @override
  _ElgrandeTotoPageState createState() => _ElgrandeTotoPageState();
}

class _ElgrandeTotoPageState extends State<ElgrandeTotoPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? playingUrl;

  List<Music> getElgrandeTotoSongs() {
    return [
      Music(
        'ElgrandeToto - Camelion',
        'images/toto_bouhali.jpg',
        'Camelion',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/91/b4/46/91b4465d-e0cf-e078-eca2-a40e1608d37b/mzaf_13175262834934973173.plus.aac.p.m4a",
      ),
      Music(
        'ElgrandeToto - Mghayer',
        'images/toto_mghayer.jpg',
        'Mghayer',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/91/db/34/91db3490-3b03-519c-f856-10ef3ac12bfc/mzaf_10072119290809854655.plus.aac.p.m4a",
      ),
      Music(
        'ElgrandeToto - 7elmetAdo',
        'images/toto_7elloo.jpg',
        '7elmetAdo',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/e6/af/35/e6af3548-53c1-e5fa-b4e8-cd0bdd0146fa/mzaf_3199800890333068763.plus.aac.p.m4a",
      ),
      Music(
        'ElgrandeToto - Halla',
        'images/toto_halla.jpg',
        'Halla',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview121/v4/88/f5/9e/88f59e39-85e2-59c5-e8f5-2b83e7f3e0f6/mzaf_12850403159457803745.plus.aac.p.m4a",
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
          'Ed Sheeran Songs',
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
                      'images/ElgrandeToto.jpg', // Image de l'artiste
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ElgrandeToto',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Elgrande Toto est un rappeur et chanteur marocain. Il est connu pour ses morceaux qui mélangent rap, trap et autres styles modernes.',
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
                          _launchURL(
                              'https://www.instagram.com/brunomars/p/DFqXuJVSC9f/?hl=en&img_index=1');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.music_note, color: Colors.white),
                        onPressed: () {
                          _launchURL(
                              'https://open.spotify.com/intl-fr/artist/0du5cEVh5yTK9QJze8zA0C');
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
                children: getElgrandeTotoSongs().map((music) {
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
