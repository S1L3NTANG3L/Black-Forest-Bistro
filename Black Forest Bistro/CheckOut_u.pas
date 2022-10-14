unit CheckOut_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls,DataModule_u,BlackForest_u;

type
  TCheckOut = class(TFrame)
    lbl1: TLabel;
    lbl2: TLabel;
    edtCustomerAmount: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    cbbTable: TComboBox;
    btnPay: TButton;
    btnBackToO: TButton;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
