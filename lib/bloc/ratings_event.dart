part of 'ratings_bloc.dart';

sealed class RatingsEvent extends Equatable {
  const RatingsEvent();

  @override
  List<Object> get props => [];
}

class FetchRatings extends RatingsEvent {}

class FetchFilteredRatings extends RatingsEvent {}

class RatingsReady extends RatingsEvent {
  const RatingsReady({required this.ratings});

  final List<Rating> ratings;

  @override
  List<Object> get props => [ratings];
}

class AddRating extends RatingsEvent {
  const AddRating({required this.rating});

  final Rating rating;

  @override
  List<Object> get props => [rating];
}

class ValidateRating extends RatingsEvent {
  const ValidateRating({required this.rating});

  final Rating rating;

  @override
  List<Object> get props => [rating];
}

class DeleteRating extends RatingsEvent {
  const DeleteRating({required this.rating});

  final Rating rating;

  @override
  List<Object> get props => [rating];
}
