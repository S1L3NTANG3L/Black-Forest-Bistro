unit DataModule_u;

interface

uses
  SysUtils, Classes, DB, ADODB,Forms;

type
  TDataModule2 = class(TDataModule)
    adoconnection: TADOConnection;
    adoquery: TADOQuery;
    datasource: TDataSource;
    adoquerytwo: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(Address: widestring);
  end;

var
  DataModule2: TDataModule2;


implementation

{$R *.dfm}

{ TDataModule2 }

constructor TDataModule2.Create(Address: widestring);
begin
  with adoconnection do
  begin
    ConnectionString :='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='
                            + Address
                            + 'BlackForestDatabase.mdb;' +
                            'Persist Security Info = FALSE;';
    LoginPrompt := FALSE;
    Open;
  end;
  adoquery.Connection := adoconnection;
  adoquerytwo.Connection := adoconnection;
end;

end.
