/**
* This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
*
* Do not edit this file as changes may cause incorrect behavior and will be lost
* once the code is regenerated.
*
* @generated by codegen project: GeneratePropsJavaDelegate.js
*/

package abi49_0_0.com.facebook.react.viewmanagers;

import android.view.View;
import androidx.annotation.Nullable;
import abi49_0_0.com.facebook.react.bridge.ReadableArray;
import abi49_0_0.com.facebook.react.bridge.ReadableMap;
import abi49_0_0.com.facebook.react.uimanager.BaseViewManagerDelegate;
import abi49_0_0.com.facebook.react.uimanager.BaseViewManagerInterface;

public class RNSVGLineManagerDelegate<T extends View, U extends BaseViewManagerInterface<T> & RNSVGLineManagerInterface<T>> extends BaseViewManagerDelegate<T, U> {
  public RNSVGLineManagerDelegate(U viewManager) {
    super(viewManager);
  }
  @Override
  public void setProperty(T view, String propName, @Nullable Object value) {
    switch (propName) {
      case "name":
        mViewManager.setName(view, value == null ? null : (String) value);
        break;
      case "opacity":
        mViewManager.setOpacity(view, value == null ? 1f : ((Double) value).floatValue());
        break;
      case "matrix":
        mViewManager.setMatrix(view, (ReadableArray) value);
        break;
      case "mask":
        mViewManager.setMask(view, value == null ? null : (String) value);
        break;
      case "markerStart":
        mViewManager.setMarkerStart(view, value == null ? null : (String) value);
        break;
      case "markerMid":
        mViewManager.setMarkerMid(view, value == null ? null : (String) value);
        break;
      case "markerEnd":
        mViewManager.setMarkerEnd(view, value == null ? null : (String) value);
        break;
      case "clipPath":
        mViewManager.setClipPath(view, value == null ? null : (String) value);
        break;
      case "clipRule":
        mViewManager.setClipRule(view, value == null ? 0 : ((Double) value).intValue());
        break;
      case "responsible":
        mViewManager.setResponsible(view, value == null ? false : (boolean) value);
        break;
      case "display":
        mViewManager.setDisplay(view, value == null ? null : (String) value);
        break;
      case "pointerEvents":
        mViewManager.setPointerEvents(view, value == null ? null : (String) value);
        break;
      case "fill":
        mViewManager.setFill(view, (ReadableMap) value);
        break;
      case "fillOpacity":
        mViewManager.setFillOpacity(view, value == null ? 1f : ((Double) value).floatValue());
        break;
      case "fillRule":
        mViewManager.setFillRule(view, value == null ? 1 : ((Double) value).intValue());
        break;
      case "stroke":
        mViewManager.setStroke(view, (ReadableMap) value);
        break;
      case "strokeOpacity":
        mViewManager.setStrokeOpacity(view, value == null ? 1f : ((Double) value).floatValue());
        break;
      case "strokeWidth":
        if (value instanceof String) {
          mViewManager.setStrokeWidth(view, (String) value);
        } else if (value instanceof Double) {
          mViewManager.setStrokeWidth(view, (Double) value);
        } else {
          mViewManager.setStrokeWidth(view, "1");
        }
        break;
      case "strokeLinecap":
        mViewManager.setStrokeLinecap(view, value == null ? 0 : ((Double) value).intValue());
        break;
      case "strokeLinejoin":
        mViewManager.setStrokeLinejoin(view, value == null ? 0 : ((Double) value).intValue());
        break;
      case "strokeDasharray":
        mViewManager.setStrokeDasharray(view, (ReadableArray) value);
        break;
      case "strokeDashoffset":
        mViewManager.setStrokeDashoffset(view, value == null ? 0f : ((Double) value).floatValue());
        break;
      case "strokeMiterlimit":
        mViewManager.setStrokeMiterlimit(view, value == null ? 0f : ((Double) value).floatValue());
        break;
      case "vectorEffect":
        mViewManager.setVectorEffect(view, value == null ? 0 : ((Double) value).intValue());
        break;
      case "propList":
        mViewManager.setPropList(view, (ReadableArray) value);
        break;
      case "x1":
        if (value instanceof String) {
          mViewManager.setX1(view, (String) value);
        } else if (value instanceof Double) {
          mViewManager.setX1(view, (Double) value);
        } else {
          mViewManager.setX1(view, (Double) null);
        }
        break;
      case "y1":
        if (value instanceof String) {
          mViewManager.setY1(view, (String) value);
        } else if (value instanceof Double) {
          mViewManager.setY1(view, (Double) value);
        } else {
          mViewManager.setY1(view, (Double) null);
        }
        break;
      case "x2":
        if (value instanceof String) {
          mViewManager.setX2(view, (String) value);
        } else if (value instanceof Double) {
          mViewManager.setX2(view, (Double) value);
        } else {
          mViewManager.setX2(view, (Double) null);
        }
        break;
      case "y2":
        if (value instanceof String) {
          mViewManager.setY2(view, (String) value);
        } else if (value instanceof Double) {
          mViewManager.setY2(view, (Double) value);
        } else {
          mViewManager.setY2(view, (Double) null);
        }
        break;
      default:
        super.setProperty(view, propName, value);
    }
  }
}
