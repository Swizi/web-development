PROGRAM PrintHelloHttp(INPUT, OUTPUT);
USES dos;
VAR
  Name, NameParameter: STRING;

FUNCTION GetQueryStringParameter(VAR Parameter: STRING): STRING;
VAR
  QueryString, ParameterWithEquality: STRING;
  QueryLength, ValueLength: INTEGER;
BEGIN {GetQueryStringParameter}
  QueryString := GetEnv('QUERY_STRING');
  QueryLength := LENGTH(QueryString);
  ParameterWithEquality := CONCAT(Parameter, '=');
  IF (POS(ParameterWithEquality, QueryString) <> 0)
  THEN
    BEGIN
      QueryString := COPY(QueryString, POS(ParameterWithEquality, QueryString), QueryLength);
      IF (POS('&', QueryString) <> 0)
      THEN
        BEGIN
          ValueLength := POS('&', QueryString)-1 - POS('=', QueryString);
          GetQueryStringParameter := COPY(QueryString, POS('=', QueryString)+1, ValueLength)
        END
      ELSE
        GetQueryStringParameter := COPY(QueryString, POS('=', QueryString)+1, QueryLength)
    END
  ELSE
    GetQueryStringParameter := ''
END; {GetQueryStringParameter}

PROCEDURE CreateHttpResponse(VAR Message: STRING);
BEGIN {CreateHttpResponse}
  WRITELN('Content-Type: text/plain');
  WRITELN;
  WRITELN(Message)
END; {CreateHttpResponse}

PROCEDURE PrintHello(VAR Name: STRING);
VAR
  HelloMessage: STRING;
BEGIN {PrintHello}
  IF (Name <> '')
  THEN
    HelloMessage := CONCAT('Hello dear, ', Name)
  ELSE
    HelloMessage := 'Hello, Anonymous';
  CreateHttpResponse(HelloMessage)
END; {PrintHello}

BEGIN {PrintHelloHttp}
  NameParameter := 'name';
  Name := GetQueryStringParameter(NameParameter);
  PrintHello(Name)
END. {PrintHelloHttp}

