import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/post.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // getUsers dengan Latihan 5 (Timeout yang dapat dikonfigurasi)
  Future<List<User>> getUsers({Duration timeoutDuration = const Duration(seconds: 10)}) async {
    try {
      print('Request GET: $_baseUrl/users');
      final response = await http
          .get(Uri.parse('$_baseUrl/users'))
          .timeout(timeoutDuration);

      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw HttpException('Gagal memuat data. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout setelah ${timeoutDuration.inSeconds} detik. Periksa koneksi Anda.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on FormatException {
      throw Exception('Format data tidak valid.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Latihan 3: Mengambil data posts
  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/posts')).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Post.fromJson(item)).toList();
      } else {
        throw HttpException('Gagal memuat posts. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Latihan 1: Simulasi Login
  Future<String> login(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (email.isNotEmpty && password.isNotEmpty) {
        final token = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
        print('Login berhasil untuk email: $email');
        return token;
      } else {
        throw Exception('Email dan password tidak boleh kosong');
      }
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() => message;
}
