USING System
USING System.Collections.Generic
USING System.Linq
USING System.Text


FUNCTION Start() AS VOID STRICT
    Console.WriteLine("Testing Console")
    Console.WriteLine("Creating Class")
    LOCAL oTesting AS TestClass
    oTesting := TestClass{}
    Console.WriteLine("Testing Output")
    Console.WriteLine(oTesting:cOutput)
    Console.WriteLine()
    Console.WriteLine("Testing Error Code")
    Console.WriteLine()

    TRY
        send(oTesting, "TestOutput")

    CATCH e AS Exception

        Console.WriteLine("There is an error")
        Console.WriteLine()
        Console.WriteLine("Raw Exception output")
        Console.WriteLine()
        Console.WriteLine(e)
        Console.WriteLine()
        Console.WriteLine("Raw InnerException Output")
        Console.WriteLine()
        Console.WriteLine(e:InnerException)
        Console.WriteLine()
    END TRY

    Console.WriteLine("Ending Test")
    Console.ReadLine()
RETURN


CLASS TestClass
PUBLIC cOutput AS STRING

CONSTRUCTOR

    cOutput := "Hello X#"

RETURN

METHOD TestOutput() AS VOID
    
    CSClassHolder.Runable.Run()

RETURN

END CLASS