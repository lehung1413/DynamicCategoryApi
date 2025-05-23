﻿using DCM.Core.Enum;
using System.ComponentModel.DataAnnotations;

namespace DCM.Core.Entities
{
    public class CategoryCondition
    {
        public int? CategoryConditionId { get; set; }

        [Required]
        public int CategoryId { get; set; }
        public string CategoryName { get; set; } = string.Empty;
        public string CategoryDescription { get; set; } = string.Empty;

        [Required]
        public string FieldName { get; set; } = string.Empty;

        [Required]
        public int OrderIndex { get; set; }

        [Required]
        [MaxLength(10)]
        public string ConditionOperator { get; set; } = string.Empty;

        [Required]
        public OperatorId OperatorId { get; set; }

        public string? ValueString { get; set; }

        public decimal? ValueNumber { get; set; }

        public DateTime? ValueDateTimeFrom { get; set; }

        public DateTime? ValueDateTimeTo { get; set; }
    }
}
