// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:emovied/main_export.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();
  @override
  List<Object?> get props => [];
}

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();
  @override
  List<Object?> get props => [];
}

class NowPlayingInitMovieEvent extends NowPlayingEvent {
  @override
  List<Object?> get props => [];
}

class NowPlayingGetMovieEvent extends NowPlayingEvent {
  @override
  List<Object?> get props => [];
}

class NowPlayingGetTVShowEvent extends NowPlayingEvent {
  @override
  List<Object?> get props => [];
}

class NowPlayingInitialState extends NowPlayingState {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadedMovieState extends NowPlayingState {
  final List<Shows> nowPlayingResponse;

  NowPlayingLoadedMovieState(this.nowPlayingResponse);
  @override
  List<Object?> get props => [this.nowPlayingResponse];
}

class NowPlayingLoadedTVShowState extends NowPlayingState {
  final List<Shows> nowPlayingResponse;

  NowPlayingLoadedTVShowState(this.nowPlayingResponse);
  @override
  List<Object?> get props => [this.nowPlayingResponse];
}

class NowPlayingLoadingState extends NowPlayingState {
  @override
  List<Object?> get props => [];
}

class NowPlayingErrorState extends NowPlayingState {
  final dynamic error;

  NowPlayingErrorState(this.error);
  @override
  List<Object?> get props => [this.error];
}

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc() : super(NowPlayingInitialState()) {
    on<NowPlayingGetMovieEvent>(getMovieList);
    on<NowPlayingGetTVShowEvent>(getTVShowList);
    on<NowPlayingInitMovieEvent>(initMovieList);
  }

  void initMovieList(NowPlayingInitMovieEvent event, Emitter<NowPlayingState> state) {
    emit(NowPlayingLoadingState());
    add(NowPlayingGetMovieEvent());
  }

  Future<void> getMovieList(NowPlayingGetMovieEvent event, Emitter<NowPlayingState> state) async {
    try {
      final response = await TheMovieDBAPI.fetchShowsData("https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1");
      emit(NowPlayingLoadedMovieState(response));
    } on Exception catch (error) {
      log("$error");
      emit(NowPlayingErrorState(error));
    }
  }

  Future<void> getTVShowList(NowPlayingGetTVShowEvent event, Emitter<NowPlayingState> state) async {
    try {
      final response = await TheMovieDBAPI.fetchShowsData("https://api.themoviedb.org/3/tv/airing_today?api_key=$apiKey&language=en-US&page=1");
      emit(NowPlayingLoadedTVShowState(response));
    } on Exception catch (error) {
      log("$error");
      emit(NowPlayingErrorState(error));
    }
  }
}
