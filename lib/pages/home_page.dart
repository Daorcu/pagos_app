import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:pagos_app/data/tarjetas.dart';
import 'package:pagos_app/helpers/helpers.dart';
import 'package:pagos_app/pages/tarjeta_page.dart';
import 'package:pagos_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pagar',
        ),
        actions: [
          IconButton(
            splashRadius: 20.0,
            icon: Icon(Icons.add),
            onPressed: () async {
              mostrarLoading(context);
              await Future.delayed(Duration(seconds: 1));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
                controller: PageController(
                  viewportFraction: 0.9,
                ),
                physics: BouncingScrollPhysics(),
                itemCount: tarjetas.length,
                itemBuilder: (_, i) {
                  final tarjeta = tarjetas[i];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, navegarFadeIn(context, TarjetaPage()));
                      print('Holi');
                    },
                    child: Hero(
                      tag: tarjeta.cardNumber,
                      child: CreditCardWidget(
                        cardNumber: tarjeta.cardNumberHidden,
                        expiryDate: tarjeta.expiracyDate,
                        cardHolderName: tarjeta.cardHolderName,
                        cvvCode: tarjeta.cvv,
                        showBackView: false,
                        obscureCardCvv: true,
                        obscureCardNumber: true,
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            bottom: 0,
            child: TotapPayButton(),
          ),
        ],
      ),
    );
  }
}
