import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meealthy/features/mealthy_chat_feature/presentation/widgets/message.dart';
import 'controller/chat_controller.dart';
import 'dart:io';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Display selected images
                Obx(
                  () =>
                      controller.selectedImages.isNotEmpty
                          ? Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.25,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Selected Images (${controller.selectedImages.length})',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: controller.clearImages,
                                      child: const Text(
                                        'Clear all',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1,
                                        ),
                                    itemCount: controller.selectedImages.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.file(
                                              File(
                                                controller
                                                    .selectedImages[index]
                                                    .path,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 4,
                                            right: 4,
                                            child: GestureDetector(
                                              onTap:
                                                  () => controller.removeImage(
                                                    index,
                                                  ),
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
                // Messages list
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      reverse: true,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message =
                            controller.messages[controller.messages.length -
                                1 -
                                index];
                        return Message(
                          message: message.text,
                          isUser: message.isUser,
                          imagePaths: message.imagePaths,
                          audioPath: message.audioPath,
                        );
                      },
                    ),
                  ),
                ),
                // Recording indicator
                Obx(
                  () =>
                      controller.isRecording.value
                          ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.mic,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Recording: ${_formatDuration(controller.recordingDuration.value)}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
                // Input area
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: controller.pickImages,
                        icon: Image.asset(
                          'assets/pngs/clip.png',
                          color: Colors.grey,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                          child: TextField(
                            controller: controller.textController,
                            maxLines: null,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.send,
                            onEditingComplete: () => controller.sendMessage(),
                            onSubmitted: (_) => controller.sendMessage(),
                            onTapOutside:
                                (_) => FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              hintText: 'Ask me a question',
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 170, 170, 170),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => GestureDetector(
                          onLongPressStart: (_) => controller.startRecording(),
                          onLongPressEnd: (_) => controller.stopRecording(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  controller.isRecording.value
                                      ? Colors.red.withOpacity(0.1)
                                      : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.mic,
                              color:
                                  controller.isRecording.value
                                      ? Colors.red
                                      : Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
