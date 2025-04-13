using DCM.Application.Interfaces;
using DCM.Core.Dtos;
using DCM.Core.Repositories;

namespace DCM.Application.Services
{
    public class CategoryConditionService: ICategoryConditionService
    {
        private readonly ICategoryConditionRepository _repository;

        public CategoryConditionService(ICategoryConditionRepository repository)
        {
            _repository = repository;
        }

        public async Task<List<int>> AddOrUpdateCategoryConditionsAsync(List<CategoryConditionDto> request)
        {
            var ids = await _repository.AddOrUpdateCategoryConditionsAsync(request);

            return ids;
        }
    }
}
