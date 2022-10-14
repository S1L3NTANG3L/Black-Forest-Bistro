unit Login_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, ExtCtrls,DataModule_u,BlackForest_u;

type
  TLoginFrame = class(TFrame)
    img1: TImage;
    edtUserName: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}



procedure TLoginFrame.btnExitClick(Sender: TObject);
begin
  if Application.MessageBox('Are you sure you want to exit?', 'Warning',
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = IDYES
  then
  begin
    Halt;
  end;
end;
end.
