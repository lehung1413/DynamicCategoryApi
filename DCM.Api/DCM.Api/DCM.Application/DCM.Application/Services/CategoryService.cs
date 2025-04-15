using DCM.Application.Dtos;
using DCM.Application.Interfaces;
using DCM.Core.Entities;
using DCM.Core.Repositories;
using Mapster;

namespace DCM.Application.Services
{
    public class CategoryService : ICategoryService
    {
        private readonly ICategoryRepository _categoryRepository;

        public CategoryService(ICategoryRepository categoryRepository)
        {
            _categoryRepository = categoryRepository;
        }

        public async Task<int> InsertOrUpdateAsync(CategoryDto request)
        {
            var category = request.Adapt<Category>();
            return await _categoryRepository.InsertOrUpdateAsync(category);
        }

        public async Task<bool> DeleteAsync(long id)
        {
            return (await _categoryRepository.DeleteAsync(id));
        }

        public async Task<IEnumerable<CategoryDto>> GetAllAsync()
        {
            return (await _categoryRepository.GetAllAsync()).Adapt<List<CategoryDto>>();
        }

        public async Task<CategoryDto> GetByIdAsync(long id)
        {
            return (await _categoryRepository.GetByIdAsync(id)).Adapt<CategoryDto>(); ;
        }
    }
}
