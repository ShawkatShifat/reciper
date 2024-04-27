import 'package:flutter/material.dart';
import 'package:reciper/screens/home.dart';
import 'package:reciper/screens/login.dart';
import 'package:reciper/screens/pages_layout.dart';
import 'package:reciper/screens/signup.dart';
import 'package:reciper/utilities/utils.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Import",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Utils.userImport().then((value) => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                        const PagesLayout(child: HomePage()))));
              },
              child: const Text("Import recipes"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Export",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Utils.userExport();
              },
              child: const Text("Export recipes"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Utils.userPdfExport();
              },
              child: const Text("Export recipes to PDF"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Login",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Signup",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: const Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }
}