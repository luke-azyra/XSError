using System.Net.NetworkInformation;
using System.Threading.Tasks;

namespace CSClassHolder
{
    public class Awaitable
    {
        private string Message { get; set; }

        public Awaitable()
        {
            Message = "Hello World!";
        }

        public async Task<string> GetMessageAsync()
        {
            await Task.Delay(5000);
            return Message;
        }
    }
    public static class Runable
    {
        private static Awaitable AwaitThisObject { get; set; }

        public static void Run() => Task.Run(async () => await AwaitThisObject?.GetMessageAsync()).Wait();
    }
}