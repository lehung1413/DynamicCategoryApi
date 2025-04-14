using DCM.Core.Dtos;

namespace DCM.Application.Interfaces
{
    public interface ISessionService
    {
        Task<IEnumerable<SessionDto>> SearchByCategoryAsync(int categoryId);
        Task<IEnumerable<SessionDto>> PreviewSessionAsync(CategoryDto request);
    }
}
