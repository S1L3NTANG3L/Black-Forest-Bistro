object ChangeVaribles: TChangeVaribles
  Left = 0
  Top = 0
  Width = 147
  Height = 218
  TabOrder = 0
  object lbl1: TLabel
    Left = 3
    Top = 3
    Width = 116
    Height = 23
    Caption = 'Change Vat:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 3
    Top = 99
    Width = 137
    Height = 23
    Caption = 'Change Profit:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtVat: TEdit
    Left = 3
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object btnChangeVat: TButton
    Left = 3
    Top = 59
    Width = 75
    Height = 21
    Caption = 'Change Vat'
    TabOrder = 1
    OnClick = btnChangeVatClick
  end
  object edtProfit: TEdit
    Left = 3
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object btnChangeProfit: TButton
    Left = 3
    Top = 155
    Width = 75
    Height = 21
    Caption = 'Change Profit'
    TabOrder = 3
    OnClick = btnChangeProfitClick
  end
  object btnBackToA: TButton
    Left = 3
    Top = 186
    Width = 75
    Height = 21
    Caption = 'Back'
    TabOrder = 4
  end
end
