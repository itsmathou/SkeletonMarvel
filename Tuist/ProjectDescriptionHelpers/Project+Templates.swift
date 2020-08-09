import ProjectDescription

extension Project {

    public static func app(name: String, platform: Platform, dependencies: [TargetDependency] = []) -> Project {
        return self.project(name: name, product: .app, platform: platform, dependencies: dependencies, infoPlist: [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"]
        ])
    }

    public static func framework(name: String, platform: Platform, dependencies: [TargetDependency] = []) -> Project {
        return self.project(name: name, product: .framework, platform: platform, dependencies: dependencies)
    }

    public static func project(name: String,
                               product: Product,
                               platform: Platform,
                               dependencies: [TargetDependency] = [],
                               infoPlist: [String: InfoPlist.Value] = [:]) -> Project {
        return Project(name: name,
                       targets: [
                        Target(name: name,
                                platform: platform,
                                product: product,
                                bundleId: "com.mathildeferrand.\(name)",
                                deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                                infoPlist: .extendingDefault(with: infoPlist),
                                sources: ["Sources/**/*.swift"],
                                resources: [],
                                dependencies: dependencies),
                        Target(name: "\(name)Tests",
                                platform: platform,
                                product: .unitTests,
                                bundleId: "com.mathildeferrand.\(name)Tests",
                                deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                                infoPlist: .default,
                                sources: ["Tests/**/*.swift"],
                                dependencies: [
                                    .target(name: "\(name)"),
                                    .xctest
                                ])
                      ])
    }

}
