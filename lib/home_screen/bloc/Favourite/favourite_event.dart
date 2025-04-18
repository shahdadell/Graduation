// class FavouriteEvent {}

// class AddToFavouriteEvent extends FavouriteEvent {
//   final int itemId;
//   final int userId;

//   AddToFavouriteEvent({required this.itemId, required this.userId});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AddToFavouriteEvent &&
//           itemId == other.itemId &&
//           userId == other.userId;

//   @override
//   int get hashCode => itemId.hashCode ^ userId.hashCode;
// }

// class RemoveFromFavouriteEvent extends FavouriteEvent {
//   final int itemId;
//   final int userId;

//   RemoveFromFavouriteEvent({required this.itemId, required this.userId});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is RemoveFromFavouriteEvent &&
//           itemId == other.itemId &&
//           userId == other.userId;

//   @override
//   int get hashCode => itemId.hashCode ^ userId.hashCode;
// }

// class FetchFavouriteEvent extends FavouriteEvent {
//   final int userId;

//   FetchFavouriteEvent({required this.userId});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is FetchFavouriteEvent && userId == other.userId;

//   @override
//   int get hashCode => userId.hashCode;
// }

// class DeleteFromFavouriteEvent extends FavouriteEvent {
//   final int favouriteId;

//   DeleteFromFavouriteEvent({required this.favouriteId});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is DeleteFromFavouriteEvent && favouriteId == other.favouriteId;

//   @override
//   int get hashCode => favouriteId.hashCode;
// }
