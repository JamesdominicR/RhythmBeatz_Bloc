import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rhythm_beatz_bloc/database/songmodel_adaptor.dart';
part 'search_event.dart';
part 'search_state.dart';
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(allSong: [])) {
    on<SerachInputEvent>((event, emit) {
      final box = MusicBox.getInstance();
      List<MusicSongs> dbSongs = [];
      List<Audio> allSongs = [];
      dbSongs = box.get("musics") as List<MusicSongs>;
      for (var element in dbSongs) {
        allSongs.add(
          Audio.file(
            element.uri.toString(),
            metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist,
            ),
          ),
        );
      }
      List<Audio> searchTitle = allSongs.where((element) {
        return element.metas.title!.toLowerCase().startsWith(
              event.search.toLowerCase(),
            );
      }).toList();

      List<Audio> searchArtist = allSongs.where((element) {
        return element.metas.artist!.toLowerCase().startsWith(
              event.search.toLowerCase(),
            );
      }).toList();

      List<Audio> searchResult = allSongs;
      if (searchTitle.isNotEmpty) {
        searchResult = searchTitle;
      } else {
        searchResult = searchArtist;
      }

      emit(SearchInitial(allSong: searchResult));

    });
  }
}

