using DCM.Core.Entities;


namespace DCM.Core.Repositories
{
    public interface ISessionRepository
    {
        /// <summary>
        /// Retrieves sessions by category ID.
        /// </summary>
        /// <param name="categoryId">The ID of the category to filter sessions.</param>
        /// <returns>A list of sessions matching the criteria.</returns>
        public Task<IEnumerable<Session>> GetSessionsByCategoryAsync(int categoryId);
        public Task<IEnumerable<Session>> PreviewSessionAsync(Category request);
    }
}
