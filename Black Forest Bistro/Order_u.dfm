object OrderFrame: TOrderFrame
  Left = 0
  Top = 0
  Width = 527
  Height = 492
  TabOrder = 0
  object lbl1: TLabel
    Left = 3
    Top = 376
    Width = 129
    Height = 23
    Caption = 'Remove Item'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 312
    Top = 376
    Width = 109
    Height = 23
    Caption = 'Order Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 312
    Top = 405
    Width = 49
    Height = 23
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object redtOrder: TRichEdit
    Left = 0
    Top = 0
    Width = 525
    Height = 361
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      
        'Item ID,  Item Name,   Amount Of Servings,  Price Per Serving,  ' +
        'Total Price,  Group ID')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object cbb1: TComboBox
    Left = 3
    Top = 405
    Width = 145
    Height = 21
    TabOrder = 1
    Text = 'cbb1'
  end
  object btnRemoveItem: TButton
    Left = 3
    Top = 432
    Width = 75
    Height = 21
    Caption = 'Remove Item'
    TabOrder = 2
    OnClick = btnRemoveItemClick
  end
  object btnClearOrder: TButton
    Left = 3
    Top = 463
    Width = 75
    Height = 21
    Caption = 'Clear Order'
    TabOrder = 3
    OnClick = btnClearOrderClick
  end
  object btnCheckOut: TButton
    Left = 312
    Top = 463
    Width = 75
    Height = 21
    Caption = 'Check Out'
    TabOrder = 4
  end
  object btnBackToH: TButton
    Left = 441
    Top = 463
    Width = 75
    Height = 21
    Caption = 'Back'
    TabOrder = 5
  end
end
