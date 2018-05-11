unit items;

interface

type
  TRecKey = record
    Code: integer;
    Price: Double;
  end;

  TRecItem = record
    Code: integer;
    Price: Double;
    Count: integer;
  end;

  TArrItems = array of TRecItem;

const
  CS_ARR: array[0..4] of TRecItem = ((Code: 7; Price: 1.10; Count: 3),
                                     (Code: 5; Price:  2.7; Count: 2),
                                     (Code: 7; Price: 1.10; Count: 1),
                                     (Code: 7; Price: 1.50; Count: 2),
                                     (Code: 5; Price:  2.7; Count: 3));

  //Для генерации записей
  CS_CODE:  array[0..2] of Integer = (7, 5, 3);
  CS_PRICE: array[0..3] of Double = (1.10, 2.7, 1.50, 4.4);

  /// <summary>
  ///   Сгенерировать массив записей.
  /// </summary>
  /// <param name="ACount">
  ///   Количество записей.
  /// </param>
  function GenerateItems(ACount: integer): TArrItems;

implementation

function GenerateItems(ACount: integer): TArrItems;
var
  FArrItems: TArrItems;
  FRecItem: TRecItem;
  I: Integer;
begin
  SetLength(FArrItems, ACount);
  for I := 0 to ACount do
  begin
    FRecItem.Code   := CS_CODE[Random(3)];
    FRecItem.Price  := CS_PRICE[Random(3)];
    FRecItem.Count  := Random(10);
    FArrItems[I] := FRecItem;
  end;
  Result := FArrItems;
end;

end.
