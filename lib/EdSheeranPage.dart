import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';  // Importation nécessaire pour lancer des URLs
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class EdSheeranPage extends StatefulWidget {
  @override
  _EdSheeranPageState createState() => _EdSheeranPageState();
}

class _EdSheeranPageState extends State<EdSheeranPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? playingUrl;

  List<Music> getEdSheeranSongs() {
    return [
      Music(
        'Ed Sheeran - Shape of You',
        'images/ed_shapeofyou.jpg',
        'Shape of You',
"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/8b/e8/4b/8be84b71-0ca5-6158-b4a4-4cf9b647cb17/mzaf_15441264363599058572.plus.aac.p.m4a",    ),
      Music(
        'Ed Sheeran - Perfect',
        'images/ed_perfect.jpg',
        'Perfect',
"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/a3/34/e8/a334e839-a234-317f-e911-25692e0c59ca/mzaf_2077702613748931138.plus.aac.p.m4a",      ),
      Music(
        'Ed Sheeran - Thinking Out Loud',
        'images/ed_thinkingoutloud.jpg',
        'Thinking Out Loud',
"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview126/v4/06/9c/8f/069c8f23-38a4-a01a-cd96-1786d35b1cdb/mzaf_10598598072673693592.plus.aac.p.m4a",      ),
      Music(
        'Ed Sheeran - Bad Habits',
        'images/ed_badhabits.jpg',
        'Bad Habits',
"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/e3/72/02/e37202a4-59f9-2964-f2af-81a2f242381c/mzaf_13336692092422407867.plus.aac.p.m4a",      ),
      Music(
      'Ed Sheeran - Castle on the Hill',
      'images/ed_castleonthehill.jpg',
      'Castle on the Hill',
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/4a/5e/39/4a5e39d1-e485-0b5c-5b3e-c93f4605a8d1/mzaf_15469536113996770882.plus.aac.p.m4a",
    ),
    Music(
      'Ed Sheeran - Galway Girl',
      'images/ed_galwaygirl.jpg',
      'Galway Girl',
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/c1/9f/57/c19f5724-5107-b68b-12b3-b9a0b8cb5f92/mzaf_3186178045599079785.plus.aac.p.m4a",
    ),
    Music(
      'Ed Sheeran - I See Fire',
      'images/ed_isee.jpg',
      'I See Fire',
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/90/8f/8e/908f8ed6-b597-c5ab-fb04-05c8f1ad6b82/mzaf_14825513497519503578.plus.aac.p.m4a",
    ),
    Music(
      'Ed Sheeran - The A Team',
      'images/ed_thea_team.jpg',
      'The A Team',
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/f2/d4/0c/f2d40c44-d722-7a7f-00ae-8c25b11b865b/mzaf_12468155904713192433.plus.aac.p.m4a",
    ),
    Music(
      'Ed Sheeran - Photograph',
      'images/ed_photograph.jpg',
      'Photograph',
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/58/ef/15/58ef1565-d533-7ad1-9b30-e7b219a6acb1/mzaf_7465351090817992812.plus.aac.p.m4a",
    ),
    Music(
      'Ed Sheeran - Give Me Love',
      'images/ed_givemelove.jpg',
      'Give Me Love',
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/df/d3/66/dfd366f3-fb0f-b51b-eaaa-bfc00b4c9b26/mzaf_4642120394863768584.plus.aac.p.m4a",
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
                      'images/EdSheeranPage.jpg', // Image de l'artiste
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ed SheeranPage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bruno Mars est un artiste, chanteur, compositeur et producteur américain. Il est connu pour son mélange de genres musicaux, de la pop au R&B en passant par le funk.',
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
                children: getEdSheeranSongs().map((music) {
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
