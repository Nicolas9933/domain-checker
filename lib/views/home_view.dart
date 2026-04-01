import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/domain_viewmodel.dart';
import 'widgets/domain_result_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _search(BuildContext context) {
    _focusNode.unfocus();
    context.read<DomainViewModel>().searchDomain(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: const Text('Consulta de Domínios .br',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<DomainViewModel>(
        builder: (context, vm, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            labelText: 'Domínio',
                            hintText: 'ex: meusite.com.br',
                            prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.indigo, width: 2)),
                          ),
                          onSubmitted: (_) => _search(context),
                          textInputAction: TextInputAction.search,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: vm.state == DomainState.loading
                                ? null
                                : () => _search(context),
                            icon: const Icon(Icons.radar),
                            label: const Text('Consultar',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (vm.state == DomainState.loading)
                  const Center(child: Column(children: [
                    CircularProgressIndicator(color: Colors.indigo),
                    SizedBox(height: 12),
                    Text('Consultando domínio...', style: TextStyle(color: Colors.indigo)),
                  ])),
                if (vm.state == DomainState.error)
                  Card(
                    color: Colors.red.shade50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 10),
                        Expanded(child: Text(vm.errorMessage,
                            style: const TextStyle(color: Colors.red))),
                      ]),
                    ),
                  ),
                if (vm.state == DomainState.success && vm.domain != null)
                  DomainResultCard(domain: vm.domain!),
                if (vm.history.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text('Histórico de buscas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54)),
                  const SizedBox(height: 8),
                  ...vm.history.map((h) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.history, color: Colors.grey),
                    title: Text(h),
                    onTap: () { _controller.text = h; _search(context); },
                  )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}