import 'package:flutter/material.dart';
import '../model/friend.dart';
import '../model/userdata.dart';

class Friendlist extends StatelessWidget {
  const Friendlist({super.key, required this.userdata});
  final Userdata userdata;

  final TextStyle followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget friendWidget(Friend friend) => Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Expanded(
          child: Image.asset(
            friend.img,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(friend.name),
        ),
      ],
    ),
  );

  Widget friendsListGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 180,
    ),
    itemCount: userdata.friendList.length,
    itemBuilder: (BuildContext ctx, index) {
      return friendWidget(userdata.friendList[index]);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(children: [Text('Friends', style: followTxtStyle)]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(children: [Text('${userdata.friendList.length} Friends')]),
        ),
        const SizedBox(height: 10),
        SizedBox(height: 380, child: friendsListGrid()),
        SizedBox(height: 10, child: Container(color: Colors.grey)),
      ],
    );
  }
}
