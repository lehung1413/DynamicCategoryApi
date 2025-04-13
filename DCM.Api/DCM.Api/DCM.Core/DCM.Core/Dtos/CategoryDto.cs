namespace DCM.Core.Dtos
{
    public class CategoryDto
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }

    public class CreateCategoryRequest
    {
        public string Name { get; set; }
        public string Description { get; set; }
    }


    public class UpdateCategoryRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }
}
