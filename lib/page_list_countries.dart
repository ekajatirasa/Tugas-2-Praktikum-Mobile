import 'package:flutter/material.dart';
import 'countries_model.dart';
import 'covid_data_source.dart';

class PageListCountries extends StatefulWidget {
  const PageListCountries({Key? key}) : super(key: key);

  @override
  State<PageListCountries> createState() => _PageListCountriesState();
}

class _PageListCountriesState extends State<PageListCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kartu Negara"),
        backgroundColor: Colors.green[800],
      ),
      body: _buildListCountriesBody(),
      backgroundColor: Colors.green,

    );
  }
}

Widget _buildListCountriesBody() {
  return Container(
    child: FutureBuilder(
      future: CovidDataSource.instance.loadCountries(),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          CountriesModel countriesModel =
              CountriesModel.fromJson(snapshot.data);
          return _buildSuccessSection(countriesModel);
        }
        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildErrorSection() {
  return Text("Error");
}

Widget _buildEmptySection() {
  return Text("Empty");
}

Widget _buildLoadingSection() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildSuccessSection(CountriesModel data) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10),
    itemCount: data.countries?.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        child: Card(
            child: InkWell(
          onTap: () {},
          splashColor: Colors.lightGreen[700],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text(
                  '${data.countries?[index].name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '(${data.countries?[index].iso3})',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        )),
      );
    },
  );
}
