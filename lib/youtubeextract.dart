import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';


final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
var yt = YoutubeExplode();
double statistics = 0.0;
String filename1 = '';

void logCallback(int level, double message) {
  statistics = message;
}

extractvideo(url) async {
  url.trim();

  // Save the video to the download directory.
  final FlutterFFmpegConfig _flutterFFmpegConfig = new FlutterFFmpegConfig();
  var storageperm = Permission.storage;
  var permissions = await storageperm.request();
  var Dir = await DownloadsPathProvider.downloadsDirectory;
  print(Dir);
  Directory(Dir.path).createSync();
  // Get video metadata.
  var video = await yt.videos.get(url);

  // Get the video manifest.
  var manifest = await yt.videos.streamsClient.getManifest(url);
  var streams = manifest.muxed;

  // Get the audio track with the highest bitrate.
  var audio = streams.withHighestBitrate();
  var audioStream = yt.videos.streamsClient.get(audio);

  // Compose the file name removing the unallowed characters in windows.
  var fileName = '${video.title}.${audio.container.name.toString()}'
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '');
  var file = File('/storage/emulated/0/Download/$fileName');

  // Delete the file if exists.
  if (file.existsSync()) {
    file.deleteSync();
  }

  // Open the file in writeAppend.
  var output = file.openWrite(mode: FileMode.writeOnlyAppend);

  // Track the file download status.
  double len = audio.size.totalBytes.toDouble();
  double count = 0;
  double indicator = 0;

  filename1 = 'Downloading ${video.title}.${audio.container.name}';
  // Listen for data received.
  await for (var data in audioStream) {
    // Keep track of the current downloaded data.
    count += data.length.toDouble();

    // Calculate the current progress.

    double progress = ((count / len) / 1);
    // Update the progressbar.
    logCallback(100, progress);

    // Write to file.
    output.add(data);

  }}

extractaudio(url) async {

  url.trim();

  // Save the video to the download directory.
  final FlutterFFmpegConfig _flutterFFmpegConfig = new FlutterFFmpegConfig();
  var storageperm = Permission.storage;
  var permissions = await storageperm.request();
  var Dir = await DownloadsPathProvider.downloadsDirectory;
  print(Dir);
  Directory(Dir.path).createSync();
  // Get video metadata.
  var video = await yt.videos.get(url);

  // Get the video manifest.
  var manifest = await yt.videos.streamsClient.getManifest(url);
  var streams = manifest.audioOnly;

  // Get the audio track with the highest bitrate.
  var audio = streams.withHighestBitrate();
  var audioStream = yt.videos.streamsClient.get(audio);

  // Compose the file name removing the unallowed characters in windows.
  var fileName = '${video.title}.${audio.container.name.toString()}'
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '');
  var file = File('/storage/emulated/0/Download/$fileName');

  // Delete the file if exists.
  if (file.existsSync()) {
    file.deleteSync();
  }

  // Open the file in writeAppend.
  var output = file.openWrite(mode: FileMode.writeOnlyAppend);

  // Track the file download status.
  double len = audio.size.totalBytes.toDouble();
  double count = 0;
  double indicator = 0;

  filename1 = 'Downloading ${video.title}.${audio.container.name}';
  // Listen for data received.
  await for (var data in audioStream) {
    // Keep track of the current downloaded data.
    count += data.length.toDouble();

    // Calculate the current progress.

    double progress = ((count / len) / 1);
    // Update the progressbar.
    logCallback(100, progress);

    // Write to file.
    output.add(data);

  }}