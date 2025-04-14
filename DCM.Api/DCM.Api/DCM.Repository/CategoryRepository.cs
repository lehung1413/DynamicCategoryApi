using Dapper;
using DCM.Core.Dtos;
using DCM.Core.Repositories;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Data;

namespace DCM.Repository
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly string _connectionString;
        public CategoryRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DCM");
        }

        public async Task<bool> DeleteAsync(long id)
        {
            using var connection = new SqlConnection(_connectionString);

            // Define parameters
            var parameters = new DynamicParameters();
            parameters.Add("@CategoryId", id);

            // Execute the stored procedure
            await connection.ExecuteScalarAsync(
                "Usp_Category_DeleteById",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return true;
        }

        public async Task<IEnumerable<CategoryDto>> GetAllAsync()
        {
            using var connection = new SqlConnection(_connectionString);

            // Define parameters
            var parameters = new DynamicParameters();

            // Execute the stored procedure
            var result = await connection.QueryAsync<CategoryDto>(
                "Usp_Category_GetAll",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<CategoryDto> GetByIdAsync(long id)
        {
            using var connection = new SqlConnection(_connectionString);

            // Define parameters
            var parameters = new DynamicParameters();
            parameters.Add("@CategoryId", id);

            // Execute the stored procedure
            var result = await connection.QueryAsync<CategoryConditionDto>(
                "Usp_Category_GetById",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return new CategoryDto()
            {
                CategoryId = result.FirstOrDefault().CategoryId,
                Name = result.FirstOrDefault().CategoryName,
                CategoryConditions = result
            };
        }

        public async Task<int> InsertOrUpdateAsync(CategoryDto conditions)
        {
            using var connection = new SqlConnection(_connectionString);
            // Convert the list of CategoryConditionDto to JSON
            var jsonData = JsonConvert.SerializeObject(conditions.CategoryConditions);

            // Define parameters
            var parameters = new DynamicParameters();
            parameters.Add("@CategoryId", conditions.CategoryId);
            parameters.Add("@CategoryName", conditions.Name);
            parameters.Add("@CategoryDescription", conditions.Description);
            parameters.Add("@JsonData", jsonData);

            // Execute the stored procedure
            var result = await connection.QueryFirstOrDefaultAsync<int>(
                "[Usp_Category_AddOrUpdateCategory]",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }
    }
}
