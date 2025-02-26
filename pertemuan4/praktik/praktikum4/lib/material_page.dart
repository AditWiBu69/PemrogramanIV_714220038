import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: <Widget>[

            const Center(
              child: Text(
                'Icecream Service',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
              ),
            ),
            const SizedBox(height: 16.0), 

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: <Widget>[
                Column(
                  children: const [
                    Icon(Icons.calendar_today),
                    SizedBox(height: 8.0), 
                    Text('Open Everyday'), 
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.access_time),
                    SizedBox(height: 8.0),
                    Text('09:00 - 20:00'), 
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.monetization_on),
                    SizedBox(height: 8.0),
                    Text('Rp 20.000'), 
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0), 
          
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Cafe Ice Cream Service di Bandung adalah destinasi yang sempurna bagi pecinta es krim yang mencari pengalaman manis dan menyegarkan. Terletak di jantung kota dengan suasana yang nyaman dan instagramable, cafe ini menawarkan berbagai varian es krim berkualitas tinggi dengan cita rasa unik, mulai dari klasik seperti vanila dan cokelat hingga rasa khas lokal seperti alpukat dan klepon. Selain itu, pelayanan yang ramah dan cepat membuat pengunjung merasa betah berlama-lama menikmati hidangan. Dengan konsep yang modern dan menu yang inovatif, Cafe Ice Cream Service menjadi pilihan favorit bagi keluarga, pasangan, dan teman-teman untuk berkumpul sambil menikmati sajian lezat di tengah kesejukan Bandung.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}