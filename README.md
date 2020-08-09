# Skeleton Marvel

Sandbox project using the Marvel Character API

You'll realise there's no `.xcodeproj` in this repo. Project generation is handled by [Tuist](https://github.com/tuist/tuist)
To set up the project, make sure you have Tuist installed. If not, run `bash <(curl -Ls https://install.tuist.io)`. Then, just run `tuist focus`.
This sandbox app requires to use Xcode 12.

Goals:
- [ ] Practicing networking, MVVM-C and UIKit avoiding third party framework as much as possible
- [x] Learning about [UICollectionLayoutListConfiguration](https://developer.apple.com/videos/play/wwdc2020/10026)
- [x] Learning about [Diffable Data Source](https://wwdcbysundell.com/2019/diffable-data-sources-first-look/)
- [ ] Learning about [Skeleton Screens](https://uxdesign.cc/what-you-should-know-about-skeleton-screens-a820c45a571a)

Next step:
- [ ] Fixing the loading state, but is it compatible with a diffable collection view?
- [ ] Second screen
- [ ] Search controller to actually see the diffing in action
