import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            _buildSectionContainer(
              context,
              child: SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildImage(context, 'assets/images/Designer.jpeg'),
                    _buildImage(context, 'assets/images/Designer (1).jpeg'),
                    _buildImage(context, 'assets/images/Designer (2).jpeg'),
                    _buildImage(context, 'assets/images/Designer (3).jpeg'),
                  ],
                ),
              ),
            ),
            _buildSectionContainer(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to VehiCrypto",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "VehiCrypto is a blockchain-powered application designed to revolutionize vehicle maintenance management by ensuring transparency, efficiency, and security.",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            _buildSectionContainer(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why VehiCrpto?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureItem(
                    context,
                    "Blockchain Transparency: All vehicle maintenance records are stored securely and immutably on the blockchain.",
                  ),
                  _buildFeatureItem(
                    context,
                    "Easy Maintenance Tracking: Track and manage your vehicle's maintenance history effortlessly.",
                  ),
                  _buildFeatureItem(
                    context,
                    "Enhanced Security: Protect your data with advanced blockchain encryption.",
                  ),
                ],
              ),
            ),
            _buildSectionContainer(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Developers",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Arda YILDIZ, Doğuna POYRAZ, Çağdaş GÜLEÇ,       Salih Barkın AKKAYA ,Ahmet Kerem ÖZTÜRK",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width * 0.7,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[700]!, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSectionContainer(BuildContext context, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
