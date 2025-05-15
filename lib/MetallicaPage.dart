import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

class MetallicaPage extends StatefulWidget {
  @override
  _MetallicaPageState createState() => _MetallicaPageState();
}

class _MetallicaPageState extends State<MetallicaPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? playingUrl;

  List<Music> getMetallicaSongs() {
    return [
      Music(
        'Metallica - Enter Sandman',
        'images/enter_sandman.jpg',
        'Enter Sandman',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/2e/ea/aa/2eeaaa06-5f4f-018d-3f6b-7676999b0981/mzaf_15310112353478045971.plus.aac.p.m4a",
      ),
      Music(
        'Metallica - Nothing Else Matters',
        'images/nothing_else_matters.jpg',
        'Nothing Else Matters',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/29/30/97/2930976a-cb5d-70d7-7e9e-3e3fa3c8a687/mzaf_539302081647506675.plus.aac.p.m4a",
      ),
      Music(
        'Metallica - The Unforgiven',
        'images/the_unforgiven.jpg',
        'The Unforgiven',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/c7/f8/1c/c7f81ce5-7fbb-1545-eec5-9f22d91188ce/mzaf_3414605049699669446.plus.aac.p.m4a",
      ),
      Music(
        'Metallica - Sad But True',
        'images/sad_but_true.jpg',
        'Sad But True',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/f2/fc/51/f2fc511a-32e8-9828-4eda-b856bcd64d92/mzaf_10119373834251519507.plus.aac.p.m4a",
      ),
      Music(
        'Metallica - One',
        'images/one.jpg',
        'One',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/15/70/4f/15704fc6-5323-f790-10cd-bb8a162e8bf4/mzaf_18179605505662845535.plus.aac.p.m4a",
      ),
      Music(
        'Metallica - Master of Puppets',
        'images/master_of_puppets.jpg',
        'Master of Puppets',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/c6/96/c0/c696c0d1-37d4-bd91-8f37-3f97591f0d3c/mzaf_3020669193940775036.plus.aac.p.m4a",
      ),
      Music(
        'Metallica - Fade to Black',
        'images/fade_to_black.jpg',
        'Fade to Black',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/9f/6b/3e/9f6b3eb6-cd8e-04a3-4a5e-0d38f4ec8c78/mzaf_3838700224913069698.plus.aac.p.m4a",
      ),
    ];
  }

  Future<void> togglePlayPause(Music music) async {
    if (playingUrl == music.url) {
      await _audioPlayer.stop();
      setState(() => playingUrl = null);
    } else {
      await _audioPlayer.setSourceUrl(music.url);
      await _audioPlayer.resume();
      setState(() => playingUrl = music.url);
    }
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
              await togglePlayPause(music);
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
              await togglePlayPause(music);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Metallica Songs',
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
            // Section Artist Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('images/metallica.jpg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Metallica',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Metallica est un groupe de heavy metal américain formé en 1981. Il est l\'un des groupes les plus influents et les plus populaires de l\'histoire de la musique.',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Social Media Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                      IconButton(
                        icon: const Icon(Icons.link, color: Colors.white),
                        onPressed: () {
                          _launchURL('https://www.instagram.com/metallica/p/C53eno1Rfxg/?img_index=1'); // Lien vers Instagram
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.music_note, color: Colors.white),
                        onPressed: () {
                          _launchURL('https://open.spotify.com/intl-fr/artist/2ye2Wgw4gimLv2eAKyk1NB'); // Lien vers Spotify
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Liste des chansons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Défilement horizontal
              child: Row(
                children: getMetallicaSongs().map((music) {
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
