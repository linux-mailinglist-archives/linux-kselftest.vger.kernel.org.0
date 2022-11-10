Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9B623CE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiKJHok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 02:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKJHoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 02:44:39 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 23:44:37 PST
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7338B7;
        Wed,  9 Nov 2022 23:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668066278; x=1699602278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t61YOUufO155AYoxo4A3BNRY8FxxZQ/aVDp/0odoA8g=;
  b=eJCEUQtDBneHtdgEFKRetM1NeQ0MN8bJPWFPiVR9SLrGXVswyo6c4qM1
   iG9bBOPWedRkZNQwD6REHAZgldZcNeuwu8TLXsA38A5//UCgB7WhMOA6d
   Y8blyfZmhyEScYR1/lZqHbtZelK2AdY1MUw/aUCka2SsvMhc6O16XQAlr
   rTLUyTJm6U/HWbluZm0Oe0WTWhNfhAbp+d/UCg6bBkINrJDs8GRUZpCRX
   /JS7SyHUCsXrHH32nsfQX73Jfw7C2VQmAstGv7ArRC18OyJSXdpwBLSHb
   hYmLVhvIK/Qr2CwZ0p9aU9cGyoU/vkmkIxxWzuBHlhjnSxCmwvvNT9JA+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="69837767"
X-IronPort-AV: E=Sophos;i="5.96,153,1665414000"; 
   d="scan'208";a="69837767"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 16:43:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcE2sk/eT77ElGAFsjleWOVOo+ds9IWLLLrurXuXQIXZVStVYBw4p2Kxz/vmlfY43LHDYtMJF0ZvoUXkDohaO0vt8sTM1QORj34IabjqW6F8vaY2tueITR/1SmlPkiHyQVUJpEF+AD37NqV1lCL1nUp1GZUeCivYs8LiDbHGoc7n7T8ir7br1rGVaFzOwQIA6OvnVUenxXyPf3xH72MFCseIyx45zw/YV1NEx0vOtHKMdBqSjf637OmGUxoA9GIQN1AHFZT0sdvKiqFlIHpsFD1byCnmmyht8TwYaxFEPbk0ApjBG5FHToqdbW1RZ19jzWyTHvBcBVox0o9ILYLxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t61YOUufO155AYoxo4A3BNRY8FxxZQ/aVDp/0odoA8g=;
 b=J5ya5bm+HEiVfxeqJmkKULQzLbWfi9qywY8BFXQhDHLeLXno8yWtWZkklJa7QyfWvmfCcv3rRyKZ7vl1lLjoHKzFK03/nwwzaLelImyZdbL4AVrZuPwUfk4zvTYOGjfBH+mmO2lDXQTDmVGICRiYyy89ulJZfv5B+YZLAChGt7z4j8Wj+cPRNtm22H23+HdQOEx/NY1Qxm7B5SNPd2buRKg3lkogZKT+nSIsI3M6xS+0yVlZteLpjS7a60pSUVyKNZEi4gpXORyQqH4rsTDSHtly4nTl9qJBFG1bEynlCyUm7/0vglPQcyFfneXgME+BgO+K0xiN65GzGn2RzGj+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSZPR01MB7964.jpnprd01.prod.outlook.com (2603:1096:604:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 07:43:27 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 07:43:27 +0000
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
Thread-Index: AQHY7dcmajbwNPvdXU24kSDwG4ldzq40LLkAgACPIMCAAJGDgIAChV7w
Date:   Thu, 10 Nov 2022 07:43:27 +0000
Message-ID: <TYAPR01MB63303EAD31EE074C950718478B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
 <afa849bf-e89b-0c48-6bf2-f7ca58940567@intel.com>
 <TYAPR01MB6330156C8B4F7A35290F44788B3F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <0e8d382f-7cf9-7987-548e-2ff8e2f10e92@intel.com>
In-Reply-To: <0e8d382f-7cf9-7987-548e-2ff8e2f10e92@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTEtMTBUMDc6MzY6?=
 =?utf-8?B?NTRaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD02YWZlYmM3MC0wY2FmLTQxNDEt?=
 =?utf-8?B?YjE3MC1lYjE1YzEzYzgzM2Q7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 3e4bdd6e17644ad1807491abd86aef34
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSZPR01MB7964:EE_
x-ms-office365-filtering-correlation-id: 5d2c1d74-8e38-4714-8434-08dac2ef415f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/6QM4rTJAZqebXMa8/aheafqCAK26M9hruOeU2TX924oyhwaph92wdZorF69Z6hVIPu3LU54pglbGQQHHlWzED0NgHdtIsjm/Mrvomfn3UWHqOyqWdN/S8TmLZqV7tAsV7r/l115lzYxTrWNGtjW98JmgLtB9EJMQac5/ROx/qcXpxQf45KAQujmyH+9STf3S5iZRVuFl9PVw+hGuEY51LdrqwjWFEdklqAD1Lxkn6vYlCCKpLOwh+6KaSjRTtsRZHqgYC4GtOghFhbE2QGJS6EQ3DCNezenYiy8KgVe88DOwWMUHPEQG88oze1aqna1VwGwF62ZHYJy9fxzNXXpus2GMABWi2550gBfe0OmocGJW7o1yfpzmJopv/0WIOyJkbEZAkBtLSYfKFCtpiXNSOdge6qmnjpwEPwoCjK7VcmkSNj2qQu9MrQZnpBVzj5dmTaXsVJFhfHLat5UbrPfCWsKVLmRPPHauN08694xe08S6catFpuCKakM2sa+gbD4atClvfPCUj+Wp1v0bEguyoPVy73e9SDK83fAvJwpeJtAS+k4f8BJrWAKRO0jiwNDgIfnPz2LRaqGoNSz6gRrvGrVjeMVgarbxeveHY0EreTqsqQulFZZIFlJFizrzqMcfRlSNJ1BNwCoQB6E2IUqA4cP4kpj/vAF41k7zc+Ka9z2iq/KgdNADoqVzVBD5rHXeC2Bw5CpkXh53j4RlaeV4lrmQr62zHava+ZXZHAS3XHtvESQwQfR6eS6RoaM6E4uoAFx3lc8y0yBVH0xi2JpXfb8l968BP2EEITrN5BCPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(1590799012)(33656002)(1580799009)(38100700002)(122000001)(52536014)(2906002)(38070700005)(82960400001)(186003)(86362001)(83380400001)(66946007)(66476007)(4326008)(76116006)(26005)(6506007)(7696005)(9686003)(53546011)(54906003)(110136005)(85182001)(8676002)(66556008)(64756008)(66446008)(316002)(71200400001)(55016003)(8936002)(41300700001)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHBzbi9NMWs3ekNWOHpqV0F1SGxTNXFURUZPbDB1ZXpVVUZiVWkyS1dJakVy?=
 =?utf-8?B?bDJBb0k3VUpObGlGVjRMQkY4N056VHZreGh0U1VCTFYzZU12aE96VEoxSU5W?=
 =?utf-8?B?Q2s4aEc2VExyRUcwaUFRKzg1Y2N0THRFbmVuMTRaVTNrQm5xc0tveEVqN0ha?=
 =?utf-8?B?QkovMEh5eGNUTTN1dzBTdHJXTVF2NnVVWU5RR1pnU1ByeElOZTFudXFMNGN3?=
 =?utf-8?B?KzdreStra0czUmx3b2NBWGx2ZzVvZW1TZUg1VE1JYStZRk1ObFhheVQxOVFy?=
 =?utf-8?B?Mnd4MkJiQXRYbW1uRFdZcWRFTmg5WVdOTURMbjYycjQwTXZVNVZWRWUwMkxa?=
 =?utf-8?B?SWhEQWpWdWVhRFc3MVRCQU8vVi9LYjdCNkMvSEdSd0FqMDFwZ1hkczFsclF5?=
 =?utf-8?B?ck9JMC94dk9lUFFYaWQ2cFNBTmdRWEhZa0gyNldCVVZPSVpwRE9SUG9vN2JF?=
 =?utf-8?B?Z3I2VXFuTm8wYitzOG94OWVId2xWeWNTa05sRGpZMmJyUmFJR3NjL3F0WTFZ?=
 =?utf-8?B?TU5xa2xweFF1elBrTkl1c3FvVFJBRW81bTdVZzJOaWdVSE81eDM5ZkRmSjBB?=
 =?utf-8?B?ZytDcGtEWEJQV3d6c0Z3WlcwalRQem9GbkdVOTlIWFZoUlFreGtqNTU1WlJw?=
 =?utf-8?B?d3ArRFhPU0Z6QVJRQW9nc0puUXZqbUR2N1J1M2tFVmlGS3UvOHVHQ0VTeUlh?=
 =?utf-8?B?ZDBvOFFzQ2kzSHZzRm9sQi80Z2N6OSthdStYdHYzYlcyZGtnc1ptWjUrN0Zh?=
 =?utf-8?B?dGhacm1FbHFDR0E5OHh3TklBeVNMdzlKdTJaa3NrTlpUR3puN1A4WDAzZW52?=
 =?utf-8?B?MEc5eWlqVGJUeHZmcjJCTDMrZW5wRFc0emJTeTFHb2lWQWNFSk9xQXk2cUFi?=
 =?utf-8?B?WE1yQ1FOVitmTDl5eWh2em1GVSt3WGZaSDU5bUVTejVYZUxQc3pJb1JFd09D?=
 =?utf-8?B?L3lvSEZGREs3eDluMS9oS1ZvVW4vWVRRbE01elJVVkFuMDVpZnpGMkRGemNE?=
 =?utf-8?B?eE1nOTlJQkJuV0VlTnhnTGZ6TGcvT0tGQzN3NjI2ODZtanRmL0J3T3MzcGw4?=
 =?utf-8?B?Wjh2L3o2RVc5U0VOc0hzR0QyWHpISnJ3N2NPNkFhS3BWcWh2REYrS0M2ZDF5?=
 =?utf-8?B?OXdJK2RyUUpmcGZNcHFtNlBoMFZwYjN4dVBZUnJGSTNGbVNxR3ZNOEF5Tzdi?=
 =?utf-8?B?dlhuYitoUEZienAvRGJiYnFnOEYxd1FCTzFBZFpTdnlUdVVpei9xN0tJczJJ?=
 =?utf-8?B?WUF5UVgzb1J5T0VLUXplV1VSUUx6TmJFc0tzYUtkdkhFMkdJSWFOWEhnbWY1?=
 =?utf-8?B?eS9FY3hld0w5RlFEQ0ZNRVFEenk0blJSZXdzTEorMjcwSUtZSlhuZ3UzUDlR?=
 =?utf-8?B?RWxGdVN3WkhjOVM4VkJWZXZ5VEs1R21SdFhpUWZNZXE2UlgvT3ZZNzI3aDE1?=
 =?utf-8?B?c0xQM3oxR3BpQ0ZWbitHbFkyN3ZmSTRzVWxRd1ZpUy9oMjdFMCt2QzNONkVT?=
 =?utf-8?B?MWtwbDh4Yy9QSTdaT0ZBUWprNUg3WU8ybnRLeHZ3VHh6bFB0bnkxUGxVLzZB?=
 =?utf-8?B?Mk5jeEpYWHRjSExLWUNQSUg1T3FOTWk2Wk5nN0UreFhPR215a1NMVStrSTl3?=
 =?utf-8?B?QWV4MmR4N04rRTg0bGljOTU3UjRQc3d5Mm9HK2xFL0x3cHppaG9sWGM1bVdI?=
 =?utf-8?B?YVI2L1hXYXJRRlNORHd5K3AvS1lPSHFOWHJMdjdLZms3dHF0cEUxZUhtT1Vq?=
 =?utf-8?B?T0hpdVpqb3EyWklaeUY4ZHdTRHN4Vi9ILzU1QWpQUnhyZ1B5VEFkeTFKYXhm?=
 =?utf-8?B?SUROdjRGbnRldmduRm9pMk45NzBPK2FmVTVRRzErZ2hrdytiM21IUU1WNUw3?=
 =?utf-8?B?VTlGcm9pY0sva1J1U0lIS3VhZ2dPK2NsOEFjd3dOTG5UdWF5Z2Vna2Myamxo?=
 =?utf-8?B?RnEzaWt0VDBtUXFjYTBWT256aDRzODJ1QlJyK2cxdUVabzhrQWM3SjNHaUh2?=
 =?utf-8?B?azVrT2huWldoRXpSRFp0aEZ6WWRQcklZR2R4UWduWUVJMUJOU1ZaVWdYaERi?=
 =?utf-8?B?Y0NKSWNwZ3UvVXJJSzhnazhxallDMkJJc1dCaG9KUE9vUjB6NVovU3BMY3lj?=
 =?utf-8?B?Q25UOGtMaDBYM0N2dWdDYzFTT1p0QTR4TFBNeWxFQWRTdVpSR0xITTJCRlZy?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2c1d74-8e38-4714-8434-08dac2ef415f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 07:43:27.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JdxiJvFIdtPOh6e2Cshw40gQqOh+hjSVNxxc28N1xaIeZb/qVIdzuJBdhBNatZXdR6+aJS7yrBg5UmmN4+7F4uMTV83D0KrstdaSPBCjjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7964
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gMTEvOC8yMDIyIDEyOjMyIEFNLCBTaGFvcGVuZyBUYW4gKEZ1
aml0c3UpIHdyb3RlOg0KPiA+IEhpIFNodWFoIGFuZCBSZWluZXR0ZSwNCj4gPg0KPiA+PiBPbiAx
MS8xLzIwMjIgMjo0MyBBTSwgU2hhb3BlbmcgVGFuIHdyb3RlOg0KPiA+Pj4gQmVmb3JlIGV4aXRp
bmcgZWFjaCB0ZXN0IGZ1bmN0aW9uKHJ1bl9jbXQvY2F0L21ibS9tYmFfdGVzdCgpKSwNCj4gPj4+
IHRlc3QgcmVzdWx0cygib2siLCJub3Qgb2siKSBhcmUgcHJpbnRlZCBieSBrc2Z0X3Rlc3RfcmVz
dWx0KCkgYW5kDQo+ID4+PiB0aGVuIHRlbXBvcmFyeSByZXN1bHQgZmlsZXMgYXJlIGNsZWFuZWQg
YnkgZnVuY3Rpb24NCj4gPj4+IGNtdC9jYXQvbWJtL21iYV90ZXN0X2NsZWFudXAoKS4NCj4gPj4+
IEhvd2V2ZXIsIGJlZm9yZSBydW5uaW5nIGtzZnRfdGVzdF9yZXN1bHQoKSwgZnVuY3Rpb24NCj4g
Pj4+IGNtdC9jYXQvbWJtL21iYV90ZXN0X2NsZWFudXAoKSBoYXMgYmVlbiBydW4gaW4gZWFjaCB0
ZXN0IGZ1bmN0aW9uIGFzDQo+ID4+PiBmb2xsb3dzOg0KPiA+Pj4gICAgY210X3Jlc2N0cmxfdmFs
KCkNCj4gPj4+ICAgIGNhdF9wZXJmX21pc3NfdmFsKCkNCj4gPj4+ICAgIG1iYV9zY2hlbWF0YV9j
aGFuZ2UoKQ0KPiA+Pj4gICAgbWJtX2J3X2NoYW5nZSgpDQo+ID4+Pg0KPiA+Pj4gUmVtb3ZlIGR1
cGxpY2F0ZSBjb2RlcyB0aGF0IGNsZWFyIGVhY2ggdGVzdCByZXN1bHQgZmlsZS4NCj4gPj4NCj4g
Pj4gVGhpcyBpc24ndCBtYWtpbmcgbXVjaCBzZW5zZSB0byBtZS4gUGxlYXNlIGluY2x1ZGUgdGVz
dCByZXBvcnQgYmVmb3JlDQo+ID4+IGFuZCBhZnRlciB0aGlzIGNoYW5nZSBpbiB0aGUgY2hhbmdl
IGxvZy4NCj4gPg0KPiA+IFdpdGggb3Igd2l0aG91dCB0aGlzIHBhdGNoLCB0aGVyZSBpcyBubyBl
ZmZlY3Qgb24gdGhlIHJlc3VsdCBtZXNzYWdlLg0KPiA+IFRoZXNlIGZ1bmN0aW9ucyB3ZXJlIGV4
ZWN1dGVkIHR3aWNlLCBpbiBicmllZiwgaXQgcnVucyBhcyBmb2xsb3dzOg0KPiA+ICAtIGNtdC9j
YXQvbWJtL21iYV90ZXN0X2NsZWFudXAoKQ0KPiA+ICAtIGtzZnRfdGVzdF9yZXN1bHQoKQ0KPiA+
ICAtIGNtdC9jYXQvbWJtL21iYV90ZXN0X2NsZWFudXAoKQ0KPiA+IFNvLCBJIGRlbGV0ZWQgb25j
ZS4NCj4gPg0KPiA+PiBGcm9tIHdoYXQgSSBjYW4gdGVsbCB0aGlzIHN0aWxsIHNlZW0gdG8gc3Vm
ZmVyIGZyb20gdGhlIHByb2JsZW0gd2hlcmUNCj4gPj4gdGhlIHRlc3QgZmlsZXMgbWF5IG5vdCBi
ZSBjbGVhbmVkLiBXaXRoIHRoZSByZW1vdmFsIG9mDQo+ID4+IG1ibV90ZXN0X2NsZWFudXAoKSB0
aGUgY2xlYW51cCBpcyBub3cgZXhwZWN0ZWQgdG8gYmUgZG9uZSBpbg0KPiBtYm1fYndfY2hhbmdl
KCkuDQo+ID4+DQo+ID4+IE5vdGUgdGhhdDoNCj4gPj4NCj4gPj4gbWJtX2J3X2NoYW5nZSgpDQo+
ID4+IHsNCj4gPj4gCS4uLg0KPiA+Pg0KPiA+PiAJcmV0ID0gcmVzY3RybF92YWwoYmVuY2htYXJr
X2NtZCwgJnBhcmFtKTsNCj4gPj4gCWlmIChyZXQpDQo+ID4+IAkJcmV0dXJuIHJldDsNCj4gPj4N
Cj4gPj4gCS8qIFRlc3QgcmVzdWx0cyBzdG9yZWQgaW4gZmlsZSAqLw0KPiA+Pg0KPiA+PiAJcmV0
ID0gY2hlY2tfcmVzdWx0cyhzcGFuKTsNCj4gPj4gCWlmIChyZXQpDQo+ID4+IAkJcmV0dXJuIHJl
dDsgPD09IFJldHVybiB3aXRob3V0IGNsZWFuaW5nIHRlc3QgcmVzdWx0IGZpbGUNCj4gPj4NCj4g
Pj4gCW1ibV90ZXN0X2NsZWFudXAoKTsgPD09IFRlc3QgcmVzdWx0IGZpbGUgY2xlYW5lZCBvbmx5
IHdoZW4gdGVzdA0KPiA+PiBwYXNzZWQuDQo+ID4+DQo+ID4+IAlyZXR1cm4gMDsNCj4gPj4gfQ0K
PiA+DQo+ID4gSSBpbnRlbmQgdG8gYXZvaWQgdGhpcyBwcm9ibGVtIHRocm91Z2ggdGhlIGZvbGxv
d2luZyBjb2Rlcy4NCj4gPg0KPiA+IG1ibV9id19jaGFuZ2UoKQ0KPiA+IHsNCj4gPiAgICAgICAg
IHJldCA9IHJlc2N0cmxfdmFsKGJlbmNobWFya19jbWQsICZwYXJhbSk7DQo+ID4gICAgICAgICBp
ZiAocmV0KQ0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAg
ICAgICBnb3RvIG91dDsNCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gY2hlY2tfcmVzdWx0cyhzcGFu
KTsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+DQo+ID4gK291dDoNCj4gPiAgICAg
ICAgIG1ibV90ZXN0X2NsZWFudXAoKTsNCj4gPg0KPiA+IC0gICAgICAgcmV0dXJuIDA7DQo+ID4g
KyAgICAgICByZXR1cm4gcmV0Ow0KPiA+IH0NCj4gPg0KPiANCj4gWWVzLCBldmVuIHRob3VnaCBm
aWxlIHJlbW92YWwgbWF5IG5vdyBlbmNvdW50ZXIgRU5PRU5UIHRoaXMgZG9lcyBzZWVtIHRoZQ0K
PiBtb3N0IHJvYnVzdCByb3V0ZSBhbmQgdGhlIHBvc3NpYmxlIGVycm9yIGlzIG9rIHNpbmNlIG1i
bV90ZXN0X2NsZWFudXAoKSBkb2VzDQo+IG5vdCBjaGVjayB0aGUgcmV0dXJuIGNvZGUuDQo+IENv
dWxkIHlvdSBwbGVhc2UgcmVwbGljYXRlIHRoaXMgcGF0dGVybiB0byB0aGUgb3RoZXIgZnVuY3Rp
b25zDQo+IChtYmFfc2NoZW1hdGFfY2hhbmdlKCkgYW5kIGNtdF9yZXNjdHJsX3ZhbCgpKSBhbHNv
Pw0KDQpUaGlzIGlzIGFuIGV4YW1wbGUgZm9yIE1CTSwgSSBpbnRlbmRlZCB0byByZXBsaWNhdGUg
dGhpcyBwYXR0ZXJuIHRvIG90aGVyIHRlc3RzLg0KDQpCZXN0IHJlZ2FyZCwNClNoYW9wZW5nIFRh
bg0K
