Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83411620B3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiKHIdl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 03:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiKHIdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 03:33:37 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 00:33:34 PST
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C166427;
        Tue,  8 Nov 2022 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667896416; x=1699432416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kpQ2isNLFrPwbux1zgXyfjWW9Hr6afrLCiZjlgDaSAQ=;
  b=qXaE/WAkDXfuTMW1WIZiiK3to8IwNYxMI+1OttxIOmuzfccqVARvnLKI
   6eg5uWJg8G1mTK1cTkZszEcSJYk1iYU/a7mAOC3aeqR6lTab/Kq19SyFi
   sBCsKI1GRBysinlsWKW3g84NdVnslPU1eRDKeyW8oiTRSDKKAV7YfP0K/
   +M3P5ZGRjKY5XStozgsVIP6vCq+H0lImbPM1Ga/QdIC0vgrUobm4C2pNX
   q1LJ9+ngkPe40M2DdQ5I8O68FpIxrw/JygkQTG+8bHwbBzRPX2IKJtWOz
   iP1HEcyQlR+D3tHXQKPF4vqYDjiH+LL+g45EAtQtGkLt6nvC6tUVkrqbv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="77264304"
X-IronPort-AV: E=Sophos;i="5.96,147,1665414000"; 
   d="scan'208";a="77264304"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:32:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKsiY+Z9jC+x5T8D5AkKGafTXTpLx7l9QaM19InxAcBTRTBqt50RkvAabI8aDuAaPulQ7kmn92MFRm7F2owwPfhn/oanM85/G1jcqSXeTcgwuM9cUF1G7Qfqni3gupvZ5hdb48OwqjaDlaV+WgwDrlSuV5TQCuFvn9s6EEZYtJbrflvsrkYU5s+ezKBxEJ4bXk+iA9Cyf/uaySqIvbzUTdN3j9EJzwRZDydYA6wRPtSSVmP59iYQ67sg/2xsKOw/+HlOneaO6FPpNvTir7RpEoGSYnkxzvu3BASFDaR7xjKEUbCtOkUS6DvPzMweFeIycfSng/5ZlHg8RZ0Pz+yzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpQ2isNLFrPwbux1zgXyfjWW9Hr6afrLCiZjlgDaSAQ=;
 b=cgsC0PTHBORbnEgaZj6ULfNssrN8MaOLmIUVe7SCi0j8DT2pUmJF/g5FEdc6YUqXb5BWB0oIqFSBpxqzqNf8Hx1cPqtpHa4rds3pI6I6ZL/ZKhH8orSKsTxR1kGdWXQ0PbG3pExW+eiDftuoRkAWBQw05IcOUFc69NtPQysXUFiVa7lpLwNTj7WEWU/NKyF4UVlqhQ3zcG0eDnWbqt5DnLBLtVgc6l0mbpmxsnjU2rWNM3H36M3o09KOClg6GhI8iI2yDggiO/B9V6ZmvfRT1mIcqLyTGFuRvti+oiXokmcMxPHjXqPPTscpp2TJ+NGzaxZDthU6sMSieWK8iNsHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB5950.jpnprd01.prod.outlook.com (2603:1096:400:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 08:32:24 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 08:32:24 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Thread-Topic: [PATCH v3 5/5] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Thread-Index: AQHY7dcmajbwNPvdXU24kSDwG4ldzq40LLkAgACPIMA=
Date:   Tue, 8 Nov 2022 08:32:24 +0000
Message-ID: <TYAPR01MB6330156C8B4F7A35290F44788B3F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
 <afa849bf-e89b-0c48-6bf2-f7ca58940567@intel.com>
In-Reply-To: <afa849bf-e89b-0c48-6bf2-f7ca58940567@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTEtMDhUMDg6MjY6?=
 =?utf-8?B?MTRaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0zNjk3MTBjMS1jNTVmLTQyZGIt?=
 =?utf-8?B?YmJlMC04MzYxNGJiNTI3Mjg7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 461763dbaa9247a2b565e9f39c106e39
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB5950:EE_
x-ms-office365-filtering-correlation-id: 60ede8ba-019e-41f8-a063-08dac163c2f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iq0Vsjtuf+DSOobFcK5pRJeK/ZSNtFrGy+xvO9Gn8Oeb79SHsofpSi6JJc0P1rEn0/lYdE5tCzBjHGx7mFC3gSX0zdAYkosrL4yBkNl029T0eIcwmFbQWYl4UMeYddvW7ulWhVQX62Z36tlCQZpy4sSong4yPMiED4K27W/J4yL61U6lVuUtra36MtDr/456H6kJLg4RjyaCM6hQEP0vVV0yvMfGZfCI6fFp0Bf09n6z0b+03PI+R9bCaONCzEyJ4vggM+glqG/O7MpBYd0AT+FfGNfX4zwAnZOMtODAO+UmS2B/tBYQotnGkEqrL/glmY6V2Dcj78FutR28MEoI2Gowte3cNjRpN48lVnLbhxAcjO4YtTtDC9FqyfhgX0un86A0cd1Wodh1kmMntMBUOm9IzDB6lCas9GYRZ+E/L0o4AV5Xmo5vdwoTTcRHnhjeZirs2KwfXgnj9ETsqoQHC5V/ZUDg1vrOpfK25JX+4TtV38ZIbGdYT2rixYUKTZG2E8gx436eEaSscp1yvyhOocSB5ime9SNz4l/bhbEPlUjTqjreOM9Xdx8GlxR8GwwJ5p5YzG2Lii4vnmt7aZhoyzdRCgr/KH8/vNUnYFCMayr4sCv2Jdv/34aNPbAaDa2J5rrWBijlTRGb0QEpiAj2MF3RRvOl7W6CapeP1Y208W+dCogFdyPJhfEGvC0HzaNR4XzjtIRHIJX8dR0UJS9FWV2A9kAMBxnhG/pURncqRgJPGgIIm/+JV8BKNRZDsPHaDAJPIBvRX4T+/cB9vy/0hle9gPU5r+f8KjtVu/idbBI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(1590799012)(66446008)(52536014)(5660300002)(2906002)(71200400001)(8936002)(41300700001)(82960400001)(66556008)(1580799009)(66476007)(76116006)(4326008)(66946007)(8676002)(64756008)(110136005)(316002)(38100700002)(86362001)(6506007)(7696005)(26005)(9686003)(85182001)(53546011)(54906003)(122000001)(38070700005)(83380400001)(478600001)(55016003)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2xSNEdjOThLWWZZRmZ4WlZrUVorK0RuY1lHTmIxam91QS9tWE1uMlkzd3VN?=
 =?utf-8?B?a2tUaXhvUG9VcUtFS0ExeTdNMlRnbjJ5ZTUrZm9ic01DMVQwNS9sRE8zbCtL?=
 =?utf-8?B?blpWQWsrNE5Vc2F5SkN6blcrb2dZbWZRSjk5dFZ5WmRtc0FSOWkxR0V5T3pV?=
 =?utf-8?B?VW90TW9XMkxlMlBWTWx5MkFveVpLS2xLYy9UcExtZ0hEVXB1S3NDQXdySEZQ?=
 =?utf-8?B?MUFUaVJ5QkFEKzZwaDV5YUNuVXlPMVl4RjhQSitYQWtzZlhsUGVwdk95RDhi?=
 =?utf-8?B?Mmtnd09PR01rQllwY1J0U0o3WWEzM3Q1Q1BIdWdBejBzUW5rOFZxV1FiSnlF?=
 =?utf-8?B?dWpwemJIZEpocS9LTmVlUFlYejgvVWp3cmRwbUo2bXRJc090c2w1WENyY245?=
 =?utf-8?B?cmhBamdGTm9lMUphL0dHWTNTMXE3M3FaZnMyQTM5VGdUWGVwSXpqOWxCMGx5?=
 =?utf-8?B?MTJ3ZUNzci9Sd2RkSHhwN2NydXp5ZlZmZ01vL0pOZmlmUEhFcDJ1NWpMVGVQ?=
 =?utf-8?B?eEM0RHZHUDY1YjVCSS96QmtkbGVJNUVlQndvNElsMjhkNGlFWTQydjVZZDNj?=
 =?utf-8?B?VlFCVlo4a2hqTUQ5anhFWlFiUktsQ3gzSHF0dC84RWo3S09BYU1lbjk4WUg0?=
 =?utf-8?B?dVJtaU9YbHpsd3ZQNlNiZ1N1dEowazFlcEk1aDBjdEF5cDYwNnFhRXR6MFpw?=
 =?utf-8?B?by8zNjFNT014M05wZmdpcjFPLzVQN3ZZNms2c3BONXhTaEZoeUcyekw3OFFv?=
 =?utf-8?B?OGs2MXoxc2RTU0JDYVpielRsNlE1UU9GdWpjMzdaUVJtYlJDM21KdUVjdmN1?=
 =?utf-8?B?NlN0cjhWeWhybnJWUFd0TVFhQm0vN2VxaEY2dWRaM2s2dHlJbW9XaElJa1ph?=
 =?utf-8?B?NmxsWmRrVkZ0LzI4RGpVNHBRYTY2amZnSHZuMVJCUm9MeE56TzdCSnpEdW1I?=
 =?utf-8?B?NXluMUpDMFhYMWdEOWFBNEZSMDZNSC9hNzUwZHN4SUFpNkxDTFFKc1RERk9L?=
 =?utf-8?B?VG85MGZTamNJMnR1QWVaSHdFZHA3L2ZKYjZ3UXFMTjJlMVcvL2pqZS9ZV291?=
 =?utf-8?B?VUVDcWlBeTJQMWdGL2I5Y1hnU21PaHAzaWxqc2crM3BPVElUSjNpOXlvRklE?=
 =?utf-8?B?TGVhVEIwZFRQUzBLWWVQOW10WDI1akxUUmlxbXA0aHpsZ25vK1FpYVJFMzAw?=
 =?utf-8?B?Y3JlZCtnWFVPa05udU1ZcXN3eGQ4OHBTdzg5UUNYY08wRjgzYitSa1hEaXRa?=
 =?utf-8?B?cWxIb1JUOFU0bTBOWUJCdnhOVXd5TGtIa1NNVWU5R2ozSTU5Nkd5M3N5YUc5?=
 =?utf-8?B?OGxFL2dTRjJaVHV3NFQwS3VibC9ZRUhYaG5yeWtLWU5lY1NiVjBPVTBhQVhh?=
 =?utf-8?B?cXdRUy9id2haaC9aY1F4QVhwNU5mZHgwQ08rcGp2R1l1OGpFcWRxSXJyc3Fj?=
 =?utf-8?B?ZGphM0htOXZoSzEyQ2ZhbXNqaTFxM2FFRm5SZUhmR3JUamxManFsV0dpa0FB?=
 =?utf-8?B?azEwWWZ1Q1lIRW9Sa1VDM1AwcFB4R0RZek9RYUZyY3NYbS9nck5FblZITWsx?=
 =?utf-8?B?SGF1MTdNS3pGaFRHOXh4NkhrSXBJZDVxRXU1TFc0c0R6blpSQnBZa3FJQjN4?=
 =?utf-8?B?TDdJNG8zOTRZZ3BwUm0vSzluZ1U0a3c1bU9uWkNlQnJJS1lKSXJ4bHZTcUtV?=
 =?utf-8?B?ZlRKNUhoSUtuMVNKNTdCMEJDbmtYZ001MVNFeE5RK3NqWTlZNjJEeDVBclRi?=
 =?utf-8?B?M0lDMG5BYVBHbFg0dFY0OEtpdUhlVUo2V243UDZSbFVjTURFU0JWdWZHRFlZ?=
 =?utf-8?B?b2h4WmR4d2RPZndrTlZ2YnVvMExMVnpYV2dHbHdPWThUYk9EVU5XaFQ1WE5h?=
 =?utf-8?B?OHZuK0pFOXF1KzlTUU1RQWczWUNudEFPWnUrSVFPMHQ1d0VrZHNNcExIVlVv?=
 =?utf-8?B?Z0tUaHhnRDcramVLQTNSL0RRdHR6Zlh4cGQ4TE9WeFlkQjlEZDlrL0NObm9s?=
 =?utf-8?B?dkpiWTNUZ0ZrWTVYVk5Hd3VkNzV1Y0JpNTI5c2VsRkRXbG54dERScVpyNDhp?=
 =?utf-8?B?RkovMTJOTkExV05rSTcvSEFqTjFzVkUyQ3JzRkJ5dWxKYUFvYWVpZEtjMjdF?=
 =?utf-8?B?U29UeVg0T3Y2YzdjMTVzUVMwcTY3SXN2MXpwTHRLdDBGc0xPbU5aaHV0Ny9J?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ede8ba-019e-41f8-a063-08dac163c2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 08:32:24.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ldtluauhltDa8HS9EbVj5Vkl7cg6xYZ8wj56dm1aXNoJxEAFfxoGuK9zinrVQiqc25UE7HJMl+4V8xw4eIExgEELtfbdpuLckE2eDCzqZ1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5950
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgU2h1YWggYW5kIFJlaW5ldHRlLA0KDQo+IE9uIDExLzEvMjAyMiAyOjQzIEFNLCBTaGFvcGVu
ZyBUYW4gd3JvdGU6DQo+ID4gQmVmb3JlIGV4aXRpbmcgZWFjaCB0ZXN0IGZ1bmN0aW9uKHJ1bl9j
bXQvY2F0L21ibS9tYmFfdGVzdCgpKSwNCj4gPiB0ZXN0IHJlc3VsdHMoIm9rIiwibm90IG9rIikg
YXJlIHByaW50ZWQgYnkga3NmdF90ZXN0X3Jlc3VsdCgpIGFuZCB0aGVuDQo+ID4gdGVtcG9yYXJ5
IHJlc3VsdCBmaWxlcyBhcmUgY2xlYW5lZCBieSBmdW5jdGlvbg0KPiA+IGNtdC9jYXQvbWJtL21i
YV90ZXN0X2NsZWFudXAoKS4NCj4gPiBIb3dldmVyLCBiZWZvcmUgcnVubmluZyBrc2Z0X3Rlc3Rf
cmVzdWx0KCksIGZ1bmN0aW9uDQo+ID4gY210L2NhdC9tYm0vbWJhX3Rlc3RfY2xlYW51cCgpIGhh
cyBiZWVuIHJ1biBpbiBlYWNoIHRlc3QgZnVuY3Rpb24gYXMNCj4gPiBmb2xsb3dzOg0KPiA+ICAg
IGNtdF9yZXNjdHJsX3ZhbCgpDQo+ID4gICAgY2F0X3BlcmZfbWlzc192YWwoKQ0KPiA+ICAgIG1i
YV9zY2hlbWF0YV9jaGFuZ2UoKQ0KPiA+ICAgIG1ibV9id19jaGFuZ2UoKQ0KPiA+DQo+ID4gUmVt
b3ZlIGR1cGxpY2F0ZSBjb2RlcyB0aGF0IGNsZWFyIGVhY2ggdGVzdCByZXN1bHQgZmlsZS4NCj4g
DQo+IFRoaXMgaXNuJ3QgbWFraW5nIG11Y2ggc2Vuc2UgdG8gbWUuIFBsZWFzZSBpbmNsdWRlIHRl
c3QgcmVwb3J0IGJlZm9yZSBhbmQgYWZ0ZXINCj4gdGhpcyBjaGFuZ2UgaW4gdGhlIGNoYW5nZSBs
b2cuDQoNCldpdGggb3Igd2l0aG91dCB0aGlzIHBhdGNoLCB0aGVyZSBpcyBubyBlZmZlY3Qgb24g
dGhlIHJlc3VsdCBtZXNzYWdlLg0KVGhlc2UgZnVuY3Rpb25zIHdlcmUgZXhlY3V0ZWQgdHdpY2Us
IGluIGJyaWVmLCBpdCBydW5zIGFzIGZvbGxvd3M6DQogLSBjbXQvY2F0L21ibS9tYmFfdGVzdF9j
bGVhbnVwKCkNCiAtIGtzZnRfdGVzdF9yZXN1bHQoKQ0KIC0gY210L2NhdC9tYm0vbWJhX3Rlc3Rf
Y2xlYW51cCgpDQpTbywgSSBkZWxldGVkIG9uY2UuIA0KDQo+IEZyb20gd2hhdCBJIGNhbiB0ZWxs
IHRoaXMgc3RpbGwgc2VlbSB0byBzdWZmZXIgZnJvbSB0aGUgcHJvYmxlbSB3aGVyZSB0aGUgdGVz
dA0KPiBmaWxlcyBtYXkgbm90IGJlIGNsZWFuZWQuIFdpdGggdGhlIHJlbW92YWwgb2YgbWJtX3Rl
c3RfY2xlYW51cCgpIHRoZSBjbGVhbnVwDQo+IGlzIG5vdyBleHBlY3RlZCB0byBiZSBkb25lIGlu
IG1ibV9id19jaGFuZ2UoKS4NCj4gDQo+IE5vdGUgdGhhdDoNCj4gDQo+IG1ibV9id19jaGFuZ2Uo
KQ0KPiB7DQo+IAkuLi4NCj4gDQo+IAlyZXQgPSByZXNjdHJsX3ZhbChiZW5jaG1hcmtfY21kLCAm
cGFyYW0pOw0KPiAJaWYgKHJldCkNCj4gCQlyZXR1cm4gcmV0Ow0KPiANCj4gCS8qIFRlc3QgcmVz
dWx0cyBzdG9yZWQgaW4gZmlsZSAqLw0KPiANCj4gCXJldCA9IGNoZWNrX3Jlc3VsdHMoc3Bhbik7
DQo+IAlpZiAocmV0KQ0KPiAJCXJldHVybiByZXQ7IDw9PSBSZXR1cm4gd2l0aG91dCBjbGVhbmlu
ZyB0ZXN0IHJlc3VsdCBmaWxlDQo+IA0KPiAJbWJtX3Rlc3RfY2xlYW51cCgpOyA8PT0gVGVzdCBy
ZXN1bHQgZmlsZSBjbGVhbmVkIG9ubHkgd2hlbiB0ZXN0DQo+IHBhc3NlZC4NCj4gDQo+IAlyZXR1
cm4gMDsNCj4gfQ0KDQpJIGludGVuZCB0byBhdm9pZCB0aGlzIHByb2JsZW0gdGhyb3VnaCB0aGUg
Zm9sbG93aW5nIGNvZGVzLg0KDQptYm1fYndfY2hhbmdlKCkNCnsNCiAgICAgICAgcmV0ID0gcmVz
Y3RybF92YWwoYmVuY2htYXJrX2NtZCwgJnBhcmFtKTsNCiAgICAgICAgaWYgKHJldCkNCi0gICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KDQogICAg
ICAgIHJldCA9IGNoZWNrX3Jlc3VsdHMoc3Bhbik7DQogICAgICAgIGlmIChyZXQpDQotICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCisgICAgICAgICAgICAgICBnb3RvIG91dDsNCg0KK291dDoN
CiAgICAgICAgbWJtX3Rlc3RfY2xlYW51cCgpOw0KDQotICAgICAgIHJldHVybiAwOw0KKyAgICAg
ICByZXR1cm4gcmV0Ow0KfQ0KDQoNCkJlc3QgcmVnYXJkcywNClNoYW9wZW5nIFRhbg0K
