import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';

import '../../Controller/provider/Login_provider.dart';
import '../../Controller/provider/Profile_provider.dart';


class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.read<ProfileProvider>().fetchProfile());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(title: "More", actions: [
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {})
      ], onLeadingPressed: () {  },),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) => profileProvider.isLoading
            ? const Center(child: CircularProgressIndicator(color: MyColors.mycolor3))
            : MoreScreenContent(profileProvider: profileProvider),
      ),
    );
  }
}

class MoreScreenContent extends StatelessWidget {
  final ProfileProvider profileProvider;
  const MoreScreenContent({Key? key, required this.profileProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ProfileCard(profileProvider: profileProvider),
          const SizedBox(height: 24),
          ..._menuSections(context)
        ],
      ),
    );
  }

  List<Widget> _menuSections(BuildContext context) => [
        _buildMenu("Orders & Wishlist", [
          _menuItem(Icons.shopping_bag_outlined, "My Orders", () {}),
          _menuItem(Icons.favorite_border, "My Wishlist", () {}),
        ]),
        _buildMenu("Account Settings", [
          _menuItem(Icons.person_outline, "Profile Settings", () {}),
          _menuItem(Icons.lock_outline, "Change Password", () {}),
        ]),
        _buildMenu("Other", [
          _menuItem(Icons.help_outline, "Help & Support", () {}),
          _menuItem(Icons.logout, "Logout", () => _showLogoutDialog(context), color: Colors.red),
        ]),
      ];
}

Widget _buildMenu(String title, List<Widget> items) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(children: items),
        ),
      ],
    );

Widget _menuItem(IconData icon, String title, VoidCallback onTap, {Color? color}) => ListTile(
      leading: Icon(icon, color: color ?? Colors.grey[700]),
      title: Text(title, style: TextStyle(color: color ?? Colors.black87, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.chevron_right, color: color ?? Colors.grey[400]),
      onTap: onTap,
    );

class ProfileCard extends StatelessWidget {
  final ProfileProvider profileProvider;
  const ProfileCard({Key? key, required this.profileProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [MyColors.mycolor3, Colors.black]),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        CircleAvatar(radius: 40, backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(Icons.person, size: 40, color: Colors.white)),
        const SizedBox(height: 12),
        Text(profileProvider.profile?.info.userName ?? "User",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(profileProvider.profile?.info.email ?? "",
            style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9))),
      ]),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<LoginProvider>(context, listen: false).logout(context);
          },
          child: const Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
