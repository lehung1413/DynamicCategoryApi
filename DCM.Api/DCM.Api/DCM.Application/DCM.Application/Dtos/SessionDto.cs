namespace DCM.Application.Dtos
{
    public class SessionDto
    {
        /// <summary>
        /// Gets or sets the ID of the session.
        /// </summary>
        public int SessionId { get; set; }

        /// <summary>
        /// Gets or sets the title of the session.
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets the location of the session.
        /// </summary>
        public string Location { get; set; }

        /// <summary>
        /// Gets or sets the start date of the session.
        /// </summary>
        public DateTime StartDate { get; set; }

        /// <summary>
        /// Gets or sets the end date of the session.
        /// </summary>
        public DateTime EndDate { get; set; }

        /// <summary>
        /// Gets or sets the description of the session.
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// Gets or sets the description of the session.
        /// </summary>
        public string SpeakerName { get; set; }

        /// <summary>
        /// Gets or sets the Tags of the session.
        /// </summary>
        public string Tags { get; set; }
    }
}
