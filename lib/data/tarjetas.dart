import '../models/tarjeta_credito.dart';

final List<TarjetaCredito> tarjetas = <TarjetaCredito>[
  TarjetaCredito(
      cardNumberHidden: '4242',
      cardNumber: '4242424242424242',
      brand: 'visa',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'David Ordaz'),
  TarjetaCredito(
      cardNumberHidden: '5555',
      cardNumber: '5555555555554444',
      brand: 'mastercard',
      cvv: '524',
      expiracyDate: '03/25',
      cardHolderName: 'Octavio Campos'),
  TarjetaCredito(
      cardNumberHidden: '3782',
      cardNumber: '378282246310005',
      brand: 'american express',
      cvv: '4879',
      expiracyDate: '09/25',
      cardHolderName: 'Julia Pérez'),
  TarjetaCredito(
      cardNumberHidden: '3782',
      cardNumber: '5200828282828210',
      brand: 'mastercarddebit',
      cvv: '587',
      expiracyDate: '08/25',
      cardHolderName: 'Julia Pérez'),
];
