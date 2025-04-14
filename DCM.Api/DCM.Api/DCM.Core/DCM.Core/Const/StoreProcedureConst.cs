namespace DCM.Core.Const
{
    public static class StoreProcedureName
    {
        public static readonly string Usp_Category_SearchById = "Usp_Category_SearchById";
        public static readonly string Usp_Session_PreviewSession = "Usp_Session_PreviewSession";
        public static readonly string Usp_Category_DeleteById = "Usp_Category_DeleteById";
        public static readonly string Usp_Category_GetAll = "Usp_Category_GetAll";
        public static readonly string Usp_Category_GetById = "Usp_Category_GetById";
        public static readonly string Usp_Category_AddOrUpdateCategory = "Usp_Category_AddOrUpdateCategory";
        public static readonly string Usp_Tag_GetAll = "Usp_Tag_GetAll";
    }

    public static class ParameterName
    {
        public static readonly string CategoryId = "@CategoryId";
        public static readonly string JsonData = "@JsonData";
        public static readonly string CategoryName = "@CategoryName";
        public static readonly string CategoryDescription = "@CategoryDescription";
    }
}
