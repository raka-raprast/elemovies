// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../main_export.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? _debounce;
  _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<MultiSearchBloc>(context).add(MultiSearchGetListEvent(query));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MultiSearchBloc>(create: (_) => MultiSearchBloc()..add(MultiSearchGetListEvent(""))),
      ],
      child: BlocBuilder<MultiSearchBloc, MultiSearchState>(builder: (context, state) {
        return ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              color: Colors.grey.withOpacity(.1),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue, width: .5),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (s) {
                          _onSearchChanged(context, s);
                        },
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search for movie or tv show",
                          hintStyle: TextStyle(fontSize: 14, color: Colors.blue.withOpacity(.5)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: Sizes.width(context),
              height: 1,
              color: Colors.blue,
            ),
            if (state is MultiSearchLoadedState && state.multiSearchResponse.isNotEmpty)
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .8,
                crossAxisCount: 2,
                children: state.multiSearchResponse
                    .map(
                      (e) => SearchResultWidget(
                        multiSearch: e,
                        onTap: (item) {
                          if (item.mediaType == "person") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistDetailScreen(artist: item)));
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSearchDetailScreen(shows: item)));
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            if (state is MultiSearchLoadedState && state.multiSearchResponse.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "No result found",
                    style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(.5)),
                  ),
                ),
              ),
            if (state is MultiSearchInitialState)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Type something to start search for movie, tv show, or person",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.blue.withOpacity(.5)),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
