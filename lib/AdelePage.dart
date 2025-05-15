import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';  // Importer le package pour ouvrir les liens

class AdelePage extends StatefulWidget {
  @override
  _AdelePageState createState() => _AdelePageState();
}

class _AdelePageState extends State<AdelePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? playingUrl;

  List<Music> getAdeleSongs() {
    return [
      Music(
        'Adele - Skyfall',
        'images/skyfall.jpg',
        'Skyfall',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/c7/f8/1c/c7f81ce5-7fbb-1545-eec5-9f22d91188ce/mzaf_3414605049699669446.plus.aac.p.m4a",
      ),
      Music(
        'Adele - Hello',
        'images/hello.jpg',
        'Hello',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/93/22/22/93222271-8d55-d923-e0ff-b2964a5abefe/mzaf_3513742103157153222.plus.aac.p.m4a",
      ),
      Music(
        'Adele - Someone Like You',
        'images/someone_Like_You.png',
        'Someone Like You',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/ef/18/7b/ef187b7d-f487-e935-4ca1-af5748313710/mzaf_8455263230305249048.plus.aac.p.m4a",
      ),
      Music(
        'Adele - Rolling in the Deep',
        'images/rolling.jpg',
        'Rolling in the Deep',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/9f/07/1d/9f071dc7-791c-c869-dfa2-06b25936a287/mzaf_11077490630806345321.plus.aac.p.m4a",
      ),
      Music(
        'Adele - Easy On Me',
        'images/easy_on_me.jpg',
        'Easy On Me',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/1a/90/6d/1a906d88-32d1-c91f-fd71-5f52102be68e/mzaf_4884130368217363099.plus.aac.p.m4a",
      ),
      Music(
        'Adele - Turning Tables',
        'images/turning_tables.png',
        'Turning Tables',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/73/62/5f/73625f7d-69b4-bc63-1122-f665a60a0b2b/mzaf_4683349592608826017.plus.aac.p.m4a",
      ),
      Music(
        'Adele - Make You Feel My Love',
        'images/make_you_feel.png',
        'Make You Feel My Love',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/c5/5d/6c/c55d6cd4-c034-091d-c31b-328a990f9837/mzaf_6930596469236892818.plus.aac.p.m4a",
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
          'Adele Songs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Retour à l'écran précédent
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section de l'artiste (Photo et Informations)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Photo de l'artiste
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'images/adele.jpg', // Remplacez par l'image d'Adele
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Nom et biographie de l'artiste
                  const Text(
                    'Adele',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Adele Laurie Blue Adkins, plus connue sous le nom d\'Adele, est une chanteuse et auteure-compositrice britannique. Elle est reconnue pour ses ballades puissantes et ses chansons qui parlent d\'amour, de perte et de rédemption.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Liens vers les réseaux sociaux ou plateformes de streaming
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.link, color: Colors.white),
                        onPressed: () {
                          _launchURL('https://www.instagram.com/adele/p/DCvnRnfgGM1/?hl=en&img_index=1'); // Lien vers Instagram
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.music_note, color: Colors.white),
                        onPressed: () {
                          _launchURL('https://open.spotify.com/search/adele'); // Lien vers Spotify
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Liste des chansons d'Adele
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: getAdeleSongs().map((music) {
                  return createMusic(music);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour ouvrir un lien URL
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }
}

class Music {
  final String name;
  final String image;
  final String desc;
  final String url;

  Music(this.name, this.image, this.desc, this.url);
}
