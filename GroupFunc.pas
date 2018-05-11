unit GroupFunc;

interface
uses
  System.Generics.Collections,
  items;


/// <summary>
///   Группировка по Code и Price. <br />
/// </summary>
/// <param name="AArray">
///   Исходный массив записей.
/// </param>
/// <remarks>
///   <para>
///     Использую коллекцию TDictionary c ключем TRecKey&lt;integer,
///     double&gt;, где integer это Code, a double - это Price.
///   </para>
///   <para>
///     Использую эту коллекцию потому, что по ключу формируется
///     hash-таблица.
///   </para>
/// </remarks>
function Group(const AArray: TArrItems): TDictionary<TRecKey, TRecItem>;

implementation

function Group(const AArray: TArrItems): TDictionary<TRecKey, TRecItem>;
var
  FItem: TRecItem;    //запись из исходного массива
  FRecItem: TRecItem; //Запись из словаря
  FKey: TRecKey;
  FGroupedItems: TDictionary<TRecKey, TRecItem>;
begin
  FGroupedItems := TDictionary<TRecKey, TRecItem>.Create;
  {
    Для большей оптимизации, думаю можно распараллелить цикл,
    используя, например, библиотеку OmniThreadLibrary.
  }
  for FItem in AArray do
  begin
    FKey.Code   := FItem.Code;
    FKey.Price  := FItem.Price;

    if FGroupedItems.TryGetValue(FKey, FRecItem) then
      begin
        FRecItem.Count := FRecItem.Count + FItem.Count;
      end
    else
      FRecItem := FItem;

    FGroupedItems.AddOrSetValue(FKey, FRecItem);
  end;

  Result := FGroupedItems;
end;

end.
