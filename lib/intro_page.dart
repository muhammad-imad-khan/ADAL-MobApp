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
            
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(52),
              child: CachedNetworkImage(
                imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYmlbOfYd1XbyOBwmxbcsxuE48g8LcdQ9ZVg&s',
                placeholder: (context, url) =>
                    CircularProgressIndicator(), // Placeholder widget while loading
                errorWidget: (context, url, error) =>
                    Icon(Icons.error), // Widget to display when there's an error
                width: 250,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 76, 137, 175),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // Arrow icon color white
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), // Space below the button
          ],
        ),
      ),
    );
  }
}
