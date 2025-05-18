import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

class Message extends StatefulWidget {
  final String message;
  final bool isUser;
  final List<String>? imagePaths;
  final String? audioPath;
  final Duration? audioDuration;

  const Message({
    super.key,
    required this.message,
    required this.isUser,
    this.imagePaths,
    this.audioPath,
    this.audioDuration,
  });

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.audioPath != null) {
      _initAudioPlayer();
    }
  }

  Future<void> _initAudioPlayer() async {
    // Listen to audio duration changes
    _audioPlayer.onDurationChanged.listen((Duration d) {
      if (mounted) {
        setState(() => duration = d);
      }
    });

    // Listen to audio position changes
    _audioPlayer.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() => position = p);
      }
    });

    // Listen to player state changes
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          isPlaying = false;
          position = Duration.zero;
        });
      }
    });

    // Set initial duration if provided
    if (widget.audioDuration != null) {
      duration = widget.audioDuration!;
    }
  }

  Future<void> _playAudio() async {
    if (widget.audioPath == null) return;

    if (isPlaying) {
      await _audioPlayer.pause();
      setState(() => isPlaying = false);
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.audioPath!));
      setState(() => isPlaying = true);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment:
            widget.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: widget.isUser ? Colors.grey[200] : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(widget.isUser ? 20 : 5),
                  bottomRight: Radius.circular(widget.isUser ? 5 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.message.isNotEmpty) ...[
                    Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isUser ? Colors.black87 : Colors.black87,
                      ),
                    ),
                    if ((widget.imagePaths?.isNotEmpty ?? false) ||
                        widget.audioPath != null)
                      const SizedBox(height: 8),
                  ],
                  if (widget.audioPath != null)
                    GestureDetector(
                      onTap: _playAudio,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: widget.isUser ? Colors.blue : Colors.blue,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatDuration(isPlaying ? position : duration),
                              style: TextStyle(
                                color:
                                    widget.isUser
                                        ? Colors.black87
                                        : Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (widget.imagePaths != null &&
                      widget.imagePaths!.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.imagePaths!.length > 1 ? 2 : 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: 1,
                      ),
                      itemCount: widget.imagePaths!.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(widget.imagePaths![index]),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
