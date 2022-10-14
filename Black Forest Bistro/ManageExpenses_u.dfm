object ManageExpenses: TManageExpenses
  Left = 0
  Top = 0
  Width = 853
  Height = 378
  TabOrder = 0
  object lbl1: TLabel
    Left = 3
    Top = 3
    Width = 169
    Height = 23
    Caption = 'Ingredient Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 3
    Top = 67
    Width = 189
    Height = 23
    Caption = 'Ingredient Amount:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 3
    Top = 131
    Width = 161
    Height = 23
    Caption = 'Ingredient Price:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 227
    Top = 3
    Width = 119
    Height = 23
    Caption = 'Drink Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 227
    Top = 67
    Width = 177
    Height = 23
    Caption = 'Amount Of Drinks:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 227
    Top = 131
    Width = 111
    Height = 23
    Caption = 'Drink Price:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl7: TLabel
    Left = 435
    Top = 3
    Width = 105
    Height = 23
    Caption = 'Pay Water:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl8: TLabel
    Left = 435
    Top = 32
    Width = 174
    Height = 23
    Caption = 'Amount Of Water:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl9: TLabel
    Left = 435
    Top = 91
    Width = 118
    Height = 23
    Caption = 'Water Price:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl10: TLabel
    Left = 647
    Top = 3
    Width = 143
    Height = 23
    Caption = 'Pay Electricity:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl11: TLabel
    Left = 647
    Top = 32
    Width = 206
    Height = 23
    Caption = 'Amount Of Electricty:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl12: TLabel
    Left = 647
    Top = 91
    Width = 156
    Height = 23
    Caption = 'Electricity Price:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl13: TLabel
    Left = 3
    Top = 243
    Width = 150
    Height = 23
    Caption = 'Pay Employees:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl14: TLabel
    Left = 3
    Top = 272
    Width = 98
    Height = 23
    Caption = 'Bonus(R):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl15: TLabel
    Left = 3
    Top = 298
    Width = 129
    Height = 13
    Caption = 'Leave empty if no bonuses'
  end
  object btnAddIngredient: TButton
    Left = 3
    Top = 187
    Width = 97
    Height = 21
    Caption = 'Add Ingredient'
    TabOrder = 0
    OnClick = btnAddIngredientClick
  end
  object btnBackToA: TButton
    Left = 647
    Top = 344
    Width = 97
    Height = 21
    Caption = 'Back'
    TabOrder = 1
  end
  object edtIngredientName: TEdit
    Left = 3
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtIngredientAmount: TEdit
    Left = 3
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtIngredientPrice: TEdit
    Left = 3
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object edtDrinkName: TEdit
    Left = 227
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object edtAmountOfDrinks: TEdit
    Left = 227
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object edtDrinkPrice: TEdit
    Left = 227
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object btnAddDrink: TButton
    Left = 227
    Top = 187
    Width = 97
    Height = 21
    Caption = 'Add Drink'
    TabOrder = 8
    OnClick = btnAddDrinkClick
  end
  object edtAmountOfWater: TEdit
    Left = 435
    Top = 61
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object edtPriceOfWater: TEdit
    Left = 435
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object btnPayWater: TButton
    Left = 435
    Top = 147
    Width = 97
    Height = 21
    Caption = 'Pay Water'
    TabOrder = 11
    OnClick = btnPayWaterClick
  end
  object edtAmountOfElectricity: TEdit
    Left = 647
    Top = 61
    Width = 121
    Height = 21
    TabOrder = 12
  end
  object edtPriceOfElectricity: TEdit
    Left = 647
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 13
  end
  object btnPayElectricity: TButton
    Left = 647
    Top = 147
    Width = 97
    Height = 21
    Caption = 'Pay Electricity'
    TabOrder = 14
    OnClick = btnPayElectricityClick
  end
  object edtBonus: TEdit
    Left = 3
    Top = 317
    Width = 121
    Height = 21
    TabOrder = 15
  end
  object btnPayEmployees: TButton
    Left = 3
    Top = 344
    Width = 97
    Height = 21
    Caption = 'Pay Employees'
    TabOrder = 16
  end
end
