import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:radio_tool_flutter/radio_info.dart';
import 'package:radio_tool_flutter/radiotool_ffi.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

class RadioTool {
  final RadioToolFfi _ffi;
  final radiotool_ctx_ptr ctx = malloc.allocate(1);

  RadioTool(RadioToolFfi f) : _ffi = f {
    final err = _ffi.radiotool_init(Pointer.fromAddress(ctx.address));
    if (err != radiotool_status.RDTS_OK) {
      throw Exception("Init failed: $err");
    }
    print(ctx);
  }

  static Future<RadioTool> create() async {
    final libusb = DynamicLibrary.open("libusb-1.0.dylib");
    final ffi = RadioToolFfi(DynamicLibrary.open("libradiotool.dylib"));
    return RadioTool(ffi);
  }

  static Future<void> extractLibs() async {
    final lib = await rootBundle.load(
        "packages/radio_tool_flutter/radio_tool/build/libradiotool.dylib");
    final ftmp = File("libradiotool.dylib");
    ftmp.writeAsBytes(lib.buffer.asUint8List());
  }

  List<RadioInfo> listRadios() {
    Pointer<radiotool_radio_info> radios = malloc.allocate(1);
    print(radios);
    final err =
        _ffi.radiotool_list_devices(ctx, Pointer.fromAddress(radios.address));
    if (err < radiotool_status.RDTS_OK) {
      throw Exception("Invalid response from listRadios: $err");
    }
    print(err);

    final ret = <RadioInfo>[];
    for (var rx = 0; rx < err; rx++) {
      final sp = radios.elementAt(rx);

      final ri = RadioInfo(
          sp.ref.port.cast<Utf8>().toDartString(),
          sp.ref.manufacturer.cast<Utf8>().toDartString(),
          sp.ref.model.cast<Utf8>().toDartString());
      print(ri);
    }

    return ret;
  }
}
