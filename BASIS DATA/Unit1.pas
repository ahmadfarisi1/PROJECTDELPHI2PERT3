unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, TeEngine, Series, ExtCtrls,
  TeeProcs, Chart, RzButton;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Button1: TButton;
    DBGrid1: TDBGrid;
    Chart1: TChart;
    Series1: TBarSeries;
    PRINT: TRzBitBtn;
    LOADDATA: TRzBitBtn;
    TAMBAHDATA: TRzBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure LOADDATAClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i:Integer;
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('select Count(no)as jumlah_kelas,sum(kehadiran_total) as total_siswa,kelas as nama_kelas from jadwal_db group by kelas');
  ADOQuery1.Open;

  Chart1.Series[0].Clear;
  for i:=1 to Adoquery1.recordcount do
  begin
    Chart1.Series[0].Add(StrToInt(ADOQuery1.fieldbyname('total_siswa').AsString),ADOQuery1.Fields[2].AsString);
    ADOQuery1.Next;
  end;
  DBGrid1.Columns[2].Width:=90;
end;

procedure TForm1.LOADDATAClick(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('select * from jadwal_db');
  ADOQuery1.Open;

  DBGrid1.Columns[0].Width:=30;
  DBGrid1.Columns[3].Width:=90;
  DBGrid1.Columns[5].Width:=50;
  DBGrid1.Columns[6].Width:=110;
  DBGrid1.Columns[7].Width:=90;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
Chart1.Title.Text.Add('GRAFIK KEHADIRAN PRAKTIKUM SISWA');
  DBGrid1.Columns[0].Width:=30;
  DBGrid1.Columns[3].Width:=90;
  DBGrid1.Columns[5].Width:=50;
  DBGrid1.Columns[6].Width:=110;
  DBGrid1.Columns[7].Width:=90;
end;

end.
