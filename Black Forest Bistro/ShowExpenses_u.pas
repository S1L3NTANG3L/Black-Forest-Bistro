unit ShowExpenses_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TShowExpenses = class(TFrame)
    btnBackToA: TButton;
    dbgrdExpenses: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
