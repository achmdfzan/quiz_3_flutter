import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'umkm.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Detil'),
        ),
      ),
      body: Center(
        child: BlocBuilder<UMKMCubit, UMKMModel>(
          buildWhen: (previousState, state) {
            developer.log("${previousState.nama} -> ${state.nama}",
                name: 'detaillog');
            return true;
          },
          builder: (context, model) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Nama: ${model.nama}"),
                  Text("Detil: ${model.jenis}"),
                  Text("Member Sejak: ${model.memberSejak}"),
                  Text("Omzet per bulan: ${model.omzetBulan}"),
                  Text("Lama usaha: ${model.lamaUsaha}"),
                  Text("Jumlah pinjaman sukses: ${model.jumlahPinjamanSukses}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
