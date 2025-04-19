// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/home_screen/bloc/Favourite/favourite_event.dart';
// import 'package:graduation_project/home_screen/bloc/Favourite/favourite_state.dart';
// import 'package:graduation_project/home_screen/data/repo/favourite_repo.dart';

// class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
//   final FavouriteRepository repository;

//   FavouriteBloc({required this.repository}) : super(FavouriteInitial()) {
//     on<AddToFavouriteEvent>((event, emit) async {
//       emit(FavouriteLoading());
//       try {
//         final response = await repository.addToFavourite(
//           event.itemId,
//           event.userId,
//         );
//         emit(FavouriteSuccess(response: response));
//       } catch (e) {
//         emit(FavouriteFailure(error: e.toString()));
//       }
//     });

//     on<RemoveFromFavouriteEvent>((event, emit) async {
//       emit(FavouriteLoading());
//       try {
//         final response = await repository.removeFromFavourite(
//           event.itemId,
//           event.userId,
//         );
//         emit(FavouriteRemoved(response: response));
//       } catch (e) {
//         emit(FavouriteFailure(error: e.toString()));
//       }
//     });

//     on<FetchFavouriteEvent>((event, emit) async {
//       emit(FavouriteLoading());
//       try {
//         final response = await repository.fetchFavourites(event.userId);
//         emit(FavouriteListLoaded(response: response));
//       } catch (e) {
//         emit(FavouriteFailure(error: e.toString()));
//       }
//     });

//     on<DeleteFromFavouriteEvent>((event, emit) async {
//       emit(FavouriteLoading());
//       try {
//         final response = await repository.deleteFromFavourite(event.favouriteId);
//         emit(FavouriteRemoved(response: response));
//       } catch (e) {
//         emit(FavouriteFailure(error: e.toString()));
//       }
//     });
//   }
// }
