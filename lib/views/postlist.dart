import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import 'profileview.dart';

class Postlist extends StatefulWidget {
  const Postlist({super.key, required this.userdata});
  final Userdata userdata;

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  final TextStyle nametxtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget buttons(Userpost userPost) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: userPost.isLiked ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  userPost.isLiked = !userPost.isLiked;
                });
              },
              icon: Icon(
                userPost.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                size: 20,
              ),
              label: const Text('Like'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileView(
                      userPost: userPost,
                      userData: widget.userdata,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.chat_bubble, size: 20),
              label: const Text('Comment'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(Icons.share, size: 20),
              label: const Text('Share'),
            ),
          ],
        ),
      ),
      const Divider(color: Colors.grey),
    ],
  );

  Widget userline(Userpost userPost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage(userPost.userimg),
          radius: 20,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userPost.username, style: nametxtStyle),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(userPost.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const Text(' • ', style: TextStyle(color: Colors.grey)),
              const Icon(Icons.group, size: 15, color: Colors.grey),
            ],
          ),
        ],
      ),
    ],
  );

  Widget postimage(Userpost userPost) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [Text(userPost.postcontent)]),
        const SizedBox(height: 15),
        Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(userPost.posting),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );

  Widget showPost(Userpost userPost) => Column(
    children: [
      userline(userPost),
      postimage(userPost),
      buttons(userPost),
      SizedBox(height: 10, child: Container(color: Colors.grey)),
      const SizedBox(height: 15),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // FIX FOR LISTVIEW BUG:
    // Removed nested SingleChildScrollView and inner scrolling ListView conflict.
    // Use shrinkWrap: true with NeverScrollableScrollPhysics so it delegates scrolling
    // entirely to the parent ListView on Socialmedia screen.
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.userdata.userList.length,
      itemBuilder: (context, index) {
        final post = widget.userdata.userList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileView(
                  userPost: post,
                  userData: widget.userdata,
                ),
              ),
            ).then((_) {
              setState(() {});
            });
          },
          child: showPost(post),
        );
      },
    );
  }
}
