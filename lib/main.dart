import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'google_sign_in.dart';
import 'video_list_screen.dart';

void main() {
  runApp(TravelVideoLinkUpdaterApp());
}

class TravelVideoLinkUpdaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Travel Video Link Updater',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Video Link Updater'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: Text('Login with Google'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoListScreen()),
                );
              },
              child: Text('Manage YouTube Links'),
            ),
          ],
        ),
      ),
    );
  }
}

class Provider {
  static of(BuildContext context, {required bool listen}) {}
}
