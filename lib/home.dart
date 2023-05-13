import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'umkm.dart';
import 'detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('My App'),
          ),
        ),
        body: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    "2108061, Achmad Fauzan; 2101114, Anandita Kusumah Mulyadi; Saya berjanji tidak akan berbuat curang data atau membantu orang lain berbuat curang"),
              ),
            ),
            Center(
              child: BlocBuilder<ListUMKMCubit, ListUMKMModel>(
                buildWhen: (previousState, state) {
                  developer.log(
                      "${previousState.listUMKMModel} -> ${state.listUMKMModel}",
                      name: 'reloadlog');
                  return true;
                },
                builder: (context, model) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ListUMKMCubit>().fetchData();
                      },
                      child: const Text("Reload Daftar UMKM"),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ListUMKMCubit, ListUMKMModel>(
                buildWhen: (previousState, state) {
                  developer.log(
                      "${previousState.listUMKMModel} -> ${state.listUMKMModel}",
                      name: 'listlog');
                  return true;
                },
                builder: (context, model) {
                  if (model.listUMKMModel.isNotEmpty) {
                    return ListView.builder(
                      itemCount: model.listUMKMModel.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    String id = model.listUMKMModel[index].id;
                                    return BlocProvider(
                                      create: (_) => UMKMCubit(id),
                                      child: DetailPage(
                                        id: id,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            leading: Image.network(
                                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                            title: Text(model.listUMKMModel[index].nama),
                            subtitle: Text(model.listUMKMModel[index].jenis),
                            trailing: const Icon(Icons.more_vert),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Tekan tombol 'Reload Daftar UMKM'"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
