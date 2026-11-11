import 'package:flutter/material.dart';
import '../socialmedia.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errormessage;
  late bool isError;

  @override
  void initState() {
    super.initState();
    errormessage = "This is an errormessage";
    isError = false;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkLogin(String username, String password) {
    setState(() {
      if (username.trim().isEmpty) {
        errormessage = "Please input your username!";
        isError = true;
      } else if (password.trim().isEmpty) {
        errormessage = "Please input your password!";
        isError = true;
      } else {
        errormessage = "";
        isError = false;
      }
    });
  }

  var txtstyle = const TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 38,
  );

  var registertxtstyle = const TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 14,
  );

  var errorxtstyle = const TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    fontSize: 14,
    color: Colors.red,
  );

  var txtstyle2 = const TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 24,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 48,
                        width: 48,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.flutter_dash, size: 48, color: Colors.blue),
                      ),
                      const SizedBox(width: 12),
                      Text('TIKITOKTOK', style: txtstyle),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Password',
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
                if (isError) ...[
                  const SizedBox(height: 8),
                  Text(errormessage, style: errorxtstyle),
                ],
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    checkLogin(
                      usernameController.text,
                      passwordController.text,
                    );
                    if (!isError) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Socialmedia(),
                        ),
                      );
                    }
                  },
                  child: Text('LOGIN', style: txtstyle2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
