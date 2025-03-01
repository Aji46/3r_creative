import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/provider/Profile_provider.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/view/auth/login_screen.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:r_creative/Controller/provider/auth_provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.read<ProfileProvider>().fetchProfile());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: "More",
        onLeadingPressed: () {},
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          if (profileProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.mycolor3,
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [MyColors.mycolor3, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        profileProvider.profile?.info.userName ?? "User",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        profileProvider.profile?.info.email ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Menu Items
                _buildMenuSection(
                  title: "Orders & Wishlist",
                  items: [
                    MenuItemData(
                      icon: Icons.shopping_bag_outlined,
                      title: "My Orders",
                      onTap: () {
                        // Navigate to orders page
                        // Use fetch-order API
                      },
                    ),
                    MenuItemData(
                      icon: Icons.favorite_border,
                      title: "My Wishlist",
                      onTap: () {
                        // Navigate to wishlist page
                        // Use get-wishlist API
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildMenuSection(
                  title: "Account Settings",
                  items: [
                    MenuItemData(
                      icon: Icons.person_outline,
                      title: "Profile Settings",
                      onTap: () {
                        // Navigate to profile settings
                        // Use get-profile API
                      },
                    ),
                    MenuItemData(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                      onTap: () {
                        // Navigate to change password
                        // Use forgot-password API
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildMenuSection(
                  title: "Information",
                  items: [
                    MenuItemData(
                      icon: Icons.newspaper_outlined,
                      title: "News",
                      onTap: () {
                        // Navigate to news page
                        // Use get-news API
                      },
                    ),
                    MenuItemData(
                      icon: Icons.monetization_on_outlined,
                      title: "Commodities",
                      onTap: () {
                        // Navigate to commodities page
                        // Use get-commodities API
                      },
                    ),
                    MenuItemData(
                      icon: Icons.account_balance_outlined,
                      title: "Banks",
                      onTap: () {
                        // Navigate to banks page
                        // Use get-banks API
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildMenuSection(
                  title: "Other",
                  items: [
                    MenuItemData(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onTap: () {
                        // Navigate to help page
                      },
                    ),
                    MenuItemData(
                      icon: Icons.logout,
                      title: "Logout",
                      onTap: () async {
                        // Show confirmation dialog
                        final shouldLogout = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (shouldLogout == true) {
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          await authProvider.logout();

                          if (context.mounted) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false,
                            );
                          }
                        }
                      },
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<MenuItemData> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items.map((item) => _buildMenuItem(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(MenuItemData item) {
    return ListTile(
      leading: Icon(
        item.icon,
        color: item.color ?? Colors.grey[700],
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: item.color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: item.color ?? Colors.grey[400],
      ),
      onTap: item.onTap,
    );
  }
}

class MenuItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  MenuItemData({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });
}