using DCM.Core.Repositories;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace DCM.Repository
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly IDbConnection _db;
        public CategoryRepository(IConfiguration config)
        {
            _db = new SqlConnection(config.GetConnectionString("DefaultConnection"));
        }
    }
}
