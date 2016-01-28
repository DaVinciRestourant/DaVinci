unit Network;
interface

function IsConnected: Boolean;
function IsWiFiConnected: Boolean;
function IsMobileConnected: Boolean;

function PhoneNumberLine1:string;

implementation
uses
  System.SysUtils
{$IFDEF ANDROID}
 ,Androidapi.JNIBridge, Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.JavaTypes
 ,Androidapi.JNI.Provider, Androidapi.JNI.Telephony
 ,Androidapi.Helpers
{$ENDIF}
 ;

{$IFDEF ANDROID}
type
  JConnectivityManager = interface;
  JNetworkInfo = interface;

  JNetworkInfoClass = interface(JObjectClass)
  ['{E92E86E8-0BDE-4D5F-B44E-3148BD63A14C}']
  end;

  [JavaSignature('android/net/NetworkInfo')]
  JNetworkInfo = interface(JObject)
  ['{6DF61A40-8D17-4E51-8EF2-32CDC81AC372}']
    function isAvailable: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnectedOrConnecting: Boolean; cdecl;
  end;
  TJNetworkInfo = class(TJavaGenericImport<JNetworkInfoClass, JNetworkInfo>) end;

  JConnectivityManagerClass = interface(JObjectClass)
  ['{E03A261F-59A4-4236-8CDF-0068FC6C5FA1}']
    function _GetTYPE_WIFI: Integer; cdecl;
    function _GetTYPE_WIMAX: Integer; cdecl;
    function _GetTYPE_MOBILE: Integer; cdecl;
    property TYPE_WIFI: Integer read _GetTYPE_WIFI;
    property TYPE_WIMAX: Integer read _GetTYPE_WIMAX;
    property TYPE_MOBILE: Integer read _GetTYPE_MOBILE;
  end;

  [JavaSignature('android/net/ConnectivityManager')]
  JConnectivityManager = interface(JObject)
  ['{1C4C1873-65AE-4722-8EEF-36BBF423C9C5}']
    function getActiveNetworkInfo: JNetworkInfo; cdecl;
    function getNetworkInfo(networkType: Integer): JNetworkInfo; cdecl;
  end;

  TJConnectivityManager = class(TJavaGenericImport<JConnectivityManagerClass, JConnectivityManager>) end;
{$ENDIF}

{$IFDEF ANDROID}
function GetPhoneManager: JTelephonyManager;
var
  LPhoneService :JObject;
begin
  Result := nil;
  LPhoneService :=  SharedActivityContext.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
  if not Assigned(LPhoneService) then
    exit;
  Result := TJTelephonyManager.Wrap( (LPhoneService as ILocalObject).GetObjectID );
end;
{$ENDIF}

function PhoneNumberLine1:string;
{$IFDEF ANDROID}
var
  LPhoneManager :JTelephonyManager;
begin
  Result := System.SysUtils.EmptyStr;
  LPhoneManager := GetPhoneManager;
  if Assigned(LPhoneManager) then
  begin
    Result := JStringToString( LPhoneManager.getLine1Number );
  end;
end;
{$ELSE}
begin
  Result := '+380501230321';
end;
{$ENDIF}

{$IFDEF ANDROID}
function GetConnectivityManager: JConnectivityManager;
var
  ConnectivityServiceNative: JObject;
begin
  Result := nil;
  ConnectivityServiceNative :=  SharedActivityContext.getSystemService(TJContext.JavaClass.CONNECTIVITY_SERVICE);
  if not Assigned(ConnectivityServiceNative) then
    exit;
  Result := TJConnectivityManager.Wrap(  (ConnectivityServiceNative as ILocalObject).GetObjectID );
end;
{$ENDIF}

function IsConnected: Boolean;
{$IFDEF ANDROID}
var
  ConnectivityManager: JConnectivityManager;
  ActiveNetwork: JNetworkInfo;
begin
  Result := False;
  ConnectivityManager := GetConnectivityManager;
  ActiveNetwork := ConnectivityManager.getActiveNetworkInfo;
  if Assigned(ActiveNetwork) then
    Result := ActiveNetwork.isConnected;
end;
{$ELSE}
begin
  Result := True;
end;
{$ENDIF}

function IsWiFiConnected: Boolean;
{$IFDEF ANDROID}
var
  ConnectivityManager: JConnectivityManager;
  WiFiNetwork: JNetworkInfo;
begin
  Result := False;
  ConnectivityManager := GetConnectivityManager;
  WiFiNetwork := ConnectivityManager.getNetworkInfo(TJConnectivityManager.JavaClass.TYPE_WIFI);
  Result := WiFiNetwork.isConnected;
end;
{$ELSE}
begin
  Result := True;
end;
{$ENDIF}

function IsMobileConnected: Boolean;
{$IFDEF ANDROID}
var
  ConnectivityManager: JConnectivityManager;
  MobileNetwork: JNetworkInfo;
begin
  Result := False;
  ConnectivityManager := GetConnectivityManager;
  MobileNetwork := ConnectivityManager.getNetworkInfo(TJConnectivityManager.JavaClass.TYPE_MOBILE);
  Result := MobileNetwork.isConnected;
end;
{$ELSE}
begin
  Result := True;
end;
{$ENDIF}

end.
