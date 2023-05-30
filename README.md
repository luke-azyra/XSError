# Demo App to Display Error Object Output
During a recent hunt for an error it was found that the X# code would wrap a thrown error in the `Error` object. This seems to be discarding information in this case that helps solve where the error is occurring.

During operations a `TargetInvocationException` was thrown and caught by `SendHelper(oObject as object, mi as MethodInfo , uArgs as usual[], result out usual)`. The InnerException is then passed to the `Error` object which further parses it's own stack trace.

The DemoApp project has three Solution configurations that help to test what is going on.

1. Test 1 - This configuration uses the orignal code for `SendHelper`
2. Test 2 - This configuration passes the full error into the `Error`object
3. Test 3 - This removes the `Error` object completely and shows the stack trace native to the runtime.

The Example code uses a similar workflow to how the issue was highlighted within our code but isolated as a demonstration.

## Test 1
This configuration uses the original code for `XSharp.RT`. The RT DLL can be found in `.\LocalDlls\Test1` and looks like the following:

![Test1Code](Images/Test1Code.png)

Line 1045 is where the error is being rewrapped and thrown on. When the Test 1 configuration is outputted, we get the following:

![Test1Output](Images/Test1Output.png)

The StackTrace tells me there is an error, but it is not telling me where to find the error. The Inner Exception that is contained within shows me roughly what error was thrown but it is difficult to extract where it is unless I know exactly what was called and where.

## Test 2
This configuration still uses the `Error` object however the creation of the object is passed the full exception. The RT DLL can be found in `.\LocalDlls\Test2` and looks like the following:

![Test2Code](Images/Test2Code.png)

This change outputs the following:

![Test2Output](Images/Test2Output.png)

This change seems to show me a bit more inside of the Inner Exception of the Error object. In particular it shows me line 51 of `Program.prg` which is the `CSClassHolder.Runable.Run()` method that is causing the issue.

## Test 3
This configuration doesn't use the `Error` object at all and just returns the raw exception. The RT DLL can be found in `.\LocalDlls\Test3` and looks like the following:

![Test3Code](Images/Test3Code.png)

This change outputs the following:

![Test3Output](Images/Test3Output.png)

Is it possible to include this information in the Error objects stack trace as well? 