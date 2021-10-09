package com.ali.onepass.config;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Color;
import android.os.Build;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

//import com.aliqin.mytel.MessageActivity;
import com.ali.onepass.AppUtils;
import com.ali.onepass.R;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.mobile.auth.gatewayauth.AuthRegisterViewConfig;
import com.mobile.auth.gatewayauth.AuthRegisterXmlConfig;
import com.mobile.auth.gatewayauth.AuthUIConfig;
import com.mobile.auth.gatewayauth.CustomInterface;
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper;
import com.mobile.auth.gatewayauth.ui.AbstractPnsViewDelegate;

import static com.ali.onepass.uitls.AppUtils.dp2px;

public class DialogBottomConfig extends BaseUIConfig {

    public ReadableMap mConfig;

    public DialogBottomConfig(Activity activity, PhoneNumberAuthHelper authHelper, String operatorName, ReadableMap config) {

        super(activity, authHelper,operatorName,config);
        mConfig = config;
    }

    /**
     * 将方法名转为key名
     * @param methodName
     * @return
     */
    private String methodName2KeyName(String methodName) {
        String result = "";
        if (methodName == null) {
            return result;
        }
        if (methodName.startsWith("set")) {
            result = methodName.substring(3);
        }
        String firstChar = result.substring(0, 1); // 首字母
        String otherChar = result.substring(1); // 首字母
        Log.d(methodName, firstChar.toLowerCase() + otherChar);
        return firstChar.toLowerCase() + otherChar;
    }

    @Override
    public void configAuthPage() {
        mAuthHelper.removeAuthRegisterXmlConfig();
        mAuthHelper.removeAuthRegisterViewConfig();
        int authPageOrientation = ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT;
        if (Build.VERSION.SDK_INT == 26) {
            authPageOrientation = ActivityInfo.SCREEN_ORIENTATION_BEHIND;
        }
        updateScreenSize(authPageOrientation);
        int dialogHeight = 390;
//        //sdk默认控件的区域是marginTop50dp
        int designHeight = dialogHeight - 50;
        int unit = designHeight / 10;
        int logBtnHeight = (int) (unit * 1.2);
        mAuthHelper.addAuthRegisterXmlConfig(new AuthRegisterXmlConfig.Builder()
                .setLayout(R.layout.alert_title_info, new AbstractPnsViewDelegate() {
                    @Override
                    public void onViewCreated(View view) {
                    }
                })
                .build());

        String appPrivacyOne = "https://test.h5.app.tbmao.com/user";
        String appPrivacyTwo = "https://dhstatic.bthome.com/prod/os/pp.html";
        if (mConfig.hasKey(methodName2KeyName("setAppPrivacyOneUrl"))) {
            appPrivacyOne = mConfig.getString(methodName2KeyName("setAppPrivacyOneUrl"));
        }
        if (mConfig.hasKey(methodName2KeyName("setAppPrivacyTwoUrl"))) {
            appPrivacyOne = mConfig.getString(methodName2KeyName("setAppPrivacyTwoUrl"));
        }

        mAuthHelper.setAuthUIConfig(new AuthUIConfig.Builder()
                .setAppPrivacyOne("《用户注册协议》", appPrivacyOne)
                .setAppPrivacyTwo("《隐私政策》", appPrivacyTwo)
                .setAppPrivacyColor(Color.parseColor("#999999"), Color.parseColor("#333333"))
                .setPrivacyTextSize(11)
                .setPrivacyBefore("我已阅读并同意")
                .setPrivacyEnd("，未注册的手机号登录时将自动注册")
                .setWebNavColor(Color.parseColor("#ffffff"))
                .setWebNavTextColor(Color.parseColor("#333333"))

//                .setNavHidden(true)
                .setNavText("免费预约")
                .setNavTextColor(Color.parseColor("#333333"))
                .setNavTextSizeDp(18)
                .setNavReturnImgPath("cancel_black")
                .setSwitchAccText("其他手机登录")
                .setSwitchAccTextColor(Color.parseColor("#FE7100"))
                .setSwitchAccTextSizeDp(14)
                .setSwitchOffsetY(unit + 10+32+8+17+34+42+27+30)
                .setPrivacyState(false)
                .setLogoHidden(true)

                .setLogBtnText("本机号码一键预约")

                .setNumFieldOffsetY(unit + 40)
                .setNumberSizeDp(32)
                .setNumberColor(Color.parseColor("#191919"))

                .setSloganText("认证服务由"+mOperatorName+"提供")
                .setSloganOffsetY(unit + 10+32+12+30)
                .setSloganTextSizeDp(12)

                .setLogBtnOffsetY(unit + 10+32+8+17+34+30)
                .setLogBtnHeight(logBtnHeight)
                .setLogBtnMarginLeftAndRight(30)
                .setLogBtnTextSizeDp(18)
                .setLogBtnBackgroundPath("login_btn_bg")

//                .setPageBackgroundPath("dialog_page_background")
//                .setAuthPageActIn("in_activity", "out_activity")
//                .setAuthPageActOut("in_activity", "out_activity")
                .setVendorPrivacyPrefix("《")
                .setVendorPrivacySuffix("》")
                .setDialogHeight(dialogHeight)
                .setDialogBottom(true)
//                .setScreenOrientation(authPageOrientation)
                .create());
    }

    /**
     * 判断运营商类型
     *
     * @param promise
     */
//    @ReactMethod
//    public void getOperatorType(final Promise promise) {
//        if (!checkInit(promise)) {
//            return;
//        }
//        String carrierName = phoneNumberAuthHelper.getCurrentCarrierName();
//        if (carrierName.equals("CMCC")) {
//            carrierName = "中国移动";
//        } else if (carrierName.equals("CUCC")) {
//            carrierName = "中国联通";
//        } else if (carrierName.equals("CTCC")) {
//            carrierName = "中国电信";
//        }
//        promise.resolve(carrierName);
//    }
}
