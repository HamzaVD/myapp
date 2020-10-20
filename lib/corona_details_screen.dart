import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'util/dialog.dart';
import 'util/firebase_manager.dart';
import 'util/global.dart';

class CoronaDetailsPage extends StatefulWidget {
  CoronaDetailsPage();
  @override
  _CoronaDetailsPageState createState() => _CoronaDetailsPageState();
}

class _CoronaDetailsPageState extends State<CoronaDetailsPage> {
  bool _isLoading = false;
  List<CovidDetails> _covidDetails = new List<CovidDetails>();

  @override
  void initState() {
    super.initState();
    _covidDetails = [
      new CovidDetails(detailHeading: 'OVERVIEW', detailText: '''
Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus.

Most people infected with the COVID-19 virus will experience mild to moderate respiratory illness and recover without requiring special treatment.  Older people, and those with underlying medical problems like cardiovascular disease, diabetes, chronic respiratory disease, and cancer are more likely to develop serious illness.

The best way to prevent and slow down transmission is to be well informed about the COVID-19 virus, the disease it causes and how it spreads. Protect yourself and others from infection by washing your hands or using an alcohol based rub frequently and not touching your face. 

The COVID-19 virus spreads primarily through droplets of saliva or discharge from the nose when an infected person coughs or sneezes, so it’s important that you also practice respiratory etiquette (for example, by coughing into a flexed elbow).
        '''),
      new CovidDetails(
          detailHeading: 'PREVENTION',
          detailText:
              '''To prevent infection and to slow transmission of COVID-19, do the following:

Wash your hands regularly with soap and water, or clean them with alcohol-based hand rub.
Maintain at least 1 metre distance between you and people coughing or sneezing.
Avoid touching your face.
Cover your mouth and nose when coughing or sneezing.
Stay home if you feel unwell.
Refrain from smoking and other activities that weaken the lungs.
Practice physical distancing by avoiding unnecessary travel and staying away from large groups of people.
'''),
      new CovidDetails(detailHeading: 'SYMPTOMS', detailText: ''' 
COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization.

Most common symptoms:

fever.
dry cough.
tiredness.
Less common symptoms:

aches and pains.
sore throat.
diarrhoea.
conjunctivitis.
headache.
loss of taste or smell.
a rash on skin, or discolouration of fingers or toes.
Serious symptoms:

difficulty breathing or shortness of breath.
chest pain or pressure.
loss of speech or movement.
Seek immediate medical attention if you have serious symptoms.  Always call before visiting your doctor or health facility. 

People with mild symptoms who are otherwise healthy should manage their symptoms at home. 

On average it takes 5–6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.'''),
      new CovidDetails(detailHeading: 'Credits', detailText: 'WHO')
    ];
    // _fetchDetails();
    // FirebaseManager.setCurrentScreen('CoronaVirusDetailsPage');
  }

  _fetchDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _covidDetails = await networkApi.getCoronaDetails();
    } catch (e) {
      showFailureAlertDialog(context, 'Failed to process request');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: greyBackground(),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('What is Coronavirus?',
                  style: TextStyle(color: ThemeConstants.primaryColorLight)),
            ),
            body: _isLoading ? customLoader() : _body()));
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.transparent,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _covidDetails.length > 0 || _covidDetails.isNotEmpty
              ? new ListView.builder(
                  itemCount: _covidDetails.length,
                  itemBuilder: (context, index) {
                    return _buildDetailCard(index);
                  },
                )
              : _emptyState(),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'No data found',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(int index) {
    return ListTile(
      title: Text(_covidDetails[index].detailHeading,
          style: TextStyle(
            fontSize: _covidDetails[index].detailHeading == 'Credits' ? 16 : 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          )),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(_covidDetails[index].detailText,
            style: TextStyle(fontSize: 18, color: Colors.black)),
      ),
    );
  }
}
