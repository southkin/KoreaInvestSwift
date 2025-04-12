import Testing
import XCTest
@testable import KoreaInvestSwift

final class KoreaInvestSwiftTests : XCTestCase {
    func test() async throws {
        do {
            struct TestEnv {
                let accountNo: String = ""
                let appKey: String = ""
                let appSecret: String = ""
            }
            let env = TestEnv()
            _ = try KISManager.init(targetServer: .실전서버, initInfo: .init(account_id: env.accountNo, appkey: env.appKey, appsecret: env.appSecret))
            let result = try await KISAPI.국내주식_주문_계좌.inquirebalance().request(param: .init(AFHR_FLPR_YN: "N", OFL_YN: "", INQR_DVSN: "02", UNPR_DVSN: "01", FUND_STTL_ICLD_YN: "N", FNCG_AMT_AUTO_RDPT_YN: "N", PRCS_DVSN: "00", CTX_AREA_FK100: "", CTX_AREA_NK100: ""))
            
            print(result?.model)
        }
        catch {
            XCTFail("POST API 호출 실패: \(error.localizedDescription)")
        }
    }
}
