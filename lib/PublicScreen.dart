import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Music {
  final String name;
  final String image;
  final String desc;
  final String url;

  Music(this.name, this.image, this.desc, this.url);
}

class PublicScreen extends StatefulWidget {
  final VoidCallback showHomeScreen;
  final VoidCallback showLoginScreen;

  const PublicScreen({
    super.key,
    required this.showHomeScreen,
    required this.showLoginScreen,
  });

  @override
  _PublicScreenState createState() => _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? playingUrl;

  List<Music> getPopularMusic() {
    return [
      Music('ElgrandeToto', 'images/toto.jpg', 'Bouhali',
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/91/b4/46/91b4465d-e0cf-e078-eca2-a40e1608d37b/mzaf_13175262834934973173.plus.aac.p.m4a"),
      Music('rosie', 'images/rossi.jpg', 'apt',
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/22/8a/a1/228aa1a0-cbfd-ac14-ae99-09ca59bcc80b/mzaf_12121445588963961343.plus.aac.p.m4a"),
      Music('Eagles', 'images/hotel.jpg', 'Hotel California',
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/a7/1b/f0/a71bf07d-f498-05c9-2c8a-d12af7d019d8/mzaf_11402952498213508559.plus.aac.p.m4a"),
       Music('The Weeknd', 'images/weeknd.jpg', 'Blinding Lights',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/a7/50/d2/a750d2f9-180e-b9b9-47f7-4b4ef2ffdc10/mzaf_7897266582266926068.plus.aac.p.m4a"),
    Music('Drake', 'images/drake.jpg', 'One Dance',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/44/a9/d6/44a9d665-f496-d16b-d2d3-9a43f3cc67b2/mzaf_14295643639813549715.plus.aac.p.m4a"),
Music('Miley Cyrus', 'images/miley.jpg', 'Flowers',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/a2/92/2d/a2922d1d-54b0-0d3e-b510-528f77c3acfd/mzaf_14712631428054012256.plus.aac.p.m4a"),
     Music('Harry Styles', 'images/harry.png', 'As It Was',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/70/27/ed/7027edbb-0329-eec6-1ffb-c17a93caa2c1/mzaf_1479269605289718896.plus.aac.p.m4a"),
    Music('Sam Smith & Kim Petras', 'images/unholy.png', 'Unholy',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/f9/a1/56/f9a156a9-14b1-64da-4e3b-98959c58c7a7/mzaf_13082312146721062266.plus.aac.p.m4a"),
    Music('Steve Lacy', 'images/steve.jpg', 'Bad Habit',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/82/2f/94/822f94d1-4181-9d34-9639-9f6f02c5683b/mzaf_18121178780070157464.plus.aac.p.m4a"),
    Music('Dua Lipa', 'images/levitating.jpg', 'Levitating',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/9a/4a/d7/9a4ad785-7b6c-f6b3-99cf-e5b9d4790101/mzaf_11363966953076411158.plus.aac.p.m4a"),
    Music('Zach Bryan & Kacey Musgraves', 'images/zach.jpg', 'I Remember Everything',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/98/28/16/98281673-1d57-5195-b993-e983bc5b1b93/mzaf_15388744600423951976.plus.aac.p.m4a"),
    Music('SZA', 'images/sza.png', 'Kill Bill',
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/af/25/a7/af25a7b9-e35d-2015-9188-6b0397e59287/mzaf_7592945681897484169.plus.aac.p.m4a"),
  
      Music('Billie Eilish', 'images/most1.jpg', 'Happier Than Ever',
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/22/8a/a1/228aa1a0-cbfd-ac14-ae99-09ca59bcc80b/mzaf_12121445588963961343.plus.aac.p.m4a"),
    ];
  }

  List<Map<String, String>> getArtists() {
    return [
      {'name': 'Adele', 'image': 'images/adele1.jpg', 'artistPage': '/adele'},
      {'name': 'Taylor Swift', 'image': 'images/TaylorSwift.jpg', 'artistPage': '/taylor'},
      {'name': 'Bruno Mars', 'image': 'images/BrunoMars.jpg', 'artistPage': '/bruno'},
      {'name': 'ElgrandeToto', 'image': 'images/ElgrandeToto.jpg', 'artistPage': '/eagles'},
      {'name': 'Ed Sheeran', 'image': 'images/EdSheeranPage.jpg', 'artistPage': '/EdSheeranPage'},
      {'name': 'Metallica', 'image': 'images/metallica.jpg', 'artistPage': '/metallica'}, 


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

  Widget buildMusicItem(Music music) {
    bool isPlaying = (playingUrl == music.url);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: InkWell(
              onTap: () => togglePlayPause(music),
              child: Image.asset(
                music.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
          ),
          Text(
            music.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            music.desc,
            style: const TextStyle(color: Colors.white),
          ),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () => togglePlayPause(music),
          ),
        ],
      ),
    );
  }

  Widget buildMusicList(String label, List<Music> musicList) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 500,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: musicList.length,
              itemBuilder: (_, index) => buildMusicItem(musicList[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArtistItem(Map<String, String> artist) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, artist['artistPage']!),
        child: Column(
          children: [
            Image.asset(
              artist['image']!,
              fit: BoxFit.cover,
              width: 400,
              height: 400,
            ),
            Text(
              artist['name']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(8),
      child: const Text(
        '© 2025 Sonnet. All rights reserved.',
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'images/logo.jpg',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'Sonnet',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: widget.showLoginScreen,
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 76, 10, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    buildMusicList('Most Popular Songs', getPopularMusic()),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Artists',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 500,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: getArtists().length,
                              itemBuilder: (_, index) =>
                                  buildArtistItem(getArtists()[index]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildFooter(),
          ],
        ),
      ),
    );
  }
}
