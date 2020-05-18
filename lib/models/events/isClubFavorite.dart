class IsClubFavorite {
  String clubFavorite;

  bool isClubFavorite(String clubId) {
    return clubFavorite.contains(";" + clubId + ";");
  }
}
