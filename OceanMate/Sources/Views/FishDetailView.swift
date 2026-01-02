import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Extra tips (simple knowledge base)
struct FishTips {
    let hook: String
    let line: String
    let weight: String
    let depth: String
    let bestTime: String
    let techniques: [String]
}

private let defaultTips = FishTips(
    hook: "#1–2/0 circle/J",
    line: "12–20 lb mono/fluoro",
    weight: "1/4–1 oz (current dependent)",
    depth: "Near bottom / structure",
    bestTime: "Dawn & dusk",
    techniques: [
        "Cast up-current; retrieve with pauses.",
        "Match bait size to local forage.",
        "Slow down in clear water; go louder/brighter in stained water."
    ]
)

private let fishTips: [String: FishTips] = [
    "Halibut": .init(
        hook: "4/0–7/0 circle",
        line: "40–80 lb braid + 40–60 lb leader",
        weight: "8–24 oz (tide)",
        depth: "Bottom, 50–200 ft",
        bestTime: "Slack → outgoing tide",
        techniques: [
            "Bounce the weight along bottom; keep bait just off sand.",
            "Drift natural baits (herring/squid) slowly.",
            "Use circle hooks—let the fish load the rod, don’t swing."
        ]
    ),
    "Trout": .init(
        hook: "#8–#12",
        line: "4–6 lb mono",
        weight: "Split shot",
        depth: "Shallow runs / pools",
        bestTime: "First light & evening",
        techniques: [
            "Light line in clear water; natural colors.",
            "Inline spinners across current; steady retrieve.",
            "Pause baits in seams and tail-outs."
        ]
    ),
    "Largemouth Bass": .init(
        hook: "2/0–4/0 EWG",
        line: "12–17 lb fluoro",
        weight: "1/8–3/8 oz",
        depth: "Weed edges / laydowns",
        bestTime: "Early/late; shade at noon",
        techniques: [
            "Texas/Wacky rig plastics; slow lift-drop.",
            "Topwater early; switch to jigs as sun rises.",
            "Pitch to cover; let it sit before moving."
        ]
    ),
    "Catfish": .init(
        hook: "3/0–6/0 circle",
        line: "20–30 lb mono",
        weight: "1–3 oz sinker",
        depth: "Deep holes / bends",
        bestTime: "Dusk–night",
        techniques: [
            "Set baits on bottom with slip-sinker rigs.",
            "Use oily/stinky baits; keep hook points clean.",
            "Let circle hooks load—don’t set hard."
        ]
    ),
    "Redfish (Red Drum)": .init(
        hook: "1/0–3/0 circle",
        line: "20–30 lb braid + 20–30 lb leader",
        weight: "1/8–1/2 oz",
        depth: "Shallow flats / cuts",
        bestTime: "Incoming tide",
        techniques: [
            "Sight-fish edges; lead the fish.",
            "Shrimp/crab on Carolina rigs—slow crawl.",
            "Paddle tails along oyster bars."
        ]
    )
]

// MARK: - View

struct FishDetailView: View {
    let fishName: String
    let setup: FishingSetup

    @State private var appeared = false
    @State private var showCopied = false

    private var tips: FishTips {
        fishTips[fishName] ?? defaultTips
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Background
            LinearGradient(colors: [.oceanInk, .oceanNavy], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {

                    // Header
                    HStack(spacing: 12) {
                        Image(systemName: "fish")
                            .font(.system(size: 28, weight: .bold))
                        Text(fishName.isEmpty ? "Details" : fishName)
                            .font(.title.bold())
                    }
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 8)
                    .animation(.easeOut(duration: 0.25), value: appeared)

                    // Loadout card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recommended Loadout")
                            .font(.headline)
                        Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 12) {
                            row(icon: "hook", label: "Hook", value: tips.hook)
                            row(icon: "line.horizontal.3", label: "Line/Test", value: tips.line)
                            row(icon: "scalemass", label: "Weight", value: tips.weight)
                            row(icon: "water.waves", label: "Depth", value: tips.depth)
                            row(icon: "sunrise.fill", label: "Best Time", value: tips.bestTime)
                        }
                        Button {
                            UIPasteboard.general.string = loadoutText
                            Haptics.success()
                            withAnimation { showCopied = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                withAnimation { showCopied = false }
                            }
                        } label: {
                            Text("Copy Loadout")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    .glassCard()

                    // Bait section
                    sectionHeader("Recommended Bait")
                    TagList(items: setup.bait)
                        .glassCard()

                    // Rigs section
                    sectionHeader("Recommended Rigs")
                    TagList(items: setup.rig)
                        .glassCard()

                    // Techniques
                    sectionHeader("Techniques")
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(tips.techniques, id: \.self) { tip in
                            Label {
                                Text(tip)
                            } icon: {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                    }
                    .padding(.top, 2)
                    .glassCard()

                    Spacer(minLength: 16)
                }
                .padding()
            }

            // Toast
            if showCopied {
                Text("Copied to Clipboard")
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.oceanStroke, lineWidth: 1)
                    )
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { appeared = true }
    }

    private var loadoutText: String {
        """
        \(fishName) Loadout:
        • Hook: \(tips.hook)
        • Line/Test: \(tips.line)
        • Weight: \(tips.weight)
        • Depth: \(tips.depth)
        • Best Time: \(tips.bestTime)
        Bait: \(setup.bait.joined(separator: ", "))
        Rigs: \(setup.rig.joined(separator: ", "))
        """
    }

    @ViewBuilder
    private func row(icon: String, label: String, value: String) -> some View {
        GridRow {
            Label(label, systemImage: icon)
                .foregroundColor(.white.opacity(0.9))
            Text(value)
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .padding(.top, 4)
    }
}


private struct TagList: View {
    let items: [String]
    @State private var appeared = false

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 10)], spacing: 10) {
            ForEach(Array(items.enumerated()), id: \.1) { index, item in
                Text(item)
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.oceanGlass)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.oceanStroke, lineWidth: 1)
                    )
                    .cornerRadius(12)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 6)
                    .animation(.easeOut(duration: 0.25).delay(0.03 * Double(index)), value: appeared)
            }
        }
        .onAppear { appeared = true }
    }
}

