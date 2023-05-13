import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class UMKMModel {
  String id;
  String nama;
  String jenis;
  String omzetBulan;
  String lamaUsaha;
  String memberSejak;
  String jumlahPinjamanSukses;
  UMKMModel({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.omzetBulan,
    required this.lamaUsaha,
    required this.memberSejak,
    required this.jumlahPinjamanSukses,
  });
}

class UMKMCubit extends Cubit<UMKMModel> {
  String selectedID = "-";

  UMKMCubit(String id)
      : super(
          UMKMModel(
              id: id,
              nama: "-",
              jenis: "-",
              omzetBulan: "-",
              lamaUsaha: "-",
              memberSejak: "-",
              jumlahPinjamanSukses: "-"),
        ) {
    selectedID = id;
    fetchData();
  }

  void setFromJson(Map<String, dynamic> json) {
    var id = json["id"];
    var nama = json["nama"];
    var jenis = json["jenis"];
    var omzetBulan = json["omzet_bulan"];
    var lamaUsaha = json["lama_usaha"];
    var memberSejak = json["member_sejak"];
    var jumlahPinjamanSukses = json["jumlah_pinjaman_sukses"];
    emit(UMKMModel(
      id: id,
      nama: nama,
      jenis: jenis,
      omzetBulan: omzetBulan,
      lamaUsaha: lamaUsaha,
      memberSejak: memberSejak,
      jumlahPinjamanSukses: jumlahPinjamanSukses,
    ));
  }

  void fetchData() async {
    String url = "http://178.128.17.76:8000/detil_umkm/$selectedID";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}

class ListUMKMModel {
  List<UMKMModel> listUMKMModel = <UMKMModel>[];
  ListUMKMModel({required this.listUMKMModel});
}

class ListUMKMCubit extends Cubit<ListUMKMModel> {
  String url = "http://178.128.17.76:8000/daftar_umkm";

  ListUMKMCubit() : super(ListUMKMModel(listUMKMModel: []));

  void setFromJson(Map<String, dynamic> json) {
    List<UMKMModel> listUMKMModel = <UMKMModel>[];
    var data = json["data"];
    for (var val in data) {
      var id = val["id"];
      var nama = val["nama"];
      var jenis = val["jenis"];
      listUMKMModel.add(
        UMKMModel(
          id: id,
          nama: nama,
          jenis: jenis,
          omzetBulan: "-",
          lamaUsaha: "-",
          memberSejak: "-",
          jumlahPinjamanSukses: "-",
        ),
      );
    }
    emit(ListUMKMModel(listUMKMModel: listUMKMModel));
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
