part of 'ratings_bloc.dart';

sealed class RatingsState extends Equatable {
  const RatingsState();
  @override
  List<Object> get props => [];
}

class RatingsInitial extends RatingsState {
  const RatingsInitial({this.ratings = const []});

  final List<Rating> ratings;

  @override
  List<Object> get props => [ratings];
}

final class RatingsLoading extends RatingsState {}

final class RatingsFetchReady extends RatingsState {
  const RatingsFetchReady({required this.ratings});

  final List<Rating> ratings;

  @override
  List<Object> get props => [ratings];
}

final class RatingsFetchError extends RatingsState {
  const RatingsFetchError({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
