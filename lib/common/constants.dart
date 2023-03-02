/// App level constants
class Constants {
  Constants._();

  /// Mongo DB Connection URL
  static const String mongoUrl =
      "mongodb+srv://yogendra_dev:techcloudTest@samplecatalog.vx1t21h.mongodb.net/techcloud_demo?retryWrites=true&w=majority";

  /// Users collection name from database
  static const String usersCollection = "users";

  /// Key to store user session in cache
  static const String loggedInUser = "logged_in_user";
}
