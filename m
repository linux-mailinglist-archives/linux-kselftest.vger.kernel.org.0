Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4249C386
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 07:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiAZGQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 01:16:02 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:58241 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235212AbiAZGQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 01:16:01 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 01:16:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643177761; x=1674713761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5r7oydULh2AKuLwO/N0v6Up+GZ8ujpxSIA/+DQQgMEM=;
  b=GyKcA6smHhE8Vl9XDzvz8a9GEXIl4dwjayaC57f8gHNS8oJYaV7+fZ9l
   YbPNOM0l0PVMiQV0Sgllw1YFqr4R5WNXpU+RPrZI2PHYtJp+QRX2+7LQD
   b0/lEHyaacjcSKSrIBhoJJ36Gu4U/QRQ919hK2U/HMCmw35v7jCaVhmTZ
   QMyGgLzsqb6yGIBkNvhY4qaPc+aocOPileA1pMFTNgAs7l8jklRT3rx2z
   NJJG7xubg01euXvCEtrOVn8np+7n5vEvAw1UiYrHjvQdCsGe7D+5VNZOf
   ROCCD3bFPpRqQyPbJGdvTkXa+gCzGmFkDr7DNAzJiZTWNYzJfQDb90uhd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="49396836"
X-IronPort-AV: E=Sophos;i="5.88,316,1635174000"; 
   d="scan'208";a="49396836"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 15:08:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9xNzLG4MD7qATqb3GHgBo0CBnnGF/tI5eL+LFcPI0yVdiYhpg3TlaJA1FGpeMo3pgU7JeAbwo4fsOy4zE3XhF9j+pZTYVspSl54OgCVeRbnejaalHSlf+GuS3M/zRV8zpC2VvsN/k2UCEi/DHVWbfuCsD69tcItSxXBvpm5cOwcfdzPpFzuyrjBHdFNZNu/ZtOXEoTlBM1TlMPBtt12bX/bWf5dpkSSkTcgOCSfdcZlsBU20Odi7UglfGSVurzbUjniltGa4xQI9k16GIAZ49PNvCvtw8OV030J0QbRRDJzXXHDHq8C5bWZgVEzgVDNDw8sMTHd3dfLusBPJ4ks9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5r7oydULh2AKuLwO/N0v6Up+GZ8ujpxSIA/+DQQgMEM=;
 b=jcM1fzzC03VRoQBFv4NFBvcfMWNQg0jJAAzpZK3su6/9c4U7vNAgWCzLKwaXcVE+oSE999GmH2mfhZvJJf0da7V5hIVxJLiSMxOear/ewcy4P9JHu7n2gt9y81TFIcX7aBcGbqoT0/0esC+bQIwY+wny4oexFxC6RYt1zzYmlwszFRZdC/s622Dxp28ii+1bpw7w0mAvBF6g6NHbmcZiQH1XT0eXfBGoCFuDrUPH3MXIcOQJJeVKmqtz3HnO+/HTKw5r652ypOCsYlRKjQCxcI5IjF3Yveb4qFb7vQ/jFc1crRaFyxn4x2bSxlpwPVy0W3doaXgo9/XeyW20vYmClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r7oydULh2AKuLwO/N0v6Up+GZ8ujpxSIA/+DQQgMEM=;
 b=pYzED4qcY2EwvhNBii9N3k1PlXtEHD24N++w/njwzZicjmFs8Iv1wby/OFjfQnm0M6u5cGhN5Sf6zuySiOXGaAOfzy133udA2yJ6+SqA1fzQAfL12f6W4jgY2Oxv/JAFO8IN6Q1l02JaPKDpgIWnbyfV17gpj5kxc0cSYeqQ9gg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8163.jpnprd01.prod.outlook.com (2603:1096:604:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 06:08:42 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 06:08:42 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "aleksei.kodanev@bell-sw.com" <aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH 2/3] selftests/zram01.sh: Fix compression ratio
 calculation
Thread-Topic: [PATCH 2/3] selftests/zram01.sh: Fix compression ratio
 calculation
Thread-Index: AQHX8ZoRazkvy8ml7UWBS3Z6InXCRax0c3uAgACf1AA=
Date:   Wed, 26 Jan 2022 06:08:42 +0000
Message-ID: <61F0E590.3080101@fujitsu.com>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639562171-4434-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <f80750cd-d2e8-cc57-37b6-cb4f770c61e2@linuxfoundation.org>
In-Reply-To: <f80750cd-d2e8-cc57-37b6-cb4f770c61e2@linuxfoundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07934152-ff9a-4437-8f8a-08d9e0924d9e
x-ms-traffictypediagnostic: OS3PR01MB8163:EE_
x-microsoft-antispam-prvs: <OS3PR01MB81637FDB7A17B0AE282D6837FD209@OS3PR01MB8163.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:270;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YiVgBrkzftIQX9/WKPOI+eOSK0LyIiU1b6l1tApBsw7Gjx1nPiki+XnJPfD2LjCk1grph5JfWcZzNn2ALbudZXpaF5fThTYLLs8nEoBH0Ofm+iLL7yJElNzC+aiVytnhToxqf/i46WQDha4ihO05WLau8Ul/ARrasg6Ot/5OedPs+qdrXoKXeQdmc/0zTAXqsRgBVbu3h2FGpNRCgrc5BsTgK3yZESoeBZn/Y41WvZ8YPs4iOybhO4Gc+fmJ5NE8/N5Sgdfzj0OBG3IUr+vCERBs2Oiv6nBJ8PwyrBPSGezojMQ6nUKHILQDsCrPCMj0mJDbzW6N5MRzVkLjC1LW0lR+Dr4TCD00ZGVD2qZv8dEg5h9TG791YyhWvPWv8P44eGK3m77jhnGhLsyT2EUl8pSvAhYngiHwFQf0VWACb8aQnYFC71Iri799/TWztVnxrIEbf/QA3iYKBFtzDkQHKVVCkCgSR3AkT5TQ0bUkv3NR7J9BdA2xmn3DLoFwPcP5fnrDsc0Nqs7tGG42Haaj6sRxhN//MTKj36OOUe23SXFBVF6zaaIlLNkRJfTEVrwSQolJybelPtXAYMR5AKWZGaLxZvPwD2aePMWc/x5ZQL0BrM79IG/JxkQ9ttDljIyplJxmk/Yxl6sKYaDRB+j82q+wITCQKuVFjWFt2KMULSS9j9zd56w5Hp8K3B0jJAkCaXxmsb13mDlS8tqqzJCVyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(53546011)(122000001)(87266011)(26005)(82960400001)(5660300002)(33656002)(85182001)(2906002)(36756003)(2616005)(186003)(71200400001)(8676002)(316002)(54906003)(86362001)(6916009)(91956017)(6486002)(4326008)(66946007)(38100700002)(508600001)(83380400001)(38070700005)(8936002)(64756008)(66446008)(66476007)(66556008)(76116006)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cURKS2JuaDJ0YzEwbzNhbStYS1NUZmNxOEk3a3lsZUp6R1hJQ3pHVE1TQTda?=
 =?utf-8?B?T2VkbWFZZS9sSG84SUlFOFJZb3NJV1VkOStpaEtLZEs0VVRWSGRBcmkvdG95?=
 =?utf-8?B?eExFU1h5RXd0TEpmMFpFMDNBQ2ZRYmF6eVFPY3ZZYmJCWjdBb245aHdPa0VG?=
 =?utf-8?B?RGRMVmkvSWI1dy9pSEZQL0JUeGFZb3Q3SUxoUkg5VGhaai9JSUE0SXlnMEkz?=
 =?utf-8?B?anp6ZjNlZXgwVFZkNmRQTDhaU3g5alkwYmRPNDY3OTM4WjdGNkJ1NGk3cWdu?=
 =?utf-8?B?bS9lTTlLWXNzMThVbm5ncVJFdkpFRmRmbjlaa2FRNStpekJTbzlza0JOS3Bu?=
 =?utf-8?B?WGNGWkRwWTFQcFVEaXBtdVJxT2J1aEk4NmpmemYxQlNQYWxWQnhOUGN4aCty?=
 =?utf-8?B?M2tsREliZEpudGo0QzdJNTVZRDgzdEJwaGNwY05VWDJOS2M5VVpXVXF4TDlM?=
 =?utf-8?B?UFMzeXF6S2l4QkNSMkw4U3lNdWJjZDJxM0cvU3NYOEdTdWlhMnE4bWF2Qnk4?=
 =?utf-8?B?TFBpVHZjZGNiZ0Q3SFpCVExRcDZleTN5UStnc2dkbk5ERWd2dHZGZ1VLQ0oz?=
 =?utf-8?B?S0xYL29zSHdTdUZ4aFhDcDZydXRHdTdZTkJoUG1vOVlKendZVWVTZVcrVlNJ?=
 =?utf-8?B?STlyd1p2bzRpcHF6UU0wY2lETktFM2hJQ2xwRktxM3BoMkNwYU5kWGNFMkox?=
 =?utf-8?B?Mmg4MWhCV2w1RTFxYmtTVlBaUjlDQmRaaFY0bUZSbTVPM2VLUmovdnNQZkdY?=
 =?utf-8?B?WWswNjhPYzFNbldhMzdYQjdUZjhuT08rRlo0Q2dJamhUWTNqNkI4c21ZdDVr?=
 =?utf-8?B?Z1dxL2ptSnkreWJlenVRQjZZS3k2UGR3and1S2hRWTFVRmxrdUVscCs4Rkts?=
 =?utf-8?B?aW5TL2RuR2lGWi8ycy9Ha20wTWNhMWhDZkRjalcxbUZtMlVDM1BzOXFBK1Fi?=
 =?utf-8?B?cE1OZ0RrOVRXU2FMMW1FTTdRcE5abGZCSVJNNEZaUTl1RjQvMlZCR1BqRHZv?=
 =?utf-8?B?Y1BPUHZGNzlyeFZyZUM2ZGdsM0pDbytjK0JQejZ1WFdneGFiMHVGRTZhTTNL?=
 =?utf-8?B?c1JmME9FY2h1VmJKRkYvcm9wVHpDVHB4UEpNOTgzakk5YS9CT3I2ZDBhWndF?=
 =?utf-8?B?ZkdKWFkraFUxQVVZR3IyWjc0Ukh2b3JVc3BYSVAvSE1EdkZ1NCtiSVRhMU16?=
 =?utf-8?B?WGVDeDhIN2lXK3h0am9EQVdHak9WN0ZESThTdkdkLzFtR0t0SXY3V2xEYmpj?=
 =?utf-8?B?bDd4a2gyTjRGb3NRWEU0aUV6WHdJQXo4TS85azRXQ1NLbWpSVjFtazlMdUY4?=
 =?utf-8?B?cWZhYVVSRlJXeXdsWFBYQXVXMEprT01ZQUJFQll0cU1VZHZTbGovQmdTRll3?=
 =?utf-8?B?blJmdzhjbndQcVM5cEFxZVdSVE1KTWNKU2hOblhKNHVJQ21lTlhVVld3dkpF?=
 =?utf-8?B?bGVSeE1KeGQ2blZoUXlDQkZJaFJoUFBHOVFxbzVJSnhhUWl4Q0RIRW1QVnJM?=
 =?utf-8?B?SVJnM0E0eStkTEtiVTRYNVl4SjVubmpBS0ZJMUh4OUM1Vk1rM2FKanRCQ1dx?=
 =?utf-8?B?ZFY1cFRzVm1sV3UrY1NLU1haeGtIeUpEZFp1cWZOU0hWZUdXNnhNVmlGM0NC?=
 =?utf-8?B?aVoyOHN6QnBGU2c2NlZNWXM0a01wZFhSK0R1dURmc3hmZjkvRnFPRzJEekUr?=
 =?utf-8?B?SjEvYXVNSno4UkhrZGxaVUg5ZVJBZnV2R2F3RzFwSTRpNER2VmFLazZwTWlR?=
 =?utf-8?B?eGFqK1FPVlVTM2RtTUZXT1JlcTlubjNwRHpDbnQ1Q055eUdpR09oaDBXbDJt?=
 =?utf-8?B?Y3JKNU5WRWdKSm9iOWxWRFMrSUVkRUZZem90Q3VaeTQrc1NKZW1aWmVnQ0l6?=
 =?utf-8?B?UW5PaFVqdmdNd296S2paOVJLZ0NETUJEcnpyUmtvUk9HYWIrTzVIeUIyVW11?=
 =?utf-8?B?cWdrMmthbFlpeGIrMkNrUzhMSW0za3VVVUY1d1NYL0lZNkZiQnNKekZwL1VP?=
 =?utf-8?B?cDlGeGgvSDFnRDhYSEViQy9HWEVmMC9BUkZhK3I3M21yYTZLV1hWOEgvVTc5?=
 =?utf-8?B?V3V1RHhyMmg5Rzg1KzFQVVRFTnNmM0tRaVVXSk5JMWJWY3dPbUF0Rk9LRzJl?=
 =?utf-8?B?THRvSURuZlRrQ0w5aU9wK25ySnlVdjVON0tSZ2FFY0p1eFpTWEJBc2JnbEtU?=
 =?utf-8?B?V3VEaWJEWWxhWmdUZjNVK3FOaXVqeGt2bXRVeUMwaG8yWm1rWVVLZHErY0hH?=
 =?utf-8?Q?oBlrDz17prPUjNpG+QSlUd8nx55w0uMOh8XBm6qgFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86F2580B976AD644A17D7198EF0D0C20@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07934152-ff9a-4437-8f8a-08d9e0924d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 06:08:42.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpwauhZ+5KwDYjCvdPEk8rpf10ZadXMSpWww5MyTEg8fyXxrY0zicoMfa6AC9Vpq03fuKufrxORUIjrWvIvggpEaSx0Sr6dFADpp12Q/F6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8163
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

b24gMjAyMi8xLzI2IDQ6MzcsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDEyLzE1LzIxIDI6NTYg
QU0sIFlhbmcgWHUgd3JvdGU6DQo+PiB6cmFtMDEgdXNlcyBgZnJlZSAtbWAgdG8gbWVhc3VyZSB6
cmFtIG1lbW9yeSB1c2FnZS4gVGhlIHJlc3VsdHMgYXJlDQo+PiBub25zZW5zZQ0KPj4gYmVjYXVz
ZSB0aGV5IGFyZSBwb2xsdXRlZCBieSBhbGwgcnVubmluZyBwcm9jZXNzZXMgb24gdGhlIHN5c3Rl
bS4NCj4+DQo+DQo+IEFyZSB0aGUgcmVzdWx0cyBpbmFjY3VyYXRlIG9yIGRvZXMgL3N5cy9ibG9j
ay96cmFtPGlkPi9tbV9zdGF0IGlzIGEgcXVpY2sNCj4gd2F5IHRvIGdldCB0aGUgaW5mb3JtYXRp
b24/DQpUaGUgImZyZWUgLW0iIHJlc3VsdCBpcyBpbmFjY3VyYXRlIGJlY2F1c2UgaXQgY2FjdWx0
ZWQgZ2xvYmFsIHN5c3RlbWQgDQpmcmVlIG1lbW9yeSBpbnN0ZWFkIG9mIHByb2Nlc3MgdGhhdCB1
c2VkIHpyYW0gZGV2aWNlLg0KDQpXZSBzaG91bGQgdXNlIG1tX3N0YXQgYXMgRG9jdW1lbnRhdGlv
bi9hZG1pbi1ndWlkZS9ibG9ja2Rldi96cmFtLnJzdCB3cm90ZToNCg0KRmlsZSAvc3lzL2Jsb2Nr
L3pyYW08aWQ+L21tX3N0YXQNCg0KVGhlIG1tX3N0YXQgZmlsZSByZXByZXNlbnRzIHRoZSBkZXZp
Y2UncyBtbSBzdGF0aXN0aWNzLiBJdCBjb25zaXN0cyBvZiBhIA0Kc2luZ2xlDQpsaW5lIG9mIHRl
eHQgYW5kIGNvbnRhaW5zIHRoZSBmb2xsb3dpbmcgc3RhdHMgc2VwYXJhdGVkIGJ5IHdoaXRlc3Bh
Y2U6DQoNCiAgPT09PT09PT09PT09PT09PSANCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgb3JpZ19kYXRhX3NpemUgICB1bmNv
bXByZXNzZWQgc2l6ZSBvZiBkYXRhIHN0b3JlZCBpbiB0aGlzIGRpc2suDQogICAgICAgICAgICAg
ICAgICAgVW5pdDogYnl0ZXMNCiAgY29tcHJfZGF0YV9zaXplICBjb21wcmVzc2VkIHNpemUgb2Yg
ZGF0YSBzdG9yZWQgaW4gdGhpcyBkaXNrDQogIG1lbV91c2VkX3RvdGFsICAgdGhlIGFtb3VudCBv
ZiBtZW1vcnkgYWxsb2NhdGVkIGZvciB0aGlzIGRpc2suIFRoaXMNCiAgICAgICAgICAgICAgICAg
ICBpbmNsdWRlcyBhbGxvY2F0b3IgZnJhZ21lbnRhdGlvbiBhbmQgbWV0YWRhdGENCj4NCj4gSW4g
YW55IGNhc2UsIHRoaXMgcGF0Y2ggYW5kIGFsbCAzIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgaGF2
ZToNCj4NCj4gV0FSTklORzogUG9zc2libGUgdW53cmFwcGVkIGNvbW1pdCBkZXNjcmlwdGlvbiAo
cHJlZmVyIGEgbWF4aW11bSA3NQ0KPiBjaGFycyBwZXIgbGluZSkNCj4NCj4gUGxlYXNlIHJ1biBj
aGVja3BhdGNoLnBsIGFuZCBjbGVhbiB0aGVzZSB1cC4NCk9rLCBXaWxsIGRvIGl0IGluIHYyLg0K
DQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCj4NCj4gdGhhbmtzLA0KPiAtLSBTaHVhaA0K
