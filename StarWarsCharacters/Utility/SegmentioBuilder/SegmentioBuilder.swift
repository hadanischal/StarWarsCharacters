//
//  SegmentioBuilder.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 22/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Segmentio
import UIKit

struct SegmentioBuilder {
    static let segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)

    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int, count: Int) {
        segmentioView.addBadge(
            at: index,
            count: count,
            color: UIColor.segmentBadge
        )
    }

    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle, segmentioContent: [SegmentioItem]) {
        segmentioView.setup(
            content: segmentioContent,
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle, segmentioPosition: segmentioPosition)
        )
    }

    private static func segmentioOptions(segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)) -> SegmentioOptions {
        var imageContentMode = UIView.ContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }

        return SegmentioOptions(
            backgroundColor: UIColor.white,
            segmentPosition: segmentioPosition,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }

    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.segmentTitle
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: .segmentDefaultTitle
            ),
            selectedState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: .segmentSelectedTitle
            ),
            highlightedState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: .segmentSelectedTitle
            )
        )
    }

    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }

    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 3,
            color: .segmentIndicator
        )
    }

    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: .segmentSeparator
        )
    }

    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: .segmentSeparator
        )
    }
}
