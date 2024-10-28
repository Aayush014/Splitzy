class UserModal {
  String url, name, email;

  UserModal({required this.url, required this.name, required this.email});

  factory UserModal.fromData(Map json)
  {
    return UserModal(url: json['photoUrl'], name: json['name'], email: json['email']);
  }
}
