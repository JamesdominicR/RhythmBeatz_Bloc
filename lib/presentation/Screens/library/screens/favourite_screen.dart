import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythm_beatz_bloc/database/songmodel_adaptor.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/widgets/popup_widget.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/now_playing/nowplaying_screen.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/widgets/open_audio.dart';
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<MusicSongs>? dbSongs = [];
  List<Audio> playLiked = [];
  final box = MusicBox.getInstance();
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
        appBar: AppBar(
          title: const Text(
            'Favourites',
            style: TextStyle(
              color: Color(0xffFFFDFD),
              fontFamily: 'assets/fonts/Inter-Medium.ttf',
              fontSize: 28,
              //fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  final likedSongs = box.get("favourites");
                  return ListView.builder(
                    itemCount: likedSongs!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        for (var element in likedSongs) {
                          playLiked.add(
                            Audio.file(
                              element.uri!,
                              metas: Metas(
                                title: element.title,
                                id: element.id.toString(),
                                artist: element.artist,
                              ),
                            ),
                          );
                        }
                        OpenAssetAudio(allsong: playLiked, index: index)
                            .openAsset(index: index, audios: playLiked);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenPlaying(
                              audiosongs: playLiked,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: QueryArtworkWidget(
                            id: likedSongs[index].id!,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(15),
                            artworkFit: BoxFit.cover,
                            nullArtworkWidget: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/Images/musicdefaultIcon.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        trailing: PopupWidget(
                            songID: likedSongs[index].id.toString()),
                        title: Text(
                          likedSongs[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                        ),
                        subtitle: Text(
                          likedSongs[index].artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
