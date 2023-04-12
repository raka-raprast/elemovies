// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:emovied/main_export.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();
  @override
  List<Object?> get props => [];
}

abstract class UpcomingEvent extends Equatable {
  const UpcomingEvent();
  @override
  List<Object?> get props => [];
}

class UpcomingGetListEvent extends UpcomingEvent {
  @override
  List<Object?> get props => [];
}

class UpcomingInitialState extends UpcomingState {
  @override
  List<Object?> get props => [];
}

class UpcomingLoadedState extends UpcomingState {
  final List<Shows> trendingResponse;

  UpcomingLoadedState(this.trendingResponse);
  @override
  List<Object?> get props => [this.trendingResponse];
}

class UpcomingLoadingState extends UpcomingState {
  @override
  List<Object?> get props => [];
}

class UpcomingErrorState extends UpcomingState {
  final dynamic error;

  UpcomingErrorState(this.error);
  @override
  List<Object?> get props => [this.error];
}

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  UpcomingBloc() : super(UpcomingInitialState()) {
    on<UpcomingGetListEvent>(getList);
  }
  Future<void> getList(UpcomingGetListEvent event, Emitter<UpcomingState> state) async {
    emit(UpcomingLoadingState());
    try {
      final response = await TheMovieDBAPI.fetchShowsData("https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=$apiKey");
      emit(UpcomingLoadedState(response));
    } on Exception catch (error) {
      log("$error");
      emit(UpcomingErrorState(error));
    }
  }
}
