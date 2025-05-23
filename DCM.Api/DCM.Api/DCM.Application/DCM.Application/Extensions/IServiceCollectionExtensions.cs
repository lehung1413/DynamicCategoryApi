﻿using DCM.Core.Repositories;
using DCM.Repository;
using Microsoft.Extensions.DependencyInjection;

namespace DCM.Application.Extensions
{
    public static class IServiceCollectionExtensions
    {
        public static IServiceCollection AddRepositoryCollection(this IServiceCollection services)
        {

            // Register repositories
            services.AddScoped<ISessionRepository, SessionRepository>();
            services.AddScoped<ICategoryRepository, CategoryRepository>();
            services.AddScoped<ITagRepository, TagRepository>();

            return services;
        }
    }
}
