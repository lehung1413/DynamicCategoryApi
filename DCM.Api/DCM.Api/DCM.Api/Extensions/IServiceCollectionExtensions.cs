using DCM.Application.Extensions;
using DCM.Application.Interfaces;
using DCM.Application.Services;

namespace DCM.Api.Extensions
{
    public static class IServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            // Register services
            services.AddScoped<ISessionService, SessionService>();

            // Register repositories
            services.AddRepositoryCollection();

            return services;
        }
    }
}
