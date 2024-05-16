import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to ADAL',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CachedNetworkImage(
              imageUrl:
                  'https://png.pngtree.com/png-vector/20190303/ourmid/pngtree-attorney-law-scale-icon-design-template-vector-png-image_770961.jpg',
              placeholder: (context, url) =>
                  CircularProgressIndicator(), // Placeholder widget while loading
              errorWidget: (context, url, error) =>
                  Icon(Icons.error), // Widget to display when there's an error
              width: 250,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                shape:
                    MaterialStateProperty.all(CircleBorder()), // Circle shape
                elevation: MaterialStateProperty.all(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Colors.blue, // Circle background color white
                    radius: 18, // Adjust the radius as needed
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white, // Arrow icon color blue
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), // Space below the button
            Text(
              'Tap to Continue',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
