class TWUserData {
  TWUserData(
      {this.error = true,
      this.userID = "error",
      this.userName = "error",
      this.authToken = "error",
      this.authTokenSecret = "error"});
  bool error;
  String userID;
  String userName;
  String authToken;
  String authTokenSecret;
}
