using DCM.Core.Entities;

namespace DCM.Core.Repositories
{
    public interface ICategoryRepository
    {
        Task<IEnumerable<Category>> GetAllAsync();
        Task<Category> GetByIdAsync(long id);
        Task<int> InsertOrUpdateAsync(Category request);
        Task<bool> DeleteAsync(long id);
    }
}
