*** Settings ***
Documentation     Read invoice data from PDF file and export to tabulated Excel file
Library           RPA.PDF
Library           RPA.FileSystem
# Library         RPA.Tables
Library           RPA.Excel.Files
Library           Collections

*** Variables ***
${TXT_OUTPUT_DIRECTORY_PATH}=    ${CURDIR}${/}output${/}
${EXCEL_FILE}     ./output/output.xlsx

*** Keywords ***
Extract invoice details from PDF file into a excel file
    [Arguments]    ${pdf_file_name}
    ${text}=    Get Text From Pdf    ${pdf_file_name}
    # ${Date} =    Find Text    DATE
    # Log List ${Date}
    Create File    ${TXT_OUTPUT_DIRECTORY_PATH}${pdf_file_name}.txt
    FOR    ${page}    IN    @{text.keys()}
        Append To File
        ...    ${TXT_OUTPUT_DIRECTORY_PATH}${pdf_file_name}.txt
        ...    ${text[${page}]}
    END
    Create Workbook    ${EXCEL_FILE}
    FOR    ${page}    IN    @{text.keys()}
        &{row}=    Create Dictionary
        ...    Mail    @{text.keys()}
        ...    Data    ${text[${page}]}
        Append Rows to Worksheet    ${row}    header=${TRUE}
    END
    Save Workbook

*** Tasks ***
Extract invoice details from PDF file into a excel file
    Extract invoice details from PDF file into a excel file    invoice1.pdf
    # Extract invoice details from PDF file into a excel file    invoice2.pdf
