Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323BA434410
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 06:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhJTEMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 00:12:38 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:62163 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhJTEMi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 00:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634703024; x=1666239024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aVeOKE7fYcVXbzYGcdnlEuVbJoZsH/uERao2cYchtjU=;
  b=U1QzSj/1evptUddReT1YUSkUNZtwU6uqKbHZpxcMwDDL/Y6ylMC7n9HJ
   WYmgqEhWTplXJ7ZSObfYLP/UfsU3cSXT+P2E3xE5FikEouWREPA7AcO74
   RZbHgVTxnxw9ZPF6ioyoL7j95pZRwIF/aY3SFpWMM3j83olBJHOzhW+2+
   Nx/F5HLlnjGtTbhwzHYI5Xo96nZkkSykFq8YMe5h/D12nmvDzkx6ZhoAI
   EDsHC0m4q5eoVVx9AQ0oOEqAxCYAK+ErM8N//i2djPFYbFi2I0EfJ9ikE
   rMt11+25YZbVhjiyQrC9C4ErzwfyxT4ocL2sBjlfCNuU5hJpGPs/7J4lj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="41798946"
X-IronPort-AV: E=Sophos;i="5.87,165,1631545200"; 
   d="scan'208";a="41798946"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 13:10:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkByY318jB6nztibhXG9nb87PnToe1KMIs8GQomw7ct8ix4TOTIwtKO8TVmN3gbjxQhhZdUoY/qVA8qoDcR7zWBqX8Reg+gv6RHZZ/fHvBcl3naSZm3X832FBrGqIrbEKBcTEtmN6eBA1MCdiDO/jw+CwDyzFjsPQw/E+cHwFxThPXrY4USQkMq57FiH5uD0YOyXXtap2vLXDuJNHBCa5dearmPF2spNK9vl+Ak0CpKocnNk/8SYgyWryT2TjAlUKFWAFH+9quRLtG+J0eY8ooI0J2AGquyf18fmCseFtcuEMvIDiLlYbdkx1hTvNwtsfgQZy6U6Hsvd08WNj4h5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVeOKE7fYcVXbzYGcdnlEuVbJoZsH/uERao2cYchtjU=;
 b=L//K5YKSNM4Zc57JCJcKJXXQzTOJsk9Tf1nsPJR8c3nzqGkFHQmWv1aZT1A/Dzi8kw6ktW3EDv2AdSc8PP91nbALv/IuMAsgYYod17/x77wEXZrrx7TduatW2/SV7qwHkjHHcBTSiyrRC7ZNzNOH2630jcTKdF/lF/SeeeHKuEC4du77hiCRdddvy9/pEjBxcYjowSldrrvOl3B13U1/fBqR4sqyHsO9gcddrVdRK1/3fOsWzSjyHv05FlE9sEId8VFKAxv1xEfyLFKmNzXIH/O6HoWBewJ4m2o7DEoMGixFniR2EHVlvPJv3+eS32+3BXDrUHrhRv9amTEoKD9YTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVeOKE7fYcVXbzYGcdnlEuVbJoZsH/uERao2cYchtjU=;
 b=F1ncRTxNrcxH5MAQOyDIaAX3seSIE45Fkf8+wWH7HSJG7XRClVaQEKG0fFzHkAW9ZYWKztde4I9JbqAolqmoWcAoA6ahudZsePV3N85KUyg9y3l/SCfa/JPFlscRZjfpPl0oZtYUUgySY9UpsBwgc2SXdTI4lty0zhQaAkMm84I=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OS3PR01MB8684.jpnprd01.prod.outlook.com (2603:1096:604:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 04:10:17 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 04:10:17 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Thread-Topic: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Thread-Index: AQHXxCMJWVkx82teokaYK1L/EvEAdKvZlmkAgAGTaICAAAQJAIAABbgAgAAUsAA=
Date:   Wed, 20 Oct 2021 04:10:17 +0000
Message-ID: <9fde6ceb-aff6-2d3b-88ea-430b960a1428@fujitsu.com>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
 <20211018221636.47157e52@gandalf.local.home>
 <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
 <20211019223454.5da09d74@gandalf.local.home>
 <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
In-Reply-To: <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ed8763b-d804-4785-4390-08d9937f86a0
x-ms-traffictypediagnostic: OS3PR01MB8684:
x-microsoft-antispam-prvs: <OS3PR01MB86841A76DA5CF4396189A394A5BE9@OS3PR01MB8684.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AKutpFF49Dvmg3CuTXrVs3KZXnKVL1Ca9+oUxA4gZkyTgEMm56IcK35zg1gKZCRTv6lpllE/4vqDp9v02O1WXjZvTLA5+6EMAX9D1laowZDpeIfimng05IdY00wfRe2pg1Optxy/PxKfaUF5VcCNqsgni5MOb5YpDhgG5jbzp1gnCP5/MsutFx/UPGpEBgSUWzpqTM6Gh4caphV5wG5jBokTIDIQRmYuc5mfDAvNBrexpvy/wazDCMw1UypDeRveHpTcsNJjcU77F2t3RKE1Q9qKO1uk0+Y2QATcxrIv5wFcl8JFXMuwobOHV/KdO/BtZMJjAE9g5no1G9YpXJBiswUQ473YhvTKOiYCbiAVmeF0ekIc5fJ1WZQ3Ax4w0hCnYNrT+XpMxxFeMQ4bIAcE5BbFzzuNOFBbRxQSW1gThHfaWnGtEL2EeqLRYDvvVfhjKdrPRyKKae0Y8fLwYj5BJ/lTuyCzJBQLtA5viPFP1huduCverP5hx8SyQTfeuEj70F5mDATyMWoZRzo/N1X1/FezU7Mtzsk3jt2Z86W8d4kly50j4/twsxqf5pii37clXQ+LW3YXSu31u7nGou4KqJ7spf+zQ4hm0dwn2y7Uu6t/xpEh9xChJAtUcS0HuNMCOr4EJ6sGbfte+roEgt9XXUYOF6UdAF74YsaFB7KzzUCCzD4jp6nHbCImzmJqhJ3DvHoHWKT0iy2eZF8nVIlN++I2RkNSekNgHF7aR48pn9a8o//R4Gu53P3OnaEGjG+Dhx7Aw15mMxqNKe4TtVmqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(508600001)(85182001)(36756003)(316002)(5660300002)(8676002)(4326008)(2616005)(8936002)(38100700002)(122000001)(38070700005)(71200400001)(110136005)(54906003)(31686004)(86362001)(6512007)(6506007)(53546011)(82960400001)(66946007)(31696002)(64756008)(66556008)(91956017)(66446008)(6486002)(76116006)(66476007)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVByamNHT2g1UmE3U2JWVG1wZkt6NlVXOHRWeFkzYWU1WERFMlF4OWtIcXE1?=
 =?utf-8?B?VHZoTDFhWW5vUjBrbzVLWEpLRjRVZlc1Z1dFSnRkSlc1OTVrTWhIYWEzNkkz?=
 =?utf-8?B?bHVXWWVxSjN1UDBaWW9OTU93OGdzMnJuT25HMGxPYmxpa0JIMXBHcGx5cXJm?=
 =?utf-8?B?RjlaaDBjLzZwdjZ0R2JOcFY3ZFQvYjAwanc0Y20zb091ZUVXaFpYdmRMUUR4?=
 =?utf-8?B?czNjMk5JVHVDdXlkVEVZZ3REQXNjOUlvQmhkaERPU3NEZ3ZlMWdaZmI2R0tM?=
 =?utf-8?B?YmUxUnpScWxCQlhrMm5naDZYak9vOVpaanprUkxEWjIxWjVScjd2YUF6ZExu?=
 =?utf-8?B?cnNxZDZPMTVnMzNMSDZuSFBFbk56YWZtUnhvRUx4Q3hyS1ZIUk5nUkVXMGFP?=
 =?utf-8?B?MHZqTFFJVjBid3ZhNzdFY0s1UGVIRXVFQ3pqNGQxR05vQmJ1aFcvZ2YyTzVH?=
 =?utf-8?B?dHVCNUZveEx3SmRzT2ZwVW5kSjdicmdicXJIZHMyQUdtQVo3MVkrYXJvdGRN?=
 =?utf-8?B?Z1VEdGZaQ2M0UERpWjJ4UTIvL0RkeHdqdTB3Smp4ZmdER0J3UHQ0QmowNlNK?=
 =?utf-8?B?R1lpWnhLNmRCYkpvMk9SaHJtZ0NKUVluYktNMUV2ZGsrTjhsZ0NDU0xWemxB?=
 =?utf-8?B?MzJuMlg4Um9QTjM4RDFpY3VpeFV2dWRTSGlaU2ErUjJtemNsQTdnbkRGbW9i?=
 =?utf-8?B?TjlRbTRNNkhrOFVDSG4vcndranVaZmZMYVkyT1BIUWV3SGpYTE5GTW1hdlh1?=
 =?utf-8?B?RXJ4Ym1XZ0laZ3NDRklSTFl1R1hFbHVsU3JlZ0VxK1VjTEx0Y0kydTJDTDdm?=
 =?utf-8?B?emc4QW5OcHRJVFJ2Tm56ajk5bTNvaENtUVVCTUVMMHByUkJ3RmZEdjk1eno4?=
 =?utf-8?B?Mjh0RmZScXZRcXNscU9aRHVHeGMrNSswcC8xa0gwMXArVlY5UUJQbld5RGJt?=
 =?utf-8?B?WGJSYW1Iak9lRUV1QUxiUFJkcHRRY2FNL2QyMTJEV0dkUXNMOUFicEtqNkFV?=
 =?utf-8?B?RGc3dVZaS1c5UmFRdlR2Y25qVmloeEF1RHAreVVLTXhudmJPYUxCK0J4KzhJ?=
 =?utf-8?B?WVF0TTZ6MEgraC9IZTJXZXRmYjRxNm1UbUNWTDlPU2J2ZzNWLzlqUDBZUTdz?=
 =?utf-8?B?enR6Y2Y3c0x5UWxqL1MydzFnVU9nWnBNeVZ2MWFiT2FtQ1JjS1FkSVZBUVlE?=
 =?utf-8?B?U3pvOFU2QzNIcWpuY0JDS1crN3FMNCtIZkUzM1VtYXY3N2JYanhmY2d5d204?=
 =?utf-8?B?cmI1SVFGM1BjRWRiYjJ0L1M2eXFjYzhyYTMydEdoZ3psazJvMkgwbmxSNWgv?=
 =?utf-8?B?V1crL1NlZGRBZVFMUVVUaXdEbWNqTmlYYVo3aXovMkNhZXcxTllyZ0MzcGNj?=
 =?utf-8?B?Wml3ZVhZVkNqT0VhMGF3RTdobldPcjdvVi81dEtqMnNSOFMzNW5CTWY1R09Q?=
 =?utf-8?B?ZlFkY3FVWm1RcmlaUXBGVkNjMzFBL2ZvK3lINHJHRW9RWm5JM29mOUFGQTJN?=
 =?utf-8?B?SVVzYllEUFBPWVA2VzY3emxGSytVOE1tUHhvSkxMNjBObkVOdWtmWU1oTkdp?=
 =?utf-8?B?R0U2L1R4NDVtN2lZbkVwZ3VhT3kxU01jS3B4Sy8rbm9iUmFqMUE0WDRHMDVl?=
 =?utf-8?B?clBqS1NjbEthaXZKSWhTRENUN2RacTd6cDdJeGdzaGUwazk5UDZSblI5aHkz?=
 =?utf-8?B?QzYvbFdzektCaE1lVFFhTGVvbmpmSmFuQXZnTHVqNGJyT0dXcEZWbHZmSnBU?=
 =?utf-8?B?cDQwMGhRdHcreStzSDFMczA5WWk5dlgydjRGaHBHZ2dvMzZremFmdlhpUE1X?=
 =?utf-8?B?aDRmcVp5MnBqUXhvNGFLdmR6cDZ6SnNsbU5qb3pHcUlYeHd3Uk1TN2pHOHBI?=
 =?utf-8?B?ZUF1bE1tQlUySHMwUUtiRU5Bc1JCR0FEZDNsa2ZRNzNFSkJoMUUwVXVpZ3pi?=
 =?utf-8?Q?IFKgxPbmGJjiwN8LzWnPF22LF4tWeo9z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87EE9362AE4DA44CB3E8D79C20737342@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed8763b-d804-4785-4390-08d9937f86a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 04:10:17.7200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lizhijian@fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8684
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCk9uIDIwLzEwLzIwMjEgMTA6NTUsIE1hc2FtaSBIaXJhbWF0c3Ugd3JvdGU6DQo+IE9uIFR1
ZSwgMTkgT2N0IDIwMjEgMjI6MzQ6NTQgLTA0MDANCj4gU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRA
Z29vZG1pcy5vcmc+IHdyb3RlOg0KPg0KPj4gT24gV2VkLCAyMCBPY3QgMjAyMSAxMToyMDoyNyAr
MDkwMA0KPj4gTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pg0KPj4+IEhtbSwgYnkgdGhlIHdheSwgc2hvdWxkbid0IHdlIHNldCB0aGlzIGZlYXR1cmUgYnkg
ZGVmYXVsdD8NCj4+PiBUaGVyZSBhcmUgbWFueSAiY2F0IHRyYWNlIHwgZ3JlcCAuLi4iIHN0eWxl
IHRlc3QgY29kZSBpbiBmdHJhY2V0ZXN0IGp1c3QgZm9yDQo+Pj4gY2hlY2tpbmcgd2hldGhlciB0
aGUgZXZlbnQgaXMgcmVjb3JkZWQuIEF0IGxlYXN0IGZvciB0aGUgZnRyYWNldGVzdCwgaXQgc2hv
dWxkDQo+Pj4gYmUgc2V0IHVubGVzcyB0aGUgdGVzdGNhc2UgaXMgZXhwbGljaXRseSBkaXNhYmxl
IGl0Lg0KPj4gRm9yIHRlc3RpbmcsIHN1cmUuDQo+Pg0KPj4gSSB3YXMgY3JpdGljaXplZCBieSB0
aGUgQlBGIGZvbGtzIGFib3V0IHRyYWNpbmcgc3RvcHBpbmcgd2hlbiB0aGUgdHJhY2UNCj4+IGZp
bGUgd2FzIGJlaW5nIHJlYWQuIFNvIGZvciBub3JtYWwgb3BlcmF0aW9ucywgaXQgZG9lc24ndCBw
YXVzZSwgYmVjYXVzZQ0KPj4gdGhhdCAiY29uZnVzZXMiIHBlb3BsZSAoc28gSSBhbSB0b2xkKS4N
Cj4gT0ssIEkgZ290IGl0Lg0KPg0KPiBIZXJlIGlzIHRoZSBwYXRjaCB0byBlbmFibGUgaXQgYnkg
ZGVmYXVsdCBmb3IgZnRyYWNldGVzdCA6KQ0KPg0KPiBUaGFua3MhDQo+DQo+ICBGcm9tIDYxZTY0
MWY0OTQzMDdkOTk0MmE4NDE1YmM2NzQzZTg1ZGQ5NTQzOGUgTW9uIFNlcCAxNyAwMDowMDowMCAy
MDAxDQo+IEZyb206IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+IERh
dGU6IFdlZCwgMjAgT2N0IDIwMjEgMTE6NTA6MzUgKzA5MDANCj4gU3ViamVjdDogW1BBVENIXSBz
ZWxmdGVzdHMvZnRyYWNlOiBTdG9wIHRyYWNpbmcgd2hpbGUgcmVhZGluZyB0aGUgdHJhY2UgZmls
ZQ0KPiAgIGJ5IGRlZmF1bHQNCj4NCj4gU3RvcCB0cmFjaW5nIHdoaWxlIHJlYWRpbmcgdGhlIHRy
YWNlIGZpbGUgYnkgZGVmYXVsdCwgdG8gcHJldmVudA0KPiB0aGUgdGVzdCByZXN1bHRzIHdoaWxl
IGNoZWNraW5nIGl0IGFuZCB0byBhdm9pZCB0YWtpbmcgYSBsb25nIHRpbWUNCj4gdG8gY2hlY2sg
dGhlIHJlc3VsdC4NCj4gSWYgdGhlcmUgaXMgYW55IHRlc3RjYXNlIHdoaWNoIHdhbnRzIHRvIHRl
c3QgdGhlIHRyYWNpbmcgd2hpbGUgcmVhZGluZw0KPiB0aGUgdHJhY2UgZmlsZSwgcGxlYXNlIG92
ZXJyaWRlIHRoaXMgc2V0dGluZyBpbnNpZGUgdGhlIHRlc3QgY2FzZS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4NCg0KTEdUTS4NCg0K
VGVzdGVkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQpSZXBvcnRl
ZC1ieToga2VybmVsIHRlc3Qgcm9ib3Q8bGtwQGludGVsLmNvbT4NCg0KDQo+IC0tLQ0KPiAgIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnVuY3Rpb25zIHwgNiArKysrKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2Z1bmN0aW9ucyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnVuY3Rpb25zDQo+IGluZGV4IDAwMGZkMDVl
ODRiMS4uOGFkYzAxNDBkMDNmIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9mdHJhY2UvdGVzdC5kL2Z1bmN0aW9ucw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9mdHJhY2UvdGVzdC5kL2Z1bmN0aW9ucw0KPiBAQCAtMTI0LDYgKzEyNCwxMiBAQCBpbml0aWFs
aXplX2Z0cmFjZSgpIHsgIyBSZXNldCBmdHJhY2UgdG8gaW5pdGlhbC1zdGF0ZQ0KPiAgICAgICBb
IC1mIHVwcm9iZV9ldmVudHMgXSAmJiBlY2hvID4gdXByb2JlX2V2ZW50cw0KPiAgICAgICBbIC1m
IHN5bnRoZXRpY19ldmVudHMgXSAmJiBlY2hvID4gc3ludGhldGljX2V2ZW50cw0KPiAgICAgICBb
IC1mIHNuYXBzaG90IF0gJiYgZWNobyAwID4gc25hcHNob3QNCj4gKw0KPiArIyBTdG9wIHRyYWNp
bmcgd2hpbGUgcmVhZGluZyB0aGUgdHJhY2UgZmlsZSBieSBkZWZhdWx0LCB0byBwcmV2ZW50DQo+
ICsjIHRoZSB0ZXN0IHJlc3VsdHMgd2hpbGUgY2hlY2tpbmcgaXQgYW5kIHRvIGF2b2lkIHRha2lu
ZyBhIGxvbmcgdGltZQ0KPiArIyB0byBjaGVjayB0aGUgcmVzdWx0Lg0KPiArICAgIFsgLWYgb3B0
aW9ucy9wYXVzZS1vbi10cmFjZSBdICYmIGVjaG8gMSA+IG9wdGlvbnMvcGF1c2Utb24tdHJhY2UN
Cj4gKw0KPiAgICAgICBjbGVhcl90cmFjZQ0KPiAgICAgICBlbmFibGVfdHJhY2luZw0KPiAgIH0N
Cg==
