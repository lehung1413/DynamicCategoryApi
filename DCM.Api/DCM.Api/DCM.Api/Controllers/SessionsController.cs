using DCM.Application.Interfaces;
using DCM.Core.Dtos;
using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace DCM.Api.Controllers
{   
    /// <summary>
    /// Handles operations related to session searches.
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class SessionsController: ControllerBase
    {
        private readonly ISessionService _sessionService;

        public SessionsController(ISessionService sessionService)
        {
            _sessionService = sessionService;
        }

        /// <summary>
        /// Searches sessions by category ID.
        /// </summary>
        /// <param name="categoryId">The ID of the category to filter sessions.</param>
        /// <returns>A list of sessions matching the criteria.</returns>
        /// <response code="200">A list of sessions was successfully retrieved.</response>
        /// <response code="400">Invalid input data provided.</response>
        /// <response code="500">An error occurred while processing the request.</response>
        [HttpGet("/category/{categoryId}")]
        [ProducesResponseType(typeof(IEnumerable<SessionDto>), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        [ProducesResponseType((int)HttpStatusCode.InternalServerError)]
        public async Task<IActionResult> SearchByCategoryAsync([FromRoute] int categoryId)
        {
            if (categoryId <= 0)
            {
                return BadRequest("Invalid Category ID.");
            }

            try
            {
                var sessions = await _sessionService.SearchByCategoryAsync(categoryId);
                return Ok(sessions);
            }
            catch (Exception ex)
            {
                // Log the error (logging should be implemented in a proper logging service)
                return StatusCode((int)HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
