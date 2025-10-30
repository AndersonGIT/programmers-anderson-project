<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AmountConvertPage.aspx.vb" Inherits="WebProject.AmountConvertPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function () {
            $("#btnAmountConvertAjax").click(function () {
                var amountInputValue = $("#amountValue").val();

                if (!amountInputValue) {
                    showAlertMessage('The input is not a valid number, try again.', 'ALERT-WARNING');
                } else {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveUrl("AmountConvertPage.aspx/ConvertAmountToWords") %>',
                        data: JSON.stringify({ amount: amountInputValue }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d) {
                                $('#txtResult').val(response.d);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error: " + error);
                        }
                    });
                }
            });
        });
    </script>

    <div class="row">
        <div class="col-md-12">
            <h2>Amount Converter</h2>
            <p>
                This page is responsible to convert the amount into text extension value.
            </p>
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <div class="form-group">
                <label for="lblAmount">Amount</label>
                
                <input runat="server" type="number" min="1" step="any" class="form-control" id="amountValue" clientidmode="Static" aria-describedby="amountHelp" placeholder="Enter amount" width="300px">
                <small id="amountHelp" class="form-text text-muted">The amount value to be writen in extension.</small>
                <p>
                    <br />
                    <button type="button" class="btn btn-primary" id="btnAmountConvertAjax" clientidmode="Static">Convert</button>
                </p>
            </div>
            <div class="form-group">
                <label for="lblResult">Result</label>
                <textarea  ClientDdMode="Static" class="form-control" id="txtResult" rows="6" disabled></textarea>
            </div>
        </div>
    </div>
</asp:Content>
