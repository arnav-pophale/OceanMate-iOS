import SwiftUI

// MARK: Data (unchanged)
struct FishingSetup { let bait: [String]; let rig: [String] }
let fishingRecommendations: [String: FishingSetup] = [
    "Largemouth Bass": .init(bait: ["Plastic Worm", "Live Shiner"], rig: ["Texas Rig", "Wacky Rig"]),
    "Trout": .init(bait: ["PowerBait", "Live Worm"], rig: ["Split Shot Rig", "Inline Spinner"]),
    "Red Snapper": .init(bait: ["Cut Squid", "Pinfish"], rig: ["Fish Finder Rig", "Bottom Rig"]),
    "Catfish": .init(bait: ["Chicken Liver", "Stink Bait"], rig: ["Slip Sinker Rig", "3-Way Rig"]),
    "Salmon": .init(bait: ["Roe", "Spoons"], rig: ["Drift Rig", "Flasher Setup"]),
    "Bluegill": .init(bait: ["Crickets", "Red Worms"], rig: ["Float Rig", "Split Shot Rig"]),
    "Striped Bass": .init(bait: ["Bunker", "Bloodworms"], rig: ["Three-Way Rig", "Fish Finder Rig"]),
    "Flounder": .init(bait: ["Minnows", "Squid Strips"], rig: ["Carolina Rig", "Drop Shot Rig"]),
    "Northern Pike": .init(bait: ["Large Minnows", "Spoons"], rig: ["Quick Strike Rig", "Spinnerbait Setup"]),
    "Crappie": .init(bait: ["Jigs", "Minnows"], rig: ["Slip Bobber Rig", "Light Jig Setup"]),
    "Walleye": .init(bait: ["Minnows", "Nightcrawlers"], rig: ["Slip Sinker Rig", "Jigging Rig"]),
    "Smallmouth Bass": .init(bait: ["Crayfish", "Jigs"], rig: ["Drop Shot Rig", "Carolina Rig"]),
    "Muskie": .init(bait: ["Large Crankbaits", "Topwater Lures"], rig: ["Heavy Duty Rig", "Wire Leader Setup"]),
    "Halibut": .init(bait: ["Herring", "Squid"], rig: ["Bottom Rig", "Circle Hook Rig"]),
    "Snapper": .init(bait: ["Shrimp", "Crabs"], rig: ["Fish Finder Rig", "Bottom Rig"]),
    "Tarpon": .init(bait: ["Crabs", "Shrimp"], rig: ["Live Bait Rig", "Circle Hook Rig"]),
    "Mahi Mahi": .init(bait: ["Ballyhoo", "Striped Mullet"], rig: ["Trolling Rig", "Teaser Rig"]),
    "Tuna": .init(bait: ["Live Bait", "Artificial Lures"], rig: ["Trolling Rig", "Heavy Duty Rig"]),
    "Bass (General)": .init(bait: ["Spinnerbaits", "Soft Plastics"], rig: ["Texas Rig", "Carolina Rig"]),
    "Bluefish": .init(bait: ["Cut Bait", "Poppers"], rig: ["Wire Leader Rig", "Trolling Rig"]),
    "Perch": .init(bait: ["Minnows", "Worms"], rig: ["Slip Bobber Rig", "Jigging Rig"]),
    "Panfish": .init(bait: ["Worms", "Small Jigs"], rig: ["Float Rig", "Slip Bobber Rig"]),
    "Carp": .init(bait: ["Corn", "Dough Balls"], rig: ["Hair Rig", "Bolt Rig"]),
    "Swordfish": .init(bait: ["Squid", "Mackerel"], rig: ["Deep Drop Rig", "Circle Hook Rig"]),
    "Snook": .init(bait: ["Live Shrimp", "Jigs"], rig: ["Fluorocarbon Leader Rig", "Live Bait Rig"]),
    "Redfish (Red Drum)": .init(bait: ["Shrimp", "Crabs"], rig: ["Carolina Rig", "Circle Hook Rig"]),
    "Lake Trout": .init(bait: ["Minnows", "Spoons"], rig: ["Jigging Rig", "Trolling Rig"]),
    "Grouper": .init(bait: ["Live Bait", "Cut Bait"], rig: ["Bottom Rig", "Circle Hook Rig"]),
    "Kingfish (King Mackerel)": .init(bait: ["Live Bait", "Cut Bait"], rig: ["Trolling Rig", "Wire Leader Rig"]),
    "Blue Catfish": .init(bait: ["Shad", "Cut Bait"], rig: ["Slip Sinker Rig", "Circle Hook Rig"]),
    "Pike": .init(bait: ["Large Minnows", "Spinnerbaits"], rig: ["Wire Leader Rig", "Heavy Duty Rig"]),
    "White Bass": .init(bait: ["Jigs", "Minnows"], rig: ["Slip Bobber Rig", "Jigging Rig"]),
    "Zander": .init(bait: ["Minnows", "Nightcrawlers"], rig: ["Jigging Rig", "Slip Sinker Rig"]),
    "Bass, Striped (Rockfish)": .init(bait: ["Bloodworms", "Small Fish"], rig: ["Three-Way Rig", "Fish Finder Rig"])
]

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedFish: String? = nil
    @State private var showChat = false
    @State private var appeared = false
    @State private var goToDetail = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.oceanInk, Color.oceanNavy, Color.oceanSky],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    // Title
                    HStack(spacing: 10) {
                        Image(systemName: "fish.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 22, weight: .bold))
                        Text("OceanMate")
                            .font(.title.bold())
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 20)
                    .animation(.easeOut(duration: 0.35), value: appeared)
                    .onAppear { appeared = true }

                    // Search
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Label("Search for a fish…", systemImage: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.55))
                                .padding(.leading, 12)
                        }
                        TextField("", text: $searchText)
                            .padding(12)
                            .background(Color.oceanGlass)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.oceanStroke, lineWidth: 1))
                    }

                    // Picker
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Select species")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                        Picker("Select a fish", selection: $selectedFish) {
                            ForEach(filteredFishList, id: \.self) { fish in
                                Text(fish).tag(Optional(fish))
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 220)
                    }
                    .glassCard()
                    
                    BestTimeCard(species: selectedFish)

                    // Get Recommendation Button
                    VStack(spacing: 14) {
                        Button {
                            if selectedFish != nil {
                                goToDetail = true
                            }
                        } label: {
                            Text("Get Recommendation")
                                .font(.headline)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .opacity(selectedFish == nil ? 0.5 : 1)
                        .disabled(selectedFish == nil)

                        NavigationLink(
                            destination: FishDetailView(
                                fishName: selectedFish ?? "",
                                setup: fishingRecommendations[selectedFish ?? ""] ?? .init(bait: [], rig: [])
                            ),
                            isActive: $goToDetail
                        ) { EmptyView() }
                        .hidden()

                        // Chat Button
                        Button {
                            showChat = true
                        } label: {
                            Text("Chat with Fishing Assistant")
                                .font(.headline)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .opacity(0.95)
                        .sheet(isPresented: $showChat) {
                            NavigationStack {
                                ChatView()
                                    .navigationTitle("Chat")
                                    .navigationBarTitleDisplayMode(.inline)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .center)
                .tint(.white)
                .foregroundColor(.white)
            }
        }
    }

    private var filteredFishList: [String] {
        let list = Array(fishingRecommendations.keys).sorted()
        return searchText.isEmpty ? list
        : list.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
}
