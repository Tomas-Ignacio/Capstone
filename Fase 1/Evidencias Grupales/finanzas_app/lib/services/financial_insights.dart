enum FinancialInsightKind {
  budgetAlert,
  categoryFocus,
  savingProgress,
  overspending,
  startTracking,
}

class FinancialInsight {
  const FinancialInsight({
    required this.kind,
    required this.title,
    required this.message,
  });

  final FinancialInsightKind kind;
  final String title;
  final String message;
}

class MonthlyExpenseComparison {
  const MonthlyExpenseComparison({
    required this.currentMonth,
    required this.previousMonth,
  });

  final double currentMonth;
  final double previousMonth;

  double get difference => (currentMonth - previousMonth).abs();
  bool get isSaving => currentMonth < previousMonth;
  bool get isHigher => currentMonth > previousMonth;
  bool get isEqual => currentMonth == previousMonth;
}

class FinancialInsights {
  static MonthlyExpenseComparison compareMonthlyExpenses({
    required double currentMonth,
    required double previousMonth,
  }) {
    return MonthlyExpenseComparison(
      currentMonth: currentMonth,
      previousMonth: previousMonth,
    );
  }

  static List<FinancialInsight> analyze({
    required double monthlyIncome,
    required double monthlyExpenses,
    required Map<String, double> categoryExpenses,
    required double totalBudget,
  }) {
    final insights = <FinancialInsight>[];

    if (totalBudget > 0) {
      final usage = monthlyExpenses / totalBudget;
      if (usage >= .85) {
        final percentage = (usage * 100).round();
        insights.add(
          FinancialInsight(
            kind: FinancialInsightKind.budgetAlert,
            title: usage > 1
                ? 'Presupuesto superado'
                : 'Presupuesto casi agotado',
            message:
                'Ya usaste $percentage% de tu presupuesto mensual. Revisa tus próximos gastos.',
          ),
        );
      }
    }

    if (categoryExpenses.isNotEmpty && monthlyExpenses > 0) {
      final highestCategory = categoryExpenses.entries.reduce(
        (current, next) => current.value >= next.value ? current : next,
      );
      final share = highestCategory.value / monthlyExpenses;
      if (share >= .35) {
        insights.add(
          FinancialInsight(
            kind: FinancialInsightKind.categoryFocus,
            title: 'Tu gasto principal es ${highestCategory.key}',
            message:
                '${highestCategory.key} concentra ${(share * 100).round()}% de tus gastos del mes.',
          ),
        );
      }
    }

    if (monthlyIncome > 0 && monthlyExpenses > monthlyIncome) {
      insights.add(
        const FinancialInsight(
          kind: FinancialInsightKind.overspending,
          title: 'Gastaste más de lo que ingresaste',
          message: 'Considera ajustar un presupuesto para recuperar el equilibrio el próximo mes.',
        ),
      );
    } else if (monthlyIncome > monthlyExpenses && monthlyIncome > 0) {
      final saved = monthlyIncome - monthlyExpenses;
      insights.add(
        FinancialInsight(
          kind: FinancialInsightKind.savingProgress,
          title: 'Vas construyendo ahorro',
          message:
              'Este mes te quedan \$${saved.round()} después de registrar ingresos y gastos.',
        ),
      );
    }

    if (insights.isEmpty) {
      insights.add(
        const FinancialInsight(
          kind: FinancialInsightKind.startTracking,
          title: 'Registra tus próximos movimientos',
          message: 'Con más gastos e ingresos podremos mostrarte recomendaciones útiles.',
        ),
      );
    }

    return insights;
  }
}
