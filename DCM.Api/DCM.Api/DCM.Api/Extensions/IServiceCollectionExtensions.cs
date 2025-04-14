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
            services.AddScoped<ICategoryService, CategoryService>();
            services.AddScoped<ITagService, TagService>();

            // Register repositories
            services.AddRepositoryCollection();

            return services;
        }
    }
}
