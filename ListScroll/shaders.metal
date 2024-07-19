//
//  File.metal
//  ListScroll
//
//  Created by Satish Vekariya on 19/07/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;


[[ stitchable ]] float2 simpleWave(float2 position, float time) {
    return position + float2 (sin(time + position.y / 20), sin(time + position.x / 20)) * 5;
}

