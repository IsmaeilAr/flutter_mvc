class ApiConstants {
  static const String serverUrl = "http://91.144.20.117:7771/";

  // static const String serverUrl = "http://192.168.2.138:808/"; // Uncomment this line for local testing
  static const String baseUrl = "${serverUrl}api/";
  static const String imageUrl = "${serverUrl}uploads/images/";
  static const String loginUrl = "${baseUrl}login";
  static const String monthlyUrl = "${baseUrl}monthly";
  static const String activePlayersUrl = "${baseUrl}myActivePlayer";
  static const String checkInUrl = "${baseUrl}storeUserTime";
  static const String showMyPlayersUrl = "${baseUrl}myPlayer";
  static const String showAllPlayersUrl = "${baseUrl}showPlayer";
  static const String monthlySubscriptionsUrl = "${baseUrl}monSubsAvg";
  static const String editCoachInfoUrl = "${baseUrl}updateUserInfo";
  static const String sendReportUrl = "${baseUrl}report";
  static const String myArticlesUrl = "${baseUrl}myArticle";
  static const String allArticleUrl = "${baseUrl}allArticle";
  static const String addArticleUrl = "${baseUrl}addArticle";
  static const String logoutUrl = "${baseUrl}logout";
  static const String getChatsUrl = "${baseUrl}listChat";
  static const String sendMessageUrl = "${baseUrl}sendMessage";
  static const String getNotificationsUrl = "${baseUrl}listNotification";
  static const String checkOutUrl = "${baseUrl}endCounter";
  static const String addProgramUrl = "${baseUrl}store";
  static const String programSearchUrl = "${baseUrl}programSearch";
  static const String addImagesUrl = "${baseUrl}storeUserImage";
  static const String getRequestProgrameUrl = "${baseUrl}getMyOrder";

  static String allCategoriesUrl(String type) {
    return "${baseUrl}getCategories?type=$type";
  }

  static String myProgramsUrl(String type, int categoryID, String programType) {
    String url =
        "${baseUrl}myprogram?type=$type&categoryId=$categoryID&programType=$programType";
    return url;
  }

  static String getPersonMetricsUrl(int id) {
    return "${baseUrl}showInfo/$id";
  }

  static String assignProgramUrl(int id) {
    return "${baseUrl}asignprogram/$id";
  }

  static String editProgramUrl(int id) {
    return "${baseUrl}updateprogram/$id";
  }

  static String deleteProgramUrl(int id) {
    return "${baseUrl}deleteProgram/$id";
  }

  static String getProgramInfoUrl(int id) {
    return "${baseUrl}programDetails/$id";
  }

  static String getPersonInfoUrl(int id) {
    return "${baseUrl}playerInfo/$id";
  }

  // static String programSearchUrl(int categoryId,String programType){
  //   return "${baseUrl}programSearch?categoryId=$categoryId&programType=$programType";
  // }

  static String getPlayerImagesUrl(int id) {
    return "${baseUrl}getimage/$id";
  }

  static String getCoachInfoUrl(int id) {
    return "${baseUrl}showCoachInfo/$id";
  }

  static String deleteMyArticleUrl(int id) {
    return "${baseUrl}deleteArticle/$id";
  }

  static String deleteMessageUrl(
    int messageID,
  ) {
    return "${baseUrl}deleteMessage/$messageID";
  }

  static String chatMessagesUrl(
    int userId,
  ) {
    return "${baseUrl}showChat/$userId";
  }

  static String showCoachTimeUrl(
    int coachId,
  ) {
    return "${baseUrl}showCoachTime/$coachId";
  }

  static String acceptOrderUrl(int id) {
    return "${baseUrl}acceptOrder/$id";
  }

  static String rejectOrderUrl(int id) {
    return "${baseUrl}cancle/$id";
  }

  static String removePlayerUrl(int id) {
    return "${baseUrl}deletePlayer/$id";
  }

  static String deleteAllImagesUrl(int id, String type) {
    return "${baseUrl}deleteAll/$id?type=$type";
  }

  static String deleteImageUrl(int imageId) {
    return "${baseUrl}deleteUserImage/$imageId";
  }

  static String editArticleUrl(int id) {
    return "${baseUrl}updateArticle/$id";
  }
}
