// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/ratings_bloc.dart';
import '../theme.dart';
import 'spinner.dart';

class Ratings extends StatelessWidget {
  const Ratings({
    super.key,
    required this.buttons,
    required this.fetch,
  });

  final bool buttons;
  final RatingsEvent fetch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16.0)),
      width: double.infinity,
      height: 474.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Témoignages",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(decoration: TextDecoration.underline),
              textAlign: TextAlign.center,
            ),
          ),
          BlocBuilder<RatingsBloc, RatingsState>(
            builder: (ctx, state) {
              if (state is RatingsLoading) {
                return const Center(child: Spinner());
              } else if (state is RatingsFetchReady) {
                return SizedBox(
                  height: 424.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.ratings.length,
                    itemBuilder: (context, index) {
                      final rating = state.ratings[index];
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 296.0,
                                    height: 36.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          rating.title!,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        RatingBar.builder(
                                          itemSize: 16,
                                          initialRating: rating.rate!.toDouble(),
                                          minRating: 0.5,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: AppColors.tertiary,
                                          ),
                                          onRatingUpdate: (rating) {
                                            debugPrint("$rating");
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 296.0,
                                    height: 215.0,
                                    child: Text(
                                      rating.comment!,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                buttons
                                    ? SizedBox(
                                        width: 296.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.tertiary,
                                                foregroundColor: AppColors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                              ),
                                              onPressed: () async {
                                                try {
                                                  BlocProvider.of<RatingsBloc>(context).add(DeleteRating(rating: rating));
                                                  BlocProvider.of<RatingsBloc>(context).add(fetch);
                                                } catch (e) {
                                                  debugPrint("Ereur lors de la deletion d'un avis: $e");
                                                }
                                              },
                                              child: const Text("Supprimer"),
                                            ),
                                            width4,
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.primary,
                                                foregroundColor: AppColors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                              ),
                                              onPressed: () async {
                                                try {
                                                  BlocProvider.of<RatingsBloc>(context).add(ValidateRating(rating: rating));
                                                  BlocProvider.of<RatingsBloc>(context).add(fetch);
                                                } catch (e) {
                                                  debugPrint("Ereur lors de la validation d'un avis: $e");
                                                }
                                              },
                                              child: const Text("Valider"),
                                            )
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 296.0,
                                  height: 36.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        rating.title!,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 16,
                                        initialRating: rating.rate!.toDouble(),
                                        minRating: 0.5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: AppColors.tertiary,
                                        ),
                                        onRatingUpdate: (rating) {
                                          debugPrint("$rating");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 296.0,
                                  height: 215.0,
                                  child: Text(
                                    rating.comment!,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              buttons
                                  ? SizedBox(
                                      width: 296.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.tertiary,
                                              foregroundColor: AppColors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                            ),
                                            onPressed: () async {
                                              try {
                                                BlocProvider.of<RatingsBloc>(context).add(DeleteRating(rating: rating));
                                                BlocProvider.of<RatingsBloc>(context).add(fetch);
                                              } catch (e) {
                                                debugPrint("Ereur lors de la deletion d'un avis: $e");
                                              }
                                            },
                                            child: const Text("Supprimer"),
                                          ),
                                          width4,
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.primary,
                                              foregroundColor: AppColors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                            ),
                                            onPressed: () async {
                                              try {
                                                BlocProvider.of<RatingsBloc>(context).add(ValidateRating(rating: rating));
                                                BlocProvider.of<RatingsBloc>(context).add(fetch);
                                              } catch (e) {
                                                debugPrint("Ereur lors de la validation d'un avis: $e");
                                              }
                                            },
                                            child: const Text("Valider"),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
