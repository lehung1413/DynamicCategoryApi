using Dapper;
using DCM.Core.Const;
using DCM.Core.Dtos;
using DCM.Core.Repositories;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace DCM.Repository
{
    public class TagRepository : ITagRepository
    {
        private readonly string _connectionString;
        public TagRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DCM") ?? throw new ArgumentNullException(nameof(configuration), "Connection String cannot be null.");
        }

        public async Task<IEnumerable<DropdownDto>> GetAllTagsAsync()
        {
            using var connection = new SqlConnection(_connectionString);

            // Define parameters  
            var parameters = new DynamicParameters();

            // Execute the stored procedure  
            var result = await connection.QueryAsync<DropdownDto>(
                StoreProcedureName.Usp_Tag_GetAll,
                null,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }
    }
}
