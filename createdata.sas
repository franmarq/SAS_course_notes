/* st100d05.sas */
ods noproctitle;

/* The homefolder macro variable is defined in libname.sas */
libname STAT1 "&homefolder";

/* st100d01.sas */
DATA STAT1.AmesHousing;
    LENGTH
        Order              8
        PID              $ 10
        MS_SubClass      $ 3
        MS_Zoning        $ 7
        Lot_Frontage       8
        Lot_Area           8
        Street           $ 4
        Alley            $ 4
        Lot_Shape        $ 3
        Land_Contour     $ 3
        Utilities        $ 6
        Lot_Config       $ 7
        Land_Slope       $ 3
        Neighborhood     $ 7
        Condition_1      $ 6
        Condition_2      $ 6
        Bldg_Type        $ 6
        House_Style      $ 6
        Overall_Qual       8
        Overall_Cond       8
        Year_Built         8
        Year_Remod_Add     8
        Roof_Style       $ 7
        Roof_Matl        $ 7
        Exterior_1st     $ 7
        Exterior_2nd     $ 7
        Mas_Vnr_Type     $ 7
        Mas_Vnr_Area       8
        Exter_Qual       $ 2
        Exter_Cond       $ 2
        Foundation       $ 6
        Bsmt_Qual        $ 2
        Bsmt_Cond        $ 2
        Bsmt_Exposure    $ 2
        BsmtFin_Type_1   $ 3
        BsmtFin_SF_1       8
        BsmtFin_Type_2   $ 3
        BsmtFin_SF_2       8
        Bsmt_Unf_SF        8
        Total_Bsmt_SF      8
        Heating          $ 5
        Heating_QC       $ 2
        Central_Air      $ 1
        Electrical       $ 5
        _1st_Flr_SF        8
        _2nd_Flr_SF        8
        Low_Qual_Fin_SF    8
        Gr_Liv_Area        8
        Bsmt_Full_Bath     8
        Bsmt_Half_Bath     8
        Full_Bath          8
        Half_Bath          8
        Bedroom_AbvGr      8
        Kitchen_AbvGr      8
        Kitchen_Qual     $ 2
        TotRms_AbvGrd      8
        Functional       $ 4
        Fireplaces         8
        Fireplace_Qu     $ 2
        Garage_Type      $ 7
        Garage_Yr_Blt      8
        Garage_Finish    $ 3
        Garage_Cars        8
        Garage_Area        8
        Garage_Qual      $ 2
        Garage_Cond      $ 2
        Paved_Drive      $ 1
        Wood_Deck_SF       8
        Open_Porch_SF      8
        Enclosed_Porch     8
        _3Ssn_Porch        8
        Screen_Porch       8
        Pool_Area          8
        Pool_QC          $ 2
        Fence            $ 5
        Misc_Feature     $ 4
        Misc_Val           8
        Mo_Sold            8
        Yr_Sold            8
        Sale_Type        $ 5
        Sale_Condition   $ 7
        SalePrice          8 
        Basement_Area      8
        Full_Bathroom      8
        Half_Bathroom      8
        Total_Bathroom     8
        Deck_Porch_Area    8
        Age_Sold           8
        Season_Sold        8
        Garage_Type_2    $ 8
        Foundation_2     $ 16 
        Masonry_Veneer   $ 1
        Lot_Shape_2      $ 10
        House_Style2     $ 6
        Overall_Qual2      8
        Overall_Cond2      8
        Log_Price          8
		Bonus              8
;
    LABEL
        MS_SubClass      = "Type of dwelling involved in the sale"
        MS_Zoning        = "General zoning classification of the sale"
        Lot_Frontage     = "Linear feet of street connected to property"
        Lot_Area         = "Lot size in square feet"
        Street           = "Type of road access to property"
        Alley            = "Type of alley access to property"
        Lot_Shape        = "General shape of property"
        Land_Contour     = "Flatness of the property"
        Utilities        = "Type of utilities available"
        Lot_Config       = "Lot configuration"
        Land_Slope       = "Slope of property"
        Neighborhood     = "Physical location within Ames city limits"
        Condition_1      = "Proximity to various conditions 1"
        Condition_2      = "Proximity to various conditions 2"
        Bldg_Type        = "Type of dwelling"
        House_Style      = "Style of dwelling"
        Overall_Qual     = "Overall material and finish of the house"
        Overall_Cond     = "Overall condition of the house"
        Year_Built       = "Original construction year"
        Year_Remod_Add   = "Remodel year (same as construction date if no remodeling or additions)"
        Roof_Style       = "Type of roof"
        Roof_Matl        = "Roof material"
        Exterior_1st     = "Exterior covering on house 1"
        Exterior_2nd     = "Exterior covering on house 2"
        Mas_Vnr_Type     = "Masonry veneer type"
        Mas_Vnr_Area     = "Masonry veneer area in square feet"
        Exter_Qual       = "Quality of the material on the exterior"
        Exter_Cond       = "Present condition of the material on the exterior"
        Foundation       = "Type of foundation"
        Bsmt_Qual        = "Rating of height of the basement"
        Bsmt_Cond        = "General condition of the basement"
        Bsmt_Exposure    = "Rating of basement exposure"
        BsmtFin_Type_1   = "Rating of basement finished area type 1"
        BsmtFin_SF_1     = "Type 1 finished square feet"
        BsmtFin_Type_2   = "Rating of basem