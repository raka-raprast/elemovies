// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:emovied/data/show_sqflite.dart';
import 'package:emovied/models/saved_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
  @override
  List<Object?> get props => [];
}

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
  @override
  List<Object?> get props => [];
}

class WatchlistInitMovieEvent extends WatchlistEvent {
  @override
  List<Object?> get props => [];
}

class WatchlistGetListEvent extends WatchlistEvent {
  @override
  List<Object?> get props => [];
}

class WatchlistGetListIDEvent extends WatchlistEvent {
  @override
  List<Object?> get props => [];
}

class WatchlistAddToWatchListEvent extends WatchlistEvent {
  final SavedShows request;

  WatchlistAddToWatchListEvent(this.request);
  @override
  List<Object?> get props => [];
}

class WatchlistRemoveFromWatchListEvent extends WatchlistEvent {
  final SavedShows request;

  WatchlistRemoveFromWatchListEvent(this.request);
  @override
  List<Object?> get props => [];
}

class WatchlistInitialState extends WatchlistState {
  @override
  List<Object?> get props => [];
}

class WatchlistLoadedState extends WatchlistState {
  final List<SavedShows> savedShowResponse;

  WatchlistLoadedState(this.savedShowResponse);
  @override
  List<Object?> get props => [this.savedShowResponse];
}

class WatchlistLoadedIDState extends WatchlistState {
  final WatchListWithID savedShowResponse;

  WatchlistLoadedIDState(this.savedShowResponse);
  @override
  List<Object?> get props => [this.savedShowResponse];
}

class WatchlistChangeState extends WatchlistState {
  @override
  List<Object?> get props => [];
}

class WatchlistLoadingState extends WatchlistState {
  @override
  List<Object?> get props => [];
}

class WatchlistErrorState extends WatchlistState {
  final dynamic error;

  WatchlistErrorState(this.error);
  @override
  List<Object?> get props => [this.error];
}

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitialState()) {
    on<WatchlistGetListEvent>(getWatchList);
    on<WatchlistGetListIDEvent>(getWatchListID);
    on<WatchlistInitMovieEvent>(initWatchlistList);
    on<WatchlistAddToWatchListEvent>(addToWatchList);
    on<WatchlistRemoveFromWatchListEvent>(removeFromWatchList);
  }

  void initWatchlistList(WatchlistInitMovieEvent event, Emitter<WatchlistState> state) async {
    emit(WatchlistLoadingState());
    add(WatchlistGetListEvent());
  }

  Future<void> getWatchList(WatchlistGetListEvent event, Emitter<WatchlistState> state) async {
    try {
      final response = await SavedShowsDatabase.instance.readAllSavedShows();
      emit(WatchlistLoadedState(response));
    } on Exception catch (error) {
      log("$error");
      emit(WatchlistErrorState(error));
    }
  }

  Future<void> getWatchListID(WatchlistGetListIDEvent event, Emitter<WatchlistState> state) async {
    try {
      final response = await SavedShowsDatabase.instance.readSavedShowsID();
      emit(WatchlistLoadedIDState(response));
    } on Exception catch (error) {
      log("$error");
      emit(WatchlistErrorState(error));
    }
  }

  Future<void> addToWatchList(WatchlistAddToWatchListEvent event, Emitter<WatchlistState> state) async {
    try {
      await SavedShowsDatabase.instance.create(event.request);
      emit(WatchlistLoadingState());
      emit(WatchlistChangeState());
    } on Exception catch (error) {
      log("$error");
      emit(WatchlistErrorState(error));
    }
  }

  Future<void> removeFromWatchList(WatchlistRemoveFromWatchListEvent event, Emitter<WatchlistState> state) async {
    try {
      await SavedShowsDatabase.instance.delete(event.request.id!);
      emit(WatchlistLoadingState());
      emit(WatchlistChangeState());
    } on Exception catch (error) {
      log("$error");
      emit(WatchlistErrorState(error));
    }
  }
}
