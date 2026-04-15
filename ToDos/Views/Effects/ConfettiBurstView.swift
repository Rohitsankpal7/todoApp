//
//  ConfettiBurstView.swift
//  ToDos
//
//  Created by Rohit Sankpal on 15/04/26.
//

import SwiftUI

struct ConfettiBurstView: View {
    struct Config: Equatable {
        var duration: TimeInterval = 1.2
        var particleCount: Int = 70
    }

    let config: Config
    let seed: UInt64
    let startDate: Date

    var body: some View {
        TimelineView(.animation) { context in
            confettiCanvas(at: context.date)
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    // MARK: - Particles

    private struct Particle {
        let color: Color
        let size: CGSize
        let cornerRadius: CGFloat
        let x0: CGFloat
        let vx: CGFloat
        let vy: CGFloat
        let gravity: CGFloat
        let spinDegrees: CGFloat
    }

    private func confettiCanvas(at date: Date) -> some View {
        Canvas { canvas, size in
            let elapsed = max(0, date.timeIntervalSince(startDate))
            let progress = min(1, elapsed / max(0.0001, config.duration))

            for particle in particles(size: size) {
                let position = position(for: particle, progress: progress, size: size)
                let alpha = 1 - progress

                var particleCanvas = canvas
                particleCanvas.translateBy(x: position.x, y: position.y)
                particleCanvas.rotate(by: .degrees(Double(particle.spinDegrees) * progress))
                particleCanvas.opacity = alpha

                let rect = CGRect(
                    x: -particle.size.width / 2,
                    y: -particle.size.height / 2,
                    width: particle.size.width,
                    height: particle.size.height
                )

                particleCanvas.fill(
                    Path(roundedRect: rect, cornerRadius: particle.cornerRadius),
                    with: .color(particle.color)
                )
            }
        }
    }

    private func particles(size: CGSize) -> [Particle] {
        var rng = SplitMix64(seed: seed)
        let colors: [Color] = [
            AppTheme.accent,
            AppTheme.success,
            Color(red: 0.98, green: 0.42, blue: 0.47),
            Color(red: 1.00, green: 0.78, blue: 0.25),
            Color(red: 0.56, green: 0.35, blue: 0.96)
        ]

        return (0..<max(0, config.particleCount)).map { _ in
            let color = colors[Int(rng.next() % UInt64(colors.count))]
            let w = CGFloat(6 + (rng.next() % 7)) // 6...12
            let h = CGFloat(6 + (rng.next() % 9)) // 6...14
            let cornerRadius = CGFloat(rng.next() % 4) // 0...3

            // Spawn near bottom center, with slight horizontal spread.
            let x0 = (size.width / 2) + rng.nextCGFloat(in: -24...24)
            let vx = rng.nextCGFloat(in: -120...120)
            let vy = rng.nextCGFloat(in: -520...(-360))
            let gravity = rng.nextCGFloat(in: 760...980)
            let spin = rng.nextCGFloat(in: -540...540)

            return Particle(
                color: color,
                size: CGSize(width: w, height: h),
                cornerRadius: cornerRadius,
                x0: x0,
                vx: vx,
                vy: vy,
                gravity: gravity,
                spinDegrees: spin
            )
        }
    }

    private func position(for particle: Particle, progress: Double, size: CGSize) -> CGPoint {
        let t = CGFloat(progress * config.duration)
        let x = particle.x0 + particle.vx * t
        let y0 = size.height + 20
        let y = y0 + particle.vy * t + 0.5 * particle.gravity * t * t
        return CGPoint(x: x, y: y)
    }
}

// MARK: - RNG

private struct SplitMix64 {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed &+ 0x9E3779B97F4A7C15
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }

    mutating func nextCGFloat(in range: ClosedRange<CGFloat>) -> CGFloat {
        let maxU = CGFloat(UInt64.max)
        let u = CGFloat(next()) / maxU
        return range.lowerBound + (range.upperBound - range.lowerBound) * u
    }
}
