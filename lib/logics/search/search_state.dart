part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

  class SearchInitial extends SearchState {
   final List<Audio> allSong;

  SearchInitial({required this.allSong});

  @override
  List<Audio> get props => allSong;
  
}
