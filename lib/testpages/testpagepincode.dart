import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class CountryPin extends StatefulWidget {
  const CountryPin({Key? key}) : super(key: key);

  @override
  _CountryPinState createState() => _CountryPinState();
}

class _CountryPinState extends State<CountryPin> {

  final _textcont = TextEditingController();
  String title ="Country Code Picker";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(border:Border.all()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Container(
                  width: 100,
                  child: CountryCodePicker(
                    initialSelection:'IN',
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed:false,
                    favorite: const ['+91','IN'],
                    alignLeft: false,
                    enabled: true,
                    hideMainText: false,
                    showFlagMain: true,
                    onChanged: (value){print(value);},
                    padding: const EdgeInsets.all(16.0),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(border:InputBorder.none),
                    controller: _textcont,
                     keyboardType: TextInputType.phone,
                  ),
                )
              ],
            ),
            ),
          ),
        ),
    );
  }
}
