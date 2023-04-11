// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:emovied/main_export.dart';
import 'package:emovied/models/search.dart';
import 'package:emovied/utils/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MultiSearchState extends Equatable {
  const MultiSearchState();
  @override
  List<Object?> get props => [];
}

abstract class MultiSearchEvent extends Equatable {
  const MultiSearchEvent();
  @override
  List<Object?> get props => [];
}

class MultiSearchGetListEvent extends MultiSearchEvent {
  final String query;

  MultiSearchGetListEvent(this.query);
  @override
  List<Object?> get props => [];
}

class MultiSearchInitialState extends MultiSearchState {
  @override
  List<Object?> get props => [];
}

class MultiSearchLoadedState extends MultiSearchState {
  final List<MultiSearch> multiSearchResponse;

  MultiSearchLoadedState(this.multiSearchResponse);
  @override
  List<Object?> get props => [this.multiSearchResponse];
}

class MultiSearchLoadingState extends MultiSearchState {
  @override
  List<Object?> get props => [];
}

class MultiSearchErrorState extends MultiSearchState {
  final dynamic error;

  MultiSearchErrorState(this.error);
  @override
  List<Object?> get props => [this.error];
}

class MultiSearchBloc extends Bloc<MultiSearchEvent, MultiSearchState> {
  MultiSearchBloc() : super(MultiSearchInitialState()) {
    on<MultiSearchGetListEvent>(getList);
  }
  Future<void> getList(MultiSearchGetListEvent event, Emitter<MultiSearchState> state) async {
    emit(MultiSearchLoadingState());
    if (event.query.isNotEmpty) {
      try {
        final response = await TheMovieDBAPI.fetchSearchData("https://api.themoviedb.org/3/search/multi?api_key=$apiKey&language=en-US&page=1&include_adult=false&query=${event.query}");
        emit(MultiSearchLoadedState(response));
      } on Exception catch (error) {
        log("$error");
        emit(MultiSearchErrorState(error));
      }
    } else {
      emit(MultiSearchInitialState());
    }
  }
}
