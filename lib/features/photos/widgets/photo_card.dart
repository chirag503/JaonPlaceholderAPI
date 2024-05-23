
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/common_option_widget.dart';
import 'package:myapp/features/photos/models/photo_listing_model.dart';

class PhotoCard extends StatelessWidget {
  final PhotoListModel item;
  final void Function() onTap;
  const PhotoCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black26,
        trailing: CommonOptionWidget(
          onDelete: onTap,
          wantEditButton: false,
        ),
        title: Text(
          item.title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      child: (item.url ?? "").contains("http")
          ? CachedNetworkImage(
              imageUrl: item.url ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  height: 25,
                  width: 25,
                  child: const Icon(
                    Icons.image,
                    size: 20,
                  ),
                );
              },
            )
          : Image.file(
              File(item.url ?? ""),
              fit: BoxFit.cover,
            ),
    );
  }
}