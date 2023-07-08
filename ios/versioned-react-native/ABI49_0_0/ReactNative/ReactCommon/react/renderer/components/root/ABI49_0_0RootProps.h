/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <memory>

#include <ABI49_0_0React/ABI49_0_0renderer/components/view/ViewProps.h>
#include <ABI49_0_0React/renderer/core/ABI49_0_0LayoutConstraints.h>
#include <ABI49_0_0React/renderer/core/ABI49_0_0LayoutContext.h>
#include <ABI49_0_0React/renderer/core/ABI49_0_0PropsParserContext.h>

namespace ABI49_0_0facebook {
namespace ABI49_0_0React {

class RootProps final : public ViewProps {
 public:
  RootProps() = default;
  RootProps(
      const PropsParserContext &context,
      RootProps const &sourceProps,
      RawProps const &rawProps);
  RootProps(
      const PropsParserContext &context,
      RootProps const &sourceProps,
      LayoutConstraints const &layoutConstraints,
      LayoutContext const &layoutContext);

#pragma mark - Props

  LayoutConstraints layoutConstraints{};
  LayoutContext layoutContext{};
};

} // namespace ABI49_0_0React
} // namespace ABI49_0_0facebook
