using DCM.Core.Dtos;

namespace DCM.Core.Repositories
{
    public interface ITagRepository
    {
        Task<IEnumerable<DropdownDto>> GetAllTagsAsync();
    }
}
