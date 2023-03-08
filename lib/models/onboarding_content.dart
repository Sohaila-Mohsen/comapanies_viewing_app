class OnBoardingContent {
  String imagePath;
  String title;
  String description;

  OnBoardingContent(
      {required this.imagePath,
      required this.description,
      required this.title});
}

List<OnBoardingContent> content = [
  OnBoardingContent(
      imagePath: "assets/images/logo.png",
      description: "This is an app which insures\nThat this is you",
      title: "Authentication App"),
  OnBoardingContent(
      imagePath: "assets/images/last.png",
      description: "you can register an accont to\n access the app eaisly",
      title: "Easy Sign Up"),
  OnBoardingContent(
      imagePath: "assets/images/gate.png",
      description: "you can login with basic info\nlike email and password",
      title: "Your Gate"),
];
