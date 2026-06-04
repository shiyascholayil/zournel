import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zournel/const.dart';
import 'package:zournel/models/journel_entry.dart';

class JournelCard extends StatelessWidget {
  final JournelEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const JournelCard({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(entry.title, style: cardTitleTextStyle),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: 10),
            Text(
              entry.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: cardDescTextStyle,
            ),
            SizedBox(height: 20),
            Text(
              DateFormat('MMM dd, yyyy - hh:mm a').format(entry.date),
              style: cardDateTextStyle,
            ),
          ],
        ),
        onTap: onTap,
        trailing: IconButton(
          onPressed: () {
            onDelete();
          },
          icon: Icon(Icons.delete, color: redColor),
        ),
      ),
    );
  }
}
