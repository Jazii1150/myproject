import 'package:flutter/material.dart';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic sex;
  bool checkboxValueA = false;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  List<String> provices = ['', 'Bangkok', 'Krabi', 'Kanchanaburi', 'Kalasin', 'Kamphaeng Phet',
    'Khon Kaen', 'Chanthaburi', 'Chachoengsao', 'Chonburi', 'Chainat', 'Chaiyaphum', 'Chumphon',
    'Chiang Rai', '	Chiang Mai', 'Trang', 'Trat', 'Tak', 'Nakhon Nayok', 'Nakhon Pathom', 
    'Nakhon Phanom', 'Nakhon Ratchasima', 'Nakhon Si Thammarat', 'Nakhon Sawan', 'Nonthaburi',
    'Narathiwa', 'Nan', 'Bueng Kan', 'Buriram', 'Pathum Thani', 'Prachuap Khiri Khan', 
    'Prachinburi', 'Pattani', 'Phra Nakhon Si Ayutthaya', 'Phayao', 'Phang Nga', 'Phatthalung',
    'Phichit', 'Phitsanulok', 'Phetchaburi', 'Phetchabun', 'Phrae', 'Phuket', 'Maha Sarakham',
    'Mukdahan', 'Mae Hong Son', 'Yasothon', 'Yala', 'Roi Et', 'Ranong', 'Rayong', 'Ratchaburi', 
    'Lopburi', 'Lampang', 'Lamphun', 'Loei', 'Sisaket', 'Sakon Nakhon', 'Songkhla', 'Satun', 
    'Samut Prakan', 'Samut Songkhram', 'Samut Sakhon', 'Sa Kaeo', 'Saraburi', 'Sing Buri',
    'Sukhothai', 'Suphan Buri', 'Surat Thani', 'Surin', 'Nong Khai', 'Nong Bua Lamphu', 
    'Ang Thong', 'Amnat Charoen', 'Udon Thani', 'Uttaradit', 'Uthai Thani', 'Ubon Ratchathani'];
  dynamic provice = '';
  final _format = DateFormat('dd/MM/yyyy');
  File? _avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
              title: Text("Edit Bio",
                style: GoogleFonts.shrikhand(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(252, 243, 233, 1.0),
                ),
              ),
            ),
      body: Material(
        color: const Color.fromRGBO(252, 243, 233, 1.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: ListView(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Name',
                  style: GoogleFonts.shrikhand(
                  color: const Color.fromRGBO(228, 76, 16, 1.0),
                  fontSize: 20.0
                )
              ),
            TextFormField(
              cursorColor: const Color.fromRGBO(228, 76, 16, 1.0),
              initialValue: 'Put your name on',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                //labelText: 'Put your name on',
                prefixIcon: Icon(Icons.person),
              ),
                
              ),
              Text('Sex',
                style: GoogleFonts.shrikhand(
                color: const Color.fromRGBO(228, 76, 16, 1.0),
                fontSize: 20.0
              )
            ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Radio(
                  value: 'M',
                  groupValue: sex,
                  onChanged: (value) {
                    setState(() {
                      sex = value;
                    });
                  },
                ),
                const Text('Male'),
                const SizedBox(
                  width: 40,
                ),
                Radio(
                  value: 'F',
                  groupValue: sex,
                  onChanged: (value) {
                    // _handleTapboxChanged(value);
                    setState(() {
                      sex = value;
                    });
                  },
                ),
                const Text('Female'),
              ]),
              // Row(children: [
              //   Text('$sex'),
              // ]),
              Text('Year',
                style: GoogleFonts.shrikhand(
                color: const Color.fromRGBO(228, 76, 16, 1.0),
                fontSize: 20.0
              )
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: checkboxValueA,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValueA = value!;
                    });
                  },
                ),
                const Text('12-19 year'),
                Checkbox(
                  value: checkboxValueB,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValueB = value!;
                    });
                  },
                ),
                const Text('20-29 year'),
                Checkbox(
                  value: checkboxValueC,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValueC = value!;
                    });
                  },
                ),
                const Text('30+ year'),
              ]),
              // Row(children: [
              //   Text('$checkboxValueA'),
              //   Text('$checkboxValueB'),
              //   Text('$checkboxValueC'),
              // ]),
              Text('Address',
                style: GoogleFonts.shrikhand(
                color: const Color.fromRGBO(228, 76, 16, 1.0),
                fontSize: 20.0
              )
            ),
              buildSelectField(),
              Text('Birth',
                style: GoogleFonts.shrikhand(
                color: const Color.fromRGBO(228, 76, 16, 1.0),
                fontSize: 20.0
              )
            ),
              buildDateField(),
              Text('Picture',
                style: GoogleFonts.shrikhand(
                color: const Color.fromRGBO(228, 76, 16, 1.0),
                fontSize: 20.0
              )
            ),
            _avatar == null
            ? ElevatedButton(onPressed: () {
              onChooseImage();
            },
            child: const Text('Choos avatar'),
            )
            : Image.file(_avatar!)
            ]),
        ],)
          ),
      ),
    );
    
  }

  DateTimeField buildDateField() {
    return DateTimeField(
      cursorColor: const Color.fromRGBO(228, 76, 16, 1.0),
      decoration: const InputDecoration(
        labelText: 'Birth Date',
        border: OutlineInputBorder(),
      ),
      format: _format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));

      },
    );
  }

  InputDecorator buildSelectField() {
    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Province',
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: provice,
          onChanged: (value) {
            setState(() {
              provice = value;
            });
          },
          items: provices
              .map(
                (value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  onChooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
    source: ImageSource.gallery);
    
    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

}
