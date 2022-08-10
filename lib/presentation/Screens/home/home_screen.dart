import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rhythm_beatz_bloc/database/songmodel_adaptor.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/home/widgets/musiclist_menuwidget.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/settings/settings.dart';
import '../widgets/open_audio.dart';

class HomeScreen extends StatefulWidget {
  List<Audio> audiosongs;
  HomeScreen({Key? key, required this.audiosongs}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? dbSongs = [];
  List playlists = [];
  List<dynamic>? favourites = [];
  List<dynamic>? likedSongs = [];
  final box = MusicBox.getInstance();
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  final _audioQuery = OnAudioQuery();
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    super.initState();
    dbSongs = box.get("musics");
    List? likeSongs = box.get('favourites');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff29225a), Color(0xff2b234e)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'Discover Your Songs',
                        style: TextStyle(
                          color: Color(0xffFFFDFD),
                          fontFamily: 'assets/fonts/Inter-Medium.ttf',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                            child: const ScreenSettings(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xffFFFDFD),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<SongModel>>(
                    future: _audioQuery.querySongs(
                      sortType: SongSortType.DISPLAY_NAME,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                    ),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (item.data!.isEmpty) {
                        return const Center(
                          child: Text("No songs found"),
                        );
                      }
                      return ListView.builder(
                          itemCount: widget.audiosongs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                widget.audiosongs[index].metas.title!,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontFamily: 'assets/fonts/Roboto-Light.ttf',
                                  fontSize: 20.0,
                                  color: Color(0xffFAF4F4),
                                ),
                              ),
                              subtitle: Text(
                                widget.audiosongs[index].metas.artist!,
                                style: const TextStyle(
                                  color: Color(0xffD9D8E0),
                                  fontFamily: 'assets/fonts/Roboto-Light.ttf',
                                  fontSize: 12.0,
                                ),
                              ),
                              leading: Container(
                                height: 80.0,
                                width: 60.0,
                                child: QueryArtworkWidget(
                                  artworkBorder: BorderRadius.circular(5.0),
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(3.0),
                                      child: Image.asset(
                                        'assets/Images/musicdefaultIcon.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  id: int.parse(widget
                                      .audiosongs[index].metas.id
                                      .toString()),
                                  type: ArtworkType.AUDIO,
                                ),
                              ),
                              trailing: MusiclistMenuWidget(
                                songID: widget.audiosongs[index].metas.id
                                    .toString(),
                              ),
                              onTap: () async {
                                OpenAssetAudio(allsong: [], index: index)
                                    .openAsset(
                                  index: index,
                                  audios: widget.audiosongs,
                                );
                              },
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
