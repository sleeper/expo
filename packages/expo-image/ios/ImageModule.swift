// Copyright 2022-present 650 Industries. All rights reserved.

import ExpoModulesCore
import SDWebImage
import SDWebImageWebPCoder
import SDWebImageAVIFCoder
import SDWebImageSVGCoder

public final class ImageModule: Module {
  lazy var prefetcher = SDWebImagePrefetcher.shared

  public func definition() -> ModuleDefinition {
    Name("ExpoImage")

    OnCreate {
      ImageModule.registerCoders()
      ImageModule.registerLoaders()
    }

    View(ImageView.self) {
      Events(
        "onLoadStart",
        "onProgress",
        "onError",
        "onLoad"
      )

      Prop("source") { (view, sources: [ImageSource]?) in
        view.sources = sources
      }

      Prop("placeholder") { (view, placeholders: [ImageSource]?) in
        view.placeholderSources = placeholders ?? []
      }

      Prop("contentFit") { (view, contentFit: ContentFit?) in
        view.contentFit = contentFit ?? .cover
      }

      Prop("contentPosition") { (view, contentPosition: ContentPosition?) in
        view.contentPosition = contentPosition ?? .center
      }

      Prop("transition") { (view, transition: ImageTransition?) in
        view.transition = transition
      }

      Prop("blurRadius") { (view, blurRadius: Double?) in
        view.blurRadius = blurRadius ?? .zero
      }

      Prop("tintColor") { (view, tintColor: UIColor?) in
        view.imageTintColor = tintColor ?? .clear
      }

      Prop("priority") { (view, priority: ImagePriority?) in
        view.loadingOptions.remove([.lowPriority, .highPriority])

        if let priority = priority?.toSDWebImageOptions() {
          view.loadingOptions.insert(priority)
        }
      }

      Prop("cachePolicy") { (view, cachePolicy: ImageCachePolicy?) in
        view.cachePolicy = cachePolicy ?? .disk
      }

      Prop("accessible") { (view, accessible: Bool?) in
        view.sdImageView.isAccessibilityElement = accessible ?? false
      }

      Prop("accessibilityLabel") { (view, label: String?) in
        view.sdImageView.accessibilityLabel = label
      }

      OnViewDidUpdateProps { view in
        view.reload()
      }
    }

    Function("prefetch") { (urls: [URL]) in
      SDWebImagePrefetcher.shared.prefetchURLs(urls)
    }

    AsyncFunction("clearMemoryCache") { () -> Bool in
      SDImageCache.shared.clearMemory()
      return true
    }

    AsyncFunction("clearDiskCache") { (promise: Promise) in
      SDImageCache.shared.clearDisk {
        promise.resolve(true)
      }
    }

    AsyncFunction("load") { (url: URL, promise: Promise) in
      SDWebImageManager.shared.loadImage(with: url, progress: nil) { image, _, _, _, finished, _ in
        if let runtime = self.appContext?.runtime, let data = image?.pngData() {
          self.appContext?.executeOnJavaScriptThread(runBlock: {
            let typedArray = JavaScriptTypedArray.createArrayBuffer(runtime, with: data)
            promise.resolve(typedArray)
          })
        } else {
          promise.reject("foo", "bar")
        }
      }
    }
  }

  static func registerCoders() {
    if #available(iOS 14.0, *) {
      // By default Animated WebP is not supported
      SDImageCodersManager.shared.addCoder(SDImageAWebPCoder.shared)
    } else {
      // This coder is much slower, but it's the only one that works in iOS 13
      SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
    }
    SDImageCodersManager.shared.addCoder(SDImageAVIFCoder.shared)
    SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    SDImageCodersManager.shared.addCoder(SDImageHEICCoder.shared)
  }

  static func registerLoaders() {
    SDImageLoadersManager.shared.addLoader(BlurhashLoader())
    SDImageLoadersManager.shared.addLoader(PhotoLibraryAssetLoader())
  }
}
