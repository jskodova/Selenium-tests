*** Settings ***
| Library | DatabaseLibrary
| Library | Collections
| Library | String
| Library | BuiltIn
| Library | OperatingSystem

*** Variables ***
${dbname}=    testdb
${dbuser}=    admin
${dbpass}=    password
${dbhost}=    127.0.0.1
${dbport}=    3306
${initialdbname}=    mysql
${path}=    C:/Users/Dell Latitude 7390/Documents/GitHub/robotframework/
${createClauses}=    create_clauses.txt
@{ExpectedColumns}=    modulenbr    name    responsible_lecturer    credits
@{ExpectedColumnsAfterAdd}=    modulenbr    name    responsible_lecturer    credits    email

*** Keywords ***
Make connection
    [Arguments]    ${dbtoconnect}
    Connect To Database    pymysql    ${dbtoconnect}    ${dbuser}    ${dbpass}    ${dbhost}    ${dbport}    

Find and log columns
    @{ColumnList}=    Create List
    ${output}=    Query    describe module;
    ${length}=    Get Length    ${output}
    FOR    ${index}    IN RANGE    ${length}
        ${ColumnName}    Set Variable    ${output}[${index}][0]
        Append To List    ${ColumnList}    ${ColumnName}
    END
    Log    ${ColumnList}
    Set Global Variable    ${ColumnList}

*** Test Cases ***
Create a Database
    Make connection    ${initialdbname}
    Execute Sql String    drop database if exists ${dbname};
    Execute Sql String    create database ${dbname};
    Execute Sql String    use ${dbname};
    ${GetCommands}=    Get File    ${path}${createClauses}
    @{CreationCommands}=    Split String    ${GetCommands}    ;
    ${TableCount}=    Get Length    ${CreationCommands}
    Log    ${CreationCommands}
    Log    ${TableCount}
    ${IndexToBeRemoved}=    Evaluate    ${TableCount}-1
    Remove From List    ${CreationCommands}    ${IndexToBeRemoved}
    ${TableCount}=    Get Length    ${CreationCommands}
    Log    ${TableCount}
    FOR    ${index}    IN RANGE    ${TableCount}
        Execute Sql String    ${CreationCommands}[${index}]
    END
    Set Global Variable    ${TableCount}

*** Test Cases ***
Check connection
    Make connection    ${initialdbname}

*** Test Cases ***
Check columns
    Make connection    ${initialdbname}
    Find and log columns
*** Test Cases ***
Add a column
    Make connection    ${initialdbname}
    Find and log columns
    Should Be Equal    ${ExpectedColumns}    ${ColumnList}
    Execute Sql String    ALTER TABLE module ADD email varchar(255);
    Find and log columns
    Should Be Equal    ${ExpectedColumnsAfterAdd}    ${ColumnList}

*** Test Cases ***
Delete a column
    Make connection    ${initialdbname}
    Execute Sql String    ALTER TABLE module DROP COLUMN email;
    Find and log columns
    Should Be Equal    ${ExpectedColumns}    ${ColumnList}

Insert incorrect value
    Make connection    ${initialdbname}
    Run Keyword And Continue On Failure    Execute Sql String    insert into module values ('a710', 'Laskento ja laulanto', 'h290', 'wrong data type');
    Log    Attempted to insert incorrect value into the database

