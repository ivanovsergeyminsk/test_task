unit GroupFunc;

interface
uses
  System.Generics.Collections,
  items;


/// <summary>
///   ����������� �� Code � Price. <br />
/// </summary>
/// <param name="AArray">
///   �������� ������ �������.
/// </param>
/// <remarks>
///   <para>
///     ��������� ��������� TDictionary c ������ TRecKey&lt;integer,
///     double&gt;, ��� integer ��� Code, a double - ��� Price.
///   </para>
///   <para>
///     ��������� ��� ��������� ������, ��� �� ����� �����������
///     hash-�������.
///   </para>
/// </remarks>
function Group(const AArray: TArrItems): TDictionary<TRecKey, TRecItem>;

implementation

function Group(const AArray: TArrItems): TDictionary<TRecKey, TRecItem>;
var
  FItem: TRecItem;    //������ �� ��������� �������
  FRecItem: TRecItem; //������ �� �������
  FKey: TRecKey;
  FGroupedItems: TDictionary<TRecKey, TRecItem>;
begin
  FGroupedItems := TDictionary<TRecKey, TRecItem>.Create;
  {
    ��� ������� �����������, ����� ����� �������������� ����,
    ���������, ��������, ���������� OmniThreadLibrary.
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
