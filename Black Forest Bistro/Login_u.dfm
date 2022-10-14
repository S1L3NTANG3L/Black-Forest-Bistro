object LoginFrame: TLoginFrame
  Left = 0
  Top = 0
  Width = 314
  Height = 428
  TabOrder = 0
  object img1: TImage
    Left = 3
    Top = 3
    Width = 308
    Height = 222
  end
  object lbl1: TLabel
    Left = 96
    Top = 237
    Width = 81
    Height = 13
    Caption = 'Enter Username:'
  end
  object lbl2: TLabel
    Left = 96
    Top = 293
    Width = 79
    Height = 13
    Caption = 'Enter Password:'
  end
  object edtUserName: TEdit
    Left = 96
    Top = 256
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 96
    Top = 312
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnLogin: TButton
    Left = 115
    Top = 352
    Width = 75
    Height = 21
    Caption = 'Login'
    TabOrder = 2
  end
  object btnExit: TButton
    Left = 115
    Top = 400
    Width = 75
    Height = 21
    Caption = 'Exit'
    TabOrder = 3
    OnClick = btnExitClick
  end
end
