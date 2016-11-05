unit UntManProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Data.Win.ADODB;

type
  TFrmManProduto = class(TForm)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    btn_Inserir: TToolButton;
    btn_Alterar: TToolButton;
    btn_Excluir: TToolButton;
    ToolButton4: TToolButton;
    btn_Sair: TToolButton;
    Panel2: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure btn_InserirClick(Sender: TObject);
    procedure btn_AlterarClick(Sender: TObject);
    procedure btn_ExcluirClick(Sender: TObject);
    procedure btn_SairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmManProduto: TFrmManProduto;

implementation

{$R *.dfm}

uses UntDM, UntCadProduto;

procedure TFrmManProduto.btn_AlterarClick(Sender: TObject);
begin
DM.ADODSSolucao.Edit;
FrmCadProduto.btn_Salvar.Enabled:= true;
FrmCadProduto.btn_Cancelar.Enabled:= true;
FrmCadProduto.btn_Sair.Enabled:= false;
FrmCadProduto.pnlFicha.Enabled:= true;
FrmCadProduto.ShowModal;
end;

procedure TFrmManProduto.btn_ExcluirClick(Sender: TObject);
var
  confExcl: integer;
begin
  confExcl := Application.MessageBox('Confirma a exclus�o deste registro?', 'Aten��o', MB_YESNO+MB_DEFBUTTON2+MB_ICONQUESTION);
  if confExcl = IDYES then
  begin
    DM.ADODSSolucao.Delete;
    Application.MessageBox('O registro foi exclu�do com sucesso.','Informa��o', MB_OK+MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('A exclus�o do registro foi abortada.','Informa��o', MB_OK+MB_ICONERROR);

end;

procedure TFrmManProduto.btn_InserirClick(Sender: TObject);
begin
DM.ADODSSolucao.Insert;
FrmCadProduto.btn_Salvar.Enabled:= true;
FrmCadProduto.btn_Cancelar.Enabled:= true;
FrmCadProduto.btn_Sair.Enabled:= false;
FrmCadProduto.pnlFicha.Enabled:= true;
FrmCadProduto.ShowModal;
end;

procedure TFrmManProduto.btn_SairClick(Sender: TObject);
begin
close;
end;


procedure TFrmManProduto.Edit1Change(Sender: TObject);
begin
  DM.ADODSSolucao.Locate('id',Edit1.Text,[loCaseInsensitive,loPartialKey]);

  {if CheckBox1.Checked = true then
  begin
  DM.ADODSSolucao.CommandText := 'SELECT id, especificacoes, preco FROM solucao WHERE tipo = "Produto" ORDER BY especificacoes';
  end
  else if CheckBox2.Checked = true then
  begin
  DM.ADODSSolucao.CommandText := 'SELECT id, especificacoes, preco FROM solucao WHERE tipo = "Servi�o" ORDER BY especificacoes';
  end
  else if (CheckBox1.Checked = true) and (CheckBox2.Checked = true) then
  begin
  DM.ADODSSolucao.CommandText := 'SELECT id, especificacoes, preco FROM solucao ORDER BY especificacoes';
  end;}

end;

procedure TFrmManProduto.FormActivate(Sender: TObject);
begin
DM.ADODSSolucao.Close;
DM.ADODSSolucao.CommandText:= '';
DM.ADODSSolucao.CommandText:= 'select * from SOLUCAO order by id';
DM.ADODSSolucao.Open;
end;

end.
