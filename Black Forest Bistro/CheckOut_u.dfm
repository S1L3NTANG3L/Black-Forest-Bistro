object CheckOut: TCheckOut
  Left = 0
  Top = 0
  Width = 208
  Height = 271
  TabOrder = 0
  object lbl1: TLabel
    Left = 3
    Top = 3
    Width = 197
    Height = 23
    Caption = 'Total Order Amount:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 3
    Top = 32
    Width = 75
    Height = 23
    Caption = 'Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 3
    Top = 77
    Width = 180
    Height = 23
    Caption = 'Customer Amount:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 3
    Top = 141
    Width = 141
    Height = 23
    Caption = 'Table Number:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtCustomerAmount: TEdit
    Left = 3
    Top = 106
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object cbbTable: TComboBox
    Left = 3
    Top = 170
    Width = 145
    Height = 21
    TabOrder = 1
    Text = 'cbbTable'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15')
  end
  object btnPay: TButton
    Left = 69
    Top = 208
    Width = 75
    Height = 21
    Caption = 'Pay'
    TabOrder = 2
  end
  object btnBackToO: TButton
    Left = 69
    Top = 239
    Width = 75
    Height = 21
    Caption = 'Back'
    TabOrder = 3
  end
end
