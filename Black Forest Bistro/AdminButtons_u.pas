unit AdminButtons_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls;

type
  TAdminButtons = class(TFrame)
    imgManageEmployees: TImage;
    imgManageExpenses: TImage;
    imgChangeVaribles: TImage;
    imgShowProfitCurve: TImage;
    imgShowLedger: TImage;
    imgBackToH: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
