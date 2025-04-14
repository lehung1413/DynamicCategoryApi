﻿using DCM.Application.Interfaces;
using DCM.Core.Dtos;
using DCM.Core.Repositories;

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
            return await _sessionRepository.PreviewSessionAsync(request);
        }

        public async Task<IEnumerable<SessionDto>> SearchByCategoryAsync(int categoryId)
        {
            return await _sessionRepository.GetSessionsByCategoryAsync(categoryId);
        }
    }
}
