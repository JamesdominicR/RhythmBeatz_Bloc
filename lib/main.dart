import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythm_beatz_bloc/logics/add_button/add_button_bloc.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/widgets/splashscreen.dart';
import 'database/songmodel_adaptor.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'logics/search/search_bloc.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MusicSongsAdapter());
  await Hive.openBox<List>(boxname);
  final box = MusicBox.getInstance();
  List<dynamic> libraryKeys = box.keys.toList();
  if (!(libraryKeys.contains("favourites"))) {
    List<dynamic> likedSongs = [];
    await box.put("favourites", likedSongs);
  }
  runApp(const MyApp());
}

final box = MusicBox.getInstance();
List<MusicSongs> dbSongs = [];
List<MusicSongs> recievedDatabaseSongs = [];
List<Audio> databaseAudioList = [];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> audiosongs = [];
  final _audioQuery = OnAudioQuery();

  List<MusicSongs> mappedSongs = [];

  List<SongModel> fetchedSongs = [];
  @override
  void initState() {
    super.initState();
    fetchSongs();
  }
  List<SongModel> allsong = [];
  fetchSongs() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    allsong = await _audioQuery.querySongs();
    mappedSongs = allsong
        .map((e) => MusicSongs(
            title: e.title,
            id: e.id,
            uri: e.uri!,
            duration: e.duration,
            artist: e.artist))
        .toList();
    await box.put('musics', mappedSongs);
    dbSongs = box.get('musics') as List<MusicSongs>;
    
    dbSongs.forEach((element) {
      audiosongs.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist),
        ),
      );
    });
    await box.put('musics', mappedSongs);
    recievedDatabaseSongs = box.get('musics') as List<MusicSongs>;

    // convert it to the type Audio
    for (var element in recievedDatabaseSongs) {
      databaseAudioList.add(
        Audio.file(element.uri.toString(),
            metas: Metas(
                title: element.title,
                artist: element.artist,
                id: element.id.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => AddButtonBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedsplashScreen(
          audioSongs: audiosongs,
        ),
      ),
    );
  }
}
