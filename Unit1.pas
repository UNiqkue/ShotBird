unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Menus;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ShootTimer: TTimer;
    TimeTimer: TTimer;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure StartGame();
    procedure NextLevel();
    procedure EndGame();
    procedure N3Click(Sender: TObject);
    procedure TimeTimerTimer(Sender: TObject);
    procedure ShootTimerTimer(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N6Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
   fx,fy: integer; // ���������� ����������� �������
   n: integer; // ���������� ��������
   p: integer; // ���������� ���������
   t: integer; // ����� �� ��������� ����
   TimeForShoot:integer; // ����� ��� ���������� ��������
   Level:Integer; // �������
   RunGame:Boolean; // ���������� ��� ����� � ������������� ����
   s: TStringList; // ���������� ��� ���������� ������ ���� � ��������� ����

implementation

{$R *.dfm}

uses Unit2, Unit3;

procedure TMainForm.FormCreate(Sender: TObject);
begin
DoubleBuffered:=True;
RunGame:=False;
Randomize;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if (t>0) and (RunGame=True) then begin
inc(n);
StatusBar1.Panels[2].text:='��������: '+IntToStr(n);
EndGame();
end;
end;

procedure TMainForm.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (t>0) and (RunGame=True) then begin
inc(p);
StatusBar1.Panels[1].text:='���������: '+IntToStr(p);
EndGame();
end;
end;

procedure TMainForm.ShootTimerTimer(Sender: TObject);
begin
if RunGame=True then begin
ShootTimer.Interval:=TimeForShoot;
fx:=Random(ClientWidth-32);
fy:=Random(ClientHeight-52);
Shape1.Top:=fy;
Shape1.Left:=fx;
end;
end;

procedure TMainForm.StartGame();
begin
ShootTimer.Enabled := true;
TimeTimer.Enabled := true;
n:=0;
p:=0;
t:=100;

fx:=100;
fy:=100;

StatusBar1.Panels[0].text:='�������: '+IntToStr(Level);
StatusBar1.Panels[1].text:='���������: '+IntToStr(p);
StatusBar1.Panels[2].text:='��������: '+IntToStr(n);
StatusBar1.Panels[3].text:='�����: '+IntToStr(t);
RunGame:=True; // ���� ��������
end;

procedure TMainForm.TimeTimerTimer(Sender: TObject);
begin
if (t>0) and (RunGame=True) then begin
dec(t);
StatusBar1.Panels[3].text:='�����: '+IntToStr(t);
EndGame();
end;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
level:=1;
TimeForShoot:=1000;
StartGame();
end;

procedure TMainForm.N4Click(Sender: TObject);
begin
 if (StatusBar1.Panels[0].text<>'') and (t<>0)then begin
 Label1.Visible:=true;
 RunGame:=false;
 end;
 end;

procedure TMainForm.N5Click(Sender: TObject);
begin
 if (StatusBar1.Panels[0].text<>'') and (t<>0)then begin
 Label1.Visible:=false;
 RunGame:=true;
end;
end;

procedure TMainForm.N6Click(Sender: TObject);
begin
try
s := TStringList.Create;
s.LoadFromFile('Level.txt');
Level:=StrToInt(s.Strings[0]);
TimeForShoot:=StrToInt(s.Strings[1]);
s.Free;
 NextLevel();
except
ShowMessage('�� ������� ��������� ����');
end;

end;

procedure TMainForm.N7Click(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.N9Click(Sender: TObject);
begin
Form3.ShowModal;
end;

procedure TMainForm.NextLevel();
begin
If TimeForShoot <> 0 then begin
ShootTimer.Enabled := true;
TimeTimer.Enabled := true;
n:=0;
p:=0;
t:=100;

fx:=100;
fy:=100;

StatusBar1.Panels[0].text:='�������: '+IntToStr(Level);
StatusBar1.Panels[1].text:='���������: '+IntToStr(p);
StatusBar1.Panels[2].text:='��������: '+IntToStr(n);
StatusBar1.Panels[3].text:='�����: '+IntToStr(t);
RunGame:=True;
end else
ShowMessage('����������. �� ��������!!!');
end;

procedure TMainForm.EndGame();
begin
if t=0 then begin

ShootTimer.Enabled := false;
TimeTimer.Enabled := false;
RunGame:=false;

ResultForm.ShowModal;
end;
end;



end.
