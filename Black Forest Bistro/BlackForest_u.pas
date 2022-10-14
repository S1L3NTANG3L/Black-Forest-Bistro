unit BlackForest_u;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,ADODB,ComObj,DB,StdCtrls,jpeg,ObjectArray,ComCtrls,DBGrids
  , pngimage,DataModule_u;

type
  TFormula = class(TObject)
  procedure     InsertTransactionDetails(Details: Array of string;BoughtID : Integer);
  procedure     RemoveUsedInventory(ItemID, GroupID, Servings: Integer);
  function      AddTransactionToLedger(BoughtID,Table: Integer; Price
                ,AmountPaid: Real):Integer;
  private
  { Private declarations }
  public
  { Public declarations }
    constructor Create(Dummy : Integer);
    procedure   RetrieveEmployeeJob(EmployeeJ: String);
    procedure   RetrieveEmployeeIDNumber(EmployeeN: Integer);
    procedure   ChangeProfitRange(NewProfitRange: Real);
    procedure   ChangeVatRange(NewVatRange: Real);
    procedure   RetrieveImageLocations;
    procedure   RetrieveStoredVaribles;
    procedure   RetrieveRecipeNames;
    procedure   RetrieveRecipeIDs;
    procedure   RetrieveRecipeServings;
    procedure   CalculateRecipePrices;
    procedure   RetrieveDrinkNames;
    procedure   RetrieveDrinkIDs;
    procedure   ViewOrder(RichEdit:TRichEdit; ComboBox: TComboBox);
    procedure   CheckOut(AmountPaid: Real; Table: Integer);
    procedure   CalculateDrinkPrices;
    procedure   ShowAllEmployees(dbGrid : TDBGrid);
    procedure   ShowCurrentEmployees(dbGrid : TDBGrid);
    procedure   ShowResignedEmployees(dbGrid : TDBGrid);
    procedure   PayEmployees(Bonus: Integer);
    procedure   PayStock(Name: String; Amount: Integer; Price: Real);
    procedure   PayDrink(Name: String; Amount: Integer; Price: Real);
    procedure   PayWater(Amount,Total: Real);
    procedure   PayElectricity(Amount,Total: Real);
    procedure   ResetBillTotal;
    procedure   ShowLedger(dbGrid : TDBGrid);
    procedure   ShowIncome(dbGrid : TDBGrid);
    procedure   ShowExpenses(dbGrid : TDBGrid);
    procedure   ShowTransactionHistory(dbGrid : TDBGrid);
    function    AddEmployee(Details : Array of String): Boolean;
    function    FireEmployee(EmployeeName, EmployeeSurname: String;
                EmployeeIDNumber: Integer): Boolean;
    function    AddStock(IngredientName: String; Amount, Price: Real):Boolean;
    function    AddDrink(DrinkName: String; Amount, Price: Real):Boolean;
    function    RemoveItemFromOrder(ItemNumber: Integer):Boolean;
    function    RemoveAllFromOrder:Boolean;
    function    GetRecipeNames(Group,Number : Integer): String;
    function    GetRecipeServing(Group,Number : Integer):Integer;
    function    GetRecipePrices(Group,Number : Integer): Real;
    function    GetDrinkNames(Number : Integer):String;
    function    GetDrinkPrices(Number : Integer): Real;
    function    GetApplicationAddress: WideString;
    function    GetLoginImageLocation: Widestring;
    function    GetSplashImageLocation: Widestring;
    function    GetRecipeImageLocations(MenuNumber,ImageNumber : Integer)
                : Widestring;
    function    GetHomeButtonImageLoacations(ImageNumber: Integer): Widestring;
    function    GetAdminButtonImageLoacations(ImageNumber: Integer): Widestring;
    function    GetBillTotal: String;
    function    CheckIfIngredientExists(IngredientName : String): Boolean;
    function    CheckIfDrinkExists(DrinkNames : String): Boolean;
    function    AddRecipeToOrder(RecipeGroup,RecipeNumber,
                AmountOrdered: Integer):Boolean;
    function    AddDrinkToOrder(DrinkNumber , AmountOrdered: Integer):Boolean;
    function    SearchEmployees(EmployeeName : String;dbGrid : TDBGrid): Boolean;
    function    CheckStock(Group,Number: Integer): Boolean;
    function    CheckDrinks(Number : Integer): Boolean;
    function    GetEmployeeJob:String;


end;

var
    // Array[0..3] 0 = Main 1 = Starters 2 = Desserts 3 = Sides
    MenuImageAddress   : array[0..4,0..14] of WideString;
    RecipeName         : array[0..3,0..14] of string;
    RecipeID           : array[0..3,0..14] of Integer;
    RecipeServings     : array[0..3,0..14] of Integer;
    RecipePrice        : array[0..3,0..14] of Real;
    DrinkName          : array[0..14] of string;
    DrinkID            : array[0..14] of Integer;
    DrinkPrice         : array[0..14] of Real;
    TempArray          : array[0..5] of string;
    HButtonImageAddress: array[0..8] of widestring;
    AButtonImageAddress: array[0..5] of widestring;
    TempAmount         : array of real;
    TempAmount2        : array of Integer;
    TempIngredientID   : array of Integer;
    TempIntegerArray   : array of integer;
    SplashImageAddress : WideString;
    LoginImageAddress  : WideString;
    ApplicationAddress : Widestring;
    FieldOne           : TField;
    FieldTwo           : TField;
    FieldThree         : TField;
    TempString         : string;
    TempStringTwo      : string;
    EmployeeJob        : String;
    TempNumberOne      : Real;
    TempNumberTwo      : Real;
    TempNumberThree    : Real;
    Vat, Profit        : Real;
    CustomerTotal      : Real;
    I, Counter         : Integer;
    ITwo,CounterTwo    : Integer;
    BoughtID           : Integer;
    TempInteger        : Integer;
    TempIntegerTwo     : Integer;
    TempRecipeID       : Integer;
    TempGroupID        : Integer;
    TempDrinkAmount    : Integer;
    EmployeeNumber     : Integer;
    TempBoolean        : Boolean;
    tfFile             : TextFile;
    vDummy             : Integer;
implementation

{ TFormula }

//Removes All Items From Temp Order CSV TextFile And **Need to Do Updates Customer Total
function TFormula.RemoveAllFromOrder:Boolean;
begin
  try
    AssignFile(tfFile, 'Order.txt');
    Rewrite(tfFile);
    CloseFile(tfFile);
  except
    Result := False;
  end;
  Result := True;
  CustomerTotal := 0;
end;

//Removes Selected Items From Temp Order CSV TextFile And Updates Customer Total
//Item Number Comes From ComboBox Items Calculated In The View Order Procedure
function TFormula.RemoveItemFromOrder(ItemNumber: Integer):Boolean;
begin
  try
    TempInteger := ItemNumber;
    AssignFile(tfFile, 'Order.txt');
    Reset(tfFile);
    for I := 1 to TempInteger -1 do
    begin
      ReadLn(tfFile);
    end;
    ReadLn(tfFile,TempString);
    while TempString <> '' do
    begin
      Counter := pos(',', TempString);
      if Counter = 0 then
      begin
        Counter := MaxInt;
      end;
      TempStringTwo := copy(TempString, 1, Counter-1);
      Delete(TempString, 1, Counter);
      TempArray[I] := TempStringTwo;
      inc(I);
    end;
    Delete(Tempstring,1,Length(TempString));
    CloseFile(tfFile);
  except
    Result := False;
  end;
  Result := True;
  CustomerTotal := CustomerTotal - StrToFloat(TempArray[4]);
end;

//Retrieves Drink IDs From DataBase For Later Use
procedure TFormula.RetrieveDrinkIDs;
begin
  I := 0;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('SELECT * FROM Drinks');
  DataModule2.adoquery.open;
  FieldOne := DataModule2.adoquery.FieldByName('Drink_ID');
  DataModule2.adoquery.Open;
  while not DataModule2.adoquery.eof do
  begin
    DrinkID[I] := FieldOne.AsInteger;
    DataModule2.adoquery.Next;
    inc(I);
  end;
end;

//Retrieves Drink Names From DataBase For Later Use
procedure TFormula.RetrieveDrinkNames;
begin
  I := 0;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('SELECT * FROM Drinks');
  DataModule2.adoquery.open;
  FieldOne := DataModule2.adoquery.FieldByName('Drink_Name');
  DataModule2.adoquery.Open;
  while not DataModule2.adoquery.eof do
  begin
    DrinkName[I] := FieldOne.AsString;
    DataModule2.adoquery.Next;
    inc(I);
  end;
end;

procedure TFormula.RetrieveEmployeeIDNumber(EmployeeN: Integer);
begin
  EmployeeNumber := EmployeeN;
end;

procedure TFormula.RetrieveEmployeeJob(EmployeeJ: String);
begin
  EmployeeJob := EmployeeJ;
end;

//Retrieves Locations Of Images And Stores Them In An Array And Two Widestring
//Varibles
procedure TFormula.RetrieveImageLocations;
begin
  ApplicationAddress := ExtractFilePath(Application.ExeName);
  for Counter := 0 to 4 do
  begin
    if Counter = 0 then
    begin
      TempString := 'Main';
    end
    else
    if Counter = 1 then
    begin
      TempString := 'Starters';
    end
    else
    if Counter = 2 then
    begin
      TempString := 'Desserts';
    end
    else
    if Counter = 3 then
    begin
      TempString := 'Sides';
    end
    else
    begin
      TempString := 'Drinks';
    end;
    for I := 0 to 14 do
    begin
      MenuImageAddress[Counter,I] := ApplicationAddress
      + '\Pictures\Menus\'+ TempString
      + '\Img' + IntToStr(i + 1) + '.jpg';
    end;
  end;
  SplashImageAddress := ApplicationAddress + '\Pictures\Other\Splash.jpg';
  LoginImageAddress := ApplicationAddress + '\Pictures\Other\Login.jpg';
  for I := 0 to 8 do
  begin
    HButtonImageAddress[I] := ApplicationAddress
    + '\Pictures\Other\Home\img' + IntToStr(i + 1) + '.png';
  end;
  for I := 0 to 5 do
  begin
    AButtonImageAddress[I] := ApplicationAddress
    + '\Pictures\Other\Admin\img' + IntToStr(i + 1) + '.png';
  end;
end;

//Adds Ordered Drink To Temp CSV TextFile For Use At CheckOut
function TFormula.AddDrinkToOrder(DrinkNumber, AmountOrdered : Integer):Boolean;
begin
  try
    TempNumberTwo := DrinkPrice[DrinkNumber -1] * AmountOrdered;
    CustomerTotal := CustomerTotal + TempNumberTwo;
    TempString := (IntToStr(DrinkID[DrinkNumber -1])//ItemID
    + ','
    + DrinkName[DrinkNumber -1]//ItemName
    + ','
    + IntToStr(AmountOrdered)//AmountOfServings
    + ','
    + FloatToStrF(DrinkPrice[DrinkNumber -1],ffCurrency,9,2)//PricePerServing
    + ','
    + FloatToStrF(TempNumberTwo,ffCurrency,9,2)//TotalPrice
    + ','
    + '2'); //Item Type 1 = Food 2 = Drinks
    AssignFile(tfFile, 'Order.txt');
    Append(tfFile);
    Writeln(tfFile,TempString);
    CloseFile(tfFile);
  Except
    result := False;
  end;
  result := True;
end;

//Adds Ordered Recipe To Temp CSV TextFile For Use At CheckOut
function TFormula.AddRecipeToOrder(RecipeGroup, RecipeNumber,
  AmountOrdered: Integer):Boolean;
begin
  Try
    TempNumberThree := RecipePrice[RecipeGroup,RecipeNumber -1] * AmountOrdered;
    CustomerTotal := CustomerTotal + TempNumberThree;
    TempString := (IntToStr(RecipeID[RecipeGroup,RecipeNumber -1])//ItemID
    + ','
    + RecipeName[RecipeGroup,RecipeNumber -1]//ItemName
    + ','
    + IntToStr(AmountOrdered)//AmountOfServings
    + ','
    + FloatToStrF(RecipePrice[RecipeGroup,RecipeNumber -1],ffCurrency,9,2)
    + ','        //PricePerServing^
    + FloatToStrF(TempNumberThree,ffCurrency,9,2)//TotalPrice
    + ','
    + '1'); //Item Type 1 = Food 2 = Drinks
    AssignFile(tfFile, 'Order.txt');
    Append(tfFile);
    Writeln(tfFile,TempString);
    CloseFile(tfFile);
  Except
    result := False;
  End;
  result := True;
end;

//Calculates Individual Drink Prices And Stores Them In A Array For Later Use
procedure TFormula.CalculateDrinkPrices;
begin
  I := 0;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('SELECT * FROM [Drinks]');
  DataModule2.adoquery.Open;
  FieldOne := DataModule2.adoquery.FieldByName('Price');
  while not DataModule2.adoquery.eof do
  begin
    DrinkPrice[I] := FieldOne.AsFloat;
    DrinkPrice[I] := (DrinkPrice[I] * vat);
    DrinkPrice[I] := (DrinkPrice[I] * profit);
    DataModule2.adoquery.Next;
    inc(I);
  end;
end;

//Retrieves Individual Recipe IDs For Later Use And Stores Them In A 2D Array
procedure TFormula.RetrieveRecipeIDs;
{var
  recordset : _Recordset;}
  var
  FieldOne: TField;
begin
  for Counter := 0 to 3 do
  begin
    for I := 0 to 14 do
    begin
      DataModule2.adoquery.Close;
      DataModule2.adoquery.SQL.Clear;
      DataModule2.adoquery.SQL.Add('SELECT [Recipe_ID] FROM [Recipe_List]');
      DataModule2.adoquery.SQL.Add('WHERE [Group_ID] = :A');
      DataModule2.adoquery.Parameters.Items[0].Value := Counter + 1;
      DataModule2.adoquery.Open;
      FieldOne := DataModule2.adoquery.FieldByName('Recipe_ID');
      RecipeID[Counter,I] := FieldOne.AsInteger;
      DataModule2.adoquery.Next;
    end;
  end;
end;

//Retrieves Individual Recipe Names And Stores Them In A 2D Array
procedure TFormula.RetrieveRecipeNames;
begin
  for Counter := 0 to 3 do
  begin
    for I := 0 to 14 do
    begin
      DataModule2.adoquery.Close;
      DataModule2.adoquery.SQL.Clear;
      DataModule2.adoquery.SQL.Add('SELECT [Recipe_Name] FROM [Recipe_List]');
      DataModule2.adoquery.SQL.Add('WHERE [Recipe_ID] = :A');
      DataModule2.adoquery.Parameters.Items[0].Value := RecipeId[Counter,I];
      DataModule2.adoquery.Open;
      FieldOne := DataModule2.adoquery.FieldByName('Recipe_Name');
      RecipeName[Counter,I] := FieldOne.AsString;
      DataModule2.adoquery.Next;
    end;
  end;
end;

//Calculates Individual Recipe Prices And Stores Them In A 2D Array
procedure TFormula.CalculateRecipePrices;
begin
  for Counter := 0 to 3 do
  begin
    for I := 0 to 14 do
    begin
      TempNumberOne := 0;
      CounterTwo := 0;
      DataModule2.adoquery.SQL.Clear;
      DataModule2.adoquery.SQL.Add('SELECT [Amount],[Ingredient_ID]');
      DataModule2.adoquery.SQL.Add(' FROM [Recipe_Ingredients]');
      DataModule2.adoquery.SQL.Add('WHERE [Recipe_ID] = :A');
      DataModule2.adoquery.Parameters.Items[0].Value := RecipeId[Counter,I];
      DataModule2.adoquery.Open;
      DataModule2.adoquery.First;
      FieldOne := DataModule2.adoquery.FieldByName('Amount');
      FieldTwo := DataModule2.adoquery.FieldByName('Ingredient_ID');
      TempInteger := DataModule2.adoquery.RecordCount;
      SetLength(TempIngredientID,TempInteger-1);
      SetLength(TempAmount2,TempInteger-1);
      while not DataModule2.adoquery.eof do
      begin
        TempAmount2[CounterTwo] := FieldOne.AsInteger;
        TempIngredientID[CounterTwo] := FieldTwo.AsInteger;
        Inc(CounterTwo);
        DataModule2.adoquery.Next;
      end;
      for CounterTwo := 0 to TempInteger -1 do
      begin
        DataModule2.adoquery.SQL.Clear;
        DataModule2.adoquery.SQL.Add('SELECT [Price_Per_Amount]');
        DataModule2.adoquery.SQL.Add('FROM [Stock]');
        DataModule2.adoquery.SQL.Add('WHERE [Ingredient_ID] = :A');
        DataModule2.adoquery.Parameters.Items[0].Value :=
        TempIngredientID[CounterTwo];
        DataModule2.adoquery.Open;
        FieldThree := DataModule2.adoquery.FieldByName('Price_Per_Amount');
        TempNumberOne := TempNumberOne +
        (TempAmount2[CounterTwo] * FieldThree.AsFloat);
      end;
      RecipePrice[Counter,I] := ((TempNumberOne * Vat * Profit)
                                 / RecipeServings[Counter,I]);
    end;
  end;
end;

//Changes The Profit Range Varible That Is Stored Extrenally
procedure TFormula.ChangeProfitRange(NewProfitRange: Real);
begin
  Profit := (NewProfitRange / 100) + 1;
  AssignFile(tfFile, 'StoredVaribles.txt');
  ReWrite(tfFile);
  Writeln(Vat);
  Writeln(Profit);
  CloseFile(tfFile);
end;

//Changes The Vat Varible That Is Stored Extrenally
procedure TFormula.ChangeVatRange(NewVatRange: Real);
begin
  Vat := (NewVatRange / 100) + 1;
  AssignFile(tfFile, 'StoredVaribles.txt');
  ReWrite(tfFile);
  Writeln(Vat);
  Writeln(Profit);
  CloseFile(tfFile);
end;

//Provides The Applications Address For Initiating The Database Connection
function TFormula.GetAdminButtonImageLoacations(
  ImageNumber: Integer): Widestring;
begin
  result := AButtonImageAddress[ImageNumber -1];
end;

function TFormula.GetApplicationAddress: WideString;
begin
  result := ExtractFilePath(Application.ExeName);
end;

//Provides The Customers Current Total Bill Amount
function TFormula.GetBillTotal: String;
begin
  result := FloatToStrF(CustomerTotal,ffCurrency,9,2);
end;

//Provides Drink Names For Display On Menus
function TFormula.GetDrinkNames(Number : Integer):String;
begin
  result := DrinkName[Number];
end;

//Provides Drink Prices For Display On Menus
function TFormula.GetDrinkPrices(Number : Integer): Real;
begin
  result := DrinkPrice[Number];
end;

function TFormula.GetEmployeeJob: String;
begin
  result := EmployeeJob;
end;

function TFormula.GetHomeButtonImageLoacations(
  ImageNumber: Integer): Widestring;
begin
  result := HButtonImageAddress[ImageNumber -1];
end;

//Provides the Location Of The Login Images Previously Sourced.
function TFormula.GetLoginImageLocation: Widestring;
begin
  result := LoginImageAddress;
end;

//Provides the Location Of Menu Images Previously Sourced.
function TFormula.GetRecipeImageLocations(MenuNumber, ImageNumber: Integer)
: Widestring;
begin
  result := MenuImageAddress[MenuNumber,ImageNumber];
end;

//Provides Recipe Names For Display On Menus
function TFormula.GetRecipeNames(Group,Number: Integer): String;
begin
  result := RecipeName[Group,Number];
end;

//Provides Recipe Prices(Per Serving) For Display On Menus
function TFormula.GetRecipePrices(Group,Number : Integer): Real;
begin
  result := RecipePrice[Group,Number];
end;

//Provides Recipe Servings For Display On Menus
function TFormula.GetRecipeServing(Group,Number : Integer):Integer;
begin
  result := RecipeServings[Group,Number];
end;

//Provides the Location Of the splash screen image previously gotten.
function TFormula.GetSplashImageLocation: Widestring;
begin
  result := SplashImageAddress;
end;

//Add Transactions From Order TextFile To Transaction Details Table
procedure TFormula.InsertTransactionDetails(Details: array of string;
    BoughtID : Integer);
begin
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('INSERT INTO [Transaction_Details]');
  DataModule2.adoquery.SQL.Add('([Bought_ID],[Recipe_ID],[Recipe_Name]');
  DataModule2.adoquery.SQL.Add(',[Amount_Of_Servings],[Price_Per_Servings],[Price])');
  DataModule2.adoquery.SQL.Add('Values (:[Bought_ID], :[Recipe_ID] ,:[Recipe_Name]');
  DataModule2.adoquery.SQL.Add(', :[Amount_Of_Servings], :[Price_Per_Servings], :[Price])');
  DataModule2.adoquery.Parameters.ParamByName('[Bought_ID]').Value := BoughtID ;
  DataModule2.adoquery.Parameters.ParamByName('[Item_ID]').Value := Details[0];
  DataModule2.adoquery.Parameters.ParamByName('[Recipe_Name]').Value := Details[1];
  DataModule2.adoquery.Parameters.ParamByName('[Amount_Of_Servings]').Value := Details[2];
  DataModule2.adoquery.Parameters.ParamByName('[Price_Per_Servings]').Value := Details[3];
  DataModule2.adoquery.Parameters.ParamByName('[Price]').Value := Details[4];
  DataModule2.adoquery.ExecSQL;
end;

//Remove Used Ingredients From Inventory
procedure TFormula.RemoveUsedInventory(ItemID, GroupID, Servings: Integer);
begin
  if GroupID = 1 then
  begin
    I := 0;
    TempIntegerTwo := 0;
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('SELECT [Servings] FROM [Recipe]');
    DataModule2.adoquery.SQL.Add('WHERE [Recipe_ID] =''' + IntToStr(ItemID) + '''');
    FieldOne := DataModule2.adoquery.FieldByName('Servings');
    TempInteger := FieldOne.AsInteger;
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('SELECT [Amount],[Ingredient_ID]');
    DataModule2.adoquery.SQL.Add(' FROM [Recipe_Ingredients]');
    DataModule2.adoquery.SQL.Add('WHERE [Recipe_ID] =''' + IntToStr(ItemID) + '''');
    SetLength(TempAmount,DataModule2.adoquery.FieldCount);
    SetLength(TempIngredientID,DataModule2.adoquery.FieldCount);
    while not DataModule2.adoquery.eof do
    begin
      FieldOne := DataModule2.adoquery.FieldByName('Amount');
      TempAmount[I] := ((FieldOne.AsInteger / TempInteger) * Servings);
      FieldTwo := DataModule2.adoquery.FieldByName('Ingredient_ID');
      TempIngredientID[I] := FieldTwo.AsInteger;
      inc(I);
      inc(TempIntegerTwo);
      DataModule2.adoquery.Next;
    end;
    for I := 0 to TempIntegerTwo do
    begin
      DataModule2.adoquery.SQL.Clear;
      DataModule2.adoquery.SQL.Add('UPDATE [Ingredients]');
      DataModule2.adoquery.SQL.Add('Set [Amount] =''' +
      FloatToStrF(TempAmount[I],ffFixed,9,2) + '''');
      DataModule2.adoquery.SQL.Add('WHERE [Ingredient_ID] =''' +
      IntToStr(TempIngredientID[I]) + '''');
      DataModule2.adoquery.ExecSQL;
    end;
  end
  else
  begin
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('SELECT [Amount] FROM [Drinks]');
    DataModule2.adoquery.SQL.Add('WHERE [Drink_ID] =''' + IntToStr(ItemID) + '''');
    FieldTwo := DataModule2.adoquery.FieldByName('Amount');
    TempNumberOne := FieldTwo.AsFloat - Servings;
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('UPDATE [Drinks]');
    DataModule2.adoquery.SQL.Add('Set [Amount] =''' + FloatToStr(TempNumberOne) + '''');
    DataModule2.adoquery.SQL.Add('WHERE [Drink_ID] =''' + IntToStr(ItemID) + '''');
  end;
end;

procedure TFormula.ResetBillTotal;
begin
  CustomerTotal := 0;
end;

//Based ID is created for order and used to insert the orders details into the
//database. Inventory used in the production of recipes and ordered drinks are
//removed from the stock lists.
//Difference in Amount Payed And Bill Total is added to waiters total tip.
//Total Tip is reset begining of the month when it ans salaries are payed.
procedure TFormula.CheckOut(AmountPaid: Real; Table: Integer);
begin
  try
    //Sub Function
    BoughtID := AddTransactionToLedger(BoughtID,Table,CustomerTotal,AmountPaid);
    //UpdateEmployeeTipCount
    //Assign Order TextFile
    AssignFile(tfFile, 'Order.txt');
    Reset(tfFile);
    while not eof(tfFile) do
    begin
      I := 0;
      ReadLn(tfFile, TempString);
      while TempString <> '' do
      begin
        Counter := pos(',', TempString);
        if Counter = 0 then
        begin
          Counter := MaxInt;
        end;
        TempStringTwo := copy(TempString, 1, Counter-1);
        delete(TempString, 1, Counter);
        TempArray[I] := TempStringTwo;
        inc(I);
      end;
      TempRecipeID := StrToInt(TempArray[0]);
      TempGroupID := StrToInt(TempArray[5]);
      TempDrinkAmount := StrToInt(TempArray[2]);
      //Sub Procedures
      InsertTransactionDetails(TempArray,BoughtID);
      RemoveUsedInventory(TempRecipeID,TempGroupID,TempDrinkAmount);
      CustomerTotal := 0;
    end;
    CloseFile(tfFile);
    Showmessage('Transaction SuccessFul');
  except
    Showmessage('Transaction Failed');
  end;
end;

//Add new transaction to ledger
function TFormula.AddTransactionToLedger(BoughtID,Table: Integer; Price,AmountPaid: Real):Integer;
begin
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('INSERT INTO [Ledger]');
  DataModule2.adoquery.SQL.Add('([Employee_ID],[Type_Of_Transaction]');
  DataModule2.adoquery.SQL.Add(',[Income_/_Expense],[Amount]');
  DataModule2.adoquery.SQL.Add(',[Total], [Transaction_Date], :[Amount_Paid],:[Table])');
  DataModule2.adoquery.SQL.Add('Values (:[Employee_ID], :[Type_Of_Transaction]');
  DataModule2.adoquery.SQL.Add(',:[Income_/_Expense], :[Amount], :[Amount_Paid],:[Table]');
  DataModule2.adoquery.SQL.Add(',:[Total], :[Date])');
  DataModule2.adoquery.Parameters.ParamByName('[Employee_ID]').Value := EmployeeNumber;
  DataModule2.adoquery.Parameters.ParamByName('[Type_Of_Transaction]').Value :=
  'Order ' + IntToStr(BoughtID);
  DataModule2.adoquery.Parameters.ParamByName('[Income_/_Expense]').Value := 'Income';
  DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value := '0' ;
  DataModule2.adoquery.Parameters.ParamByName('[Total]').Value := Price ;
  DataModule2.adoquery.Parameters.ParamByName('[Date]').Value :=
    sysutils.DateToStr(sysutils.Date);
  DataModule2.adoquery.Parameters.ParamByName('[Amount_Paid]').Value := AmountPaid ;
  DataModule2.adoquery.Parameters.ParamByName('[Table]').Value := Table;
  DataModule2.adoquery.ExecSQL;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('SELECT [Bought_ID] FROM [Transaction_History]');
  DataModule2.adoquery.SQL.Add('WHERE [Employee_Number] =''' + IntToStr(EmployeeNumber) +
   ''' AND [Amount_Paid] =''' + FloatToStr(AmountPaid) +
   ''' AND [Total_Amount] =''' + FloatToStr(CustomerTotal) + ''' ');
  FieldOne := DataModule2.adoquery.FieldByName('Bought_ID');
  result := FieldOne.AsInteger;
end;

//Retrieve Recipe Servings For Later Calculations From Database
procedure TFormula.RetrieveRecipeServings;
begin
  for Counter := 0 to 3 do
  begin
    for I := 0 to 14 do
    begin
      DataModule2.adoquery.SQL.Clear;
      DataModule2.adoquery.SQL.Add('SELECT [Servings] FROM [Recipe_List]');
      DataModule2.adoquery.SQL.Add('WHERE [Recipe_ID] = :A');
      DataModule2.adoquery.Parameters.Items[0].Value := RecipeId[Counter,I];
      DataModule2.adoquery.Open;
      FieldOne := DataModule2.adoquery.FieldByName('Servings');
      RecipeServings[Counter,I] := FieldOne.AsInteger;
    end;
  end;
end;

//Retrieves Varibles Needed For Calculations Not Stored In Delphi From TextFile
procedure TFormula.RetrieveStoredVaribles;
begin
  AssignFile(tfFile, 'StoredVaribles.txt');
  Reset(tfFile);
  ReadLn(tfFile, TempString);
  Vat := StrToFloat(copy(TempString, 1, 4));
  ReadLn(tfFile, TempString);
  Profit := StrToFloat(copy(TempString, 1, 4));
  CloseFile(tfFile);
end;

//Retrieves Order From TextFile And Displays It In A Rich Edit And Adds Items To
//A ComboBox For Later Use
procedure TFormula.ViewOrder(RichEdit: TRichEdit;ComboBox : TComboBox);
begin
  Counter := 0;
  AssignFile(tfFile, 'Order.txt');
  Reset(tfFile);
  while not eof(tfFile) do
  begin
    Inc(Counter);
    ComboBox.Items.Add(IntToStr(Counter));
    ReadLn(tfFile, TempString);
    Richedit.Lines.Add(TempString);
    Richedit.Lines.Add('');
  end;
end;

//Check if ingredient name exists in database
function TFormula.CheckIfIngredientExists(IngredientName : String): Boolean;//Safe
begin
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Stock]');
  DataModule2.adoquery.SQL.Add('WHERE [Ingredient_Name]');
  DataModule2.adoquery.SQL.Add('Values (:[Name])');
  DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := IngredientName + '%';
  DataModule2.adoquery.Open;
  if DataModule2.adoquery.RecordCount = 0 then
  begin
    result := False;
  end;
  if DataModule2.adoquery.RecordCount = 1 then
  begin
    result := True;
  end
  else
  begin
    result := False;
  end;
end;

//Search for certain employees in database and display in dbgrid
function TFormula.SearchEmployees(EmployeeName: String;dbGrid : TDBGrid): Boolean;
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Employee Information]');
  DataModule2.adoquery.SQL.Add('WHERE [Employee_Name]');
  DataModule2.adoquery.SQL.Add('Values (:[Name])');
  DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := EmployeeName + '%';
  DataModule2.adoquery.Open;
  if DataModule2.adoquery.RecordCount = 0 then
  begin
    result := False;
  end
  else
  begin
    DataModule2.adoquery.open;
    DataModule2.adoquery.Active := TRUE;
    dbgrid.DataSource := DataModule2.datasource;
    result := true;
  end;
end;

//Show all employees in database
procedure TFormula.ShowAllEmployees(dbGrid : TDBGrid);
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Employee_Information]');
  DataModule2.adoquery.SQL.Add('GROUP BY [Currently_Employed]');
  DataModule2.adoquery.open;
  DataModule2.adoquery.Active := TRUE;
  dbgrid.DataSource := DataModule2.datasource;
end;

//Show current employees in database
procedure TFormula.ShowCurrentEmployees(dbGrid : TDBGrid);
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Employee_Information]');
  DataModule2.adoquery.SQL.Add('WHERE [Currently_Employed] = True');
  DataModule2.adoquery.open;
  DataModule2.adoquery.Active := TRUE;
  dbgrid.DataSource := DataModule2.datasource;
end;

procedure TFormula.ShowExpenses(dbGrid: TDBGrid);
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Ledger]');
  DataModule2.adoquery.SQL.Add('WHERE [Income_/_Expense] = Expense');
  DataModule2.adoquery.open;
  DataModule2.adoquery.Active := TRUE;
  dbgrid.DataSource := DataModule2.datasource;
end;

procedure TFormula.ShowIncome(dbGrid: TDBGrid);
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Ledger]');
  DataModule2.adoquery.SQL.Add('WHERE [Income_/_Expense] = Expense');
  DataModule2.adoquery.open;
  DataModule2.adoquery.Active := TRUE;
  dbgrid.DataSource := DataModule2.datasource;
end;

procedure TFormula.ShowLedger(dbGrid : TDBGrid);
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Ledger]');
  DataModule2.adoquery.open;
  DataModule2.adoquery.Active := TRUE;
  dbgrid.DataSource := DataModule2.datasource;
end;

//Show resigned employees in database
procedure TFormula.ShowResignedEmployees(dbGrid : TDBGrid);
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Employee_Information]');
  DataModule2.adoquery.SQL.Add('WHERE [Currently_Employed] = False');
  DataModule2.adoquery.open;
  DataModule2.adoquery.Active := TRUE;
  dbgrid.DataSource := DataModule2.datasource;
end;

procedure TFormula.ShowTransactionHistory(dbGrid: TDBGrid);
begin
  DataModule2.datasource.dataset := DataModule2.adoquery;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Transaction_History]');
  DataModule2.adoquery.open;
  DataModule2.adoquery.Active := TRUE;
  dbgrid.DataSource := DataModule2.datasource;
end;

//Fire old employee from database
function TFormula.FireEmployee(EmployeeName, EmployeeSurname: String;
  EmployeeIDNumber: Integer): Boolean;
begin
  //Check if employee exists
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Employee_Information]');
  DataModule2. adoquery.SQL.Add('WHERE [Employee_Name], [Employee_Surname]');
  DataModule2.adoquery.SQL.Add(', [Employee_ID_Number]');
  DataModule2.adoquery.SQL.Add('Values (:[Name],:[Surname] ,:[ID_Number])');
  DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := EmployeeName;
  DataModule2.adoquery.Parameters.ParamByName('[Surname]').Value := EmployeeSurname ;
  DataModule2.adoquery.Parameters.ParamByName('[ID_Number]').Value := EmployeeIDNumber;
  DataModule2.adoquery.Open;
  if DataModule2.adoquery.RecordCount = 0 then
  begin
    result := False;
  end
  else //If does
  begin
    //Change Currently Employed To False
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('UPDATE [Employee_Information]');
    DataModule2.adoquery.SQL.Add('Set [Currently_Employed] = False');
    DataModule2.adoquery.SQL.Add('WHERE [Employee_Name], [Employee_Surname]');
    DataModule2.adoquery.SQL.Add(', [Employee_ID_Number]');
    DataModule2.adoquery.SQL.Add('Values (:[Name],:[Surname] ,:[ID_Number])');
    DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := EmployeeName;
    DataModule2.adoquery.Parameters.ParamByName('[Surname]').Value := EmployeeSurname;
    DataModule2.adoquery.Parameters.ParamByName('[ID_Number]').Value := EmployeeIDNumber;
    DataModule2.adoquery.ExecSQL;
    result := true;
  end;
end;

//Add new employee to database
function TFormula.AddEmployee(Details: array of String): Boolean;
begin
  //Check if user already exists
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Employee_Information]');
  DataModule2.adoquery.SQL.Add('WHERE [Employee_Name]');
  DataModule2.adoquery.SQL.Add('Values (:[Name])');
  DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := Details[0] + '%';
  DataModule2.adoquery.Open;
  if DataModule2.adoquery.RecordCount <> 0 then
  begin
    result := False;
  end
  else //If not
  begin
    //Insert Employee Information into employee information
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('INSERT INTO [Employee_Information]');
    DataModule2.adoquery.SQL.Add('([Employee_Name],[Employee_Surname]');
    DataModule2.adoquery.SQL.Add(',[Employee_ID_Number]');
    DataModule2.adoquery.SQL.Add(',[Country]');
    DataModule2.adoquery.SQL.Add(',[City],[Address],[Job],[Salary],[Currently Employed]');
    DataModule2.adoquery.SQL.Add(',[Password])');
    DataModule2.adoquery.SQL.Add('Values (:[Employee_Name], :[Employee_Surname]');
    DataModule2.adoquery.SQL.Add(' ,:[Employee_ID_Number],:[Employee_Country_Of_Origin]');
    DataModule2.adoquery.SQL.Add(', :[City], :[Address], :[Job], :[Salary]');
    DataModule2.adoquery.SQL.Add(', :[Currently Employed])');
    DataModule2.adoquery.Parameters.ParamByName('[Employee_Name]').Value := Details[0];
    DataModule2.adoquery.Parameters.ParamByName('[Employee_Surname]').Value := Details[1];
    DataModule2.adoquery.Parameters.ParamByName('[Employee_ID Number]').Value := Details[2];
    DataModule2.adoquery.Parameters.ParamByName('[Employee_Country_Of_Origin]').Value :=
    Details[3];
    DataModule2.adoquery.Parameters.ParamByName('[City]').Value := Details[4];
    DataModule2.adoquery.Parameters.ParamByName('[Address]').Value := Details[5];
    DataModule2.adoquery.Parameters.ParamByName('[Job]').Value := Details[6];
    DataModule2.adoquery.Parameters.ParamByName('[Salary]').Value := Details[7];
    DataModule2.adoquery.Parameters.ParamByName('[Currently_Employed]').Value := True;
    DataModule2.adoquery.Parameters.ParamByName('[Password]').Value := Details[8];
    DataModule2.adoquery.ExecSQL;
    result := true;
  end;
end;

//Check if enough ingredients in inventory to make selected group of recipes
function TFormula.CheckStock(Group,Number: Integer):Boolean;
begin
  TempNumberOne := 0;
  CounterTwo := 0;
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('SELECT [Amount],[Ingredient_ID]');
  DataModule2.adoquery.SQL.Add(' FROM [Recipe_Ingredients]');
  DataModule2.adoquery.SQL.Add('WHERE [Recipe_ID] = :A');
  DataModule2.adoquery.Parameters.Items[0].Value :=
  RecipeID[Group,Number];
  DataModule2.adoquery.Open;
  FieldOne := DataModule2.adoquery.FieldByName('Amount');
  FieldTwo := DataModule2.adoquery.FieldByName('Ingredient_ID');
  TempInteger := DataModule2.adoquery.RecordCount;
  SetLength(TempIngredientID,TempInteger-1);
  SetLength(TempAmount2,TempInteger-1);
  while not DataModule2.adoquery.eof do
  begin
    TempAmount2[CounterTwo] := FieldOne.AsInteger;
    TempIngredientID[CounterTwo] := FieldTwo.AsInteger;
    Inc(CounterTwo);
    DataModule2.adoquery.Next;
  end;
  for CounterTwo := 0 to TempInteger - 1 do
  begin
    DataModule2.adoquery.DisableControls;
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('SELECT [Amount]');
    DataModule2.adoquery.SQL.Add('FROM [Stock]');
    DataModule2.adoquery.SQL.Add('WHERE [Ingredient_ID] = :A');
    DataModule2.adoquery.Parameters.Items[0].Value :=
    TempIngredientID[CounterTwo];
    DataModule2.adoquery.Open;
    FieldThree := DataModule2.adoquery.FieldByName('Amount');
    TempNumberOne := FieldThree.AsFloat;
    if TempAmount2[CounterTwo] <= TempNumberOne then
    begin
      TempBoolean := False;
    end;
  end;
  if not TempBoolean then
  begin
    result := False;
  end
  else
  begin
    result := True;
  end;
end;

constructor TFormula.Create(Dummy: Integer);
begin
  vDummy := Dummy;
end;

//Check if enough drinks in inventory
function TFormula.CheckDrinks(Number: Integer): Boolean;
begin
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.SQL.Add('SELECT [Amount]');
  DataModule2.adoquery.SQL.Add('FROM [Drinks]');
  DataModule2.adoquery.SQL.Add('WHERE [Drink_ID] = :A');
  DataModule2.adoquery.Parameters.Items[0].Value :=
  DrinkID[Number];
  DataModule2.adoquery.Open;
  FieldOne := DataModule2.adoquery.FieldByName('Amount');
  if FieldOne.AsInteger <= 2 then
  begin
    result := False;
  end
  else
  begin
    result := True;
  end;
end;

//Add electricity payement to ledger
procedure TFormula.PayElectricity(Amount,Total: Real);
begin
  DataModule2.adoquery.sql.Clear;
  DataModule2.adoquery.SQL.Add('INSERT INTO [Ledger]');
  DataModule2.adoquery.SQL.Add('([Employee_ID],[Type_Of_Transaction],');
  DataModule2.adoquery.SQL.Add('[Income_/_Expense],[Amount],');
  DataModule2.adoquery.SQL.Add('[Total], [Transaction_Date])');
  DataModule2.adoquery.SQL.Add('Values (:[Employee_ID], :[Type_Of_Transaction],');
  DataModule2.adoquery.SQL.Add(':[Income_/_Expense], :[Amount],');
  DataModule2.adoquery.SQL.Add(':[Total], :[Date])');
  DataModule2.adoquery.Parameters.ParamByName('[Employee_ID]').Value := EmployeeNumber;
  DataModule2.adoquery.Parameters.ParamByName('[Type_Of_Transaction]').Value :=
  'Electricity';
  DataModule2.adoquery.Parameters.ParamByName('[Income_/_Expense]').Value := 'Expense';
  DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value := Amount;
  DataModule2.adoquery.Parameters.ParamByName('[Total]').Value := Total;
  DataModule2.adoquery.Parameters.ParamByName('[Date]').Value :=
    sysutils.DateToStr(sysutils.Date);
  DataModule2.adoquery.ExecSQL;
end;

//Add water payement to ledger
procedure TFormula.PayWater(Amount,Total: Real);
begin
  DataModule2.adoquery.sql.Clear;
  DataModule2.adoquery.SQL.Add('INSERT INTO [Ledger]');
  DataModule2.adoquery.SQL.Add('([Employee_ID],[Type_Of_Transaction],');
  DataModule2.adoquery.SQL.Add('[Income_/_Expense],[Amount],');
  DataModule2.adoquery.SQL.Add('[Total], [Transaction_Date])');
  DataModule2.adoquery.SQL.Add('Values (:[Employee_ID], :[Type_Of_Transaction],');
  DataModule2.adoquery.SQL.Add(':[Income_/_Expense], :[Amount],');
  DataModule2.adoquery.SQL.Add(':[Total], :[Date])');
  DataModule2.adoquery.Parameters.ParamByName('[Employee_ID]').Value := EmployeeNumber;
  DataModule2.adoquery.Parameters.ParamByName('[Type_Of_Transaction]').Value := 'Water';
  DataModule2.adoquery.Parameters.ParamByName('[Income_/_Expense]').Value := 'Expense';
  DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value := Amount;
  DataModule2.adoquery.Parameters.ParamByName('[Total]').Value := Total;
  DataModule2.adoquery.Parameters.ParamByName('[Date]').Value :=
    sysutils.DateToStr(sysutils.Date);
  DataModule2.adoquery.ExecSQL;
end;

//Used to check if drink exists
function TFormula.CheckIfDrinkExists(DrinkNames: String): Boolean;
begin
  DataModule2.adoquery.SQL.Clear;
  DataModule2.adoquery.sql.add('SELECT * FROM [Drinks]');
  DataModule2.adoquery.SQL.Add('WHERE [Drink_Name]');
  DataModule2.adoquery.SQL.Add('Values (:[Name])');
  DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := DrinkNames + '%';
  DataModule2.adoquery.Open;
  if DataModule2.adoquery.RecordCount = 0 then
  begin
    result := False;
  end;
  if DataModule2.adoquery.RecordCount = 1 then
  begin
    result := True;
  end
  else
  begin
    result := False;
  end;
end;

//Add stock payement to ledger
procedure TFormula.PayStock(Name: String;  Amount: Integer; Price: Real);
begin
  DataModule2.adoquery.sql.Clear;
  DataModule2.adoquery.SQL.Add('INSERT INTO [Ledger]');
  DataModule2.adoquery.SQL.Add('([Employee_ID],[Type_Of_Transaction],');
  DataModule2.adoquery.SQL.Add('[Income_/_Expense],[Amount],');
  DataModule2.adoquery.SQL.Add('[Total], [Transaction_Date])');
  DataModule2.adoquery.SQL.Add('Values (:[Employee_ID], :[Type_Of_Transaction]');
  DataModule2.adoquery.SQL.Add(':[Income_/_Expense], :[Amount],');
  DataModule2.adoquery.SQL.Add(':[Total], :[Date])');
  DataModule2.adoquery.Parameters.ParamByName('[Employee_ID]').Value := EmployeeNumber;
  DataModule2.adoquery.Parameters.ParamByName('[Type_Of_Transaction]').Value := 'Name';
  DataModule2.adoquery.Parameters.ParamByName('[Income_/_Expense]').Value := 'Expense';
  DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value := Amount;
  DataModule2.adoquery.Parameters.ParamByName('[Total]').Value := Price;
  DataModule2.adoquery.Parameters.ParamByName('[Date]').Value :=
    sysutils.DateToStr(sysutils.Date);
  DataModule2.adoquery.ExecSQL;
end;

//Add drink payement to ledger
procedure TFormula.PayDrink(Name: String; Amount: Integer; Price: Real);
begin
  DataModule2.adoquery.sql.Clear;
  DataModule2.adoquery.SQL.Add('INSERT INTO [Ledger]');
  DataModule2.adoquery.SQL.Add('([Employee_ID],[Type_Of_Transaction]');
  DataModule2.adoquery.SQL.Add('[Income_/_Expense],[Amount]');
  DataModule2.adoquery.SQL.Add('[Total], [Transaction_Date])');
  DataModule2.adoquery.SQL.Add('Values (:[Employee_ID], :[Type_Of_Transaction]');
  DataModule2.adoquery.SQL.Add(':[Income_/_Expense], :[Amount]');
  DataModule2.adoquery.SQL.Add(':[Total], :[Date])');
  DataModule2.adoquery.Parameters.ParamByName('[Employee_ID]').Value := EmployeeNumber;
  DataModule2.adoquery.Parameters.ParamByName('[Type_Of_Transaction]').Value := 'Name';
  DataModule2.adoquery.Parameters.ParamByName('[Income_/_Expense]').Value := 'Expense';
  DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value := Amount;
  DataModule2.adoquery.Parameters.ParamByName('[Total]').Value := Price;
  DataModule2.adoquery.Parameters.ParamByName('[Date]').Value :=
    sysutils.DateToStr(sysutils.Date);
  DataModule2.adoquery.ExecSQL;
end;

//Gets New Amounts From User And After Validation And Updates Drink Amounts
function TFormula.AddDrink(DrinkName: String; Amount, Price: Real): Boolean;
begin
  try
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('UPDATE [Drinks]');
    DataModule2.adoquery.SQL.Add('(Set [Amount], [Price]');
    DataModule2.adoquery.SQL.Add('Values (:[Amount],:[Price]))');
    DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value :=  TempNumberOne;
    DataModule2.adoquery.Parameters.ParamByName('[Price]').Value := Price;
    DataModule2.adoquery.SQL.Add('(WHERE [Drink_Name] ');
    DataModule2.adoquery.SQL.Add('Values (:[Name]))');
    DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := DrinkName;
    DataModule2.adoquery.ExecSQL;
  except
    result := False;
  end;
  result := true;
end;

//Gets New Amounts From User And After Validation And Updates Stock Amounts
function TFormula.AddStock(IngredientName: String; Amount, Price: Real): Boolean;
begin
  try
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('SELECT [Amount],[Price]');
    DataModule2.adoquery.SQL.Add(',[Price_Per_Amount] FROM [Stock]');
    DataModule2.adoquery.SQL.Add('WHERE [Ingredient_Name] ');
    DataModule2.adoquery.SQL.Add('Values (:[Name])');
    DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := IngredientName;
    FieldOne := DataModule2.adoquery.FieldByName('[Amount]');
    TempNumberOne := FieldOne.AsFloat + Amount;
    TempNumberTwo := Amount * Price;
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('UPDATE [Stock]');
    DataModule2.adoquery.SQL.Add('(Set [Amount], [Price_Per_Amount], [Price]');
    DataModule2.adoquery.SQL.Add('Values (:[Amount],:[Price_Per_Amount] ,:[Price]))');
    DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value :=  TempNumberOne;
    DataModule2.adoquery.Parameters.ParamByName('[Price_Per_Amount]').Value :=
    TempNumberTwo;
    DataModule2.adoquery.Parameters.ParamByName('[Price]').Value := Price;
    DataModule2.adoquery.SQL.Add('(WHERE [Ingredient_Name] ');
    DataModule2.adoquery.SQL.Add('Values (:[Name]))');
    DataModule2.adoquery.Parameters.ParamByName('[Name]').Value := IngredientName;
    DataModule2.adoquery.ExecSQL;
    except
    result := False;
  end;
  result := true;
end;

//Pay All Employees And Add Record To Ledger
 procedure TFormula.PayEmployees(Bonus: Integer);
begin
  if Bonus = 0 then
  begin
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('SELECT [Salary]');
    DataModule2.adoquery.SQL.Add('FROM [Employee_Information]');
    DataModule2.adoquery.SQL.Add('WHERE [Currently_Employed] = True');
    DataModule2.adoquery.Open;
    FieldOne := DataModule2.adoquery.FieldByName('[Salary]');
    while not DataModule2.adoquery.eof do
    begin
      TempInteger := TempInteger + FieldOne.AsInteger;
      DataModule2.adoquery.Next;
    end;
    DataModule2.adoquery.sql.Clear;
    DataModule2.adoquery.SQL.Add('INSERT INTO [Ledger]');
    DataModule2.adoquery.SQL.Add('([Employee_ID],[Type_Of_Transaction]');
    DataModule2.adoquery.SQL.Add('[Income_/_Expense],[Amount]');
    DataModule2.adoquery.SQL.Add('[Total], [Transaction_Date])');
    DataModule2.adoquery.SQL.Add('Values (:[Employee_ID], :[Type_Of_Transaction]');
    DataModule2.adoquery.SQL.Add(':[Income_/_Expense], :[Amount]');
    DataModule2.adoquery.SQL.Add(':[Total], :[Date])');
    DataModule2.adoquery.Parameters.ParamByName('[Employee_ID]').Value := EmployeeNumber;
    DataModule2.adoquery.Parameters.ParamByName('[Type_Of_Transaction]').Value :=
    'Pay Employees';
    DataModule2.adoquery.Parameters.ParamByName('[Income_/_Expense]').Value := 'Expense';
    DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value := '0';
    DataModule2.adoquery.Parameters.ParamByName('[Total]').Value := TempInteger;
    DataModule2.adoquery.Parameters.ParamByName('[Date]').Value :=
    sysutils.DateToStr(sysutils.Date);
    DataModule2.adoquery.ExecSQL;
  end
  else
  begin
    I := 0;
    DataModule2.adoquery.SQL.Clear;
    DataModule2.adoquery.SQL.Add('SELECT [Salary]');
    DataModule2.adoquery.SQL.Add('FROM [Employee_Information]');
    DataModule2.adoquery.SQL.Add('WHERE [Currently_Employed] = True');
    DataModule2.adoquery.Open;
    FieldOne := DataModule2.adoquery.FieldByName('[Salary]');
    while not DataModule2.adoquery.eof do
    begin
      TempInteger := TempInteger + FieldOne.AsInteger;
      DataModule2.adoquery.Next;
      Inc(I);
    end;
    DataModule2.adoquery.sql.Clear;
    DataModule2.adoquery.SQL.Add('INSERT INTO [Ledger]');
    DataModule2.adoquery.SQL.Add('([Employee_ID],[Type_Of_Transaction]');
    DataModule2.adoquery.SQL.Add('[Income_/_Expense],[Amount]');
    DataModule2.adoquery.SQL.Add('[Total],[Transaction_Date])');
    DataModule2.adoquery.SQL.Add('Values (:[Employee_ID], :[Type_Of_Transaction]');
    DataModule2.adoquery.SQL.Add(':[Income_/_Expense], :[Amount]');
    DataModule2.adoquery.SQL.Add(':[Total], :[Date])');
    DataModule2.adoquery.Parameters.ParamByName('[Employee_ID]').Value := EmployeeNumber;
    DataModule2.adoquery.Parameters.ParamByName('[Type_Of_Transaction]').Value :=
     'Pay Employees';
    DataModule2.adoquery.Parameters.ParamByName('[Income_/_Expense]').Value := 'Expense';
    DataModule2.adoquery.Parameters.ParamByName('[Amount]').Value := '0' + '%';
    DataModule2.adoquery.Parameters.ParamByName('[Total]').Value :=
    ((I * Bonus) + TempInteger);
    DataModule2.adoquery.Parameters.ParamByName('[Date]').Value :=
    sysutils.DateToStr(sysutils.Date);
    DataModule2.adoquery.ExecSQL;
  end;
end;
end.

