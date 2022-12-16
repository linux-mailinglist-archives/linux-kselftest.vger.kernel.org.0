Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1A64E818
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 09:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLPIVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 03:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPIVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 03:21:22 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 00:21:20 PST
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C5120A0;
        Fri, 16 Dec 2022 00:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1671178881; x=1702714881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DOVAsG92tNRTqJQeIS4gzRjs1XJUSphFO3n8a95zzSk=;
  b=fTjVjtlc6WvN5dOTLZxVVwVPn4bUM0vj2VzSrUf0niwnR+CLDFzPlBbj
   B6OL+Uwn/kFZwEWM11i2I8+pMjGljYo9031VUzEdyG5ci4/WOVxUfku56
   wHz9b+2K8oKhiBxNuDbo5eKWfP+98At3NJGrUMJ+v3IAYH8YuGmWO4Axv
   6kPT5L69zD/j2WLKy31cZg8W6vXORzc85E7LHKiifjxzcT9G+x5G9h5Q+
   FVN//tR3SrF6ieK3+r4qmof8Bh0W14h14tLNNQnKHUKC0fPG/KuEhx7By
   ng7lay92NNYJLJsQEBw861MJFjmnXJPw7hcRvVw8N7Q+u33KeL7zAq9OG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="72599434"
X-IronPort-AV: E=Sophos;i="5.96,249,1665414000"; 
   d="scan'208";a="72599434"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:20:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsDdWzMSEFgkugro+OErYT8UwrokJI+vKb33mEY25tsvzwQG7MFqjAfFY1OafAXcuvEqUf5TKgcnxI76sSUmnavez3gqJG+Vq6VEjl2IKNcXfHCzvEhIBgLN5TTabNPt/Fy+WN65euE/vFmCvIQ8gaWq7OFrfxI6XYkyiKuYLzAq4ISVphiH2fExtW613SWGJzjaQ/dTQHKNwO/7Cr95QzF7e2YagzjjASLk2vzTGfAb3C+Yp+iWLz0l8GJSdB+ajUG04j70MoVo3SN5f9SFE+wu35FjofVPUEGHHaly/ArMUjLneeevwVIRbXPVkERUEbm384u8ZB7vuhiLAvsKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOVAsG92tNRTqJQeIS4gzRjs1XJUSphFO3n8a95zzSk=;
 b=QYS5VxS54Nvj4HHzRpUSNnI5n6iIRhoQtHdlAEFz0pzb9sROuv+sGUqGPejrXMlp/wWSG7o7xKtPwsP5GKb9fTbCJTP5ESoaXXtgWLUgWyG5y3bMpWrHHwopvLiRWnePCblvwEiyqCSMm/caFQ0rrHWveKilqcnXyH4cUVv3oYQHrb4pDfCbk/ICbd2S1Z3cFRJeEZYP587yGPNO4kL8hNJuLBTqeRdj7ARzfyb1P8UuELoPnlcFcKv7aNrtGzZyBKGDZTw+igE8rnBJEsJJK2rwicYP3GYAr4kSyt2w+qQtZNC8ALCKX0vw2CMgUfCsH5o8Ot4f34rjXWD+uCfgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com (2603:1096:604:e8::8)
 by TYAPR01MB5786.jpnprd01.prod.outlook.com (2603:1096:404:8053::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 08:20:10 +0000
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::5ab2:75fd:5b59:b295]) by OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::5ab2:75fd:5b59:b295%8]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 08:20:10 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: RE: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHY+iGKVtajSkrGmEuJ9jg67HQSRq5M00IAgADx+yCABt9YgIACkaeQgACIj4CAAQYgIIAAp8SAgBbrv5A=
Date:   Fri, 16 Dec 2022 08:20:10 +0000
Message-ID: <OSZPR01MB632837AC9133DFBD2061637D8BE69@OSZPR01MB6328.jpnprd01.prod.outlook.com>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
 <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
 <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ba5a9ef2-b4ca-5c90-cc03-2296586455a6@intel.com>
 <TYAPR01MB63300F91A0755310E78D98308B159@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ce549bc3-7e54-b1d3-7ec5-4cde66bd468f@intel.com>
 <TYAPR01MB6330FFB9E5BA7CCDC652EE3F8B149@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <9801fa7f-5971-1f5f-1b63-0d672c32fcf1@intel.com>
In-Reply-To: <9801fa7f-5971-1f5f-1b63-0d672c32fcf1@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTItMTZUMDg6MTM6?=
 =?utf-8?B?NThaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD00MTM5YzVmNS1kZTEyLTQzN2Mt?=
 =?utf-8?B?YmRlNC1hYzY4MzE5YzllOGI7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 41489974e2fe424697abedcc0acd9d0e
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6328:EE_|TYAPR01MB5786:EE_
x-ms-office365-filtering-correlation-id: 959f92d5-7e87-4ba4-4423-08dadf3e5943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHRqBFmZ02k5ueY1iiFo9Bl4meeYnZg7t42DiuiexfbzdDn7VxfnMjmd7X7PgJOc7NF/IH5uASp+SK5Wrv1AH+JYDMH+biuGuoXVkqXn85Oa8JGDGw41KLOPQ9W0PRBMmXQJntrWWM6zpTHjWNucwp4koQieahoqCIQAiOsUqg5mu+5ELEJ4quq5KCWNKFUZejb5UszJcoEXwz0mgk/AnQxVk8efmd/eDdVFSruhgoswCQYkscgeQKMBV889TjCvgl7jCBgBsc02qEY7CM7E6ib2RB+lpcrVKiZDeROnHZ06t7NehrFI5grGD91ZOXjB4zS47Hp5ffL1x7qyJlaFlSZPd6bv9AOUYwPmaJUbNLV4byNaRESuuDnGPD9vkjFqFI/cyV10Q+EFxW86WvJycar4U/CTJnyWZw6IFCpMBqkM29lJ2gIfeta1j9levkjNGAiMuSyUdbsWvdgEqTXuTVRPQGObLMfMXJkghMALiVrmhn5MZiKSYxgf5IGwkeeXIW57LO1M4x6GmrW21iNN70h0yaA5GpWfGs2hcNb4BTuQ0+OCgs5zUIV0lxm4PeqDe2+w6l90Ue7Z9suaMISaEYpl/4qFuOWhABGMrzsGBXa3+2RmhTlV8+h9wtawdqTHiMqTuhaXURNmDZLyJbgvxbwEl2u9p7Fvbp2B+LatsO2Anuw/CFFDjOA8G0OLf9iNpYugQ2IsIaRSnpqRKTU1z6sZCRkWXrINR88llvIKxOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6328.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(1590799012)(451199015)(8936002)(52536014)(33656002)(66476007)(64756008)(66446008)(85182001)(4326008)(8676002)(41300700001)(66946007)(76116006)(66556008)(54906003)(316002)(83380400001)(38100700002)(82960400001)(122000001)(38070700005)(55016003)(71200400001)(478600001)(26005)(86362001)(53546011)(7696005)(186003)(9686003)(6506007)(2906002)(1580799009)(66899015)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUs1QXZkaVVFeUdkeDRPQXBIK0gvd0IvdTN0TktLOUJIb3YvRkI2QnRpN0xS?=
 =?utf-8?B?VmlkMkZkVzE2VmNjOHVoTkRkSGQ4QnNUM0RGWGprdWV6TjBWbzNqd2xEUWIw?=
 =?utf-8?B?ZlpTTmRYTmJxYkxheDBGbVVBWG9YZmlQa1hlaEgweEhGUXR0dGpSV0NJcXVo?=
 =?utf-8?B?WWhQN2E4djJKL2pTaTlDMk1pL0lVd0FoK2ZkMjdZU1h0V3RSZmhIOWR0dFU3?=
 =?utf-8?B?K3ZhdmhZN0p5eHVaRVQ1aUtIUG02RmJGNEdOdy9qMEZTSXJoTXlBQWZsVjJ2?=
 =?utf-8?B?VEhrRjk3ci94NGVTVDRmblNlM3FqZmRjQzlhUk1YQTFNa3dLYzhqMmd6QWQz?=
 =?utf-8?B?aHJpa1pJdkY2YnV2VkF5aDU1YXNSYTJHcndaSVV5WVN6MldmMHhQQXZiTSta?=
 =?utf-8?B?aWViZXNIQU9FRXV6NG5VWXdNaGl2ejBwY0h6MHJZUEZnL0EwVVVVemdUcEx4?=
 =?utf-8?B?ZU5SakZxeUUxUmwxNlFXMGVualNHSWFkQnJ5L3dSM0hXSWFUUmY3WVlyN2Ro?=
 =?utf-8?B?dkhkYkRmMnhZNW12cy80SnNuOUhDaC9aaGRpY09iOFVKY3ZwenBYeERTYys0?=
 =?utf-8?B?eHFvcFR3QnJ0SktlTzhRSkpPMVdxU0RrSnMyNjBiR0szZUJYdldxQkF3NllZ?=
 =?utf-8?B?ckIrM0ttQ2tYVEFFdGN5QkFROWtLT3Rpa0MrU3lpZnk4ZEE2bzVWWFZMY2Yy?=
 =?utf-8?B?d3c5MHp1Zk1yUVc3b2xQYW9JUzlyQ2xwdmJQazg3VnQvS0lNQnhiY0p1ZnY5?=
 =?utf-8?B?QmZ3RE5YMmliYkZzR0YwUlZ4Z1pBenlBM3pDWVVLZUNTV0hBMVZyZ1E4YVVE?=
 =?utf-8?B?R21tZkI0TFpPZnJGY052K3o2T0RuNzYvNzBsZC9JczBSOVVvaXJBbGJZWUR6?=
 =?utf-8?B?S0orMzF5Nm1CVkJOTzZUQWJHSkV3N1F6bFREZVY3ci9vcXRLUWg4ajhZZXRN?=
 =?utf-8?B?SU11SzdHcllpRWc3S1M1Z1VOTVlRLytndnZqT1pJNldjOXdRbVErVHIzMmdQ?=
 =?utf-8?B?cit2S0JZVmxRUzdIM0RZbnBZT21lck0xQkR1dkdRdC9UVGxXL051Sk1zR1NU?=
 =?utf-8?B?MzF6Um9GeVhHdVlTbStyTWZ1MXplMXBTMDc5SFRCTmR0T2JzLzd2QXhmSm00?=
 =?utf-8?B?RXFURFBkamU5ajRDb2hQWm1MeEZ2dUQ5OTZYek9HelNVU3JVNjl2ZDN1NVpq?=
 =?utf-8?B?d3hFL3BDczVrS1VDV2IxSWVCbWJObFE0UFRPbkhlTG5ZdnJ0Wm1SU2NQNDFs?=
 =?utf-8?B?UnB1UzRMbUw5YkFyQk1ncXJBMGxELzZ0VHlYWmpsRGYxSlQ3MmZFRFNyT1dC?=
 =?utf-8?B?TlEyZHM3aU9sTkZwMDA3eWl2ZDNnYVNIYzlNQzBRNGg3L1RKK2g0TVI1TnRi?=
 =?utf-8?B?QkRlRDBCeEkzcG1EMHBpVHN3TCttTFVNbDVHWGpETW14U0huZGtBQVV5bUdT?=
 =?utf-8?B?eStpVVExQzNPWUVvcXZ6bWg2VmZLcmozTitIS0ZSSTIzS2toV1JXWmYyZDU1?=
 =?utf-8?B?ZXZmL2dYendiOWx3a21SR09LN2p3YXNxRDljd1Y0YlMzTlNyT2habEErbVZR?=
 =?utf-8?B?Ujk4dStmRlBZNXlPcXYyZ0xCcnc4bU1vR1h0Z2pRbUZhaWFCYkw4WTRkajlI?=
 =?utf-8?B?M0RweGViOGRTbUlrZ2VQQVhZa0J4Q2xyYklicFNNMWg3ODM2WkY0ZE1iSytQ?=
 =?utf-8?B?TGFjYlMvM0NtaVFnTEtpL3hRbmoxSDFDT0RsTW1TL21qUFBMNzE4Z0NQbWVB?=
 =?utf-8?B?OWFkSXloMFlBZXA2RW9mMFN3QjJWUTRSUlB0YUcwUG9wVTNab0dUQ3R6UmtS?=
 =?utf-8?B?QlpWK0RQQk9lWjJIWHhXQkhsZzB6ZUJpbUJZZzVSc1FSa2k0MFFsOWFRNXRX?=
 =?utf-8?B?aEZwSDE3aE9vb2VEaE1RN3MyLzk5T1B1U3VPVUJTUlFxSi85Umx1cjhzYUln?=
 =?utf-8?B?TE11Y1lubURpNDR1Rk9mSmpRRWoxMkp4QUpEc0FYaGw5Y1B1eTNxb1FqTUR0?=
 =?utf-8?B?MzJmOTkrZkZ0V25ueUZpRjN0NklTN04vbHRGRDZKbHhzcTF1REtVQWRvZi9r?=
 =?utf-8?B?YnpXVW9BZUEvZWpZNlkydVNqL2dQaVhtaTJFbFRDVGNBUjgyQUpITHkyMWl5?=
 =?utf-8?B?dkpObDFKa1hBMGRtNFBqbjZJaG1uRXNmRCtVQTNVVUkwL3VKb2VOeGVLdTdz?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6328.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959f92d5-7e87-4ba4-4423-08dadf3e5943
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 08:20:10.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhfKcTzAGdpTDj3pQa4gpo8x27qpvj/GqiFucXGx95vUA9L8roPXetPziwMrMLBiUmHJdcrmgiA6FkIQf7PGeoMqnTDBIRlrOwqPAsQFPVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5786
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUNCg0KPiBPbiAxMi8xLzIwMjIgMTI6MjAgQU0sIFNoYW9wZW5nIFRhbiAoRnVq
aXRzdSkgd3JvdGU6DQo+ID4gSGkgUmVpbmV0dGUsDQo+ID4NCj4gPj4gT24gMTEvMzAvMjAyMiAx
MjozMiBBTSwgU2hhb3BlbmcgVGFuIChGdWppdHN1KSB3cm90ZToNCj4gPj4NCj4gPj4+IFJlbW92
aW5nIGN0cmxfaGFuZGxlcigpIGlzIG9ubHkgcGFydCBvZiB0aGUgZml4IGluIHRoZSBuZXh0IHZl
cnNpb24odjUpLg0KPiA+Pj4gQWxsIGZpeGVzIGFzIGZvbGxvd3MuDQo+ID4+Pg0KPiA+Pj4gLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jDQo+ID4+PiArKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gPj4+IEBAIC05
OCwxMiArOTgsMTcgQEAgdm9pZCBjYXRfdGVzdF9jbGVhbnVwKHZvaWQpDQo+ID4+PiAgICAgICAg
IHJlbW92ZShSRVNVTFRfRklMRV9OQU1FMik7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+ICtzdGF0
aWMgdm9pZCBjdHJsY19oYW5kbGVyX2NoaWxkKGludCBzaWdudW0sIHNpZ2luZm9fdCAqaW5mbywg
dm9pZA0KPiA+Pj4gKypwdHIpIHsNCj4gPj4+ICsgICAgICAgZXhpdChFWElUX1NVQ0NFU1MpOw0K
PiA+Pj4gK30NCj4gPj4+ICsNCj4gPj4NCj4gPj4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGUg
d2h5IHRoaXMgaXMgbmVjZXNzYXJ5Pw0KPiA+DQo+ID4gSWYgZW50ZXIgImN0cmwtYyIgd2hlbiBy
dW5uaW5nICJyZXNjdHJsX3Rlc3RzIC10IGNhdCIsIFNJR0lOVCB3aWxsIGJlDQo+ID4gc2VudCB0
byBhbGwgcHJvY2Vzc2VzIChwYXJlbnQmY2hpbGQpLg0KPiA+DQo+ID4gQXQgdGhpcyB0aW1lLCB0
aGUgY2hpbGQgcHJvY2VzcyByZWNlaXZlcyBhIFNJR0lOVCBzaWduYWwsIGJ1dCBkb2VzIG5vdCB0
YWtlIGFueQ0KPiBhY3Rpb24uDQo+ID4gSW4gdGhpcyBjYXNlIHRoZSBwYXJlbnQgcHJvY2VzcyBt
YXkgbm90IGNhbGwgY3RybGNfaGFuZGxlcigpIGFzIGV4cGVjdGVkLg0KPiANCj4gQXBvbG9naWVz
LCBidXQgSSBhbSBub3QgYWJsZSB0byBmb2xsb3cuIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0
aGUgaWRlYWwgaW4NCj4gd29ya2luZyBhbiBmYWlsaW5nIGNhc2UgaXMgZm9yIHRoZSBwYXJlbnQg
dG8ga2lsbCB0aGUgY2hpbGQuDQo+IENvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdoeSB0aGUg
Y3RybGNfaGFuZGxlcigpIG1heSBub3QgYmUgY2FsbGVkPw0KDQpBcG9sb2dpZXMgZm9yIHRoZSBs
YXRlIHJlcGxheS4NCg0KVGhlIHByb2JsZW0gaXMgdGhhdCBhdCB0aGUgdGltZSBvZiBydW5uaW5n
IENBVCB0ZXN0LCANCnByZXZpb3VzIGN0cmxjX2hhbmRsZXIgZnJvbSBNQk0vTUJBL0NNVCB0ZXN0
IHdpbGwgYmUgaW5oZXJpdGVkIHRvIGNoaWxkIHByb2Nlc3MuDQoNCkxldCBtZSBleHBsYWluIGlu
IGRldGFpbDoNCkluIHJlc2N0cmxfdGVzdHMsdGhlIGRlZmF1bHQgcnVuIG9yZGVyIG9mIHRoZSB0
ZXN0cyBpcyBNQk0tPk1CQS0+Q01ULT5DQVQuDQpXaGVuIHJ1bm5pbmcgTUJNLCBNQkEsIENNVCwg
c2lnbmFsIGhhbmRsZXIoY3RybGNfaGFuZGxlcikgd2FzIHNldCB0byB0aGUgcGFyZW50IHByb2Nl
c3MuDQpBZnRlciB0aGVzZSB0ZXN0cywgd2hlbiBmb3JrKCkgaXMgZXhlY3V0ZWQgaW4gQ0FULCAN
CnRoZSBzaWduYWwgaGFuZGxlciBzZXQgYnkgTUJNL01CQS9DTVQgaXMgaW5oZXJpdGVkIGJ5IHRo
ZSBwYXJlbnQmY2hpbGQgcHJvY2VzcyBvZiBDQVQuDQpBdCB0aGlzIHRpbWUsIGlmICJjdHJsK2Mi
IFNJR0lOVCBpcyBzZW50IHRvIHBhcmVudCZjaGlsZCBwcm9jZXNzLA0KYWNjb3JkaW5nIHRvIHRo
ZSBpbmhlcml0ZWQgc2lnbmFsIGhhbmRsZXIsDQp0aGUgY2hpbGQgcHJvY2VzcyBtYXkga2lsbCBw
YXJlbnQgcHJvY2VzcyBiZWZvcmUgcGFyZW50IHByb2Nlc3Mga2lsbHMgY2hpbGQgcHJvY2Vzcy4N
ClRoZXJlZm9yZSwgd2hlbiBydW5uaW5nIGFsbCB0ZXN0cyhNQk0tPk1CQS0+Q01ULT5DQVQpLA0K
c2lnbmFsIGhhbmRsZXIgb2YgY2hpbGQgcHJvY2VzcyBuZWVkIHRvIGJlIG92ZXJyaWRkZW4gaW4g
Q0FULg0KDQpBbHNvLCB3aGVuIHJ1bm5pbmcgQ0FUIHRlc3Qgb25seSwNCnNpbmNlIHRoZXJlIGFy
ZSBubyBzaWduYWwgaGFuZGxlciB0aGF0IGNhbiBiZSBpbmhlcml0ZWQgZnJvbSBvdGhlciB0ZXN0
cywNCnNpZ25hbCBoYW5kbGVyIG9mIHBhcmVudCBwcm9jZXNzIG5lZWQgdG8gYmUgc2V0Lg0KDQo+
ID4gVGhlcmVmb3JlLCBjdHJsY19oYW5kbGVyX2NoaWxkKCkgaXMgbmVjZXNzYXJ5Lg0KPiA+DQo+
ID4gSXQgbWF5IGJlIGJldHRlciB0byBpZ25vcmUgdGhlIHNpZ25hbCwgdGhlbiBjb2RlIGNhbiBi
ZSBzaW1wbGUgYXMgZm9sbG93cy4NCj4gPiAtLS0tDQo+ID4gICAgICAgICBpZiAoYm1fcGlkID09
IDApIHsNCj4gPiAgICAgICAgICAgICAgICAgcGFyYW0ubWFzayA9IGxfbWFza18xOw0KPiA+ICAg
ICAgICAgICAgICAgICBzdHJjcHkocGFyYW0uY3RybGdycCwgImMxIik7DQo+ID4gICAgICAgICAg
ICAgICAgIHN0cmNweShwYXJhbS5tb25ncnAsICJtMSIpOw0KPiA+ICAgICAgICAgICAgICAgICBw
YXJhbS5zcGFuID0gY2FjaGVfc2l6ZSAqIG4gLyBjb3VudF9vZl9iaXRzOw0KPiA+ICAgICAgICAg
ICAgICAgICBzdHJjcHkocGFyYW0uZmlsZW5hbWUsIFJFU1VMVF9GSUxFX05BTUUxKTsNCj4gPiAg
ICAgICAgICAgICAgICAgcGFyYW0ubnVtX29mX3J1bnMgPSAwOw0KPiA+ICAgICAgICAgICAgICAg
ICBwYXJhbS5jcHVfbm8gPSBzaWJsaW5nX2NwdV9ubzsNCj4gPiAgICAgICAgICAgICAgICAgLyog
SWdub3JlIHRoZSBzaWduYWwsYW5kIHdhaXQgdG8gYmUgY2xlYW5lZCB1cCBieSB0aGUgcGFyZW50
DQo+IHByb2Nlc3MgKi8NCj4gPiAgICAgICAgICAgICAgICAgc2lnZmlsbHNldCgmc2lnYWN0LnNh
X21hc2spOw0KPiA+ICAgICAgICAgICAgICAgICBzaWdhY3Quc2FfaGFuZGxlciA9IFNJR19JR047
DQo+ID4gICAgICAgICAgICAgICAgIC8vc2lnYWN0LnNhX3NpZ2FjdGlvbiA9IGN0cmxjX2hhbmRs
ZXJfY2hpbGQ7ICAvL2RlbGV0ZQ0KPiA+ICAgICAgICAgICAgICAgICBpZiAoc2lnYWN0aW9uKFNJ
R0lOVCwgJnNpZ2FjdCwgTlVMTCkgfHwNCj4gPiAgICAgICAgICAgICAgICAgICAgIHNpZ2FjdGlv
bihTSUdURVJNLCAmc2lnYWN0LCBOVUxMKSB8fA0KPiA+ICAgICAgICAgICAgICAgICAgICAgc2ln
YWN0aW9uKFNJR0hVUCwgJnNpZ2FjdCwgTlVMTCkpDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgcGVycm9yKCIjIHNpZ2FjdGlvbiIpOw0KPiA+ICAgICAgICAgfSBlbHNlIHsNCg0KQmVzdCBy
ZWdhcmRzLA0KU2hhb3BlbmcNCg==
