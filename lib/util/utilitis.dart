bool checkEmail(String email) {
  return RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$')
      .hasMatch(email);
}

bool chekPassword(String mp) {
  return (mp.length >= 6);
}
