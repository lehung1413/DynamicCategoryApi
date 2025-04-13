using Dapper;
using DCM.Core.Dtos;
using DCM.Core.Repositories;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Data;

namespace DCM.Repository
{
    public class CategoryConditionRepository : ICategoryConditionRepository
    {
        private readonly string _connectionString;

        public CategoryConditionRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DCM");
        }

        /// <inheritdoc />
        public async Task<List<int>> AddOrUpdateCategoryConditionsAsync(List<CategoryConditionDto> conditions)
        {
            using var connection = new SqlConnection(_connectionString);
            // Convert the list of CategoryConditionDto to JSON
            var jsonData = JsonConvert.SerializeObject(conditions);

            // Define parameters
            var parameters = new DynamicParameters();
            parameters.Add("@JsonData", jsonData, DbType.String);

            // Execute the stored procedure
            var result = await connection.QueryAsync<int>(
                "AddOrUpdateCategoryConditions",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result.ToList();
        }
    }
}
