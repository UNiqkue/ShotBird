unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TResultForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResultForm: TResultForm;



implementation

{$R *.dfm}

uses Unit1;

procedure TResultForm.Button1Click(Sender: TObject);
begin
MainForm.NextLevel();
Button1.Enabled:=false;
Close;
end;

procedure TResultForm.Button2Click(Sender: TObject);
begin
 try
 s := TStringList.Create;
 s.Add(IntToStr(Level));
  s.Add(IntToStr(TimeForShoot));
  s.SaveToFile('Level.txt');  s.Free;
  ShowMessage('Игра сохранена');
  except
  ShowMessage('Не удалось сохранить игру');
  end;

end;

procedure TResultForm.Button3Click(Sender: TObject);
begin
Close;
end;

procedure TResultForm.FormShow(Sender: TObject);
begin
Label2.Caption:='Количество выстрелов: '+IntTostr(n+p);
Label3.Caption:='Количество попаданий: '+IntTostr(p);
Label4.Caption:='Количество промахов: '+IntTostr(n);
if p>9 then begin
inc(Level);//увеличиваем уровень на 1
TimeForShoot:=TimeForShoot-100;//уменьшаем интервал на 100
Button1.Enabled:=true;

end;
end;

end.
