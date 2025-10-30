<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="PalindromeCheckPage.aspx.vb" Inherits="WebProject.PalindromeCheckPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function () {
            $("#btnPalindromeCheckAjax").click(function () {
                var valueInput = $("#valueInput").val();

                if (!valueInput) {
                    showAlertMessage('The input is not a valid positive number, try again.', 'ALERT-WARNING');
                } else {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveUrl("PalindromeCheckPage.aspx/IsPalindrome") %>',
                    data: JSON.stringify({ input: valueInput }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d) {
                            $('#txtResult').val(valueInput + ' is Palindrome.');
                        } else {
                            $("#txtResult").val(valueInput + ' is NOT Palindrome.');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error: " + error);
                    }
                });
            }
        });
    });

        $(document).ready(function () {
            $("#btnPalindromeCheckJS").click(function () {
                var valueInput = $("#valueInput").val();

                if (!valueInput) {
                    showAlertMessage('The input is not a valid positive number, try again.', 'ALERT-WARNING');
                } else {
                    var result = isPalindrome(valueInput);
                    if (result) {
                        $('#txtResult').val(valueInput + ' is Palindrome.');
                    } else {
                        $("#txtResult").val(valueInput + ' is NOT Palindrome.');
                    }
                }
            });

            function isPalindrome(num) {
                if (num < 0) return false;

                const str = num.toString();
                const reversed = str.split('').reverse().join('');

                return str === reversed;
            }
        });
    </script>
    <div class="row">
        <div class="col-md-12">
            <h2>Palindrome Check</h2>
            <p>
                This page is responsible to check if a page is palindrome or not.
            </p>
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <div class="form-group">
                <label for="lblValueToCheck">Value To Check</label>
                <input runat="server" class="form-control" id="valueInput" ClientIdMode="Static" aria-describedby="amountHelp" placeholder="Enter a positive number:">
                <small id="valueInputHelp" class="form-text text-muted">The number to check if it is Palindrome or not.</small>
                <p>
                    <br />
                    <button type="button" runat="server" class="btn btn-primary" id="btnPalindromeCheckAjax" ClientIdMode="Static">Check</button>
                    <button type="button" runat="server" class="btn btn-secondary" id="btnPalindromeCheckJS" ClientIdMode="Static">Check JS</button>
                </p>
            </div>
            <div class="form-group">
                <label for="lblResult">Result</label>
                <input runat="server" type="text" class="form-control" ClientIdMode="Static" id="txtResult" disabled>
            </div>
        </div>
    </div>
</asp:Content>
