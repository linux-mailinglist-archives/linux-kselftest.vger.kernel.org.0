Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D323678E26
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 03:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjAXCTp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 21:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjAXCTo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 21:19:44 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 18:19:42 PST
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6DB135
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jan 2023 18:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1674526783; x=1706062783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yRTquAvK3moszlQJl7jrHKq66iBh/H5kUYz7Fodr4PE=;
  b=nLLIjjR3/hPq3KIqzxN2bt52PoZl0ilM4phRaPm2oZS3OWDT40GrHiFB
   KW6TSdBkAiKSdnYmlSZVcaP01Sh8NnUCnSB4KcbDMVg8y6c2JxIN/9K5c
   WhAzB1921hnmarNHwo/ZOWxWWxXsxwyEqhFePmNr9ldNqo089GqBQyRG6
   AeEahW6kugwJ8T4D2cZG7k2FGWpL7HzBQ1M9Y0Bo7XhrGlPne0vBIG0wh
   T1j7tet71D01Y2qJwW/lVuVkkJ79LWjN2kJrcYns4SeQTzns7xvrMOF4D
   Wv9aD8/LYenLNAZY1E/8XkLspHM9qdNdmuaGqrsZcxXITnC/r7ymsF+A2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="75095747"
X-IronPort-AV: E=Sophos;i="5.97,241,1669042800"; 
   d="scan'208";a="75095747"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 11:16:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrPfPJtWU5ACHn2o1atfMD1wvTBUqI5cdx1u8syZKxvC24mO0rp+XNS8gZZLt7q74oVv/PLO7VTrhXJZogNqgUm9KMkLn6W1H2gKBoGnrNQ0ukYmpYnpNl0cFJFhP0T6iuC0wIyUbyLBBij2/zVNm1bK/Nm1EZkSwQpIVtheLi8OXef3deD0gHolBNhGRGPj6qYe5Q/pCh/1Igajn2m6LNzEpANsJ3q4foi8cCD98Ha9td1DHFMey4nVf6r83Awz5P7lm7xtalBtMZmXh9WBTuHHuRBxsmuc1tjTgBKuYeIu4s+xuVwEqs1mUqO20FqaPdioBLfa7m//RcuT8LUO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRTquAvK3moszlQJl7jrHKq66iBh/H5kUYz7Fodr4PE=;
 b=HI9ujCwnuhE65YYyOekEOgXuO/k5miKYDrDt9PQ8qdwXR7p0aCfBKDOhb5qnSVaulknoPnFlIgvuduIJo+NImMPNqQBrH7pSxe0UQuWUGOUmPTl1SXWn5JM7TqAtjGIGCp91oxU3TLKiW3ZdSB5h3+scXmJjmGRCSWZ7Zl4WLqjDfDJMVeigVgCrCol7O4sggh8UU5qpm0hU+EUJI+M3q+6NewwOQhMOaRQTg7MGZNtC60iWZc8bULNf952kHR+15FlpPIMBlbXAPJ8MU+u+rcOkFVnIptxXs536loVLjqR+3jmO2KzDDMcjP5twK+F3sXwAAYa64SOvdtH8mfWUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYYPR01MB7853.jpnprd01.prod.outlook.com (2603:1096:400:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 02:16:27 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a%8]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 02:16:27 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v5 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v5 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHZJZKjp+w/pOVQJUiMpclC502Bsa6k9uwAgAZ9LLCAAOMigIAAkQew
Date:   Tue, 24 Jan 2023 02:16:27 +0000
Message-ID: <TYAPR01MB6330317EADA62C45EAD8B0608BC99@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
 <20230111075802.3556803-5-tan.shaopeng@jp.fujitsu.com>
 <3201c461-2f46-f354-6019-94ce8978fb46@intel.com>
 <TYAPR01MB6330B2248A693BD3170CC76B8BC89@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <25ca1de3-5673-6332-a1d5-59920c191739@intel.com>
In-Reply-To: <25ca1de3-5673-6332-a1d5-59920c191739@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDEtMjRUMDI6MTU6?=
 =?utf-8?B?MTdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1mYzM5MWY1Zi0zNzQ0LTRkZjkt?=
 =?utf-8?B?OGJjMi02ZTNiYzRlZTZlNjg7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 5f953e4ca86d47e2bc69c87fdbeb1e6e
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYYPR01MB7853:EE_
x-ms-office365-filtering-correlation-id: c5a040cf-e649-42ca-785b-08dafdb10004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndF6qZKLgC3IBMTCocysbtOTkUavOerXE0TTTZAQ88t0qA5PjmDnduEW9o64Yvd0aqdr+VELVn+NNSbe2wAefJIRHb1volTe7qVf5cq6g/PTO3ge4DKuYn0uESxic11g8cDUHHoEff5hk2wvEjSYyWf4vQ5+CBrW6wIKYkCWr84ZxCN01wMjnlQgRTc3wZ0uH+tBXRH1D50g0SSDCgxNJ/RPFOvf9gfrom6GavQ0LWQGS4E9PVCwSX7EziFSXKAeF7DO9/z1uTJIxXJdqZPxtJX01dMGywdpi+EaoRbr5TC3cspbf7PTKA1ZPYTDPdwNxnbv20RVi5k1jH9lqg7/Gjz7rYYhYtEO635LOoctq8kKew15XZ2FxaoGhhmNTiPBNUUNBHVBZOqriGpXQre9hI0u+bprTSEV3//qkByYP/tSUQYZIgNnUe/HbBy8e970u5CPyj5fu0YIq+ZE4AaGvLh/HQbY+3ewylkd/Rgx0LgL06c7yw/woaSPquiKwKZCaUjL8teg8cvHnAzD3OzkvWXGf9jDt9A78WX7b9Y6/KLcxflCEqFgb1UEy02aNrcp6FavQmqh9lzj5o1Ah73Y9/eBSnzGP76VY8ZEGJEaQwTLf7Fwuu+1oag3MRFm+FK8pOBZZHZJrYRWSXOGdIsFhgekvnfwHHGWmCfBIFjS/rMV4xgxyNffXBZg87Xn/QmQ0eJtYyAhQAQovxRl2zbe3j9C1K+tI6PHTECPz84kybY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(1590799012)(38100700002)(83380400001)(122000001)(33656002)(82960400001)(38070700005)(41300700001)(86362001)(2906002)(52536014)(8936002)(5660300002)(4326008)(55016003)(9686003)(26005)(53546011)(6506007)(8676002)(186003)(66556008)(66476007)(64756008)(316002)(76116006)(66446008)(54906003)(66946007)(110136005)(478600001)(7696005)(71200400001)(85182001)(1580799009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTlHVDk5UWxuRmdaeHVOOXRucjN3S0pTYS9RT010S3loVW9WRGVqb3RPbGNU?=
 =?utf-8?B?eEJJOUtaUjdhdk5IYktJQWFpUVB4Rlgrb2VranJrQ1kxbDZPTVduZjlxb0N6?=
 =?utf-8?B?NGhTdXZCZWtOWnBRS2VZajdVYi9GclNxRkg2aXFGbDMxMGxTKzdRNGxIMzQr?=
 =?utf-8?B?OVljdGUyWVc0NFZsSFVab3ZYd3A1QU9kcUZiQ0x5T0xESU9uTXNwNUtET1V4?=
 =?utf-8?B?cUxXQWhQREVRTWlOaklVUXBYOVJ5WDZ5N0RNbWkxMDVYN2dnbGJPNlhBdGsy?=
 =?utf-8?B?TWw3THZGa1N2MDJ2Qy9GNVR5bDJJaW9TM1JQaVJ1bE1tOWZmci9UWUFuRGFp?=
 =?utf-8?B?TVQweUs2QmZpVFJNQUFVenNhU0FjcEZLYnNlbUJiY3d6UkxUWFdyS1lMeFR6?=
 =?utf-8?B?OUdsNHhSRFhlSWNkNnYyRkgvUDdnSWhtY2s2Ykxuc0dsMVV1dGdDcWFmOHdt?=
 =?utf-8?B?OGdCLzBTeWJvbDU0aWZUdnI5dEduYkRuSk1JUDR3STk1eHFVazV2aEpPdHVp?=
 =?utf-8?B?Nk55SmxDcDNuUDNkY0VJdFVYZCtQWVJxaHJSV0RZNWhOZkU5SEVOcnFmTW15?=
 =?utf-8?B?WHgrV2ZRQ3kzVFM1L2FKY2NBcHdDaldMckRaQmczZnUxZGJXMGRJdlVRT1hY?=
 =?utf-8?B?N09CanVWTjFmZmFMQ3pvU3BJeW1COVNHM0ViR2haMDVRSkF5TzlydmhYUGhQ?=
 =?utf-8?B?V3FKNzIxUHF4YzhZMHRmMWdkKzg3WDlOVWovRlFHRFl6WExVaXBzUGY2MFEy?=
 =?utf-8?B?Z1JWeTEydVJZdVR6bEFiNk1zTjFyTVNhak9qL3Faa3F3eEpKaFZ2M1ZoeTJI?=
 =?utf-8?B?aFJpb3JkV1Nrb01kRmhkbVhmYWpwZmlDOHp5WXBzbVFzM04xNFVseHM4R0R4?=
 =?utf-8?B?WDY0NDJ6czdkbXVzMFcwMEpXelhaaHVXWURFcHdCS0xhdVk0dy85NDRNWnA4?=
 =?utf-8?B?ZDRIYkJUSnYydTFXNEtPM1ZQOGVmN1drak9FY0VzYWphOU1sZHZFMEp6c3J5?=
 =?utf-8?B?dFJTZ01uY3ZPcHpaTHlNMmt5aitkVFpxK1pPUVhxK2JEYWhCb0tUVjlLc2ZT?=
 =?utf-8?B?VFpjeXJZczZmRGordjdGZFh2eFVTMmNLNWQzOUtvREtFYUw1WGUxSDlJVUp2?=
 =?utf-8?B?NHZYWFg5amJNTUUzb3Y4R01zUU9uSGRBRzZNbEwxVE5BR21ta3FrbXB4aG1s?=
 =?utf-8?B?ekJaZ3l3VGNjR2Vlc3hhc3FoNzBzUkFlZlM2Y0N2b01sbkxjcjVTc056aUx3?=
 =?utf-8?B?Zzc1a2QvWTIzUGNQQjFIbU9MU2VvQytjazg1N0hOVno0cFJ6SDZzNzJnbGNP?=
 =?utf-8?B?YU9EcjVNU1d4ajVxcTI5dWJlQVRCQWZSeVdTcVBqZndzMy96ZXZMU1ZMdUp3?=
 =?utf-8?B?TjVIb01yYTU5aFNMZHI2U1F6VDdTcDRuMVFCam1YWXR0Q1ppdm1QcWVOWjJH?=
 =?utf-8?B?eUpRTHc4SDVFc2UwTTZUb05qem5hUjhDemxhY1pmQXJ2OHJHY2JNTGtBREZj?=
 =?utf-8?B?VElnVU44V1h2Y2V6L0JUaXBXbDdHTGtpUDhTUnE0UlRYMy9HZGFjTnJSK1ND?=
 =?utf-8?B?WHFHb1NxNHdWTEx5NU5qQ1Y2YWludEVPdGtQKzBDQlFrTFlyZXprTTNod1Z1?=
 =?utf-8?B?Tm1LekRBQ01nOE1XY0E4TnFFSzcyVldBV0tYWkx2ZjNrdjhxNDZHMk5hdlo2?=
 =?utf-8?B?WmFjMndqNEFnZy9pb292aUt3c0QrUHVDc0ozaTR1QTY0aVlNdnZDeGlNbGpB?=
 =?utf-8?B?S3cyekFzYmlpNmtHYWpRVzE2QzVoT3g0ZGpFNXJWaFFMV1pDMG1NNk5XQ2pR?=
 =?utf-8?B?RUswdk1kNUhLQ0lUdktPbjNEWGkwNjdnRGU2cWFpVnJyc2ljVXRBNWNPbnpH?=
 =?utf-8?B?ZVU4aXhDeUNtZ1FNVFN6RTI0NUliYW9NVUd3L1MreWdFSGU4ZUU0cGtRclBn?=
 =?utf-8?B?LzBLY1lpVFZDbzAyeTFncTdsVTZmK1ZKdmtraGQxTW9BcHZ6dDlHTmdJUzJZ?=
 =?utf-8?B?UndXQXlUMFhIQkJoQ1YydU1wT2N5dUpEeHNLNWxGeFRsT0ZJM3JlVnFGUHYv?=
 =?utf-8?B?VjhuT05YZWljbkNTYjBleS9uWkR2V3lyMU93QXJ1ZFN2Q1hrNHRpTm5sQnda?=
 =?utf-8?B?OGd3clI0ZkV3Qm0wL1ZDb2tHb3FVWWtYem1GblAwOW5JNTZnbEg4RVBCUlgz?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0wH8nfcrrZmWOeMiEemmOIha7yKlPLjTRbYHDjL8pcC0S4pqMNOycJ5+BYqjnDUVxEy5tNd/tW3s4K/sSrsdG3pbByliTJVHh3NoWSGjdzA430Vc5fbiBNSiKpmPFGHVJsgMXzxS5Ynw7Ug7HNEGQ2xaOcIo92vQt88Ywxtpa9SrpZlEgS/89hE6ljCNGonsgDzQa/p3L0nSAEmgF5zjiGSobIcByGKYIGWSvYRzIlyOXIMOJ7/k4GN9rkQ3s9wuqiksxLit9i3zEwwVNxlU2KGxpjoZBpR+Jw1XN8pBMwOkmm5h0Yc/6Xryv5Bwg2WpAzFAFbzOrkpnbLCSm08f4fDGagwdi745VCLDNBzBwuc9ycJ6XMJvgK/RPZkGK286m5xZXgtbmx+aSPmbCn7AYHCaiJEB/7XTFWwh/7vSip4BqUdhVr6D8V0t0vM555zB8kpPC8vZRc7in94hkVKZzu24xGGvDej00BVS0l2Q5L5FblaKcsIZccThLbuyISzI2Ue8FrTySn6n9k5i4gL6hhVGOQJRAmj63fLDWEAJxYa4lErA28RItqIFq/WqtahRzkJGxZV/RNPIBuJjd8u92ZXJEvBFobpR6W19p56gUCzJQ5vUoR4XE/Vt/1UW8CFKBRpE+EoQKd68AgnqDyO69+6ttJjDH0b7aHw1+qfrbL4ORiWvWckOv2eIAFkCGuTuTrpSJ21ojw2Wc52QL1z54hatQbM7oqiYIC21lsyuEAGGTOCHF1XBXiQ2DdTYAcuJC6smhBKalUTiYGgkbGIF6jfamc1tUv+pAFZV4yR3+3sPCbScZZU5qcrXaqJkEt8QAwIiILl89knoPP4O9KCLRA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a040cf-e649-42ca-785b-08dafdb10004
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 02:16:27.7521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uw/3xqB+eqyhuLeyUaBnA8Akx631+ISyZ89/ENESsEoxwO/SR821W2QxCc7wTgnLpcuoeItYSuD28Q41dFfrxnVvP7W0bI70KqUNNe9EYd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7853
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gMS8yMi8yMDIzIDg6MjIgUE0sIFNoYW9wZW5nIFRhbiAoRnVq
aXRzdSkgd3JvdGU6DQo+ID4+IE9uIDEvMTAvMjAyMyAxMTo1OCBQTSwgU2hhb3BlbmcgVGFuIHdy
b3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYw0KPiA+Pj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gPj4+IGluZGV4IDZhODMwNmIwYTEwOS4uODczMDJiODgy
OTI5IDEwMDY0NA0KPiA+Pj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9j
YXRfdGVzdC5jDQo+ID4+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2Nh
dF90ZXN0LmMNCj4gPj4+IEBAIC0xMDMsNyArMTAzLDYgQEAgaW50IGNhdF9wZXJmX21pc3NfdmFs
KGludCBjcHVfbm8sIGludCBuLCBjaGFyDQo+ID4+ICpjYWNoZV90eXBlKQ0KPiA+Pj4gIAl1bnNp
Z25lZCBsb25nIGxfbWFzaywgbF9tYXNrXzE7DQo+ID4+PiAgCWludCByZXQsIHBpcGVmZFsyXSwg
c2libGluZ19jcHVfbm87DQo+ID4+PiAgCWNoYXIgcGlwZV9tZXNzYWdlOw0KPiA+Pj4gLQlwaWRf
dCBibV9waWQ7DQo+ID4+Pg0KPiA+Pj4gIAljYWNoZV9zaXplID0gMDsNCj4gPj4+DQo+ID4+PiBA
QCAtMTgxLDI4ICsxODAsMjkgQEAgaW50IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGlu
dCBuLCBjaGFyDQo+ID4+ICpjYWNoZV90eXBlKQ0KPiA+Pj4gIAkJc3RyY3B5KHBhcmFtLmZpbGVu
YW1lLCBSRVNVTFRfRklMRV9OQU1FMSk7DQo+ID4+PiAgCQlwYXJhbS5udW1fb2ZfcnVucyA9IDA7
DQo+ID4+PiAgCQlwYXJhbS5jcHVfbm8gPSBzaWJsaW5nX2NwdV9ubzsNCj4gPj4+ICsJfSBlbHNl
IHsNCj4gPj4+ICsJCXJldCA9IHNpZ25hbF9oYW5kbGVyX3JlZ2lzdGVyKCk7DQo+ID4+PiArCQlp
ZiAocmV0KQ0KPiA+Pj4gKwkJCWdvdG8gb3V0Ow0KPiA+Pg0KPiA+PiBUaGUgImdvdG8iIHdpbGwg
dW5yZWdpc3RlciB0aGUgc2lnbmFsIGhhbmRsZXIuIElzIHRoYXQgbmVjZXNzYXJ5IGlmDQo+ID4+
IHRoZSByZWdpc3RyYXRpb24gZmFpbGVkPw0KPiA+Pg0KPiA+PiBBbHNvLCBpZiBzaWduYWxfaGFu
ZGxlcl9yZWdpc3RlcigpIGZhaWxzIHRoZW4gdGhlIGNoaWxkIHdpbGwga2VlcA0KPiA+PiBydW5u
aW5nIGFuZCBydW4gaXRzIHRlc3QgLi4uIHdvdWxkIGNoaWxkIG5vdCB0aGVuIHJ1biBmb3JldmVy
Pw0KPiA+DQo+ID4gQSBzaWduYWwgaGFuZGxlciBpcyBuZWVkZWQgaGVyZSwgYnV0IGl0IGlzIHJh
cmVseSB1c2VkLg0KPiA+IEFsc28sIHRoZSByZWdpc3RyYXRpb24gcmFyZWx5IGZhaWxzLg0KPiA+
IFRoZXJlZm9yZSwgaWYgcmVnaXN0cmF0aW9uIGZhaWxlZCwNCj4gPiBqdXN0IHByaW50IGEgd2Fy
bmluZy9pbmZvIG1lc3NhZ2UgYXMgZm9sbG93Lg0KPiA+IGhvdyBhYm91dCB0aGlzIGlkZWE/DQo+
ID4NCj4gPiBrc2Z0X3ByaW50X21zZygiRmFpbGVkIHRvIHJlZ2lzdGVyIHNpZ25hbCBoYW5kbGVy
LCBzaWduYWxzDQo+ID4gU0lHSU5UL1NJR1RFUk0vU0lHSFVQIHdpbGwgbm90IGJlIGhhbmRsZWQg
YXMgZXhwZWN0ZWQiKTsNCj4gPg0KPiANCj4gSSBkbyBub3QgdGhpbmsgdGhpcyBpcyBuZWNlc3Nh
cnkgY29uc2lkZXJpbmcgdGhhdCBzaWduYWxfaGFuZGxlcl9yZWdpc3RlcigpDQo+IGFscmVhZHkg
cHJpbnRzIGFuIGVycm9yIG9uIGZhaWx1cmUuDQo+IA0KPiBBZGRpbmcgYW4gZXJyb3IgbWVzc2Fn
ZSBkb2VzIG5vdCBhZGRyZXNzIHRoZSB0d28gaXNzdWVzIEkgcmFpc2VkLg0KDQpUaGUgcHJldmlv
dXMgaWRlYSB3YXMganVzdCB0byBwcmludCBhIG1lc3NhZ2UgaW5zdGVhZCBvZiAiZ290byIuDQpI
b3cgYWJvdXQgdGhlIGlkZWEgdG8ga2VlcCB0aGUgcGFyZW50JmNoaWxkIHByb2Nlc3MgcnVubmlu
ZyBmb3JldmVyIGV2ZW4gaWYgdGhlIHNpZ25hbCBoYW5kbGVyIHJlZ2lzdHJhdGlvbiBmYWlscy4N
Cg0KKwl9IGVsc2Ugew0KKwkJc2lnbmFsX2hhbmRsZXJfcmVnaXN0ZXIoKTsNCisJfQ0KDQpJIGRv
bid0IHRoaW5rIHRoZSB0ZXN0IG5lZWQgc3RvcCB3aGVuIHRoZSBzaWduYWwgaGFuZGxlciByZWdp
c3RyYXRpb24gZmFpbHMsDQpzaW5jZSB0aGlzIHNpZ25hbCBoYW5kbGVyIGlzIHJhcmVseSB1c2Vk
IGFuZCByZWdpc3RyYXRpb24gb2Ygc2lnbmFsIGhhbmRsZXJzIHJhcmVseSBmYWlscy4NCg0KQmVz
dCByZWdhcmRzLA0KU2hhb3BlbmcgVEFODQo=
