import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toponomy_app/controller/auth_controller.dart';
import 'package:toponomy_app/model/user.dart';
import 'package:toponomy_app/view/login_view.dart'; // Sesuaikan dengan lokasi file dan nama kelas LoginView.dart

class RegisterView extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                User user = User(
                  id: 0,
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );

                bool registerResult = await authController.registerUser(user);

                if (registerResult) {
                  // Navigasi ke halaman login setelah registrasi berhasil
                  Navigator.popUntil(
                      context,
                      (route) => route
                          .isFirst); // Hapus semua halaman di atas halaman login
                } else {
                  // Tampilkan pesan error jika registrasi gagal
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Registration failed. Please try again.'),
                  ));
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
