namespace DCM.Application.Dtos
{
    public class CategoryDto
    {
        public long? CategoryId { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public IEnumerable<CategoryConditionDto> CategoryConditions { get; set; } = [];
    }
}
