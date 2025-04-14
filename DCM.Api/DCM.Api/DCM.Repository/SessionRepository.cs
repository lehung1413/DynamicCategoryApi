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
    public class SessionRepository : ISessionRepository
    {
        private readonly string _connectionString;

        /// <summary>
        /// Initializes a new instance of the <see cref="SessionRepository"/> class.
        /// </summary>
        /// <param name="configuration">Configuration to access the connection string.</param>
        public SessionRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DCM");
        }


        public async Task<IEnumerable<SessionDto>> GetSessionsByCategoryAsync(int categoryId)
        {
            using var connection = new SqlConnection(_connectionString);
            string procedureName = StoreProcedureName.Usp_Category_SearchById;

            var parameters = new DynamicParameters();
            parameters.Add(ParameterName.CategoryId, categoryId, DbType.Int32);

            var sessions = await connection.QueryAsync<SessionDto>(
                procedureName,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return sessions;
        }

        public async Task<IEnumerable<SessionDto>> PreviewSessionAsync(CategoryDto request)
        {
            using var connection = new SqlConnection(_connectionString);
            string procedureName = StoreProcedureName.Usp_Session_PreviewSession;
            // Convert the list of CategoryConditionDto to JSON
            var jsonData = JsonConvert.SerializeObject(request.CategoryConditions);

            var parameters = new DynamicParameters();
            parameters.Add(ParameterName.JsonData, jsonData);

            var sessions = await connection.QueryAsync<SessionDto>(
                procedureName,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return sessions;
        }
    }
}
