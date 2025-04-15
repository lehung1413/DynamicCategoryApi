using DCM.Application.Dtos;

namespace DCM.Application.Interfaces
{
    public interface ICategoryService
    {
        Task<IEnumerable<CategoryDto>> GetAllAsync();
        Task<CategoryDto> GetByIdAsync(long id);
        Task<int> InsertOrUpdateAsync(CategoryDto request);
        Task<bool> DeleteAsync(long id);
    }
}
