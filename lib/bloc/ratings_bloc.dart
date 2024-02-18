import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/rating_model.dart';
import '../service/ratings_service.dart';

part 'ratings_event.dart';
part 'ratings_state.dart';

class RatingsBloc extends Bloc<RatingsEvent, RatingsState> {
  RatingsBloc({required this.ratingsService}) : super(const RatingsInitial(ratings: [])) {
    on<FetchRatings>((event, emit) async {
      try {
        emit(RatingsLoading());
        final ratings = await ratingsService.getRatings();
        final filteredRatings = ratings.where((rating) => rating.validated && !rating.deleted).toList();
        emit(RatingsFetchReady(ratings: filteredRatings));
      } catch (_) {
        emit(const RatingsInitial());
        debugPrint("error");
      }
    });

    on<FetchFilteredRatings>((event, emit) async {
      try {
        emit(RatingsLoading());
        final ratings = await ratingsService.getRatings();
        final filteredRatings = ratings.where((rating) => !rating.validated && !rating.deleted).toList();
        emit(RatingsFetchReady(ratings: filteredRatings));
      } catch (_) {
        emit(const RatingsInitial());
        debugPrint("error");
      }
    });

    on<AddRating>((event, emit) async {
      try {
        emit(RatingsLoading());
        await ratingsService.addRating(event.rating);
      } catch (e) {
        emit(const RatingsInitial());
        debugPrint("error");
      }
    });

    on<ValidateRating>((event, emit) async {
      try {
        emit(RatingsLoading());
        await ratingsService.updateRating(event.rating.id!, validated: true);
      } catch (e) {
        emit(const RatingsInitial());
        debugPrint("error");
      }
    });

    on<DeleteRating>((event, emit) async {
      try {
        emit(RatingsLoading());
        await ratingsService.updateRating(event.rating.id!, deleted: true);
      } catch (e) {
        emit(const RatingsInitial());
        debugPrint("error");
      }
    });
  }
  RatingsService ratingsService;
}
