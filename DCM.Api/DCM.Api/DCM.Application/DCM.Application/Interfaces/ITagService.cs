using DCM.Core.Dtos;

namespace DCM.Application.Interfaces
{
    public interface ITagService
    {
        Task<IEnumerable<DropdownDto>> GetAllTagsAsync();
    }
}
