unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  System.Generics.Collections,
  items, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.Layouts
  ;

const
  CS_STR_RECORD = '%d'+char(vkTab)+'%f'+char(vkTab)+'%d';
  CS_STR_HEADER = 'CODE'+char(vkTab)+'PRICE'+char(vkTab)+'COUNT';
  CS_STR_TIME   = Char(vkReturn)+'Tick: %d ms';

type

  TForm1 = class(TForm)
    MemoResult: TMemo;
    ButtonShowGrouped: TButton;
    Layout1: TLayout;
    procedure ButtonShowGroupedClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowGrouped(AGroupedItems: TDictionary<TRecKey, TRecItem>;
                          ATickTime: cardinal);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  GroupFunc,
  Winapi.Windows;

{$R *.fmx}

{ TForm1 }

procedure TForm1.ButtonShowGroupedClick(Sender: TObject);
var
  FSourceArray: TArrItems;
  TickBegin, TickEnd, TickResult: Cardinal;
  FGroupedItems: TDictionary<TRecKey, TRecItem>;
begin
  FSourceArray := GenerateItems(100000);

  TickBegin := GetTickCount;

  FGroupedItems := Group(FSourceArray);

  TickEnd := GetTickCount;
  TickResult := TickEnd - TickBegin; //Время, затраченное на выполнение группировки (ms).

  Self.ShowGrouped(FGroupedItems,
                   TickResult);
end;

procedure TForm1.ShowGrouped(AGroupedItems: TDictionary<TRecKey, TRecItem>; ATickTime: cardinal);
var
  I: integer;
  FPair: TPair<TRecKey, TRecItem>;
  strRecord: string;

  function GetStrRecord(ARecItem: TRecItem): string;
  begin
    Result := Format(CS_STR_RECORD, [ARecItem.Code,
                                     ARecItem.Price,
                                     ARecItem.Count]);
  end;

begin
  self.MemoResult.Lines.Clear;
  Self.MemoResult.Lines.Add(CS_STR_HEADER);
  for FPair in AGroupedItems do
    begin
      strRecord := GetStrRecord(FPair.Value);
      self.MemoResult.Lines.Add(strRecord);
    end;

  Self.MemoResult.Lines.Add(Format(CS_STR_TIME, [ATickTime]));

  AGroupedItems.Free;
end;

end.
