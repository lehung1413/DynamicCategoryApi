using Dapper;
using DCM.Core.Const;
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
            parameters.Add(ParameterName.CategoryId, id);

            // Execute the stored procedure
            await connection.ExecuteScalarAsync(
                StoreProcedureName.Usp_Category_DeleteById,
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
                StoreProcedureName.Usp_Category_GetAll,
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
            parameters.Add(ParameterName.CategoryId, id);

            // Execute the stored procedure
            var result = await connection.QueryAsync<CategoryConditionDto>(
                StoreProcedureName.Usp_Category_GetById,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return new CategoryDto()
            {
                CategoryId = result.FirstOrDefault().CategoryId,
                Name = result.FirstOrDefault().CategoryName,
                Description = result.FirstOrDefault().CategoryDescription,
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
            parameters.Add(ParameterName.CategoryId, conditions.CategoryId);
            parameters.Add(ParameterName.CategoryName, conditions.Name);
            parameters.Add(ParameterName.CategoryDescription, conditions.Description);
            parameters.Add(ParameterName.JsonData, jsonData);

            // Execute the stored procedure
            var result = await connection.QueryFirstOrDefaultAsync<int>(
                StoreProcedureName.Usp_Category_AddOrUpdateCategory,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }
    }
}
