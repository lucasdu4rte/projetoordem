unit UntDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADODSCliente: TADODataSet;
    DSCliente: TDataSource;
    ADODSFuncionario: TADODataSet;
    ADODSOrdemServico: TADODataSet;
    ADODSSolucao: TADODataSet;
    DSFuncionario: TDataSource;
    DSOrdemServico: TDataSource;
    DSSolucao: TDataSource;
    ADODSSolucaoXOrdem: TADODataSet;
    DSSolucaoXOrdem: TDataSource;
    ADODSClientenome_razao: TStringField;
    ADODSClientecpf_cnpj: TStringField;
    ADODSClienterg_ie: TStringField;
    ADODSClientedata_nasc: TStringField;
    ADODSClienteendereco: TStringField;
    ADODSClientecep: TStringField;
    ADODSClientecidade: TStringField;
    ADODSClienteestado: TStringField;
    ADODSClientetelefone: TStringField;
    ADODSClientecelular: TStringField;
    ADODSClienteemail: TStringField;
    ADODSClientetipo: TStringField;
    ADODSClientebairro: TStringField;
    ADODSClienteid: TAutoIncField;
    ADODSOrdemServiconumero: TAutoIncField;
    ADODSOrdemServicoid_cliente: TIntegerField;
    ADODSOrdemServicoid_funcionario: TIntegerField;
    ADODSOrdemServicodescri_equipamento: TStringField;
    ADODSOrdemServicodata_inicio: TStringField;
    ADODSOrdemServicodata_termino: TStringField;
    ADODSOrdemServicoobservacoes: TStringField;
    ADODSOrdemServicoserie_equipamento: TStringField;
    ADODSOrdemServicostatus_ordem: TStringField;
    ADODSOrdemServicovalor_produtos: TFloatField;
    ADODSOrdemServicovalor_total: TFloatField;
    ADODSSolucaoid: TAutoIncField;
    ADODSSolucaopreco: TFloatField;
    ADODSSolucaoespecificacoes: TStringField;
    ADODSSolucaomarca: TStringField;
    ADODSSolucaoquantidade: TIntegerField;
    ADODSSolucaotipo: TStringField;
    ADODSSolucaoXOrdemid_solucao: TIntegerField;
    ADODSSolucaoXOrdemnum_os: TIntegerField;
    ADODSSolucaoXOrdemvalor_unit: TFloatField;
    ADODSSolucaoXOrdemquant: TIntegerField;
    ADODSSolucaoXOrdemvalor_total: TFloatField;
    ADODSSolucaoXOrdemNomeProduto2: TStringField;
    ADODSFuncionarioid: TAutoIncField;
    ADODSFuncionariocargo: TStringField;
    ADODSFuncionarionome_func: TStringField;
    ADODSFuncionariocpf: TStringField;
    ADODSFuncionariorg: TStringField;
    ADODSFuncionariodata_nasc: TStringField;
    ADODSFuncionarioendereco: TStringField;
    ADODSFuncionariocep: TStringField;
    ADODSFuncionariobairro: TStringField;
    ADODSFuncionariocidade: TStringField;
    ADODSFuncionarioestado: TStringField;
    ADODSFuncionariotelefone: TStringField;
    ADODSFuncionariocelular: TStringField;
    ADODSFuncionarioemail: TStringField;
    procedure ADODSSolucaoXOrdemid_produtoValidate(Sender: TField);
    procedure ADODSSolucaoXOrdemAfterPost(DataSet: TDataSet);
    procedure ADODSSolucaoXOrdemAfterDelete(DataSet: TDataSet);
    procedure ADODSSolucaoXOrdemNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UntManOS;

{$R *.dfm}

procedure TDM.ADODSSolucaoXOrdemAfterDelete(DataSet: TDataSet);
var
  bmk: TBookmark;
  valTot: double;
begin
with ADODSSolucaoXOrdem do
  begin
    bmk := GetBookmark;
    DisableControls;
    try
      valTot:= 0.0;
      First;
      while not EOF do
      begin
        valTot:= valTot + ADODSSolucaoXOrdemvalor_total.AsFloat;
        Next;
      end;
    finally
    EnableControls;
    if bmk <> nil then
    begin
      GotoBookmark(bmk);
      FreeBookmark(bmk);
    end;
    end;
    if not (ADODSOrdemServico.State in [dsInsert, dsEdit]) then
    ADODSOrdemServico.Edit;

    ADODSOrdemServicovalor_produtos.AsFloat:= valTot;
    ADODSOrdemServicovalor_total.AsFloat := valTot;

  end;
end;

procedure TDM.ADODSSolucaoXOrdemAfterPost(DataSet: TDataSet);
var
  bmk: TBookmark;
  valTot: double;
begin
with ADODSSolucaoXOrdem do
  begin
    bmk := GetBookmark;
    DisableControls;
    try
      valTot:= 0.0;
      First;
      while not EOF do
      begin
        valTot:= valTot + ADODSSolucaoXOrdemvalor_total.AsFloat;
        Next;
      end;
    finally
    EnableControls;
    if bmk <> nil then
    begin
      GotoBookmark(bmk);
      FreeBookmark(bmk);
    end;
    end;
    if not (ADODSOrdemServico.State in [dsInsert, dsEdit]) then
    ADODSOrdemServico.Edit;

    ADODSOrdemServicovalor_produtos.AsFloat:= valTot;
    ADODSOrdemServicovalor_total.AsFloat := valTot;

  end;
end;

procedure TDM.ADODSSolucaoXOrdemid_produtoValidate(Sender: TField);
begin
  if not FrmManOS.ADOQueryProduto.Locate('id', ADODSSolucaoXOrdemid_solucao.AsString, []) then
    begin
      MessageDlg('Produto n�o encontrado.',mtError,[mbOK], 0);
      Abort;
    end
    else
    begin
      ADODSSolucaoXOrdemvalor_unit.AsFloat := FrmManOS.ADOQueryProdutopreco.AsFloat;
      ADODSSolucaoXOrdemquant.AsInteger := 1;
      ADODSSolucaoXOrdemvalor_total.AsFloat := FrmManOS.ADOQueryProdutopreco.AsFloat;
      FrmManOS.DBEdit5.SetFocus;
    end;

end;

procedure TDM.ADODSSolucaoXOrdemNewRecord(DataSet: TDataSet);
begin
  ADODSSolucaoXOrdemnum_os.AsInteger := ADODSOrdemServiconumero.AsInteger;
end;

end.
