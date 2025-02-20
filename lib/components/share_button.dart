import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareButtons extends StatelessWidget {

  const ShareButtons({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildShareButton(
          icon: FontAwesomeIcons.whatsapp,
          label: "Share via WhatsApp",
          color: Colors.green,
          backgroundColor: Colors.green.shade100,
          onPressed: ()=>Fluttertoast.showToast(msg: "Shared in whatsapp"),
        ),
        const SizedBox(width: 12),
        _buildShareButton(
          icon: FontAwesomeIcons.linkedin,
          label: "Share on LinkedIn",
          color: Colors.blue,
          backgroundColor: Colors.blue.shade100,
          onPressed: ()=>Fluttertoast.showToast(msg: "Shared in LinkedIn"),
        ),
      ],
    );
  }

  Widget _buildShareButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: FaIcon(icon, color: color, size: 18),
      label: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 0,
      ),
    );
  }
}
