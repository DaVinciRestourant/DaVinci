unit Restourant.Consts.Strings;
interface
type
  TLang = (
     lngRUS
    ,lngUSA
    ,lngDEU
    ,lngFRA
    ,lngUKR
  );
const
  LangID :array[TLang]of Integer = (
     1000054
    ,1000056
    ,1000090
    ,1000091
    ,1000071
  );
  LangNames :array[TLang]of string = (
     'Русский'
    ,'English'
    ,'Deutsch'
    ,'Français'
    ,'Українська'
  );

function TLangToInt(const Lang:TLang):Integer;
function IntToTLang(const ID:Integer):TLang;

implementation

function TLangToInt(const Lang:TLang):Integer;
begin
  Result := LangId[Lang];
end;

function IntToTLang(const ID:Integer):TLang;
begin
  for Result := Low(TLang) to High(TLang) do
    if(LangId[Result] = ID)then
      Break;
end;

end.
