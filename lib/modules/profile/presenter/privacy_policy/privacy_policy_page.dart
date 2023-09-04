import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Política de Privacidade'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at JournalVerse unless otherwise defined in this Privacy Policy.',
          ),
          SizedBox(height: 20.0),
          // Information Collection and Use
          Text(
            'Information Collection and Use',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Name, Addresses, Phone numbers, Asset information. The information that I request will be retained on your device and is not collected by me in any way.',
          ),
          Text(
            'The app does use third-party services that may collect information used to identify you.',
          ),
          Text(
            'Link to the privacy policy of third-party service providers used by the app',
          ),
          BulletPoint(text: Text('Google Play Services')),
          BulletPoint(text: Text('Google Analytics for Firebase')),
          BulletPoint(text: Text('Firebase Crashlytics')),
          SizedBox(height: 20.0),
          // Log Data
          Text(
            'Log Data',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.',
          ),
          SizedBox(height: 20.0),
          // Cookies
          Text(
            'Cookies',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device’s internal memory. This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
          ),
          SizedBox(height: 20.0),
          // Service Providers
          Text(
            'Service Providers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'I may employ third-party companies and individuals due to the following reasons:',
          ),
          BulletPoint(text: Text('To facilitate our Service;')),
          BulletPoint(text: Text('To provide the Service on our behalf;')),
          BulletPoint(text: Text('To perform Service-related services; or')),
          BulletPoint(
            text: Text('To assist us in analyzing how our Service is used.'),
          ),
          Text(
            'I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.',
          ),
          SizedBox(height: 20.0),
          // Security
          Text(
            'Security',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.',
          ),
          SizedBox(height: 20.0),
          // Links to Other Sites
          Text(
            'Links to Other Sites',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
          ),
          SizedBox(height: 20.0),
          // Children’s Privacy
          Text(
            'Children’s Privacy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
          ),
          SizedBox(height: 20.0),
          // Changes to This Privacy Policy
          Text(
            'Changes to This Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.',
          ),
          Text(
            'This policy is effective as of 2023-08-28',
          ),
          SizedBox(height: 20.0),
          // Contact Us
          Text(
            'Contact Us',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at georgealvessilveira@gmail.com.',
          ),
          Text(
            'This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator',
          ),
        ],
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final Widget text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("\u2022", style: TextStyle(fontSize: 30)),
        const SizedBox(width: 10),
        Expanded(child: text),
      ],
    );
  }
}
