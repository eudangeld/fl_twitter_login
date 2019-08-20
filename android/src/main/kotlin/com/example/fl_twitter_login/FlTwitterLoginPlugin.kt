package com.example.fl_twitter_login

import android.content.Intent
import android.util.Log
import com.twitter.sdk.android.core.*
import com.twitter.sdk.android.core.identity.TwitterAuthClient
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlTwitterLoginPlugin(private val registrar: Registrar) : MethodCallHandler, PluginRegistry.ActivityResultListener {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "fl.dan.twitter/login")
            channel.setMethodCallHandler(FlTwitterLoginPlugin(registrar))
        }
    }

    private var twitterAuthClient: TwitterAuthClient? = null

    init {
        this.registrar.addActivityResultListener(this)
    }

    private fun login(call: MethodCall, result: Result) {
        Log.i("TWITTER", "Login")

        getTwitterAuthClient(call.argument<String>("consumerKey"), call.argument<String>("secret"))?.authorize(registrar.activity(), object : Callback<TwitterSession>() {
            override fun success(session: com.twitter.sdk.android.core.Result<TwitterSession>?) {
                Log.i("TWITTER", "Success")

                result.success(hashMapOf(
                        "error" to false,
                        "userName" to session?.data?.userName,
                        "authToken" to session?.data?.authToken?.token,
                        "authTokenSecret" to session?.data?.authToken?.secret,
                        "userID" to session?.data?.userId.toString()))
            }

            override fun failure(exception: TwitterException?) {
                Log.i("TWITTER", "Failure")

                result.error("TWITTER_LOGIN_ERROR", exception?.message, null)
            }
        })

        Log.i("TWITTER", "Called authorize")
    }

    private fun getTwitterAuthClient(consumerKey: String?, secret: String?): TwitterAuthClient? {
        if (twitterAuthClient == null) {
            val authConfig = TwitterAuthConfig(consumerKey, secret)
            val config = TwitterConfig.Builder(registrar.context()).twitterAuthConfig(authConfig).build()

            Twitter.initialize(config)

            twitterAuthClient = TwitterAuthClient()
        }

        return twitterAuthClient
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "twitterLogin" -> login(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?): Boolean {
        Log.i("TWITTER", "onActivityResult")
        twitterAuthClient?.onActivityResult(requestCode, resultCode, intent)
        return false
    }
}
