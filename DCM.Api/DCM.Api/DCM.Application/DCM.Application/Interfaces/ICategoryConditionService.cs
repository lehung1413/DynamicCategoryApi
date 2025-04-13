using DCM.Core.Dtos;

namespace DCM.Application.Interfaces
{
    public interface ICategoryConditionService
    {
        Task<List<int>> AddOrUpdateCategoryConditionsAsync(List<CategoryConditionDto> request);
    }
}
