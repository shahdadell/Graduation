// import 'package:graduation_project/home_screen/data/model/Favourite_model_response/add_to_favourite.dart';
// import 'package:graduation_project/home_screen/data/model/Favourite_model_response/favourite_view_response.dart';
// import 'package:graduation_project/home_screen/data/model/Favourite_model_response/remove_from_favourite.dart';

// class FavouriteState {}

// class FavouriteInitial extends FavouriteState {
//   @override
//   bool operator ==(Object other) => identical(this, other) || other is FavouriteInitial;

//   @override
//   int get hashCode => runtimeType.hashCode;
// }

// class FavouriteLoading extends FavouriteState {
//   @override
//   bool operator ==(Object other) => identical(this, other) || other is FavouriteLoading;

//   @override
//   int get hashCode => runtimeType.hashCode;
// }

// class FavouriteSuccess extends FavouriteState {
//   final AddToFavourite response; // للـ add

//   FavouriteSuccess({required this.response});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is FavouriteSuccess && response == other.response;

//   @override
//   int get hashCode => response.hashCode;
// }

// class FavouriteRemoved extends FavouriteState {
//   final RemoveFromFavourite response; // للـ remove وdelete

//   FavouriteRemoved({required this.response});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is FavouriteRemoved && response == other.response;

//   @override
//   int get hashCode => response.hashCode;
// }

// class FavouriteListLoaded extends FavouriteState {
//   final FavouriteViewResponse response; // للـ view

//   FavouriteListLoaded({required this.response});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is FavouriteListLoaded && response == other.response;

//   @override
//   int get hashCode => response.hashCode;
// }

// class FavouriteFailure extends FavouriteState {
//   final String error;

//   FavouriteFailure({required this.error});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) || other is FavouriteFailure && error == other.error;

//   @override
//   int get hashCode => error.hashCode;
// }
