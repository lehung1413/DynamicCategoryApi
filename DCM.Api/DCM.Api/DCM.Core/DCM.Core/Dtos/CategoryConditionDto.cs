using System.ComponentModel.DataAnnotations;

namespace DCM.Core.Dtos
{
    public class CategoryConditionDto
    {
        public int? CategoryConditionId { get; set; }

        [Required]
        public int CategoryId { get; set; }

        [Required]
        public int GroupId { get; set; }

        public int? ParentGroupId { get; set; }

        [Required]
        public int OrderIndex { get; set; }

        [Required]
        [MaxLength(10)]
        public string LogicalOperator { get; set; } = string.Empty;

        [Required]
        public int FieldOrOperatorId { get; set; }

        public string? Value_String { get; set; }

        public decimal? Value_Number { get; set; }

        public DateTime? Value_DateTime_From { get; set; }

        public DateTime? Value_DateTime_To { get; set; }
    }
}
