unit HomeButtons_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls;

type
  THomeButtons = class(TFrame)
    imgMain: TImage;
    imgStarter: TImage;
    imgDessert: TImage;
    imgDrink: TImage;
    imgSide: TImage;
    imgSettings: TImage;
    imgExit: TImage;
    imgOrder: TImage;
    imgLogOut: TImage;
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure THomeButtons.btnExitClick(Sender: TObject);
begin
  if Application.MessageBox('Are you sure you want to exit?', 'Warning',
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = IDYES
  then
  begin
    Halt;
  end;
end;
end.
