unit ManageEmployees_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, DBGrids,DataModule_u,BlackForest_u, Data.DB;

type
  TManageEmployees = class(TFrame)
    dbgrdEmployees: TDBGrid;
    lbl1: TLabel;
    edtSearch: TEdit;
    btnSearch: TButton;
    btnShowAll: TButton;
    btnShowResigned: TButton;
    lbl2: TLabel;
    edtName: TEdit;
    edtSurname: TEdit;
    edtIDNumber: TEdit;
    edtSalary: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    edtAddress: TEdit;
    cbbJobType: TComboBox;
    lbl11: TLabel;
    edtPassword: TEdit;
    lbl12: TLabel;
    lbl13: TLabel;
    edtFireName: TEdit;
    lbl14: TLabel;
    edtFireSurname: TEdit;
    lbl15: TLabel;
    edtFireIDNumber: TEdit;
    btnAdd: TButton;
    btnFire: TButton;
    lbl16: TLabel;
    cbbCountry: TComboBox;
    cbbCity: TComboBox;
    btnShowCurrent: TButton;
    btnBackToA: TButton;
    procedure btnSearchClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnShowResignedClick(Sender: TObject);
    procedure btnShowAllClick(Sender: TObject);
    procedure btnFireClick(Sender: TObject);
    procedure btnShowCurrentClick(Sender: TObject);
  private
    { Private declarations }
    Formula : TFormula;
    Details : array[0..8] of string;
    SuccessBoolean : Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TManageEmployees.btnShowResignedClick(Sender: TObject);
begin
  Formula.ShowResignedEmployees(dbgrdEmployees);
end;

procedure TManageEmployees.btnShowAllClick(Sender: TObject);
begin
  Formula.ShowAllEmployees(dbgrdEmployees);
end;

procedure TManageEmployees.btnShowCurrentClick(Sender: TObject);
begin
  Formula.ShowCurrentEmployees(dbgrdEmployees);
end;

procedure TManageEmployees.btnSearchClick(Sender: TObject);
begin
  SuccessBoolean := False;
  if (edtSearch.Text = 'Employee Name') or (edtSearch.Text = '')  then
  begin
    Application.MessageBox('Please enter an employee name!', 'Error', MB_OK +
    MB_ICONSTOP + MB_DEFBUTTON2);
  end
  else
  begin
    SuccessBoolean := Formula.SearchEmployees(edtSearch.Text,dbgrdEmployees);
    if not SuccessBoolean then
    begin
      Application.MessageBox('No record of any employee with the name !',
       'Error', MB_OK +
      MB_ICONSTOP + MB_DEFBUTTON2);
    end;
  end;
  edtSearch.Clear;
end;

procedure TManageEmployees.btnFireClick(Sender: TObject);
begin
  if    (edtFireName.Text = '')     or (edtFireSurname.Text = '')
     or (edtFireIDNumber.Text = '')
  then
  begin
    Application.MessageBox('Please enter all details requested!', 'Error', MB_OK +
    MB_ICONSTOP + MB_DEFBUTTON2);
  end
  else
  begin
    SuccessBoolean := False;
    SuccessBoolean := Formula.FireEmployee(edtFireName.Text, edtFireSurname.Text,
    StrToInt(edtFireIDNumber.Text));
    if not SuccessBoolean then
    begin
      Application.MessageBox('No record of any employee with the name!',
       'Error', MB_OK +
      MB_ICONSTOP + MB_DEFBUTTON2);
    end;
  end;

end;

procedure TManageEmployees.btnAddClick(Sender: TObject);
begin
  if    (edtName.Text = '')     or (cbbCity.Text = '')
     or (edtSurname.Text = '')  or (edtAddress.Text = '')
     or (edtIDNumber.Text = '') or (cbbJobType.Text = '')
     or (cbbCountry.Text = '')  or (edtSalary.Text = '')
     or (edtPassword.Text = '')
  then
  begin
    Application.MessageBox('Please enter all details requested!', 'Error', MB_OK +
    MB_ICONSTOP + MB_DEFBUTTON2);
  end
  else
  begin
    Details[0] := edtName.Text;
    Details[1] := edtSurname.Text;
    Details[2] := edtIDNumber.Text;
    Details[3] := cbbCountry.Text;
    Details[4] := cbbCity.Text;
    Details[5] := edtAddress.Text;
    Details[6] := cbbJobType.Text;
    Details[7] := edtSalary.Text;
    Details[8] := edtPassword.Text;
    SuccessBoolean := False;
    SuccessBoolean := Formula.AddEmployee(Details);
    if not SuccessBoolean then
    begin
      Application.MessageBox('Record of an employee with the given name '+
      'already exists!', 'Error', MB_OK +
      MB_ICONSTOP + MB_DEFBUTTON2);
    end;
  end;
end;
end.
