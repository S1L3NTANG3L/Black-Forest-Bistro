object Ledger: TLedger
  Left = 0
  Top = 0
  Width = 842
  Height = 623
  TabOrder = 0
  object dbgrdLedger: TDBGrid
    Left = 3
    Top = 3
    Width = 836
    Height = 582
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnBack: TButton
    Left = 704
    Top = 591
    Width = 135
    Height = 21
    Caption = 'Back'
    TabOrder = 1
  end
  object btnShowIncome: TButton
    Left = 3
    Top = 591
    Width = 135
    Height = 21
    Caption = 'Show Income'
    TabOrder = 2
    OnClick = btnShowIncomeClick
  end
  object btnShowExpense: TButton
    Left = 144
    Top = 591
    Width = 135
    Height = 21
    Caption = 'Show Expenses'
    TabOrder = 3
    OnClick = btnShowExpenseClick
  end
  object btnShowTransactionHistory: TButton
    Left = 426
    Top = 591
    Width = 135
    Height = 21
    Caption = 'Show Transaction History'
    TabOrder = 4
    OnClick = btnShowTransactionHistoryClick
  end
  object btnShowLedger: TButton
    Left = 285
    Top = 591
    Width = 135
    Height = 21
    Caption = 'Show Ledger'
    TabOrder = 5
    OnClick = btnShowLedgerClick
  end
end
