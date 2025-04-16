# 한국투자증권 api
> 파이썬으로 개발자페이지의 문서를 스크래핑해서 자동으로 만든 코드에 최소한의 수작업만을 더했기 때문에 오류가 있을 수 있습니다

> 이슈리포트 주셔도 되고 직접 수정하셔서 풀리퀘스트 주셔도 확인 후 반영하도록 하겠습니다

> FullyRestful 패키지를 기반으로 몇몇 귀찮은 포인트의 자동화가 반영되어 있습니다(해시값 받아오기 등)

> [한국투자증권 api](https://apiportal.koreainvestment.com/apiservice/oauth2#L_5c87ba63-740a-4166-93ac-803510bb9c02) 페이지와 최대한 구조도 맞추고 경로도 한글로 동일하게 설정했습니다

> 저도 곧 자동거래 개발을 할 예정이어서 직접 확인은 하겠지만 제가 쓰는 api 가 매우 적을 예정이라 모든 api 들을 확인하지 못할것 같습니다
## 초기화
```swift
_ = try KISManager.init(targetServer: .실전서버, initInfo: .init(account_id: env.accountNo, appkey: env.appKey, appsecret: env.appSecret))
```

## 계좌 조회
```swift
let result = try await KISAPI.국내주식_주문_계좌.inquirebalance().request(param: .init(AFHR_FLPR_YN: "N", OFL_YN: "", INQR_DVSN: "02", UNPR_DVSN: "01", FUND_STTL_ICLD_YN: "N", FNCG_AMT_AUTO_RDPT_YN: "N", PRCS_DVSN: "00", CTX_AREA_FK100: "", CTX_AREA_NK100: ""))
print(result?.model)
```
---

## 📄 License

MIT License
