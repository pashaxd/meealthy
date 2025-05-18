import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'dart:io';
import 'dart:async';

class ChatMessage {
  final String text;
  final List<String> imagePaths;
  final String? audioPath;
  final Duration? audioDuration;
  final bool isUser;

  ChatMessage({
    required this.text,
    this.imagePaths = const [],
    this.audioPath,
    this.audioDuration,
    required this.isUser,
  });
}

class ChatController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final _audioRecorder = AudioRecorder();
  final RxList<XFile> selectedImages = <XFile>[].obs;
  final TextEditingController textController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  // Voice recording state
  final RxBool isRecording = false.obs;
  final RxString recordingPath = ''.obs;
  final Rx<Duration> recordingDuration = Duration.zero.obs;
  Timer? _recordingTimer;
  DateTime? _recordingStartTime;

  @override
  void onInit() {
    super.onInit();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // The record package doesn't support these configurations directly
        // Only start() method is available for basic recording
      }
    } catch (e) {
      print('Error initializing recorder: $e');
    }
  }

  void _startRecordingTimer() {
    _recordingStartTime = DateTime.now();
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) {
      if (_recordingStartTime != null) {
        recordingDuration.value = DateTime.now().difference(
          _recordingStartTime!,
        );
      }
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _recordingStartTime = null;
  }

  Future<void> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final path =
            '${Directory.systemTemp.path}/voice_message_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _audioRecorder.start(const RecordConfig(), path: path);
        isRecording.value = true;
        recordingPath.value = path;
        recordingDuration.value = Duration.zero;
        _startRecordingTimer();
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      if (isRecording.value) {
        await _audioRecorder.stop();
        isRecording.value = false;
        final finalDuration = recordingDuration.value;
        _stopRecordingTimer();

        // Send voice message
        if (recordingPath.value.isNotEmpty) {
          final message = ChatMessage(
            text: '',
            audioPath: recordingPath.value,
            audioDuration: finalDuration,
            isUser: true,
          );
          messages.add(message);
          recordingPath.value = '';
          recordingDuration.value = Duration.zero;
        }
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images);
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  void clearImages() {
    selectedImages.clear();
  }

  void sendMessage() {
    if (textController.text.isNotEmpty || selectedImages.isNotEmpty) {
      final message = ChatMessage(
        text: textController.text,
        imagePaths: selectedImages.map((image) => image.path).toList(),
        isUser: true,
      );
      messages.add(message);

      // Clear input
      textController.clear();
      clearImages();
    }
  }

  @override
  void onClose() {
    _stopRecordingTimer();
    textController.dispose();
    _audioRecorder.dispose();
    super.onClose();
  }
}
