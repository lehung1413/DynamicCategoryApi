using DCM.Application.Interfaces;
using DCM.Core.Dtos;
using Microsoft.AspNetCore.Mvc;
using System.Net;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace DCM.Api.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class CategoryConditionsController : ControllerBase
    {

        private readonly ICategoryConditionService _service;

        public CategoryConditionsController(ICategoryConditionService service)
        {
            _service = service;
        }

        /// <summary>
        /// Add or update a CategoryCondition.
        /// </summary>
        /// <param name="condition">The CategoryCondition details.</param>
        /// <returns>The ID of the added or updated CategoryCondition.</returns>
        [HttpPost("/categoryConditions")]
        [ProducesResponseType(typeof(int), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> AddOrUpdateCategoryConditions([FromBody] List<CategoryConditionDto> conditions)
        {

            try
            {
                var result = await _service.AddOrUpdateCategoryConditionsAsync(conditions);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
