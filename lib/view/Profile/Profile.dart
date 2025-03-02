import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/provider/Profile_provider.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.read<ProfileProvider>().fetchProfile());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(title: "Profile", actions: [
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      ], onLeadingPressed: () {  },),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) => provider.isLoading
            ? const Center(child: CircularProgressIndicator(color: MyColors.mycolor3))
            : provider.profile == null
                ? _EmptyProfileView(onRefresh: provider.fetchProfile)
                : _ProfileContent(info: provider.profile!.info),
      ),
    );
  }
}

class _EmptyProfileView extends StatelessWidget {
  final VoidCallback onRefresh;
  const _EmptyProfileView({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('No profile data available',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          TextButton(onPressed: onRefresh, child: const Text('Refresh')),
        ],
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final dynamic info;
  const _ProfileContent({required this.info});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileHeader(userName: info.userName, companyName: info.companyName),
          const SizedBox(height: 24),
          ..._profileItems().map((item) => ProfileDetailCard(item: item)).toList(),
        ],
      ),
    );
  }

  List<ProfileItem> _profileItems() => [
        ProfileItem("User Name", info.userName, Icons.person, Colors.indigo),
        ProfileItem("Company", info.companyName, Icons.business, Colors.teal),
        ProfileItem("Address", info.address, Icons.location_on, Colors.deepOrange, _launchMap),
        ProfileItem("Email", info.email, Icons.email, Colors.purple, _launchEmail),
        ProfileItem("Contact", info.contact.toString(), Icons.phone, Colors.green, _launchPhone),
        ProfileItem("WhatsApp", info.whatsapp.toString(), Icons.whatshot, Colors.lightGreen, _launchWhatsApp),
      ];

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _launchPhone() => _launchUrl('tel:${info.contact}');
  void _launchWhatsApp() => _launchUrl('https://wa.me/${info.whatsapp}');
  void _launchEmail() => _launchUrl('mailto:${info.email}');
  void _launchMap() => _launchUrl('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(info.address)}');
}

class _ProfileHeader extends StatelessWidget {
  final String userName, companyName;
  const _ProfileHeader({required this.userName, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [MyColors.mycolor3, Colors.black]),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(radius: 50, child: Text(userName[0].toUpperCase(), style: const TextStyle(fontSize: 40))),
          const SizedBox(height: 16),
          Text(userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(companyName, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        ],
      ),
    );
  }
}

class ProfileItem {
  final String label, value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  ProfileItem(this.label, this.value, this.icon, this.color, [this.onTap]);
}

class ProfileDetailCard extends StatelessWidget {
  final ProfileItem item;
  const ProfileDetailCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: item.color.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: item.color.withOpacity(0.1), child: Icon(item.icon, color: item.color)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    const SizedBox(height: 4),
                    Text(item.value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
