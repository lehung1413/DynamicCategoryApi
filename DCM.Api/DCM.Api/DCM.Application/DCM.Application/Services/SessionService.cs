using DCM.Application.Dtos;
using DCM.Application.Interfaces;
using DCM.Core.Entities;
using DCM.Core.Repositories;
using Mapster;

namespace DCM.Application.Services
{
    public class SessionService : ISessionService
    {
        private readonly ISessionRepository _sessionRepository;

        public SessionService(ISessionRepository sessionRepository)
        {
            _sessionRepository = sessionRepository;
        }

        public async Task<IEnumerable<SessionDto>> PreviewSessionAsync(CategoryDto request)
        {
            var category = request.Adapt<Category>();
            return (await _sessionRepository.PreviewSessionAsync(category)).Adapt<IEnumerable<SessionDto>>();
        }

        public async Task<IEnumerable<SessionDto>> SearchByCategoryAsync(int categoryId)
        {
            return (await _sessionRepository.GetSessionsByCategoryAsync(categoryId)).Adapt<IEnumerable<SessionDto>>();
        }
    }
}
