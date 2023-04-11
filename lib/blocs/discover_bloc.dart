// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:emovied/main_export.dart';
import 'package:emovied/models/show.dart';
import 'package:emovied/utils/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();
  @override
  List<Object?> get props => [];
}

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();
  @override
  List<Object?> get props => [];
}

class DiscoverInitMovieEvent extends DiscoverEvent {
  @override
  List<Object?> get props => [];
}

class DiscoverGetPopularMovieEvent extends DiscoverEvent {
  @override
  List<Object?> get props => [];
}

class DiscoverGetPopularTVShowEvent extends DiscoverEvent {
  @override
  List<Object?> get props => [];
}

class DiscoverGetTopRatedMovieEvent extends DiscoverEvent {
  @override
  List<Object?> get props => [];
}

class DiscoverGetTopRatedTVShowEvent extends DiscoverEvent {
  @override
  List<Object?> get props => [];
}

class DiscoverInitialState extends DiscoverState {
  @override
  List<Object?> get props => [];
}

class DiscoverLoadedPopularMovieState extends DiscoverState {
  final List<Shows> discoverResponse;

  DiscoverLoadedPopularMovieState(this.discoverResponse);
  @override
  List<Object?> get props => [this.discoverResponse];
}

class DiscoverLoadedPopularTVShowState extends DiscoverState {
  final List<Shows> discoverResponse;

  DiscoverLoadedPopularTVShowState(this.discoverResponse);
  @override
  List<Object?> get props => [this.discoverResponse];
}

class DiscoverLoadedTopRatedMovieState extends DiscoverState {
  final List<Shows> discoverResponse;

  DiscoverLoadedTopRatedMovieState(this.discoverResponse);
  @override
  List<Object?> get props => [this.discoverResponse];
}

class DiscoverLoadedTopRatedTVShowState extends DiscoverState {
  final List<Shows> discoverResponse;

  DiscoverLoadedTopRatedTVShowState(this.discoverResponse);
  @override
  List<Object?> get props => [this.discoverResponse];
}

class DiscoverLoadingState extends DiscoverState {
  @override
  List<Object?> get props => [];
}

class DiscoverErrorState extends DiscoverState {
  final dynamic error;

  DiscoverErrorState(this.error);
  @override
  List<Object?> get props => [this.error];
}

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverInitialState()) {
    on<DiscoverGetPopularMovieEvent>(getPopularMovieList);
    on<DiscoverGetPopularTVShowEvent>(getPopularTVShowList);
    on<DiscoverGetTopRatedMovieEvent>(getTopRatedMovieList);
    on<DiscoverGetTopRatedTVShowEvent>(getTopRatedTVShowList);
    on<DiscoverInitMovieEvent>(initPopularModeList);
  }

  void initPopularModeList(DiscoverInitMovieEvent event, Emitter<DiscoverState> state) async {
    emit(DiscoverLoadingState());
    add(DiscoverGetPopularMovieEvent());
  }

  Future<void> getPopularMovieList(DiscoverGetPopularMovieEvent event, Emitter<DiscoverState> state) async {
    try {
      final response = await TheMovieDBAPI.fetchShowsData("https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1");
      emit(DiscoverLoadedPopularMovieState(response));
    } on Exception catch (error) {
      log("$error");
      emit(DiscoverErrorState(error));
    }
  }

  Future<void> getPopularTVShowList(DiscoverGetPopularTVShowEvent event, Emitter<DiscoverState> state) async {
    try {
      final response = await TheMovieDBAPI.fetchShowsData("https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&language=en-US&page=1");
      emit(DiscoverLoadedPopularTVShowState(response));
    } on Exception catch (error) {
      log("$error");
      emit(DiscoverErrorState(error));
    }
  }

  Future<void> getTopRatedMovieList(DiscoverGetTopRatedMovieEvent event, Emitter<DiscoverState> state) async {
    try {
      final response = await TheMovieDBAPI.fetchShowsData("https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1");
      emit(DiscoverLoadedPopularMovieState(response));
    } on Exception catch (error) {
      log("$error");
      emit(DiscoverErrorState(error));
    }
  }

  Future<void> getTopRatedTVShowList(DiscoverGetTopRatedTVShowEvent event, Emitter<DiscoverState> state) async {
    try {
      final response = await TheMovieDBAPI.fetchShowsData("https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&language=en-US&page=1");
      emit(DiscoverLoadedPopularTVShowState(response));
    } on Exception catch (error) {
      log("$error");
      emit(DiscoverErrorState(error));
    }
  }
}
