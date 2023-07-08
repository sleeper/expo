package abi49_0_0.expo.modules.font

import android.content.Context
import abi49_0_0.expo.modules.core.BasePackage
import abi49_0_0.expo.modules.core.ExportedModule

class FontLoaderPackage : BasePackage() {
  override fun createExportedModules(context: Context): List<ExportedModule> {
    return listOf<ExportedModule>(FontLoaderModule(context))
  }
}
