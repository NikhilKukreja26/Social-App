class ProfileModel {
  String name;
  String imagePath;
  String country;
  String city;
  int followers;
  int posts;
  int following;

  ProfileModel({
    this.name,
    this.imagePath,
    this.country,
    this.city,
    this.followers,
    this.posts,
    this.following,
  });
}

final List<ProfileModel> profiles = [
  ProfileModel(
    name: 'Lorei Perez',
    imagePath: 'assets/images/profile1.jpg',
    country: 'U.S.',
    city: 'Springfield Missouri',
    followers: 1000,
    posts: 50,
    following: 450,
  ),
  ProfileModel(
    name: 'Lauren Turner',
    imagePath: 'assets/images/nikhil.png',
    country: 'France',
    city: 'Paris',
    followers: 1500,
    posts: 500,
    following: 590,
  ),
  ProfileModel(
    name: 'Barry Allen',
    imagePath: 'assets/images/profile3.jpg',
    country: 'USA',
    city: 'Newyork',
    followers: 800,
    posts: 420,
    following: 1000,
  ),
];
