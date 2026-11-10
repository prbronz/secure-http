class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // Mengubah isi body menjadi teks acak/sembarangan
    final List<String> dummyBodies = [
      'asdkjhf kjashd kfjhaskdjfh kajshdf kjahsdf',
      'qwerty zxcvb poiuy lkjhg mnbvc',
      'bla bla bla test test 123 random text',
      'xyz abc 999 status pending clear cache',
    ];

    // Ambil teks acak berdasarkan ID post
    int id = json['id'] ?? 0;
    String randomBody = dummyBodies[id % dummyBodies.length];

    return Post(
      userId: json['userId'] ?? 0,
      id: id,
      title: json['title'] ?? 'Tanpa Judul',
      body: randomBody,
    );
  }
}