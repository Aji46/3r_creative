import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:r_creative/view/widgets/whatsapp.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLeadingPressed;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onLeadingPressed,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
         icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
         onPressed: () {
    whatsapp(); 
  },
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
