//
//  StyleSingleton.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/7/23.
//

import Foundation
import UIKit

class StyleSingleton {
    private init() {}
    
    static var s = StyleSingleton()
    let mainViewBackgroundColor : UIColor = .black
    let GoogleBlue = UIColor(red: 0.30, green: 0.55, blue: 0.96, alpha: 1.00)
    let YouTubeRed = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1.00)
    let ChatGTPGreen = UIColor(red: 0.05, green: 0.64, blue: 0.50, alpha: 1.00)
    let AppYellow = UIColor(red: 0.99, green: 0.73, blue: 0.01, alpha: 1.00)
    
    func fontType(fonts : fontOptions, fontSize : CGFloat) -> UIFont? {
        switch fonts {
            case .AcademyEngravedLetPlain: return UIFont(name: "AcademyEngravedLetPlain", size: fontSize)
            case .AlNile: return UIFont(name: "AlNile", size: fontSize)
            case .AlNileBold: return UIFont(name: "AlNile-Bold", size: fontSize)
            case .AmericanTypewriter: return UIFont(name: "AmericanTypewriter", size: fontSize)
            case .AmericanTypewriterLight: return UIFont(name: "AmericanTypewriter-Light", size: fontSize)
            case .AmericanTypewriterSemibold: return UIFont(name: "AmericanTypewriter-Semibold", size: fontSize)
            case .AmericanTypewriterBold: return UIFont(name: "AmericanTypewriter-Bold", size: fontSize)
            case .AmericanTypewriterCondensed: return UIFont(name: "AmericanTypewriter-Condensed", size: fontSize)
            case .AmericanTypewriterCondensedLight: return UIFont(name: "AmericanTypewriter-CondensedLight", size: fontSize)
            case .AmericanTypewriterCondensedBold: return UIFont(name: "AmericanTypewriter-CondensedBold", size: fontSize)
            case .AppleColorEmoji: return UIFont(name: "AppleColorEmoji", size: fontSize)
            case .AppleSDGothicNeoRegular: return UIFont(name: "AppleSDGothicNeo-Regular", size: fontSize)
            case .AppleSDGothicNeoThin: return UIFont(name: "AppleSDGothicNeo-Thin", size: fontSize)
            case .AppleSDGothicNeoUltraLight: return UIFont(name: "AppleSDGothicNeo-UltraLight", size: fontSize)
            case .AppleSDGothicNeoLight: return UIFont(name: "AppleSDGothicNeo-Light", size: fontSize)
            case .AppleSDGothicNeoMedium: return UIFont(name: "AppleSDGothicNeo-Medium", size: fontSize)
            case .AppleSDGothicNeoSemiBold: return UIFont(name: "AppleSDGothicNeo-SemiBold", size: fontSize)
            case .AppleSDGothicNeoBold: return UIFont(name: "AppleSDGothicNeo-Bold", size: fontSize)
            case .AppleSymbols: return UIFont(name: "AppleSymbols", size: fontSize)
            case .ArialMT: return UIFont(name: "ArialMT", size: fontSize)
            case .ArialItalicMT: return UIFont(name: "Arial-ItalicMT", size: fontSize)
            case .ArialBoldMT: return UIFont(name: "Arial-BoldMT", size: fontSize)
            case .ArialBoldItalicMT: return UIFont(name: "Arial-BoldItalicMT", size: fontSize)
            case .ArialHebrew: return UIFont(name: "ArialHebrew", size: fontSize)
            case .ArialHebrewLight: return UIFont(name: "ArialHebrew-Light", size: fontSize)
            case .ArialHebrewBold: return UIFont(name: "ArialHebrew-Bold", size: fontSize)
            case .ArialRoundedMTBold: return UIFont(name: "ArialRoundedMTBold", size: fontSize)
            case .AvenirBook: return UIFont(name: "Avenir-Book", size: fontSize)
            case .AvenirRoman: return UIFont(name: "Avenir-Roman", size: fontSize)
            case .AvenirBookOblique: return UIFont(name: "Avenir-BookOblique", size: fontSize)
            case .AvenirOblique: return UIFont(name: "Avenir-Oblique", size: fontSize)
            case .AvenirLight: return UIFont(name: "Avenir-Light", size: fontSize)
            case .AvenirLightOblique: return UIFont(name: "Avenir-LightOblique", size: fontSize)
            case .AvenirMedium: return UIFont(name: "Avenir-Medium", size: fontSize)
            case .AvenirMediumOblique: return UIFont(name: "Avenir-MediumOblique", size: fontSize)
            case .AvenirHeavy: return UIFont(name: "Avenir-Heavy", size: fontSize)
            case .AvenirHeavyOblique: return UIFont(name: "Avenir-HeavyOblique", size: fontSize)
            case .AvenirBlack: return UIFont(name: "Avenir-Black", size: fontSize)
            case .AvenirBlackOblique: return UIFont(name: "Avenir-BlackOblique", size: fontSize)
            case .AvenirNextRegular: return UIFont(name: "AvenirNext-Regular", size: fontSize)
            case .AvenirNextItalic: return UIFont(name: "AvenirNext-Italic", size: fontSize)
            case .AvenirNextUltraLight: return UIFont(name: "AvenirNext-UltraLight", size: fontSize)
            case .AvenirNextUltraLightItalic: return UIFont(name: "AvenirNext-UltraLightItalic", size: fontSize)
            case .AvenirNextMedium: return UIFont(name: "AvenirNext-Medium", size: fontSize)
            case .AvenirNextMediumItalic: return UIFont(name: "AvenirNext-MediumItalic", size: fontSize)
            case .AvenirNextDemiBold: return UIFont(name: "AvenirNext-DemiBold", size: fontSize)
            case .AvenirNextDemiBoldItalic: return UIFont(name: "AvenirNext-DemiBoldItalic", size: fontSize)
            case .AvenirNextBold: return UIFont(name: "AvenirNext-Bold", size: fontSize)
            case .AvenirNextBoldItalic: return UIFont(name: "AvenirNext-BoldItalic", size: fontSize)
            case .AvenirNextHeavy: return UIFont(name: "AvenirNext-Heavy", size: fontSize)
            case .AvenirNextHeavyItalic: return UIFont(name: "AvenirNext-HeavyItalic", size: fontSize)
            case .AvenirNextCondensedRegular: return UIFont(name: "AvenirNextCondensed-Regular", size: fontSize)
            case .AvenirNextCondensedItalic: return UIFont(name: "AvenirNextCondensed-Italic", size: fontSize)
            case .AvenirNextCondensedUltraLight: return UIFont(name: "AvenirNextCondensed-UltraLight", size: fontSize)
            case .AvenirNextCondensedUltraLightItalic: return UIFont(name: "AvenirNextCondensed-UltraLightItalic", size: fontSize)
            case .AvenirNextCondensedMedium: return UIFont(name: "AvenirNextCondensed-Medium", size: fontSize)
            case .AvenirNextCondensedMediumItalic: return UIFont(name: "AvenirNextCondensed-MediumItalic", size: fontSize)
            case .AvenirNextCondensedDemiBold: return UIFont(name: "AvenirNextCondensed-DemiBold", size: fontSize)
            case .AvenirNextCondensedDemiBoldItalic: return UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: fontSize)
            case .AvenirNextCondensedBold: return UIFont(name: "AvenirNextCondensed-Bold", size: fontSize)
            case .AvenirNextCondensedBoldItalic: return UIFont(name: "AvenirNextCondensed-BoldItalic", size: fontSize)
            case .AvenirNextCondensedHeavy: return UIFont(name: "AvenirNextCondensed-Heavy", size: fontSize)
            case .AvenirNextCondensedHeavyItalic: return UIFont(name: "AvenirNextCondensed-HeavyItalic", size: fontSize)
            case .Baskerville: return UIFont(name: "Baskerville", size: fontSize)
            case .BaskervilleItalic: return UIFont(name: "Baskerville-Italic", size: fontSize)
            case .BaskervilleSemiBold: return UIFont(name: "Baskerville-SemiBold", size: fontSize)
            case .BaskervilleSemiBoldItalic: return UIFont(name: "Baskerville-SemiBoldItalic", size: fontSize)
            case .BaskervilleBold: return UIFont(name: "Baskerville-Bold", size: fontSize)
            case .BaskervilleBoldItalic: return UIFont(name: "Baskerville-BoldItalic", size: fontSize)
            case .BodoniSvtyTwoITCTTBook: return UIFont(name: "BodoniSvtyTwoITCTT-Book", size: fontSize)
            case .BodoniSvtyTwoITCTTBookIta: return UIFont(name: "BodoniSvtyTwoITCTT-BookIta", size: fontSize)
            case .BodoniSvtyTwoITCTTBold: return UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: fontSize)
            case .BodoniSvtyTwoOSITCTTBook: return UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: fontSize)
            case .BodoniSvtyTwoOSITCTTBookIt: return UIFont(name: "BodoniSvtyTwoOSITCTT-BookIt", size: fontSize)
            case .BodoniSvtyTwoOSITCTTBold: return UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: fontSize)
            case .BodoniSvtyTwoSCITCTTBook: return UIFont(name: "BodoniSvtyTwoSCITCTT-Book", size: fontSize)
            case .BodoniOrnamentsITCTT: return UIFont(name: "BodoniOrnamentsITCTT", size: fontSize)
            case .BradleyHandITCTTBold: return UIFont(name: "BradleyHandITCTT-Bold", size: fontSize)
            case .ChalkboardSERegular: return UIFont(name: "ChalkboardSE-Regular", size: fontSize)
            case .ChalkboardSELight: return UIFont(name: "ChalkboardSE-Light", size: fontSize)
            case .ChalkboardSEBold: return UIFont(name: "ChalkboardSE-Bold", size: fontSize)
            case .Chalkduster: return UIFont(name: "Chalkduster", size: fontSize)
            case .CharterRoman: return UIFont(name: "Charter-Roman", size: fontSize)
            case .CharterItalic: return UIFont(name: "Charter-Italic", size: fontSize)
            case .CharterBold: return UIFont(name: "Charter-Bold", size: fontSize)
            case .CharterBoldItalic: return UIFont(name: "Charter-BoldItalic", size: fontSize)
            case .CharterBlack: return UIFont(name: "Charter-Black", size: fontSize)
            case .CharterBlackItalic: return UIFont(name: "Charter-BlackItalic", size: fontSize)
            case .Cochin: return UIFont(name: "Cochin", size: fontSize)
            case .CochinItalic: return UIFont(name: "Cochin-Italic", size: fontSize)
            case .CochinBold: return UIFont(name: "Cochin-Bold", size: fontSize)
            case .CochinBoldItalic: return UIFont(name: "Cochin-BoldItalic", size: fontSize)
            case .Copperplate: return UIFont(name: "Copperplate", size: fontSize)
            case .CopperplateLight: return UIFont(name: "Copperplate-Light", size: fontSize)
            case .CopperplateBold: return UIFont(name: "Copperplate-Bold", size: fontSize)
            case .CourierNewPSMT: return UIFont(name: "CourierNewPSMT", size: fontSize)
            case .CourierNewPSItalicMT: return UIFont(name: "CourierNewPS-ItalicMT", size: fontSize)
            case .CourierNewPSBoldMT: return UIFont(name: "CourierNewPS-BoldMT", size: fontSize)
            case .CourierNewPSBoldItalicMT: return UIFont(name: "CourierNewPS-BoldItalicMT", size: fontSize)
            case .Damascus: return UIFont(name: "Damascus", size: fontSize)
            case .DamascusLight: return UIFont(name: "DamascusLight", size: fontSize)
            case .DamascusMedium: return UIFont(name: "DamascusMedium", size: fontSize)
            case .DamascusSemiBold: return UIFont(name: "DamascusSemiBold", size: fontSize)
            case .DamascusBold: return UIFont(name: "DamascusBold", size: fontSize)
            case .DevanagariSangamMN: return UIFont(name: "DevanagariSangamMN", size: fontSize)
            case .DevanagariSangamMNBold: return UIFont(name: "DevanagariSangamMN-Bold", size: fontSize)
            case .Didot: return UIFont(name: "Didot", size: fontSize)
            case .DidotItalic: return UIFont(name: "Didot-Italic", size: fontSize)
            case .DidotBold: return UIFont(name: "Didot-Bold", size: fontSize)
            case .DINAlternateBold: return UIFont(name: "DINAlternate-Bold", size: fontSize)
            case .DINCondensedBold: return UIFont(name: "DINCondensed-Bold", size: fontSize)
            case .EuphemiaUCAS: return UIFont(name: "EuphemiaUCAS", size: fontSize)
            case .EuphemiaUCASItalic: return UIFont(name: "EuphemiaUCAS-Italic", size: fontSize)
            case .EuphemiaUCASBold: return UIFont(name: "EuphemiaUCAS-Bold", size: fontSize)
            case .Farah: return UIFont(name: "Farah", size: fontSize)
            case .FuturaMedium: return UIFont(name: "Futura-Medium", size: fontSize)
            case .FuturaMediumItalic: return UIFont(name: "Futura-MediumItalic", size: fontSize)
            case .FuturaBold: return UIFont(name: "Futura-Bold", size: fontSize)
            case .FuturaCondensedMedium: return UIFont(name: "Futura-CondensedMedium", size: fontSize)
            case .FuturaCondensedExtraBold: return UIFont(name: "Futura-CondensedExtraBold", size: fontSize)
            case .Galvji: return UIFont(name: "Galvji", size: fontSize)
            case .GalvjiBold: return UIFont(name: "Galvji-Bold", size: fontSize)
            case .GeezaPro: return UIFont(name: "GeezaPro", size: fontSize)
            case .GeezaProBold: return UIFont(name: "GeezaPro-Bold", size: fontSize)
            case .Georgia: return UIFont(name: "Georgia", size: fontSize)
            case .GeorgiaItalic: return UIFont(name: "Georgia-Italic", size: fontSize)
            case .GeorgiaBold: return UIFont(name: "Georgia-Bold", size: fontSize)
            case .GeorgiaBoldItalic: return UIFont(name: "Georgia-BoldItalic", size: fontSize)
            case .GillSans: return UIFont(name: "GillSans", size: fontSize)
            case .GillSansItalic: return UIFont(name: "GillSans-Italic", size: fontSize)
            case .GillSansLight: return UIFont(name: "GillSans-Light", size: fontSize)
            case .GillSansLightItalic: return UIFont(name: "GillSans-LightItalic", size: fontSize)
            case .GillSansSemiBold: return UIFont(name: "GillSans-SemiBold", size: fontSize)
            case .GillSansSemiBoldItalic: return UIFont(name: "GillSans-SemiBoldItalic", size: fontSize)
            case .GillSansBold: return UIFont(name: "GillSans-Bold", size: fontSize)
            case .GillSansBoldItalic: return UIFont(name: "GillSans-BoldItalic", size: fontSize)
            case .GillSansUltraBold: return UIFont(name: "GillSans-UltraBold", size: fontSize)
            case .GranthaSangamMNRegular: return UIFont(name: "GranthaSangamMN-Regular", size: fontSize)
            case .GranthaSangamMNBold: return UIFont(name: "GranthaSangamMN-Bold", size: fontSize)
            case .Helvetica: return UIFont(name: "Helvetica", size: fontSize)
            case .HelveticaOblique: return UIFont(name: "Helvetica-Oblique", size: fontSize)
            case .HelveticaLight: return UIFont(name: "Helvetica-Light", size: fontSize)
            case .HelveticaLightOblique: return UIFont(name: "Helvetica-LightOblique", size: fontSize)
            case .HelveticaBold: return UIFont(name: "Helvetica-Bold", size: fontSize)
            case .HelveticaBoldOblique: return UIFont(name: "Helvetica-BoldOblique", size: fontSize)
            case .HelveticaNeue: return UIFont(name: "HelveticaNeue", size: fontSize)
            case .HelveticaNeueItalic: return UIFont(name: "HelveticaNeue-Italic", size: fontSize)
            case .HelveticaNeueUltraLight: return UIFont(name: "HelveticaNeue-UltraLight", size: fontSize)
            case .HelveticaNeueUltraLightItalic: return UIFont(name: "HelveticaNeue-UltraLightItalic", size: fontSize)
            case .HelveticaNeueThin: return UIFont(name: "HelveticaNeue-Thin", size: fontSize)
            case .HelveticaNeueThinItalic: return UIFont(name: "HelveticaNeue-ThinItalic", size: fontSize)
            case .HelveticaNeueLight: return UIFont(name: "HelveticaNeue-Light", size: fontSize)
            case .HelveticaNeueLightItalic: return UIFont(name: "HelveticaNeue-LightItalic", size: fontSize)
            case .HelveticaNeueMedium: return UIFont(name: "HelveticaNeue-Medium", size: fontSize)
            case .HelveticaNeueMediumItalic: return UIFont(name: "HelveticaNeue-MediumItalic", size: fontSize)
            case .HelveticaNeueBold: return UIFont(name: "HelveticaNeue-Bold", size: fontSize)
            case .HelveticaNeueBoldItalic: return UIFont(name: "HelveticaNeue-BoldItalic", size: fontSize)
            case .HelveticaNeueCondensedBold: return UIFont(name: "HelveticaNeue-CondensedBold", size: fontSize)
            case .HelveticaNeueCondensedBlack: return UIFont(name: "HelveticaNeue-CondensedBlack", size: fontSize)
            case .HiraMaruProNW4: return UIFont(name: "HiraMaruProN-W4", size: fontSize)
            case .HiraMinProNW3: return UIFont(name: "HiraMinProN-W3", size: fontSize)
            case .HiraMinProNW6: return UIFont(name: "HiraMinProN-W6", size: fontSize)
            case .HiraginoSansW3: return UIFont(name: "HiraginoSans-W3", size: fontSize)
            case .HiraginoSansW6: return UIFont(name: "HiraginoSans-W6", size: fontSize)
            case .HiraginoSansW7: return UIFont(name: "HiraginoSans-W7", size: fontSize)
            case .HoeflerTextRegular: return UIFont(name: "HoeflerText-Regular", size: fontSize)
            case .HoeflerTextItalic: return UIFont(name: "HoeflerText-Italic", size: fontSize)
            case .HoeflerTextBlack: return UIFont(name: "HoeflerText-Black", size: fontSize)
            case .HoeflerTextBlackItalic: return UIFont(name: "HoeflerText-BlackItalic", size: fontSize)
            case .Impact: return UIFont(name: "Impact", size: fontSize)
            case .Kailasa: return UIFont(name: "Kailasa", size: fontSize)
            case .KailasaBold: return UIFont(name: "Kailasa-Bold", size: fontSize)
            case .KefaRegular: return UIFont(name: "Kefa-Regular", size: fontSize)
            case .KhmerSangamMN: return UIFont(name: "KhmerSangamMN", size: fontSize)
            case .KohinoorBanglaRegular: return UIFont(name: "KohinoorBangla-Regular", size: fontSize)
            case .KohinoorBanglaLight: return UIFont(name: "KohinoorBangla-Light", size: fontSize)
            case .KohinoorBanglaSemibold: return UIFont(name: "KohinoorBangla-Semibold", size: fontSize)
            case .KohinoorDevanagariRegular: return UIFont(name: "KohinoorDevanagari-Regular", size: fontSize)
            case .KohinoorDevanagariLight: return UIFont(name: "KohinoorDevanagari-Light", size: fontSize)
            case .KohinoorDevanagariSemibold: return UIFont(name: "KohinoorDevanagari-Semibold", size: fontSize)
            case .KohinoorGujaratiRegular: return UIFont(name: "KohinoorGujarati-Regular", size: fontSize)
            case .KohinoorGujaratiLight: return UIFont(name: "KohinoorGujarati-Light", size: fontSize)
            case .KohinoorGujaratiBold: return UIFont(name: "KohinoorGujarati-Bold", size: fontSize)
            case .KohinoorTeluguRegular: return UIFont(name: "KohinoorTelugu-Regular", size: fontSize)
            case .KohinoorTeluguLight: return UIFont(name: "KohinoorTelugu-Light", size: fontSize)
            case .KohinoorTeluguMedium: return UIFont(name: "KohinoorTelugu-Medium", size: fontSize)
            case .LaoSangamMN: return UIFont(name: "LaoSangamMN", size: fontSize)
            case .MalayalamSangamMN: return UIFont(name: "MalayalamSangamMN", size: fontSize)
            case .MalayalamSangamMNBold: return UIFont(name: "MalayalamSangamMN-Bold", size: fontSize)
            case .MarkerFeltThin: return UIFont(name: "MarkerFelt-Thin", size: fontSize)
            case .MarkerFeltWide: return UIFont(name: "MarkerFelt-Wide", size: fontSize)
            case .MenloRegular: return UIFont(name: "Menlo-Regular", size: fontSize)
            case .MenloItalic: return UIFont(name: "Menlo-Italic", size: fontSize)
            case .MenloBold: return UIFont(name: "Menlo-Bold", size: fontSize)
            case .MenloBoldItalic: return UIFont(name: "Menlo-BoldItalic", size: fontSize)
            case .DiwanMishafi: return UIFont(name: "DiwanMishafi", size: fontSize)
            case .MuktaMaheeRegular: return UIFont(name: "MuktaMahee-Regular", size: fontSize)
            case .MuktaMaheeLight: return UIFont(name: "MuktaMahee-Light", size: fontSize)
            case .MuktaMaheeBold: return UIFont(name: "MuktaMahee-Bold", size: fontSize)
            case .MyanmarSangamMN: return UIFont(name: "MyanmarSangamMN", size: fontSize)
            case .MyanmarSangamMNBold: return UIFont(name: "MyanmarSangamMN-Bold", size: fontSize)
            case .NoteworthyLight: return UIFont(name: "Noteworthy-Light", size: fontSize)
            case .NoteworthyBold: return UIFont(name: "Noteworthy-Bold", size: fontSize)
            case .NotoNastaliqUrdu: return UIFont(name: "NotoNastaliqUrdu", size: fontSize)
            case .NotoNastaliqUrduBold: return UIFont(name: "NotoNastaliqUrdu-Bold", size: fontSize)
            case .NotoSansKannadaRegular: return UIFont(name: "NotoSansKannada-Regular", size: fontSize)
            case .NotoSansKannadaLight: return UIFont(name: "NotoSansKannada-Light", size: fontSize)
            case .NotoSansKannadaBold: return UIFont(name: "NotoSansKannada-Bold", size: fontSize)
            case .NotoSansMyanmarRegular: return UIFont(name: "NotoSansMyanmar-Regular", size: fontSize)
            case .NotoSansMyanmarLight: return UIFont(name: "NotoSansMyanmar-Light", size: fontSize)
            case .NotoSansMyanmarBold: return UIFont(name: "NotoSansMyanmar-Bold", size: fontSize)
            case .NotoSansOriya: return UIFont(name: "NotoSansOriya", size: fontSize)
            case .NotoSansOriyaBold: return UIFont(name: "NotoSansOriya-Bold", size: fontSize)
            case .OptimaRegular: return UIFont(name: "Optima-Regular", size: fontSize)
            case .OptimaItalic: return UIFont(name: "Optima-Italic", size: fontSize)
            case .OptimaBold: return UIFont(name: "Optima-Bold", size: fontSize)
            case .OptimaBoldItalic: return UIFont(name: "Optima-BoldItalic", size: fontSize)
            case .OptimaExtraBlack: return UIFont(name: "Optima-ExtraBlack", size: fontSize)
            case .PalatinoRoman: return UIFont(name: "Palatino-Roman", size: fontSize)
            case .PalatinoItalic: return UIFont(name: "Palatino-Italic", size: fontSize)
            case .PalatinoBold: return UIFont(name: "Palatino-Bold", size: fontSize)
            case .PalatinoBoldItalic: return UIFont(name: "Palatino-BoldItalic", size: fontSize)
            case .Papyrus: return UIFont(name: "Papyrus", size: fontSize)
            case .PapyrusCondensed: return UIFont(name: "Papyrus-Condensed", size: fontSize)
            case .PartyLetPlain: return UIFont(name: "PartyLetPlain", size: fontSize)
            case .PingFangHKRegular: return UIFont(name: "PingFangHK-Regular", size: fontSize)
            case .PingFangHKUltralight: return UIFont(name: "PingFangHK-Ultralight", size: fontSize)
            case .PingFangHKThin: return UIFont(name: "PingFangHK-Thin", size: fontSize)
            case .PingFangHKLight: return UIFont(name: "PingFangHK-Light", size: fontSize)
            case .PingFangHKMedium: return UIFont(name: "PingFangHK-Medium", size: fontSize)
            case .PingFangHKSemibold: return UIFont(name: "PingFangHK-Semibold", size: fontSize)
            case .PingFangSCRegular: return UIFont(name: "PingFangSC-Regular", size: fontSize)
            case .PingFangSCUltralight: return UIFont(name: "PingFangSC-Ultralight", size: fontSize)
            case .PingFangSCThin: return UIFont(name: "PingFangSC-Thin", size: fontSize)
            case .PingFangSCLight: return UIFont(name: "PingFangSC-Light", size: fontSize)
            case .PingFangSCMedium: return UIFont(name: "PingFangSC-Medium", size: fontSize)
            case .PingFangSCSemibold: return UIFont(name: "PingFangSC-Semibold", size: fontSize)
            case .PingFangTCRegular: return UIFont(name: "PingFangTC-Regular", size: fontSize)
            case .PingFangTCUltralight: return UIFont(name: "PingFangTC-Ultralight", size: fontSize)
            case .PingFangTCThin: return UIFont(name: "PingFangTC-Thin", size: fontSize)
            case .PingFangTCLight: return UIFont(name: "PingFangTC-Light", size: fontSize)
            case .PingFangTCMedium: return UIFont(name: "PingFangTC-Medium", size: fontSize)
            case .PingFangTCSemibold: return UIFont(name: "PingFangTC-Semibold", size: fontSize)
            case .RockwellRegular: return UIFont(name: "Rockwell-Regular", size: fontSize)
            case .RockwellItalic: return UIFont(name: "Rockwell-Italic", size: fontSize)
            case .RockwellBold: return UIFont(name: "Rockwell-Bold", size: fontSize)
            case .RockwellBoldItalic: return UIFont(name: "Rockwell-BoldItalic", size: fontSize)
            case .SavoyeLetPlain: return UIFont(name: "SavoyeLetPlain", size: fontSize)
            case .SinhalaSangamMN: return UIFont(name: "SinhalaSangamMN", size: fontSize)
            case .SinhalaSangamMNBold: return UIFont(name: "SinhalaSangamMN-Bold", size: fontSize)
            case .SnellRoundhand: return UIFont(name: "SnellRoundhand", size: fontSize)
            case .SnellRoundhandBold: return UIFont(name: "SnellRoundhand-Bold", size: fontSize)
            case .SnellRoundhandBlack: return UIFont(name: "SnellRoundhand-Black", size: fontSize)
            case .STIXTwoMathRegular: return UIFont(name: "STIXTwoMath-Regular", size: fontSize)
            case .STIXTwoText: return UIFont(name: "STIXTwoText", size: fontSize)
            case .STIXTwoTextItalic: return UIFont(name: "STIXTwoText-Italic", size: fontSize)
            case .STIXTwoText_Medium: return UIFont(name: "STIXTwoText_Medium", size: fontSize)
            case .STIXTwoTextItalic_MediumItalic: return UIFont(name: "STIXTwoText-Italic_Medium-Italic", size: fontSize)
            case .STIXTwoText_SemiBold: return UIFont(name: "STIXTwoText_SemiBold", size: fontSize)
            case .STIXTwoTextItalic_SemiBoldItalic: return UIFont(name: "STIXTwoText-Italic_SemiBold-Italic", size: fontSize)
            case .STIXTwoText_Bold: return UIFont(name: "STIXTwoText_Bold", size: fontSize)
            case .STIXTwoTextItalic_BoldItalic: return UIFont(name: "STIXTwoText-Italic_Bold-Italic", size: fontSize)
            case .Symbol: return UIFont(name: "Symbol", size: fontSize)
            case .TamilSangamMN: return UIFont(name: "TamilSangamMN", size: fontSize)
            case .TamilSangamMNBold: return UIFont(name: "TamilSangamMN-Bold", size: fontSize)
            case .Thonburi: return UIFont(name: "Thonburi", size: fontSize)
            case .ThonburiLight: return UIFont(name: "Thonburi-Light", size: fontSize)
            case .ThonburiBold: return UIFont(name: "Thonburi-Bold", size: fontSize)
            case .TimesNewRomanPSMT: return UIFont(name: "TimesNewRomanPSMT", size: fontSize)
            case .TimesNewRomanPSItalicMT: return UIFont(name: "TimesNewRomanPS-ItalicMT", size: fontSize)
            case .TimesNewRomanPSBoldMT: return UIFont(name: "TimesNewRomanPS-BoldMT", size: fontSize)
            case .TimesNewRomanPSBoldItalicMT: return UIFont(name: "TimesNewRomanPS-BoldItalicMT", size: fontSize)
            case .TrebuchetMS: return UIFont(name: "TrebuchetMS", size: fontSize)
            case .TrebuchetMSItalic: return UIFont(name: "TrebuchetMS-Italic", size: fontSize)
            case .TrebuchetMSBold: return UIFont(name: "TrebuchetMS-Bold", size: fontSize)
            case .TrebuchetBoldItalic: return UIFont(name: "Trebuchet-BoldItalic", size: fontSize)
            case .Verdana: return UIFont(name: "Verdana", size: fontSize)
            case .VerdanaItalic: return UIFont(name: "Verdana-Italic", size: fontSize)
            case .VerdanaBold: return UIFont(name: "Verdana-Bold", size: fontSize)
            case .VerdanaBoldItalic: return UIFont(name: "Verdana-BoldItalic", size: fontSize)
            case .ZapfDingbatsITC: return UIFont(name: "ZapfDingbatsITC", size: fontSize)
            case .Zapfino: return UIFont(name: "Zapfino", size: fontSize)
        }
    }
    // Can get a list all avaible fonts
    func getListOfAllAvailbleFonts() {
        //https://gist.github.com/jbergen/f57fe6f958901900e711
        for family in UIFont.familyNames {
            let sName: String = family as String
            for name in UIFont.fontNames(forFamilyName: sName) {
                let aString = name as String
                let newString = aString.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
//                print("case .\(newString): return UIFont(name: \"\(name as String)\", size: fontSize)")
            }
        }
    }
}

enum fontOptions {
    case AcademyEngravedLetPlain
    case AlNile
    case AlNileBold
    case AmericanTypewriter
    case AmericanTypewriterLight
    case AmericanTypewriterSemibold
    case AmericanTypewriterBold
    case AmericanTypewriterCondensed
    case AmericanTypewriterCondensedLight
    case AmericanTypewriterCondensedBold
    case AppleColorEmoji
    case AppleSDGothicNeoRegular
    case AppleSDGothicNeoThin
    case AppleSDGothicNeoUltraLight
    case AppleSDGothicNeoLight
    case AppleSDGothicNeoMedium
    case AppleSDGothicNeoSemiBold
    case AppleSDGothicNeoBold
    case AppleSymbols
    case ArialMT
    case ArialItalicMT
    case ArialBoldMT
    case ArialBoldItalicMT
    case ArialHebrew
    case ArialHebrewLight
    case ArialHebrewBold
    case ArialRoundedMTBold
    case AvenirBook
    case AvenirRoman
    case AvenirBookOblique
    case AvenirOblique
    case AvenirLight
    case AvenirLightOblique
    case AvenirMedium
    case AvenirMediumOblique
    case AvenirHeavy
    case AvenirHeavyOblique
    case AvenirBlack
    case AvenirBlackOblique
    case AvenirNextRegular
    case AvenirNextItalic
    case AvenirNextUltraLight
    case AvenirNextUltraLightItalic
    case AvenirNextMedium
    case AvenirNextMediumItalic
    case AvenirNextDemiBold
    case AvenirNextDemiBoldItalic
    case AvenirNextBold
    case AvenirNextBoldItalic
    case AvenirNextHeavy
    case AvenirNextHeavyItalic
    case AvenirNextCondensedRegular
    case AvenirNextCondensedItalic
    case AvenirNextCondensedUltraLight
    case AvenirNextCondensedUltraLightItalic
    case AvenirNextCondensedMedium
    case AvenirNextCondensedMediumItalic
    case AvenirNextCondensedDemiBold
    case AvenirNextCondensedDemiBoldItalic
    case AvenirNextCondensedBold
    case AvenirNextCondensedBoldItalic
    case AvenirNextCondensedHeavy
    case AvenirNextCondensedHeavyItalic
    case Baskerville
    case BaskervilleItalic
    case BaskervilleSemiBold
    case BaskervilleSemiBoldItalic
    case BaskervilleBold
    case BaskervilleBoldItalic
    case BodoniSvtyTwoITCTTBook
    case BodoniSvtyTwoITCTTBookIta
    case BodoniSvtyTwoITCTTBold
    case BodoniSvtyTwoOSITCTTBook
    case BodoniSvtyTwoOSITCTTBookIt
    case BodoniSvtyTwoOSITCTTBold
    case BodoniSvtyTwoSCITCTTBook
    case BodoniOrnamentsITCTT
    case BradleyHandITCTTBold
    case ChalkboardSERegular
    case ChalkboardSELight
    case ChalkboardSEBold
    case Chalkduster
    case CharterRoman
    case CharterItalic
    case CharterBold
    case CharterBoldItalic
    case CharterBlack
    case CharterBlackItalic
    case Cochin
    case CochinItalic
    case CochinBold
    case CochinBoldItalic
    case Copperplate
    case CopperplateLight
    case CopperplateBold
    case CourierNewPSMT
    case CourierNewPSItalicMT
    case CourierNewPSBoldMT
    case CourierNewPSBoldItalicMT
    case Damascus
    case DamascusLight
    case DamascusMedium
    case DamascusSemiBold
    case DamascusBold
    case DevanagariSangamMN
    case DevanagariSangamMNBold
    case Didot
    case DidotItalic
    case DidotBold
    case DINAlternateBold
    case DINCondensedBold
    case EuphemiaUCAS
    case EuphemiaUCASItalic
    case EuphemiaUCASBold
    case Farah
    case FuturaMedium
    case FuturaMediumItalic
    case FuturaBold
    case FuturaCondensedMedium
    case FuturaCondensedExtraBold
    case Galvji
    case GalvjiBold
    case GeezaPro
    case GeezaProBold
    case Georgia
    case GeorgiaItalic
    case GeorgiaBold
    case GeorgiaBoldItalic
    case GillSans
    case GillSansItalic
    case GillSansLight
    case GillSansLightItalic
    case GillSansSemiBold
    case GillSansSemiBoldItalic
    case GillSansBold
    case GillSansBoldItalic
    case GillSansUltraBold
    case GranthaSangamMNRegular
    case GranthaSangamMNBold
    case Helvetica
    case HelveticaOblique
    case HelveticaLight
    case HelveticaLightOblique
    case HelveticaBold
    case HelveticaBoldOblique
    case HelveticaNeue
    case HelveticaNeueItalic
    case HelveticaNeueUltraLight
    case HelveticaNeueUltraLightItalic
    case HelveticaNeueThin
    case HelveticaNeueThinItalic
    case HelveticaNeueLight
    case HelveticaNeueLightItalic
    case HelveticaNeueMedium
    case HelveticaNeueMediumItalic
    case HelveticaNeueBold
    case HelveticaNeueBoldItalic
    case HelveticaNeueCondensedBold
    case HelveticaNeueCondensedBlack
    case HiraMaruProNW4
    case HiraMinProNW3
    case HiraMinProNW6
    case HiraginoSansW3
    case HiraginoSansW6
    case HiraginoSansW7
    case HoeflerTextRegular
    case HoeflerTextItalic
    case HoeflerTextBlack
    case HoeflerTextBlackItalic
    case Impact
    case Kailasa
    case KailasaBold
    case KefaRegular
    case KhmerSangamMN
    case KohinoorBanglaRegular
    case KohinoorBanglaLight
    case KohinoorBanglaSemibold
    case KohinoorDevanagariRegular
    case KohinoorDevanagariLight
    case KohinoorDevanagariSemibold
    case KohinoorGujaratiRegular
    case KohinoorGujaratiLight
    case KohinoorGujaratiBold
    case KohinoorTeluguRegular
    case KohinoorTeluguLight
    case KohinoorTeluguMedium
    case LaoSangamMN
    case MalayalamSangamMN
    case MalayalamSangamMNBold
    case MarkerFeltThin
    case MarkerFeltWide
    case MenloRegular
    case MenloItalic
    case MenloBold
    case MenloBoldItalic
    case DiwanMishafi
    case MuktaMaheeRegular
    case MuktaMaheeLight
    case MuktaMaheeBold
    case MyanmarSangamMN
    case MyanmarSangamMNBold
    case NoteworthyLight
    case NoteworthyBold
    case NotoNastaliqUrdu
    case NotoNastaliqUrduBold
    case NotoSansKannadaRegular
    case NotoSansKannadaLight
    case NotoSansKannadaBold
    case NotoSansMyanmarRegular
    case NotoSansMyanmarLight
    case NotoSansMyanmarBold
    case NotoSansOriya
    case NotoSansOriyaBold
    case OptimaRegular
    case OptimaItalic
    case OptimaBold
    case OptimaBoldItalic
    case OptimaExtraBlack
    case PalatinoRoman
    case PalatinoItalic
    case PalatinoBold
    case PalatinoBoldItalic
    case Papyrus
    case PapyrusCondensed
    case PartyLetPlain
    case PingFangHKRegular
    case PingFangHKUltralight
    case PingFangHKThin
    case PingFangHKLight
    case PingFangHKMedium
    case PingFangHKSemibold
    case PingFangSCRegular
    case PingFangSCUltralight
    case PingFangSCThin
    case PingFangSCLight
    case PingFangSCMedium
    case PingFangSCSemibold
    case PingFangTCRegular
    case PingFangTCUltralight
    case PingFangTCThin
    case PingFangTCLight
    case PingFangTCMedium
    case PingFangTCSemibold
    case RockwellRegular
    case RockwellItalic
    case RockwellBold
    case RockwellBoldItalic
    case SavoyeLetPlain
    case SinhalaSangamMN
    case SinhalaSangamMNBold
    case SnellRoundhand
    case SnellRoundhandBold
    case SnellRoundhandBlack
    case STIXTwoMathRegular
    case STIXTwoText
    case STIXTwoTextItalic
    case STIXTwoText_Medium
    case STIXTwoTextItalic_MediumItalic
    case STIXTwoText_SemiBold
    case STIXTwoTextItalic_SemiBoldItalic
    case STIXTwoText_Bold
    case STIXTwoTextItalic_BoldItalic
    case Symbol
    case TamilSangamMN
    case TamilSangamMNBold
    case Thonburi
    case ThonburiLight
    case ThonburiBold
    case TimesNewRomanPSMT
    case TimesNewRomanPSItalicMT
    case TimesNewRomanPSBoldMT
    case TimesNewRomanPSBoldItalicMT
    case TrebuchetMS
    case TrebuchetMSItalic
    case TrebuchetMSBold
    case TrebuchetBoldItalic
    case Verdana
    case VerdanaItalic
    case VerdanaBold
    case VerdanaBoldItalic
    case ZapfDingbatsITC
    case Zapfino
}
