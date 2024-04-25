package expo.modules.cobra

import expo.modules.mainconbra.cobraMainClass

import android.content.Context
import android.content.SharedPreferences
import androidx.core.os.bundleOf
import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

public class ExpoCobraModule : Module() {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.

  override fun definition() = ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('ExpoCobra')` in JavaScript.
    Name("ExpoCobra")

    // Defines event names that the module can send to JavaScript.
    Events("onChangeCobra")

    Function("setCobra") { cobra: String ->
      val cobraModel = cobraMainClass() // Instantiating CobraMainClass
      cobraModel.init()
      cobraModel.toggle()
      myCobra = cobraModel
      getPreferences().edit().putString("cobra", cobra).commit()
      // this@ExpoCobraModule.sendEvent("onChangeCobra", bundleOf("cobra" to cobra))
    }

    Function("getCobra") {
      return@Function getVP()
      //return@Function getPreferences().getString("cobra", "system")
    }
  }

  private var myCobra : cobraMainClass? = null
  private val context
  get() = requireNotNull(appContext.reactContext)

  private fun getVP(): String {
    var ret : String = "N/A"
    var tmpCobra : cobraMainClass = myCobra as cobraMainClass
    ret = tmpCobra.getVoiceProbability();
    return ret;
  }  


  private fun getPreferences(): SharedPreferences {
      return context.getSharedPreferences("hfc.modules.cobra" + ".cobra", Context.MODE_PRIVATE)
//      return context.getSharedPreferences(context.packageName + ".cobra", Context.MODE_PRIVATE)
}

}
