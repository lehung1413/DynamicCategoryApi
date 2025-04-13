using DCM.Application.Interfaces;
using DCM.Core.Dtos;
using DCM.Core.Repositories;

namespace DCM.Application.Services
{
    public class SessionService : ISessionService
    {
        private readonly ISessionRepository _sessionRepository;

        /// <summary>
        /// Initializes a new instance of the <see cref="SessionService"/> class.
        /// </summary>
        /// <param name="sessionRepository">Repository for accessing session data.</param>
        public SessionService(ISessionRepository sessionRepository)
        {
            _sessionRepository = sessionRepository;
        }

        public async Task<IEnumerable<SessionDto>> SearchByCategoryAsync(int categoryId)
        {
            return await _sessionRepository.GetSessionsByCategoryAsync(categoryId);
        }
    }
}
