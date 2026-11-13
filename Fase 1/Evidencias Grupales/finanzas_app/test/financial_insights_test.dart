import 'package:flutter_test/flutter_test.dart';

import 'package:finanzas_app/services/financial_insights.dart';

void main() {
  test('alerta cuando el gasto mensual está cerca del límite', () {
    final insights = FinancialInsights.analyze(
      monthlyIncome: 800000,
      monthlyExpenses: 360000,
      categoryExpenses: const {'Comida': 220000, 'Transporte': 140000},
      totalBudget: 400000,
    );

    expect(insights.first.kind, FinancialInsightKind.budgetAlert);
    expect(insights.first.title, 'Presupuesto casi agotado');
  });

  test('destaca la categoría que concentra el gasto', () {
    final insights = FinancialInsights.analyze(
      monthlyIncome: 900000,
      monthlyExpenses: 300000,
      categoryExpenses: const {'Comida': 180000, 'Ocio': 120000},
      totalBudget: 0,
    );

    expect(insights.first.kind, FinancialInsightKind.categoryFocus);
    expect(insights.first.message, contains('Comida'));
  });

  test('compara los gastos del mes con el mes anterior', () {
    final comparison = FinancialInsights.compareMonthlyExpenses(
      currentMonth: 180000,
      previousMonth: 225000,
    );

    expect(comparison.isSaving, isTrue);
    expect(comparison.difference, 45000);
  });
}
