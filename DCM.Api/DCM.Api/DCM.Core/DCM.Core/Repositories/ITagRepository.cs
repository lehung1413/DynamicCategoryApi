using DCM.Core.Entities;

namespace DCM.Core.Repositories
{
    public interface ITagRepository
    {
        Task<IEnumerable<Dropdown>> GetAllTagsAsync();
    }
}
