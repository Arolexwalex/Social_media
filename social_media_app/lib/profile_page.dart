import 'package:flutter/material.dart';
import 'package:social_media_app/posts_list.dart';
import 'package:social_media_app/profile_manager.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileManager _profileManager = ProfileManager();
  Map? _profileData;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final userId = 'current_user_id'; // Replace with the current user's ID
    final snapshot = await _profileManager.getUserProfile(userId);
    setState(() {
      _profileData = snapshot?.value as Map?;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _profileData != null
          ? Column(
              children: [
                Text(_profileData!['name'] ?? ''),
                Text(_profileData!['email'] ?? ''),
                Expanded(child: PostsList(),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
