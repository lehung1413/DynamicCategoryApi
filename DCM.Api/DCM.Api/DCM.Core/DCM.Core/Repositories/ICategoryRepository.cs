using DCM.Core.Dtos;

namespace DCM.Core.Repositories
{
    public interface ICategoryRepository
    {
        Task<IEnumerable<CategoryDto>> GetAllAsync();
        Task<CategoryDto> GetByIdAsync(long id);
        Task<int> InsertOrUpdateAsync(CategoryDto request);
        Task<bool> DeleteAsync(long id);
    }
}
