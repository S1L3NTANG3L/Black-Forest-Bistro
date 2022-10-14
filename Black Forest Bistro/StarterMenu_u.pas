unit StarterMenu_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls,BlackForest_u;

type
  TStarterMenu = class(TFrame)
    img1: TImage;
    img6: TImage;
    img11: TImage;
    lbl11: TLabel;
    lbl6: TLabel;
    lbl1: TLabel;
    img7: TImage;
    img2: TImage;
    img12: TImage;
    img13: TImage;
    img8: TImage;
    img3: TImage;
    img4: TImage;
    img9: TImage;
    img14: TImage;
    img15: TImage;
    img10: TImage;
    img5: TImage;
    lbl15: TLabel;
    lbl10: TLabel;
    lbl5: TLabel;
    lbl4: TLabel;
    lbl9: TLabel;
    lbl14: TLabel;
    lbl13: TLabel;
    lbl8: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    lbl7: TLabel;
    lbl12: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    lbl30: TLabel;
    btn11: TButton;
    btn6: TButton;
    btn1: TButton;
    btn15: TButton;
    btn10: TButton;
    btn5: TButton;
    btn4: TButton;
    btn9: TButton;
    btn14: TButton;
    btn13: TButton;
    btn8: TButton;
    btn3: TButton;
    btn2: TButton;
    btn7: TButton;
    btn12: TButton;
    btnBackToH: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure btn11Click(Sender: TObject);
    procedure btn12Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure btn14Click(Sender: TObject);
    procedure btn15Click(Sender: TObject);
    procedure StarterAdd(RecipeNumber : Integer);
  private
    { Private declarations }
    Formula : TFormula;
    ServingsSelected : Integer;
    SuccessBoolean : Boolean;
  public
    { Public declarations }
    Servings : array[0..14] of integer;
  end;

implementation

{$R *.dfm}

procedure TStarterMenu.btn1Click(Sender: TObject);
begin
  StarterAdd(1);
end;

procedure TStarterMenu.btn2Click(Sender: TObject);
begin
  StarterAdd(2);
end;

procedure TStarterMenu.btn3Click(Sender: TObject);
begin
  StarterAdd(3);
end;

procedure TStarterMenu.btn4Click(Sender: TObject);
begin
  StarterAdd(4);
end;

procedure TStarterMenu.btn5Click(Sender: TObject);
begin
  StarterAdd(5);
end;

procedure TStarterMenu.btn6Click(Sender: TObject);
begin
  StarterAdd(6);
end;

procedure TStarterMenu.btn7Click(Sender: TObject);
begin
  StarterAdd(7);
end;

procedure TStarterMenu.btn8Click(Sender: TObject);
begin
  StarterAdd(8);
end;

procedure TStarterMenu.btn9Click(Sender: TObject);
begin
  StarterAdd(9);
end;

procedure TStarterMenu.btn10Click(Sender: TObject);
begin
  StarterAdd(10);
end;

procedure TStarterMenu.btn11Click(Sender: TObject);
begin
  StarterAdd(11);
end;

procedure TStarterMenu.btn12Click(Sender: TObject);
begin
  StarterAdd(12);
end;

procedure TStarterMenu.btn13Click(Sender: TObject);
begin
  StarterAdd(13);
end;

procedure TStarterMenu.btn14Click(Sender: TObject);
begin
  StarterAdd(14);
end;

procedure TStarterMenu.btn15Click(Sender: TObject);
begin
  StarterAdd(15);
end;

procedure TStarterMenu.StarterAdd(RecipeNumber: Integer);
begin
  SuccessBoolean := False;
  ServingsSelected := 0;
  repeat
    ServingsSelected := StrToInt(inputbox('Servings',
    'Please enter amount of servings wanted', IntToStr(1)));
  until (ServingsSelected <= Servings[RecipeNumber -1]) ;
  SuccessBoolean := Formula.AddRecipeToOrder(1,RecipeNumber,ServingsSelected);
  if not SuccessBoolean then
  begin
    Application.MessageBox('An error occured during adding item to order.',
    'Error', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
  end;
end;

end.
