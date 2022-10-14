unit ManageExpenses_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,DataModule_u,BlackForest_u;

type
  TManageExpenses = class(TFrame)
    btnAddIngredient: TButton;
    btnBackToA: TButton;
    lbl1: TLabel;
    edtIngredientName: TEdit;
    lbl2: TLabel;
    edtIngredientAmount: TEdit;
    lbl3: TLabel;
    edtIngredientPrice: TEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtDrinkName: TEdit;
    edtAmountOfDrinks: TEdit;
    edtDrinkPrice: TEdit;
    btnAddDrink: TButton;
    lbl7: TLabel;
    edtAmountOfWater: TEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    edtPriceOfWater: TEdit;
    btnPayWater: TButton;
    lbl10: TLabel;
    lbl11: TLabel;
    edtAmountOfElectricity: TEdit;
    lbl12: TLabel;
    edtPriceOfElectricity: TEdit;
    btnPayElectricity: TButton;
    lbl13: TLabel;
    lbl14: TLabel;
    edtBonus: TEdit;
    lbl15: TLabel;
    btnPayEmployees: TButton;
    procedure btnAddIngredientClick(Sender: TObject);
    procedure btnPayWaterClick(Sender: TObject);
    procedure btnPayElectricityClick(Sender: TObject);
    procedure btnAddDrinkClick(Sender: TObject);
  private
    { Private declarations }
    Formula : TFormula;
    IngredientName : string;
    IngredientAmount :Integer;
    IngredientPrice : real;
    SuccessBoolean : Boolean;
    SuccessBooleanTwo : Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TManageExpenses.btnAddDrinkClick(Sender: TObject);
begin
  SuccessBoolean := False;
  SuccessBooleanTwo := False;
  if (edtDrinkName.text = '') or (edtAmountOfDrinks.text = '') or
     (edtDrinkPrice.text = '')
  then
  begin
    Application.MessageBox('Please make sure all information' +
    ' about the drink is added!',
    'Error', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
  end
  else
  begin
    SuccessBoolean := Formula.CheckIfDrinkExists(edtDrinkName.text);
    if SuccessBoolean then
    begin
      SuccessBooleanTwo := Formula.AddDrink(edtDrinkName.text,
      StrToInt(edtAmountOfDrinks.text),StrToFloat(edtDrinkPrice.text));
      Formula.PayDrink(edtDrinkName.text,StrToInt(edtAmountOfDrinks.text),
      StrToFloat(edtDrinkPrice.text));
      if SuccessBooleanTwo then
      begin
        Application.MessageBox('Stock successfully added!', 'Application.Title',
        MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
      end
      else
      begin
        Application.MessageBox('An error occurred while adding stock.', 'Error',
        MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
      end;
    end
    else
    begin
      Application.MessageBox('Error: Ingredient doesn''t exists.', 'Error',
      MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
    end;
  end;
  edtDrinkName.Clear;
  edtAmountOfDrinks.Clear;
  edtDrinkPrice.Clear;
end;

procedure TManageExpenses.btnAddIngredientClick(Sender: TObject);
begin
  SuccessBoolean := False;
  SuccessBooleanTwo := False;
  if (edtIngredientName.text = '') or (edtIngredientAmount.text = '') or
     (edtIngredientPrice.text = '')
  then
  begin
    Application.MessageBox('Please make sure all information' +
    ' about the ingredient is added!',
    'Error', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
  end
  else
  begin
    SuccessBoolean := Formula.CheckIfIngredientExists(IngredientName);
    if SuccessBoolean then
    begin
      SuccessBooleanTwo := Formula.AddStock(IngredientName,
      IngredientAmount,IngredientPrice);
      Formula.PayStock(IngredientName,IngredientAmount,
      IngredientPrice);
      if SuccessBooleanTwo then
      begin
        Application.MessageBox('Stock successfully added!', 'Application.Title',
        MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
      end
      else
      begin
        Application.MessageBox('An error occurred while adding stock.', 'Error',
        MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
      end;
    end
    else
    begin
      Application.MessageBox('Error: Ingredient doesn''t exists.', 'Error',
      MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
    end;
  end;
  edtIngredientName.Clear;
  edtIngredientAmount.Clear;
  edtIngredientPrice.Clear;
end;




procedure TManageExpenses.btnPayWaterClick(Sender: TObject);
begin
  if (edtAmountOfWater.text = '') or (edtPriceOfWater.text = '')then
  begin
    Application.MessageBox('Please make sure all information' +
    ' regarding payment of water is entered!',
    'Error', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
  end
  else
  begin
    Formula.PayWater(StrToFloat(edtAmountOfWater.text),
    StrToFloat(edtPriceOfWater.text));
  end;
  edtAmountOfWater.Clear;
  edtPriceOfWater.Clear;
end;

procedure TManageExpenses.btnPayElectricityClick(Sender: TObject);
begin
  if (edtAmountOfElectricity.text = '') or (edtPriceOfElectricity.text = '')then
  begin
    Application.MessageBox('Please make sure all information' +
    ' regarding payment of electricity is entered!',
    'Error', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
  end
  else
  begin
    Formula.PayElectricity(StrToFloat(edtAmountOfElectricity.text),
    StrToFloat(edtPriceOfElectricity.text));
  end;
  edtAmountOfElectricity.Clear;
  edtPriceOfElectricity.Clear;
end;
end.
