import 'package:flutter/material.dart';
import 'package:wisata_candi/main.dart';

class SignInSreen extends StatelessWidget {
  SignInSreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Nama Pengguna",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: "Kata Sandi",
                    errorText: _errorText.isNotEmpty ? _errorText : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility))),
                obscureText: _obscurePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                  );
                },
                child: const Text("Sign In"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text("Belum punya akun? Daftar di sini")),
            ],
          ),
        ),
      ),
    );
  }
}
