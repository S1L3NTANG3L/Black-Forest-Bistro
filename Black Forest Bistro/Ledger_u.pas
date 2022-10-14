unit Ledger_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, DBGrids,DataModule_u,BlackForest_u, Data.DB;

type
  TLedger = class(TFrame)
    dbgrdLedger: TDBGrid;
    btnBack: TButton;
    btnShowIncome: TButton;
    btnShowExpense: TButton;
    btnShowTransactionHistory: TButton;
    btnShowLedger: TButton;
    procedure btnShowIncomeClick(Sender: TObject);
    procedure btnShowExpenseClick(Sender: TObject);
    procedure btnShowLedgerClick(Sender: TObject);
    procedure btnShowTransactionHistoryClick(Sender: TObject);
  private
    { Private declarations }
    Formula  : TFormula;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TLedger.btnShowExpenseClick(Sender: TObject);
begin
  Formula.ShowExpenses(dbgrdLedger);
end;

procedure TLedger.btnShowIncomeClick(Sender: TObject);
begin
  Formula.ShowIncome(dbgrdLedger);
end;

procedure TLedger.btnShowLedgerClick(Sender: TObject);
begin
  Formula.ShowLedger(dbgrdLedger);
end;

procedure TLedger.btnShowTransactionHistoryClick(Sender: TObject);
begin
  Formula.ShowTransactionHistory(dbgrdLedger);
end;

end.
