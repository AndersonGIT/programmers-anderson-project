Imports System.Globalization
Imports System.Web.Services

Public Class AmountConvertPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    <WebMethod()>
    Public Shared Function ConvertAmountToWords(amount As Long) As String
        If amount = 0 Then Return "zero"
        If amount >= 1000000000000 Then Return "Limit of 1000000000000 reached"

        Dim dollars As Long = Math.Floor(amount)
        Dim cents As Integer = CInt((amount - dollars) * 100)

        Dim dollarsText As String = NumberToWordsEnglish(dollars)
        Dim centsText As String = cents.ToString("00")

        Return $"{dollarsText} and {centsText}/100 dollars"
    End Function

    Shared Function NumberToWordsEnglish(number As Long) As String
        If number < 0 Then Return "minus " & NumberToWordsEnglish(Math.Abs(number))

        Dim words As New StringBuilder()

        Dim unitsMap() As String = {"zero", "one", "two", "three", "four", "five",
                                    "six", "seven", "eight", "nine", "ten", "eleven",
                                    "twelve", "thirteen", "fourteen", "fifteen",
                                    "sixteen", "seventeen", "eighteen", "nineteen"}

        Dim tensMap() As String = {"zero", "ten", "twenty", "thirty", "forty", "fifty",
                                   "sixty", "seventy", "eighty", "ninety"}

        If (number \ 1000000000) > 0 Then
            words.Append(NumberToWordsEnglish(number \ 1000000000) & " billion ")
            number = number Mod 1000000000
        End If

        If (number \ 1000000) > 0 Then
            words.Append(NumberToWordsEnglish(number \ 1000000) & " million ")
            number = number Mod 1000000
        End If

        If (number \ 1000) > 0 Then
            words.Append(NumberToWordsEnglish(number \ 1000) & " thousand ")
            number = number Mod 1000
        End If

        If (number \ 100) > 0 Then
            words.Append(NumberToWordsEnglish(number \ 100) & " hundred ")
            number = number Mod 100
        End If

        If number > 0 Then
            If words.Length > 0 Then words.Append(" ")

            If number < 20 Then
                words.Append(unitsMap(number))
            Else
                words.Append(tensMap(number \ 10))
                If (number Mod 10) > 0 Then
                    words.Append("-" & unitsMap(number Mod 10))
                End If
            End If
        End If

        Return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(words.ToString().Trim())
    End Function

End Class