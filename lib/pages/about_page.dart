import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmail(String url) async {
    if (await canLaunch("mailto:" + url)) {
      await launch("mailto:" + url);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text("About Page"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text("Developed By"),
              subtitle: Text("Aldy Yuan G.N"),
            ),
            ListTile(
              title: Text("Contact"),
              subtitle: Text("yuanaldy@gmail.com"),
              trailing: FlatButton(
                child: Icon(Icons.email),
                onPressed: () {
                  _launchEmail("yuanaldy@gmail.com");
                },
              ),
            ),
            ListTile(
              title: Text("All Photos Provider By Pexels"),
              subtitle: Text(
                  "Free stock photos and videos from global network of creators"),
              trailing: FlatButton(
                child: Image.asset("assets/pexels.png"),
                onPressed: () {
                  _launchUrl("https://www.pexels.com/");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
