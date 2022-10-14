program BlackForestBistro_p;

uses
  Forms,
  MainForm_u in 'MainForm_u.pas' {BlackForestBistro},
  Login_u in 'Login_u.pas' {LoginFrame: TFrame},
  BlackForest_u in 'BlackForest_u.pas',
  Order_u in 'Order_u.pas' {OrderFrame: TFrame},
  CheckOut_u in 'CheckOut_u.pas' {CheckOut: TFrame},
  ManageExpenses_u in 'ManageExpenses_u.pas' {ManageExpenses: TFrame},
  ManageEmployees_u in 'ManageEmployees_u.pas' {ManageEmployees: TFrame},
  ChangeVaribles_u in 'ChangeVaribles_u.pas' {ChangeVaribles: TFrame},
  ProfitCurve_u in 'ProfitCurve_u.pas' {ProfitCurve: TFrame},
  MainMenu_u in 'MainMenu_u.pas' {MainMenus: TFrame},
  StarterMenu_u in 'StarterMenu_u.pas' {StarterMenu: TFrame},
  SideMenu_u in 'SideMenu_u.pas' {SideMenu: TFrame},
  DrinkMenu_u in 'DrinkMenu_u.pas' {DrinkMenu: TFrame},
  DessertMenu_u in 'DessertMenu_u.pas' {DessertMenu: TFrame},
  HomeButtons_u in 'HomeButtons_u.pas' {HomeButtons: TFrame},
  AdminButtons_u in 'AdminButtons_u.pas' {AdminButtons: TFrame},
  Ledger_u in 'Ledger_u.pas' {Ledger: TFrame},
  DataModule_u in 'DataModule_u.pas' {DataModule2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TBlackForestBistro, BlackForestBistro);
  Application.Run;
end.
