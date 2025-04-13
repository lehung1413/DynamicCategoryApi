using DCM.Core.Dtos;

namespace DCM.Application.Interfaces
{
    public interface ISessionService
    {
        /// <summary>
        /// Searches for sessions by category ID.
        /// </summary>
        /// <param name="categoryId">The ID of the category to filter sessions.</param>
        /// <returns>A list of sessions matching the criteria.</returns>
        Task<IEnumerable<SessionDto>> SearchByCategoryAsync(int categoryId);
    }
}
