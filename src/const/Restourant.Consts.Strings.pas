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

  TabItemMainMenu     = 'Меню';
  TabItemMainOrder    = 'Заказ';
  TabItemMainUser     = 'Профиль';

  TabItemMenuCat      = 'Категории';
  TabItemMenuGroup    = 'Группы';
  TabItemMenuList     = 'Список';
  TabItemMenuTMC      = 'ТМЦ';
  TabItemMenuImg      = 'Изобр.';

  TabItemOrderList    = 'История';
  TabItemOrder        = 'Заказ';

  TmcPrice            = 'Цена:';
  TmcEdizm            = 'Выход:';
  TmcImageHint        = 'Нажмите здесь для заказа';

  OrderCurrent        = 'Текущий заказ';
  OrderNo             = 'Номер';
  OrderNoNotExists    = 'заказ ещё не отправлен.';
  OrderDateFrom       = 'от';
  OrderDate           = 'Дата';
  OrderTotal          = 'Итого';
  OrderName           = 'Примечания';

  OrderDataImg        = 'Фото';
  OrderDataName       = 'Блюдо';
  OrderDataPrice      = 'Цена';
  OrderDataQuant      = 'Кол.';
  OrderDataTotal      = 'Сумма';
  OrderDataQuantChange= 'нажмите здесь, чтобы изменить количество.';

  btnUserRegister     = 'Регистрация';
  btnUserUpdate       = 'Изменить информацию';
  btnOrderSend        = 'Отправить заказ';
  btnOrderSendDone    = 'Заказ отправлен';
  btnOrderClear       = 'Удалить историю';

  ErrorInternerNotConnected        = 'Нет подключения к Internet.'+#13#10;
  ErrorInternetAnswer              = 'Ответ сервера: ';
  ErrorInternetNoAnswer            = 'Сервер не отвечает.';
  ErrorInternetAnswerInvalid       = 'Сервер венул недопустимый формат данных.';

  ErrorUserPasswordNotEntered      = 'Не введен пароль для пользователя!';
  ErrorUserPasswordNotConfirmed    = 'Введенный пароль не равен подтверждению!';
  ErrorUserYouShouldToConnect      = 'Подключитесь к сети Internet для регистрации или обновления пользовательской информации.';
  ErrorUserRegisteredSuccesfully   = 'Регистрация успешно завершена.';
  ErrorUserNotRegistered           = 'Не удалось зарегистрироваться в системе.';

  ErrorUserNotRegisteredToOrder    = 'Не удается отправить заказ, пользователь не зарегистрирован!'+#13#10+
                                     'Пожалуйста, зарегистрируйтесь в системе для того, чтобы иметь возможность отправлять заказы.';
  ErrorOrderWasSend                = 'Этот заказ уже отправлен.';
  ErrorOrderWasSendNoQuant         = 'Не могу отправить пустой заказ, Вы ничего не выбрали в электронном меню!';
  ErrorOrderSendedSuccesfully      = 'Заказ успешно отправлен.';
  ErrorOrderNotSended              = 'Не удалось отправить заказ.';
  ErrorOrderNewNumber              = 'Заказу присвоен номер';

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
