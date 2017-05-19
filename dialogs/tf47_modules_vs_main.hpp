class tf47_modules_vs_main_dialog
{
	idd = -1;
	movingEnable = false;
	onLoad = "uiNamespace setVariable ['tf47_modules_vs_main_dialog_var',_this select 0];";
	onUnLoad = "uiNamespace setVariable ['tf47_modules_vs_main_dialog_var',nil]";
    class ControlsBackground
    {
        class tf47_modules_vs_main_background: tf47_modules_vs_base_rsctext
        {
        	idc = 1000;

        	x = 0.37625 * safezoneW + safezoneX;
        	y = 0.357 * safezoneH + safezoneY;
        	w = 0.2475 * safezoneW;
        	h = 0.286 * safezoneH;
        	colorBackground[] = {-1,-1,-1,0.8};
        };
        class tf47_modules_vs_main_title: tf47_modules_vs_base_rsctext
        {
        	idc = 1001;
        	textSize = 1;

        	text = "TF47 Service Point"; //--- ToDo: Localize;
        	x = 0.37625 * safezoneW + safezoneX;
        	y = 0.33302 * safezoneH + safezoneY;
        	w = 0.2475 * safezoneW;
        	h = 0.022 * safezoneH;
        	colorBackground[] = {
                "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
                1
            };
        };
    };
    class Controls
    {
        class tf47_modules_vs_main_close_button: tf47_modules_vs_base_rscbutton_main
        {
        	idc = 1600;
        	action = "closeDialog 0;";
        	text = "Schließen"; //--- ToDo: Localize;
        	x = 0.37625 * safezoneW + safezoneX;
        	y = 0.64498 * safezoneH + safezoneY;
        	w = 0.042 * safezoneW;
        	h = 0.022 * safezoneH;
        	colorBackground[] = {-1,-1,-1,0.8};
        };
        class tf47_modules_vs_main_apply_button: tf47_modules_vs_base_rscbutton_main
        {
        	idc = 1603;
        	action = "";
        	text = "Anwenden"; //--- ToDo: Localize;
        	x = 0.578478 * safezoneW + safezoneX;
        	y = 0.64498 * safezoneH + safezoneY;
        	w = 0.045 * safezoneW;
        	h = 0.022 * safezoneH;
        	colorBackground[] = {-1,-1,-1,0.8};
        };

        class tf47_modules_vs_main_vehiclelist_listbox: tf47_modules_vs_adv_listbox
        {
            columns[] = {0,0.25,0.4};
        	idc = 1500;
        	x = 0.381406 * safezoneW + safezoneX;
        	y = 0.368 * safezoneH + safezoneY;
        	w = 0.237187 * safezoneW;
        	h = 0.264 * safezoneH;
        };
        class tf47_modules_vs_main_firstbox_frame: tf47_modules_vs_base_frame
        {
        	idc = 1800;
        	x = 0.381406 * safezoneW + safezoneX;
        	y = 0.368 * safezoneH + safezoneY;
        	w = 0.0567187 * safezoneW;
        	h = 0.264 * safezoneH;
        };
        class tf47_modules_vs_main_secondbox_frame: tf47_modules_vs_base_frame
        {
        	idc = 1801;
        	x = 0.438125 * safezoneW + safezoneX;
        	y = 0.368 * safezoneH + safezoneY;
        	w = 0.061875 * safezoneW;
        	h = 0.264 * safezoneH;
        };
    };
};
