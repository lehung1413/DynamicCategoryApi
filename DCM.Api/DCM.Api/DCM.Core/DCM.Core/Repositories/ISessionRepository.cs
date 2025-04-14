using DCM.Core.Dtos;


namespace DCM.Core.Repositories
{
    public interface ISessionRepository
    {
        /// <summary>
        /// Retrieves sessions by category ID.
        /// </summary>
        /// <param name="categoryId">The ID of the category to filter sessions.</param>
        /// <returns>A list of sessions matching the criteria.</returns>
        public Task<IEnumerable<SessionDto>> GetSessionsByCategoryAsync(int categoryId);
        public Task<IEnumerable<SessionDto>> PreviewSessionAsync(CategoryDto request);
    }
}
