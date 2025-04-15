using DCM.Application.Dtos;
using DCM.Core.Entities;
using Mapster;

namespace DCM.Application.Mappings
{
    public static class MapsterConfig
    {
        public static void Configure()
        {
            TypeAdapterConfig<Category, CategoryDto>.NewConfig()
                .Map(dest => dest.CategoryConditions, src => src.CategoryConditions);

            TypeAdapterConfig<CategoryDto, Category>.NewConfig()
                .Map(dest => dest.CategoryConditions, src => src.CategoryConditions);

            TypeAdapterConfig<CategoryCondition, CategoryConditionDto>.NewConfig();
            TypeAdapterConfig<CategoryConditionDto, CategoryCondition>.NewConfig();

            TypeAdapterConfig<Session, SessionDto>.NewConfig();
            TypeAdapterConfig<SessionDto, Session>.NewConfig();

            TypeAdapterConfig<Dropdown, DropdownDto>.NewConfig();
            TypeAdapterConfig<DropdownDto, Dropdown>.NewConfig();
        }
    }
}
