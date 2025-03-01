import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/provider/Profile_provider.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';
import 'package:r_creative/view/widgets/PhoneNumber.dart';
import 'package:r_creative/view/widgets/whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.microtask(() => context.read<ProfileProvider>().fetchProfile());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: "Profile",
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
          
          if (profileProvider.profile == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off_outlined, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'No profile data available',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => profileProvider.fetchProfile(),
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          final info = profileProvider.profile!.info;
          final List<Map<String, dynamic>> profileData = [
            {
              'label': 'User Name',
              'value': info.userName,
              'icon': Icons.person,
              'color': Colors.indigo,
            },
            {
              'label': 'Company',
              'value': info.companyName,
              'icon': Icons.business,
              'color': Colors.teal,
            },
            {
              'label': 'Address',
              'value': info.address,
              'icon': Icons.location_on,
              'color': Colors.deepOrange,
            },
            {
              'label': 'Email',
              'value': info.email,
              'icon': Icons.email,
              'color': Colors.purple,
            },
            {
              'label': 'Contact',
              'value': info.contact.toString(),
              'icon': Icons.phone,
              'color': Colors.green,
            },
            {
              'label': 'WhatsApp',
              'value': info.whatsapp.toString(),
              'icon': Icons.whatshot, 
              'color': Colors.lightGreen,
            },
          ];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
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
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text(
                          info.userName.isNotEmpty ? info.userName[0].toUpperCase() : "?",
                          style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        info.userName,
                        style: const TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        info.companyName,
                        style: TextStyle(
                          fontSize: 16, 
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                const Text(
                  "Profile Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
         
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileData.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return ProfileDetailCard(
                      label: profileData[index]['label'],
                      value: profileData[index]['value'],
                      icon: profileData[index]['icon'],
                      color: profileData[index]['color'],
                      onTap: () {
                        switch (profileData[index]['label']) {
                          case "Contact":
                            if (info.contact != null && info.contact.toString().isNotEmpty) {
                              dialNumber(info.contact.toString());
                            }
                            break;
                          case "WhatsApp":
                            if (info.whatsapp != null && info.whatsapp.toString().isNotEmpty) {
                              whatsapp();
                            }
                            break;
                          case "Email":
                            if (info.email.isNotEmpty) {
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: info.email,
                              );
                              launchUrl(emailLaunchUri);
                            }
                            break;
                          case "Address":
                            if (info.address.isNotEmpty) {
                              final Uri mapsUrl = Uri.parse(
                                'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(info.address)}'
                              );
                              launchUrl(mapsUrl);
                            }
                            break;
                          default:
                            // Show a snackbar for other items
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${profileData[index]['label']}: ${profileData[index]['value']}"),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: profileData[index]['color'],
                              ),
                            );
                        }
                      },
                    );
                  },
                ),
                
                const SizedBox(height: 24),
           
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileDetailCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ProfileDetailCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.2), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                radius: 24,
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}