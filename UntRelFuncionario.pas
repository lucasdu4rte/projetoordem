unit UntRelFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  frxClass, frxDBSet, Data.DB, Data.Win.ADODB;

type
  TFrmRelFuncionario = class(TForm)
    Panel1: TPanel;
    EdtCodigoDe: TLabeledEdit;
    EdtCodigoAte: TLabeledEdit;
    EdtNomeDe: TLabeledEdit;
    EdtNomeAte: TLabeledEdit;
    RadioGroup1: TRadioGroup;
    ADOQryFuncionario: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADOQryFuncionarioid: TAutoIncField;
    ADOQryFuncionariocargo: TStringField;
    ADOQryFuncionarionome_func: TStringField;
    ADOQryFuncionariocpf: TStringField;
    ADOQryFuncionariorg: TStringField;
    ADOQryFuncionariodata_nasc: TStringField;
    ADOQryFuncionarioendereco: TStringField;
    ADOQryFuncionariocep: TStringField;
    ADOQryFuncionariobairro: TStringField;
    ADOQryFuncionariocidade: TStringField;
    ADOQryFuncionarioestado: TStringField;
    ADOQryFuncionariotelefone: TStringField;
    ADOQryFuncionariocelular: TStringField;
    ADOQryFuncionarioemail: TStringField;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelFuncionario: TFrmRelFuncionario;

implementation

{$R *.dfm}

uses UntDM;

procedure TFrmRelFuncionario.BitBtn1Click(Sender: TObject);
 var strliga: string;
begin
  strliga := 'where ';
  ADOQryFuncionario.Close;
  with ADOQryFuncionario.SQL do
  begin
    clear;
    Add('select * from funcionarios ');
    if EdtCodigoDe.Text <> '' then
    try
      strtoint(EdtCodigoDe.Text);
      Add(strliga+'id >= '+ EdtCodigoDe.Text);
      strliga:= ' and ';
    except
      on EConvertError do;
    end;
      if EdtCodigoAte.Text <> '' then
      try
        strtoint(EdtCodigoAte.Text);
        Add(strliga+'id <= '+EdtCodigoAte.Text);
        strliga:= ' and ';
      except
      on EConvertError do;
      end;
      if EdtNomeDe.Text <> '' then
      begin
        Add(strliga+'nome_func <= ''' + EdtNomeAte.Text + 'zzz''');
        strliga := ' and ';
      end;
        case RadioGroup1.ItemIndex of
        0: Add(' order by id');
        1: Add(' order by nome_func');
        end;
  end;
  ADOQryFuncionario.Open;
  frxReport1.ShowReport();
end;

procedure TFrmRelFuncionario.BitBtn2Click(Sender: TObject);
begin
Close;
end;

end.
