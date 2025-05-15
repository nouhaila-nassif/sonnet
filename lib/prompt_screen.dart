import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:sonnet/random_circles.dart';
import 'package:url_launcher/url_launcher.dart';

class PromptScreen extends StatefulWidget {
  final VoidCallback showHomeScreen;

  const PromptScreen({super.key, required this.showHomeScreen});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final List<String> genres = [
    'Jazz', 'Rock', 'R&B', 'Latin', 'Hip-Hop', 'Hip-Life',
    'Reggae', 'Gospel', 'Afrobeat', 'Blues', 'Country', 'Punk', 'Pop',
  ];

  final Set<String> _selectedGenres = {};
  String? _selectedMood;
  String? _selectedMoodImage;
  List<Map<String, String?>> _playlist = [];
  bool _isLoading = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Validation de l'URL pour les sources audio valides
  bool _isValidAudioUrl(String url) {
    final validAudioFormats = ['mp3', 'wav', 'aac', 'ogg'];
    return validAudioFormats.any((format) => url.endsWith(format));
  }

  // Sélection des genres
  void _onGenreTap(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  // Fonction pour gérer la sélection de l'humeur
  void _onMoodSelected(String mood, String image) {
    setState(() {
      _selectedMood = mood;
      _selectedMoodImage = image;
    });
  }

  // Fonction de déconnexion
  void _logout() {
    setState(() {
      _selectedGenres.clear();
      _selectedMood = null;
      _selectedMoodImage = null;
      _playlist.clear();
    });
    widget.showHomeScreen(); // Navigue vers l'écran d'accueil
  }

  // Gestion de la lecture audio
  Future<void> _submitSelections() async {
    if (_selectedMood == null || _selectedGenres.isEmpty) {
      _showSnackBar('Please select a mood and at least one genre');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final moodAndGenres = '$_selectedMood ${_selectedGenres.join(' ')}';
    final url = Uri.parse(
      'http://ws.audioscrobbler.com/2.0/?method=track.search'
      '&track=$moodAndGenres'
      '&api_key=86f06e9e15682088d83d4f6134bef94a'
      '&format=json',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tracks = data['results']?['trackmatches']?['track'] as List? ?? [];

        if (tracks.isNotEmpty) {
          setState(() {
            _playlist = tracks.map<Map<String, String?>>((track) {
              return {
                'artist': track['artist'] ?? 'Unknown Artist',
                'title': track['name'] ?? 'Unknown Title',
                'url': track['url'],
              };
            }).toList();
          });
        } else {
          _showSnackBar('No songs found for the selected mood and genres');
        }
      } else {
        _showSnackBar('Failed to fetch playlist from Last.fm');
      }
    } catch (e) {
      _showSnackBar('An error occurred while fetching the playlist: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Méthode pour jouer une chanson
  Future<void> _playSong(String? url) async {
    if (url == null || url.isEmpty) {
      _showSnackBar('No valid URL found for this song');
      return;
    }

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Could not launch the URL');
      }
    } catch (e) {
      _showSnackBar('Failed to launch the URL: ${e.toString()}');
    }
  }

  // Affichage de messages snack
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Réinitialisation des sélections
  void _resetSelections() {
    setState(() {
      _playlist = [];
      _selectedGenres.clear();
      _selectedMood = null;
      _selectedMoodImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF330000),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo.jpg', // Logo à gauche
            fit: BoxFit.contain,
            height: 40,
          ),
        ),
        title: Text(
          'Sonnet', // App name added here
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: _logout, // Déconnexion au clic
          ),
        ],
        leadingWidth: 60,  // Adjust width if needed
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF330000),
              Color(0xFF000000),
            ],
          ),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
          child: _isLoading
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    height: 50.0,
                    width: 50.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: const CircularProgressIndicator(
                      color: Color(0xFF000000),
                    ),
                  ),
                )
              : _playlist.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RandomCircles(
                            onMoodSelected: (mood, image) {
                              _selectedMood = mood;
                              _selectedMoodImage = image;
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Genre',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFFFFFF).withOpacity(0.8),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 5.0,
                                  ),
                                  child: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Wrap(
                                        children: genres.map((genre) {
                                          final isSelected = _selectedGenres.contains(genre);
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_selectedGenres.contains(genre)) {
                                                  _selectedGenres.remove(genre);
                                                } else {
                                                  _selectedGenres.add(genre);
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(3.0),
                                              margin: const EdgeInsets.only(right: 4.0, top: 4.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  width: 0.4,
                                                  color: const Color(0xFFFFFFFF).withOpacity(0.8),
                                                ),
                                              ),
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                  top: 8.0,
                                                  bottom: 8.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? const Color(0xFF0000FF)
                                                      : const Color(0xFFFFFFFF).withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                                child: Text(
                                                  genre,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: isSelected
                                                        ? const Color(0xFFFFFFFF)
                                                        : const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                ),
                               Padding(
  padding: const EdgeInsets.only(top: 20.0),
  child: Center( // Ajout du widget Center pour centrer le bouton
    child: GestureDetector(
      onTap: _submitSelections,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0xFF0000FF),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Get Playlist',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
),

                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _playlist.length,
                            itemBuilder: (context, index) {
                              final song = _playlist[index];
                              final artist = song['artist'];
                              final title = song['title'];
                              final url = song['url'];
                              return ListTile(
                                title: Text(
                                  '$title by $artist',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _playSong(url);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: _resetSelections,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xFF0000FF),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Clear Playlist',
                                style: GoogleFonts.inter(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
