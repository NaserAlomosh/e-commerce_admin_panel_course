import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class UploadImageService {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://yudvvhkkyjozuimhbcsz.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1ZHZ2aGtreWpvenVpbWhiY3N6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2ODgxMjMsImV4cCI6MjA2MTI2NDEyM30.TFJ53ogV6bx23XfJ8j2_myNsf-GXtqCZOwfKUUzgrFw',
    );
  }

  static Future<String?> uploadImage(File imageFile) async {
    try {
      final imagename = imageFile.uri.pathSegments.last;
      final supabase = Supabase.instance.client;
      final storgeSupabase = await supabase.storage
          .from('images')
          .upload('uploads/$imagename', imageFile);

      if (storgeSupabase.isNotEmpty) {
        return supabase.storage.from('images').getPublicUrl('uploads/$imagename');
      } else {
        return null;
      }
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }
}
