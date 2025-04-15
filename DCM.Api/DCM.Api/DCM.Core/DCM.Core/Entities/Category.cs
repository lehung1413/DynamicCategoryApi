﻿namespace DCM.Core.Entities
{
    public class Category
    {
        public long? CategoryId { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public IEnumerable<CategoryCondition> CategoryConditions { get; set; } = [];
    }
}
