unit Restourant.Consts.Strings;
interface
type
  TLang = (
     lngRUS
    ,lngUSA
    ,lngUKR
    ,lngDEU
//    ,lngFRA
  );
const
  LangId :array[TLang]of Integer = (
     1000054
    ,1000056
    ,1000071
    ,1000090
//    ,1000091
  );

  ApplicationTitle    = 'DaVinci';

  TabItemMainMenu     = '����';
  TabItemMainOrder    = '�����';
  TabItemMainUser     = '�������';

  TabItemMenuCat      = '���������';
  TabItemMenuGroup    = '������';
  TabItemMenuList     = '������';
  TabItemMenuTMC      = '���';
  TabItemMenuImg      = '�����.';

  TabItemOrderList    = '�������';
  TabItemOrder        = '�����';

  TmcPrice            = '����:';
  TmcEdizm            = '�����:';
  TmcImageHint        = '������� ����� ��� ������';

  OrderCurrent        = '������� �����';
  OrderNo             = '�����';
  OrderNoNotExists    = '����� ��� �� ���������.';
  OrderDateFrom       = '��';
  OrderDate           = '����';
  OrderTotal          = '�����';
  OrderName           = '����������';

  OrderDataImg        = '����';
  OrderDataName       = '�����';
  OrderDataPrice      = '����';
  OrderDataQuant      = '���.';
  OrderDataTotal      = '�����';
  OrderDataQuantChange= '������� �����, ����� �������� ����������.';

  btnUserRegister     = '�����������';
  btnUserUpdate       = '�������� ����������';
  btnOrderSend        = '��������� �����';
  btnOrderSendDone    = '����� ���������';
  btnOrderClear       = '������� �������';

  ErrorInternerNotConnected        = '��� ����������� � Internet.'+#13#10;
  ErrorInternetAnswer              = '����� �������: ';
  ErrorInternetNoAnswer            = '������ �� ��������.';
  ErrorInternetAnswerInvalid       = '������ ����� ������������ ������ ������.';

  ErrorUserPasswordNotEntered      = '�� ������ ������ ��� ������������!';
  ErrorUserPasswordNotConfirmed    = '��������� ������ �� ����� �������������!';
  ErrorUserYouShouldToConnect      = '������������ � ���� Internet ��� ����������� ��� ���������� ���������������� ����������.';
  ErrorUserRegisteredSuccesfully   = '����������� ������� ���������.';
  ErrorUserNotRegistered           = '�� ������� ������������������ � �������.';

  ErrorUserNotRegisteredToOrder    = '�� ������� ��������� �����, ������������ �� ���������������!'+#13#10+
                                     '����������, ����������������� � ������� ��� ����, ����� ����� ����������� ���������� ������.';
  ErrorOrderWasSend                = '���� ����� ��� ���������.';
  ErrorOrderWasSendNoQuant         = '�� ���� ��������� ������ �����, �� ������ �� ������� � ����������� ����!';
  ErrorOrderSendedSuccesfully      = '����� ������� ���������.';
  ErrorOrderNotSended              = '�� ������� ��������� �����.';
  ErrorOrderNewNumber              = '������ �������� �����';

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
