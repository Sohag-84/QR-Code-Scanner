// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String qrResultData = "Scanned data will appear here";

  Future<void> scanQrCode() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#FF6666",
        "Cancel",
        true,
        ScanMode.QR,
      );
      if (qrCode != "-1") {
        if (!mounted) return;
        setState(() {
          qrResultData = qrCode;
          log("Something is worng");
        });
      }
    } on PlatformException {
      qrResultData = "Fail to read qr code";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Qr Code"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                qrResultData,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: scanQrCode,
                child: Text("Scan Qr Code"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
