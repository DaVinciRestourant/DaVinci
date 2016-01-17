unit Restourant.JsonDatabase;

interface
uses
   System.SysUtils,  System.IOUtils, System.Types, System.Classes, System.Variants
  ,Restourant.JsonDataObject
  ;
type
  TJsonDataBase = class(TComponent)
  private
    FTables      :TStringList;
    FFileExt     :string;
    FDataBasePath:string;
    procedure     SetDataBasePath(const Value:string);
    function      GetTable(const TableName:string):TJsonObject;
  public
    constructor   Create(aOwner :TComponent); override;
    destructor    Destroy;                    override;
    function      AddTable(const TableName:string):TJsonObject;
    function      NewTable(const TableName:string):TJsonObject;
    function      ReloadTable(const TableName:string):TJsonObject;
    procedure     DeleteTable(const TableName:string; SaveData: Boolean = False);
    procedure     Clear(SaveData: Boolean = False);
    procedure     ReloadAll;
    property      DataBasePath:string read FDataBasePath write SetDataBasePath;
    property      FileExt     :string read FFileExt      write FFileExt;
    property      Tables[const TableName:string]:TJsonObject read GetTable; default;
  end;

implementation

constructor TJsonDataBase.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FDataBasePath := System.SysUtils.EmptyStr;
  FTables := TStringList.Create;
  FTables.Clear;
end;

destructor TJsonDataBase.Destroy;
begin
  FTables.Clear;
  FreeAndNil(FTables);
  inherited Destroy;
end;

procedure TJsonDataBase.SetDataBasePath(const Value: string);
begin
  if(FDataBasePath <> Value)then
  begin
    FTables.Clear;
    FDataBasePath := Value;
  end;
end;

function TJsonDataBase.GetTable(const TableName: string): TJsonObject;
var
  LIndex :Integer;
begin
  Result := nil;
  LIndex := FTables.IndexOf(TableName);
  if(LIndex > -1)then
    Result := TJsonObject( FTables.Objects[LIndex] );
end;

function TJsonDataBase.NewTable(const TableName: string): TJsonObject;
begin
  Result := GetTable(TableName);
  if(Result = nil)then
  begin
    Result := TJsonObject.Create;
    FTables.AddObject(TableName, Result);
  end;
end;

procedure TJsonDataBase.ReloadAll;
var
  i :Integer;
begin
  for i:=0 to FTables.Count-1 do
    ReloadTable( FTables.Names[i] );
end;

function TJsonDataBase.ReloadTable(const TableName: string): TJsonObject;
begin
  Result := NewTable(TableName);
  try
    Result.LoadFromFile( System.IOUtils.TPath.Combine(FDataBasePath, TableName) + FFileExt );
  except
    raise Exception.Create('Cannot to load datafile:' + #13#10 + System.IOUtils.TPath.Combine(FDataBasePath, TableName) + FFileExt);
  end;
end;

function TJsonDataBase.AddTable(const TableName: string): TJsonObject;
begin
  Result := ReloadTable(TableName);
end;

procedure TJsonDataBase.DeleteTable(const TableName: string; SaveData: Boolean = False);
var
  LObj :TJsonObject;
begin
  LObj := GetTable(TableName);
  if(LObj <> nil)then
  begin
    if SaveData then
      LObj.SaveToFile( System.IOUtils.TPath.Combine(FDataBasePath, TableName) + FFileExt, False );
    FTables.Delete( FTables.IndexOfName(TableName) );
  end;
end;

procedure TJsonDataBase.Clear(SaveData: Boolean = False);
var
  i :Integer;
begin
  if SaveData then
    for i:=0 to FTables.Count-1 do
      TJsonObject(FTables.Objects[i]).SaveToFile( System.IOUtils.TPath.Combine(FDataBasePath, FTables.Names[i]) + FFileExt , False );
  FTables.Clear;
end;

end.
