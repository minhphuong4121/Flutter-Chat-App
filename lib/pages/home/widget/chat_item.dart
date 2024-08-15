import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.imageUrl,
    this.name,
    this.lastChat,
    this.lastTime,
  });

  final String imageUrl;
  final String? name;
  final String? lastChat;
  final String? lastTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 70,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.45,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      name ?? "Name",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.45,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      lastChat ?? "last chat",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            lastTime ?? "08:00 PM",
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
