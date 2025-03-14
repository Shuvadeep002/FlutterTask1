import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/search/search_bloc.dart';
import '../utils/screen_size.dart';

class HomeSearchbar extends StatelessWidget {
  const HomeSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize.of(context);
    final width = screenSize.width;
    final height = screenSize.height;

    return Column(
      children: [
        // Search Bar Container
        Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.04),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.003,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.045),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: width * 0.025),
              // Search Input Field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Places',
                    hintStyle: GoogleFonts.roboto(
                      fontSize: width * 0.035,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (query) {
                    context.read<SearchBloc>().add(SearchQueryChanged(query));
                  },
                ),
              ),

              // Divider
              Container(
                width: 1,
                height: height * 0.03,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              ),

              // Settings Icon
              Icon(
                Icons.tune,
                color: Colors.grey,
                size: width * 0.06,
              ),
            ],
          ),
        ),

        // Search Results
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
              );
            }

            if (state is SearchSuccess || state is SearchItemSelected) {
              final results = state is SearchSuccess
                  ? state.results
                  : (state as SearchItemSelected).results;

              final selectedItem =
                  state is SearchItemSelected ? state.selectedItem : null;
print("selectedItem $selectedItem");
              return Container(
                height: 200,
                margin: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      var rslt = results[index];
                      final isSelected = rslt == selectedItem;
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<SearchBloc>()
                              .add(SelectSearchItem(rslt));

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Selection'),
                              content: Text('$rslt selected'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );

                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.yellow : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.orange
                                  : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            rslt,
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color:
                                  isSelected ? Colors.black : Colors.grey[800],
                            ),
                          ),
                        ),
                      );
                    }
                    ),
              );
            }

            if (state is SearchFailure) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.error,
                  style: GoogleFonts.roboto(color: Colors.red),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
