using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Primitives;

namespace OdeToFood
{
    public class BasicAuthMiddleware
    {
        private readonly RequestDelegate _next;

        public BasicAuthMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            StringValues authHeader = context.Request.Headers["Authorization"];

            if (authHeader.Count == 0)
                await context.Response.WriteAsync("Not authorized!");
            else
                await _next(context);
        }
    }
}