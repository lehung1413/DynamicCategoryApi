using DCM.Application.Dtos;
using DCM.Application.Interfaces;
using DCM.Core.Repositories;
using Mapster;

namespace DCM.Application.Services
{
    public class TagService : ITagService
    {
        private readonly ITagRepository _tagRepository;

        public TagService(ITagRepository tagRepository)
        {
            _tagRepository = tagRepository ?? throw new ArgumentNullException(nameof(tagRepository), "Tag repository cannot be null.");
        }

        public async Task<IEnumerable<DropdownDto>> GetAllTagsAsync()
        {
            return (await _tagRepository.GetAllTagsAsync()).Adapt<IEnumerable<DropdownDto>>();
        }
    }
}
