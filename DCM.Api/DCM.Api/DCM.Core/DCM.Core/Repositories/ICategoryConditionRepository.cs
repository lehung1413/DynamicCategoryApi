using DCM.Core.Dtos;

namespace DCM.Core.Repositories
{
    public interface ICategoryConditionRepository
    {
        Task<List<int>> AddOrUpdateCategoryConditionsAsync(List<CategoryConditionDto> request);
    }
}
