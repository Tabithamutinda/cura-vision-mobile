import 'package:cura_vision/helpers/constants.dart';
import 'package:flutter/material.dart';

class SuggestionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SuggestionTile({
    required this.icon,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: const Color(Constants.appPrimaryColor)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Handle tap actions
        },
      ),
    );
  }
}
