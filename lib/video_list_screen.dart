import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'google_sign_in.dart';
import 'youtube_service.dart';
import 'edit_link_screen.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<Map<String, String>> _videos = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final service = YouTubeService();
    final videos =
        await service.fetchVideos(provider.user.authHeaders['Authorization']!);
    setState(() {
      _videos = videos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your YouTube Videos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadVideos,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          return ListTile(
            title: Text(video['title']!),
            subtitle: Text(video['link']!),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditLinkScreen(
                    title: video['title']!,
                    currentLink: video['link']!,
                    onSave: (newLink) {
                      setState(() {
                        _videos[index]['link'] = newLink;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
