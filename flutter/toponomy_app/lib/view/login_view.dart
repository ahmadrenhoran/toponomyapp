import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toponomy_app/controller/auth_controller.dart';
import 'package:toponomy_app/model/user.dart';
import 'package:toponomy_app/view/home_view.dart';
import 'package:toponomy_app/view/register_view.dart'; // Pastikan menggantinya sesuai dengan lokasi file RegisterView.dart

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                BuildContext currentContext = context;
                User user = User(
                  id: 0,
                  username: "",
                  email: emailController.text,
                  password: passwordController.text,
                );

                bool loginResult = await authController.loginUser(user);

                if (loginResult) {
                  // Navigasi ke halaman setelah login berhasil
                  Navigator.pushReplacement(
                    currentContext,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                } else {
                  // Tampilkan pesan error jika login gagal
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Login failed. Please try again.'),
                  ));
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman pendaftaran (RegisterView)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterView()),
                );
              },
              child: Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
