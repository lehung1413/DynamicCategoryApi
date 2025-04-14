using DCM.Application.Interfaces;
using DCM.Core.Dtos;
using DCM.Core.Repositories;

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
            return await _categoryRepository.InsertOrUpdateAsync(request);
        }

        public async Task<bool> DeleteAsync(long id)
        {
            return (await _categoryRepository.DeleteAsync(id));
        }

        public async Task<IEnumerable<CategoryDto>> GetAllAsync()
        {
            return await _categoryRepository.GetAllAsync();
        }

        public async Task<CategoryDto> GetByIdAsync(long id)
        {
            return await _categoryRepository.GetByIdAsync(id);
        }
    }
}
