import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rhythm_beatz_bloc/database/songmodel_adaptor.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/screens/favourite_screen.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/screens/user_playlist_screen.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/widgets/custom_listtile_library.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/widgets/custom_playlist.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/widgets/edit_playlist_card.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/now_playing/widgets/create_playlist_card.dart';

class LibraryPlaylistWidget extends StatefulWidget {
  const LibraryPlaylistWidget({Key? key}) : super(key: key);

  @override
  State<LibraryPlaylistWidget> createState() => _LibraryPlaylistWidgetState();
}

class _LibraryPlaylistWidgetState extends State<LibraryPlaylistWidget> {
  final box = MusicBox.getInstance();
  List playlists = [];
  String? playlistName = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Column(
              children: [
                CustomListtileLibrary(
                  titleNew: 'Create Playlist',
                  leadingNew: FontAwesomeIcons.squarePlus,
                  ontapNew: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreatePlaylistCard(),
                    );
                  },
                ),
                CustomListtileLibrary(
                  titleNew: 'Favourites',
                  leadingNew: FontAwesomeIcons.heart,
                  ontapNew: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouriteScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, boxes, _) {
                  playlists = box.keys.toList();
                  return ListView.builder(
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: playlists[index] != "musics" &&
                                playlists[index] != "favourites"
                            ? CustomPlayList(
                                titleNew: playlists[index].toString(),
                                leadingNew: Icons.queue_music,
                                trailingNew: PopupMenuButton(
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      child: Text(
                                        'Remove Playlist',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins'),
                                      ),
                                      value: "0",
                                    ),
                                    const PopupMenuItem(
                                      value: "1",
                                      child: Text(
                                        "Rename Playlist",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == "0") {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                backgroundColor:
                                                    Color(0xffB4AFEF),
                                                content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                    const  Padding(
                                                        padding:
                                                            EdgeInsets
                                                                .only(
                                                          right: 20,
                                                          left: 20,
                                                          top: 20,
                                                        ),
                                                        child: Text(
                                                          'Remove this Playlist',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 5,
                                                              ),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      false);
                                                                },
                                                                child: const Center(
                                                                  child: Text(
                                                                    'Close',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 5,
                                                              ),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  box.delete(
                                                                      playlists[
                                                                          index]);
                                                                  setState(() {
                                                                    playlists = box
                                                                        .keys
                                                                        .toList();
                                                                  });
                                                                  Navigator.pop(
                                                                      context,
                                                                      false);
                                                                },
                                                                child: const Center(
                                                                  child: Text(
                                                                    'Remove',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ]),
                                              ));

                                      // Navigator.of(context).pop();
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //     content: Text('Playlist Removed'),
                                      //   ),
                                      // );

                                    }
                                    if (value == "1") {
                                      showDialog(
                                        context: context,
                                        builder: (context) => EditPlaylistCard(
                                          playlistName: playlists[index],
                                        ),
                                      );
                                    }
                                  },
                                ),
                                ontapNew: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserPlaylistScreen(
                                        PlaylistName: playlists[index],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //setting up popup for showing created playlist is deleted
  showAlertDialogue(BuildContext context) async {
    Widget cancelButton = await TextButton(
      child: const Text('Close'),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget deleteButton = await TextButton(
      child: const Text('Delete'),
      onPressed: () {},
    );
    AlertDialog alert = AlertDialog(
      content: const Text('Are you sure want to remove this playlist'),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
  }
}
