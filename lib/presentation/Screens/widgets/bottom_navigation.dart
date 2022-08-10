import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/home/home_screen.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/screens/library_screen.dart';
import 'package:rhythm_beatz_bloc/presentation/search/search_screen.dart';
import 'package:swipe_to/swipe_to.dart';
import '../now_playing/nowplaying_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  List<Audio> allsong;
  BottomNavigationWidget({Key? key, required this.allsong}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  final audioQuery = OnAudioQuery();
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetoptions = <Widget>[
      HomeScreen(
        audiosongs: widget.allsong,
      ),
      SearchScreen(
        audiosongs: widget.allsong,
      ),
     const LibraryScreen(),
    ];
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: (() {
          Navigator.of(context).push(PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300),
            child: ScreenPlaying(
              index: 0,
              audiosongs: widget.allsong,
            ),
          ));
        }),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xffB4AFEF),
          ),
          child: assetsAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
              final myaudio =
                  find(widget.allsong, playing!.audio.assetAudioPath);
              return Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 47,
                    width: 47,
                    child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(5.0),
                        id: int.parse(myaudio.metas.id!),
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(3.0),
                            child: Image.asset(
                              'assets/Images/musicdefaultIcon.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        top: 12,
                      ),
                      child: SwipeTo(
                        iconSize: 0,
                        onLeftSwipe: () {
                          assetsAudioPlayer.next();
                        },
                        onRightSwipe: () {
                          assetsAudioPlayer.previous();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myaudio.metas.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              myaudio.metas.artist!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      playing.index == 0
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Color(0xff7285A5),
                              ))
                          : IconButton(
                              onPressed: () {
                                assetsAudioPlayer.previous();
                              },
                              icon: const Icon(Icons.skip_previous),
                            ),
                      PlayerBuilder.isPlaying(
                          player: assetsAudioPlayer,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () async {
                                await assetsAudioPlayer.playOrPause();
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                              ),
                            );
                          }),
                      GestureDetector(
                        child: playing.index == dbSongs.length - 1
                            ? IconButton(
                              onPressed: () {},
                                icon: const Icon(Icons.skip_next,
                                color: Color(0xff7285A5),
                              )
                            )
                            : IconButton(
                                onPressed: () {
                                  assetsAudioPlayer.next();
                                },
                                icon: const Icon(Icons.skip_next),
                              ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
      body: Center(
        child: _widgetoptions[_selectedIndex],
      ),
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Color(0xff8B6EFF)),
        ),
        child: CurvedNavigationBar(
          key: bottomNavigationKey,
          backgroundColor: Colors.transparent,
          color: const Color(0xff0e0b2a),
          height: 60,
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.library_add, size: 30),
          ],
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
