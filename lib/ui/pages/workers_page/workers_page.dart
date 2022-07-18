import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/ui/widgets/worker_card/worker_card.dart';

class WorkersPage extends StatelessWidget {
  const WorkersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthProvider>();
    final workers = model.workers;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Сотрудники',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.18,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: workers.length,
        shrinkWrap: true,
        separatorBuilder: (context, i) => const SizedBox(height: 15),
        itemBuilder: (context, i) {
          final label = '${workers[i].firstName} ${workers[i].lastName}';

          return WorkerCard(
            name: label,
            born: workers[i].born ?? '',
            position: workers[i].position ?? '',
            id: workers[i].id ?? -1,
          );
        },
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
