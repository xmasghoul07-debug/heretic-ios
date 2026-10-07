import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(hex: "0b1118")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                PhoneStatusBar()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        RepoBrowserSection()
                        ReadmeSection()
                    }
                    .frame(width: 390, alignment: .center)
                }
                .safeAreaInset(edge: .bottom) {
                    BrowserFooter()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct PhoneStatusBar: View {
    var body: some View {
        HStack {
            Text("12:40")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding(.leading, 18)

            Spacer()

            HStack(spacing: 14) {
                Image(systemName: "cellularbars")
                    .font(.system(size: 16, weight: .bold))
                Image(systemName: "wifi")
                    .font(.system(size: 16, weight: .bold))
                BatteryView()
            }
            .foregroundStyle(.white)
            .padding(.trailing, 18)
        }
        .frame(height: 56)
        .background(Color(hex: "091118"))
    }
}

private struct BatteryView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 26, height: 14)
                .foregroundStyle(Color.white.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white, lineWidth: 1.2)
                )

            RoundedRectangle(cornerRadius: 3)
                .frame(width: 18, height: 8)
                .foregroundStyle(Color(hex: "7fe57f"))
                .padding(.leading, 3)

            Capsule()
                .frame(width: 2, height: 6)
                .padding(.leading, 26)
                .foregroundStyle(.white)
        }
    }
}

private struct RepoBrowserSection: View {
    let entries: [(String, String)] = [
        (".github/workflows", "last week"),
        ("src/heretic", "yesterday"),
        ("tests", "yesterday"),
        (".gitattributes", "10 months ago"),
        (".gitignore", "4 months ago"),
        (".python-version", "last year"),
        ("LICENSE", "last year"),
        ("README.md", "last week"),
        ("config.default.toml", "last week"),
        ("config.nohumor.toml", "last week"),
        ("config.noslop.toml", "last week"),
        ("config.piqa.toml", "last week"),
        ("pyproject.toml", "5 days ago"),
        ("uv.lock", "5 days ago")
    ]

    var body: some View {
        VStack(spacing: 0) {
            topHeaderRow()

            VStack(spacing: 0) {
                ForEach(entries.indices, id: \ .self) { index in
                    RepoRow(name: entries[index].0, date: entries[index].1, isSelected: entries[index].0 == "config.piqa.toml")
                        .padding(.horizontal, 14)
                }
            }
        }
        .background(Color(hex: "0c1621"))
        .frame(width: 390)
    }

    @ViewBuilder
    private func topHeaderRow() -> some View {
        HStack {
            Circle()
                .frame(width: 28, height: 28)
                .foregroundStyle(LinearGradient(colors: [.gray, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(
                    Circle()
                        .inset(by: 2)
                        .stroke(Color.black.opacity(0.35), lineWidth: 1)
                )

            Text("jayhemnani9910")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)

            Text("yesterday")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.gray)

            Spacer()

            Button {} label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.gray)
            }

            Button {} label: {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .frame(height: 58)
        .background(Color(hex: "0c1a26"))
    }
}

private struct RepoRow: View {
    let name: String
    let date: String
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "doc.fill")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.white.opacity(0.85))
                .frame(width: 22, height: 22)
                .padding(.leading, 4)

            Text(name)
                .font(.system(size: 20, weight: .light))
                .foregroundStyle(isSelected ? Color.blue : .white)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(date)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.gray)
                .padding(.trailing, 8)
        }
        .frame(height: 52)
        .background(Color(hex: "0c1621"))
        .overlay(
            Rectangle().frame(height: 1).foregroundColor(Color.white.opacity(0.08)).padding(.horizontal, 0),
            alignment: .bottom
        )
    }
}

private struct ReadmeSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("README")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)

                Text("AGPL-3.0 license")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.gray)
                    .padding(.leading, 6)

                Spacer()

                HStack(spacing: 14) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 22, weight: .medium))
                    Image(systemName: "arrow.up.right.square")
                        .font(.system(size: 22, weight: .medium))
                    Image(systemName: "list.bullet")
                        .font(.system(size: 22, weight: .medium))
                }
                .foregroundStyle(.gray)
            }
            .padding(.horizontal, 14)
            .padding(.top, 12)

            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color(hex: "f88d6b"))
                .padding(.horizontal, 14)

            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Heretic:")
                            .font(.system(size: 54, weight: .heavy))
                            .foregroundStyle(.white)
                        Text("Fully")
                            .font(.system(size: 54, weight: .heavy))
                            .foregroundStyle(.white)
                        Text("automatic")
                            .font(.system(size: 54, weight: .heavy))
                            .foregroundStyle(.white)
                        Text("censorship removal")
                            .font(.system(size: 54, weight: .heavy))
                            .foregroundStyle(.white)
                        Text("for language models")
                            .font(.system(size: 54, weight: .heavy))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    HereticBadge()
                        .padding(.top, 14)
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        StatusPill(title: "DISCORD", accent: Color(hex: "4f5ce6"), count: "233 ONLINE")
                        StatusPill(title: "MATRIX", accent: Color(hex: "4e6def"), count: "")
                    }

                    HStack(spacing: 10) {
                        FollowPill(title: "Follow us on")
                        FollowPill(title: "CODEBERG MIRROR")
                    }
                }

                TrendingCard()
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 18)
        }
        .background(Color(hex: "0d1621"))
        .padding(.top, 8)
    }
}

private struct HereticBadge: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26)
                .fill(LinearGradient(colors: [.black, Color(hex: "1c140f")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 180, height: 180)
                .overlay(
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(Color.orange.opacity(0.8), lineWidth: 2)
                )

            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color(hex: "ffb347"), Color(hex: "ff5f00")], startPoint: .top, endPoint: .bottom))
                    .blur(radius: 12)
                    .frame(width: 120, height: 120)
                    .offset(y: 25)

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "1a1a1f"))
                    .frame(width: 90, height: 100)
                    .offset(y: 20)

                Capsule()
                    .fill(Color(hex: "1b1a1d"))
                    .frame(width: 84, height: 66)
                    .offset(y: -14)

                Rectangle()
                    .fill(Color(hex: "110d0e"))
                    .frame(width: 80, height: 62)
                    .offset(y: -2)
            }
            .frame(width: 160, height: 160)
        }
    }
}

private struct StatusPill: View {
    let title: String
    let accent: Color
    let count: String

    var body: some View {
        HStack(spacing: 8) {
            if title == "DISCORD" {
                Image(systemName: "message.fill")
                    .font(.system(size: 18, weight: .bold))
            }
            if title == "MATRIX" {
                Text("[ ]")
                    .font(.system(size: 20, weight: .bold))
            }

            Text(title)
                .font(.system(size: 18, weight: .bold))
                .tracking(0.5)
                .foregroundStyle(.white)

            if !count.isEmpty {
                Text(count)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(accent)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(height: 42)
        .background(Color(hex: "111821"))
        .clipShape(Capsule())
    }
}

private struct FollowPill: View {
    let title: String

    var body: some View {
        HStack(spacing: 8) {
            if title == "Follow us on" {
                Text("Follow us on")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .bold))
            } else {
                Text(title)
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color(hex: "111821"))
        .clipShape(Capsule())
    }
}

private struct TrendingCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(hex: "f3f3f6"))
                .frame(height: 110)

            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "efe9f6"))
                        .frame(width: 50, height: 50)
                    Text("1")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(Color(hex: "3d2d52"))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("#1 Repository Of The Day")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundStyle(Color(hex: "1d1a2a"))
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 18)
        }
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

private struct BrowserFooter: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 16) {
                Button {} label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.white)
                }

                Button {} label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.white)
                }

                HStack {
                    Spacer()
                    Text("github.com")
                        .font(.system(size: 22, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .frame(height: 56)
                .background(Color(hex: "b9b9bf").opacity(0.3))
                .clipShape(Capsule())

                Button {} label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(Color(hex: "b9b9bf").opacity(0.35))
                        .clipShape(Circle())
                }

                Button {} label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(Color(hex: "b9b9bf").opacity(0.35))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 14)
            .padding(.top, 10)
            .padding(.bottom, 12)

            HStack(alignment: .center) {
                VStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Ask Gemini")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)

                VStack(spacing: 6) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "f9f9fa").opacity(0.18))
                            .frame(width: 44, height: 44)
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Text("New tab")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)

                VStack(spacing: 6) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "f9f9fa").opacity(0.18))
                            .frame(width: 44, height: 44)
                        Text("40")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(6)
                            .background(Color(hex: "0d1621"))
                            .clipShape(Circle())
                    }
                    Text("All tabs")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity)
        }
        .background(Color(hex: "0b1118"))
        .frame(width: 390)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}

#Preview {
    ContentView()
        .previewDevice("iPhone 13")
}



























































































































































































































































































































































