import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagos_app/bloc/pagar/pagar_bloc.dart';

import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:pagos_app/data/tarjetas.dart';
import 'package:pagos_app/helpers/helpers.dart';
import 'package:pagos_app/pages/tarjeta_page.dart';
import 'package:pagos_app/services/stripe_service.dart';
import 'package:pagos_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  final stripeService = new StripeService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bloc = BlocProvider.of<PagarBloc>(context).state;

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
              final amount = bloc.montoPagarString;
              final currency = bloc.moneda;

              final resp = await this.stripeService.pagarNuevaTarjeta(
                    amount: amount,
                    currency: currency,
                  );
              Navigator.pop(context);

              if (resp.ok) {
                mostrarAlerta(context, 'Tarjeta Nueva Agregada',
                    'Tarjeta agregada correctamente');
              } else {
                mostrarAlerta(context, 'Algo salió mal', resp.msg);
              }

              // Navigator.pop(context);
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
                      BlocProvider.of<PagarBloc>(context)
                          .add(OnSeleccionarTarjeta(tarjeta));
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
            child: TotalPayButton(),
          ),
        ],
      ),
    );
  }
}
