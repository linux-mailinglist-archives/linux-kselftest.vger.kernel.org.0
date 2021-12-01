Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713284644F3
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 03:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbhLACkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 21:40:24 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:51218 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346180AbhLACkT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 21:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638326219; x=1669862219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lEwYCBvEOMcHmUmKbS7HZzzO9onSY7T5m5q0Vk3BSWA=;
  b=sJfzu5tHDIWfcsPC5AzGYPZ5L2Omd0vOfWqcx/izYDgHaL/y6hF5vBK/
   Mh3gjkqnGoUeIiu5ZTf1XjyQKQW/UO2I6UEVjNSPVdRZ0NnXJwhwPVB7c
   TwwZCW01GyHPYFBaEWfXtCNouX9CnZm4lT1bh7ZIfOy+rKksiv2kPtW1P
   PX4nwEGluAaQzdm+2osdvrJ1Ija4y0jl4LV33yAe7VFIJ6YYYdK4I6L8I
   STCfUrwV2cl5oPG7wJC5eQTUl58gzYpJ65WRF3EB0L0/LwuWgruVnxr+H
   wNuNjiV446Bvhg+U0lakJ1lXCGj8TjXQvcHmEq+WsYzWKdIm7WLNqlH70
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="44870535"
X-IronPort-AV: E=Sophos;i="5.87,277,1631545200"; 
   d="scan'208";a="44870535"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:36:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUX3TKBXELsb3Inyp2ymy4EZhv1vBNlFTqJxP7BgDvJRrgRV9iK9cFiTbxAEmppP7RzOu1q9DEWWMWeBwx3Vl97IY1UDEOCL2FRdqBGY56B/ymgZnJdCACHld6BgBN1cFefIK04Rtswf694dDgv6oMrNHcfRHwR3qZLdGHJATTVVzHdT8DmYhZUecW1SxmOVnzeh25QdC7u+/lQm27XtizQXcJSN+UWHd1uE3NMeYuVSQlGIrbz0y8WVYgYU28KGyLF8qE/DaGaVWHbf2bdrnwcPkFXhGoV5keBhNRCUWFK9yVyKpz7okKT+y5xZxilOvFEdVbWhNr8m7hunrOCBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEwYCBvEOMcHmUmKbS7HZzzO9onSY7T5m5q0Vk3BSWA=;
 b=m7mUVfXWwc29pYDjtuDeVtIqusL6Lc5agJyPUCOmSLNnBjgvyIJksOButKQYCgSBeZWDXrhyZoJhJJA10zaIte5KGW92zLc0bUgkVlbdz3wGTTeRAbAv+U9r9mfk04MnbYcRHBPkqYI55oopL+1Zpr7ck0s7DEMZJ/FsGyw+WdU7Kh0rcvZRvdpEdWkUC+mSCZqzCsm159BbkrBNxazQlh3t2349hs8JGcPIcYTfK37Rmq6g1xJpJHY9m0v8x3Np2LhJH34Ek3LEHvkWCpyE5Sail8dOrUiIc4ZQPc6tdY2ShFAmaER/Qrn8wGx6gYDSar5C4HJaCkYP7bnfXB8iVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEwYCBvEOMcHmUmKbS7HZzzO9onSY7T5m5q0Vk3BSWA=;
 b=cfA22YNg1P/RreFzWD1yE/XMPUhhqo8pKI+cx39mjVXWdGBHvDzaJzil/Ak6rpUyqAVTHdNv03jHw6KRaJTHjNELHvN15k5K2MvMlNWio1XuafoMNCppvxm2+VQsxfNLS/OEnTTtMSHiABVh5fSr7tX/FZ8XY/GhNiDgJ8+6F6s=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYYPR01MB6990.jpnprd01.prod.outlook.com (2603:1096:400:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 02:36:52 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 02:36:52 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 2/3] selftests/resctrl: Return KSFT_SKIP(4) if resctrl
 filessystem is not supported or resctrl is not run as root
Thread-Topic: [PATCH 2/3] selftests/resctrl: Return KSFT_SKIP(4) if resctrl
 filessystem is not supported or resctrl is not run as root
Thread-Index: AQHX1hYXKOECrwtKoUyX3PcsxviheqwbAhWAgAICyeA=
Date:   Wed, 1 Dec 2021 02:36:51 +0000
Message-ID: <TYAPR01MB63303777416D1D3C0EF066278B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-3-tan.shaopeng@jp.fujitsu.com>
 <6b9ed425-cadb-15df-4c4f-eb1dc0b814dd@intel.com>
In-Reply-To: <6b9ed425-cadb-15df-4c4f-eb1dc0b814dd@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZTEyZDg1ZTEtNTRhMS00MzQ3LTllNDUtNjk0ZTk4ZjNi?=
 =?utf-8?B?ODlmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMi0wMVQwMjowOTo0OVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54b10e3f-3ad7-4ba0-9a87-08d9b4736eac
x-ms-traffictypediagnostic: TYYPR01MB6990:
x-microsoft-antispam-prvs: <TYYPR01MB6990280076D51BC19B459D528B689@TYYPR01MB6990.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5g+8jxWxgwZA7ocxkW536/AMJwa3vvH4hKuxOdQKaFiI53SejQoZLzcZSoF8kWZMRbkzgHc/mv05+kfOUCniZ/DZSroJN/pHPOATMfTC+qtZEpcDybqTqOU6PfCD4R+7Mpeaeyzq9MGGLRcGDIsLhV0Sg8j6VQLT2R6nITFXSG5Mkdk3e8MNkXCKhPzrO9GyhwHwxgPRjg9Pl5DEWf8QulX7ykCYiPeucx/GC39IEc2vm3pFgMycKYlZ8Jzn0xcsNlfreAOv9KOlDxT2iD6+KjM34c3UGxubLQGkPwCpCgklAzDpP+LRrleaEhvZLM0GfXYFDrpW95TsBFI1NyTxoRrBeR4da0qn5pfzDB20HcoJ59gDPu3hX3X836kTgo73Xdi1PV4aI93HkjiQODkaPsfPmO6LQf+GhegV7iDSlyycfoczT0rhwbjBS8+Z+5loSrdqzzfJ2fN+Akpzwi9QIsK69YzRB205mH4ECUu2AJRYc60N/+ooHrZY+LqaAlj5Z42zt+urs8gz/qn9Ctx+gYA2fBDM8Rm+lUsYbwUYmMqFID60lvW5WtrRElYj+TYnJIG3A8HhAr2nmw7r5h2sp7eAOEwme/Snc7GIdcjz08G89NPJKiIdct4q31mdull0NXUW2iFVh/vk3SVsy6kReeyM2J8niVwz7iS6Jud3Jms27XIrbglXxw+O+XotWdQRehc1tBsLPqKvrY9Pk0cL0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(26005)(122000001)(83380400001)(38070700005)(33656002)(7696005)(8936002)(5660300002)(6506007)(186003)(85182001)(9686003)(55016003)(2906002)(82960400001)(86362001)(66946007)(64756008)(110136005)(508600001)(53546011)(66446008)(316002)(66556008)(66476007)(8676002)(52536014)(71200400001)(38100700002)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVhVZnN1NVJqdnF5cklIWVRqWFJzNkRLY3VrVXNWZUp4S0ZnOW1hLzZXMzU5?=
 =?utf-8?B?YjluSkxpbW9HYUM1dEZjdWJMWElmMFk0bnBYVGVoK1F4SlJjb016SkRzOEMx?=
 =?utf-8?B?SVJiNGwwU1ZqTE9VcS8veUVLMXJxd05PTTRjYy83alU1dUxqQmRIdE9wdmVy?=
 =?utf-8?B?ZVorWXFjNmhJdi9STExIY0pqUWw3Zi9rWS9SVFNTL0tKYmUyeGQ2ckJHcmRl?=
 =?utf-8?B?WkQ2R2RTNzQ4VXRtK1lpODRVS04vNUo0TzBEL21VMXFGUGZHMy9wcGpPQ0pM?=
 =?utf-8?B?MjI1RkZKa2xXMUZrVVFZWmh0aU5haWxrd2w3Nll0QS9MaXErVlpTQ29sQUl5?=
 =?utf-8?B?Z1M5bytac3JYSTBmTUJMakswN1lVRlVoNEFYNUxtc0tEMXFRUkJCdXN2dmtq?=
 =?utf-8?B?bytyRkR2MTEyT1VJWG0rc3M4UGV3b1BVQjYyT2YxTFcxL29OME40cmVBNXEw?=
 =?utf-8?B?ZXRpQmh5ZnZ2aEFRdUdBUUdUMy91cEFyS1RlNi9qTk1vTHpTWGFCUEtBVW9w?=
 =?utf-8?B?WDV5ODlITVNvb20venk1U2h1L0diaUlWOFM3bkVaVVdvem16d1BwQmVnYzFR?=
 =?utf-8?B?RTNkbGhyREViUVRpL1cwS3g1Nk43Rmo3VlZHL3owWFhLUm10RHFvVVd6Wk80?=
 =?utf-8?B?cG5acWtEM3YwcEtobHZMaXFvL3A3bWVyK1RKSlhIbnc0MkhxbXNnZFhyRkVW?=
 =?utf-8?B?ZjdIRDlnbXBvTkFGWUcrWEpjRW96RlBTb08vWjlQY01XQVFndW5zcjAyVmFn?=
 =?utf-8?B?ZHNJTE83YWU5NXNZVjN6R0NWQlpaRkZsS1lFS0pzeXJpWnBYUDd4QmlnWm1s?=
 =?utf-8?B?MDU2S0MxRlRPQW5kZWEzdUROMjgxT2N4YkE5eVNtbjJIcm4wNWVyUHhBMUw3?=
 =?utf-8?B?UWRuazRzOU5TOFpiY0UxMmVYUXVNSUh0bjVIYVhya0RhS2kzdUdTa0ZoRVU3?=
 =?utf-8?B?NUhHYUpOZWpTWWRUNUp0MDYrcjk0VTRPSWUrMDN0dGJuVlBBM2VLUXBCMERu?=
 =?utf-8?B?VXlINDc5bUo1QWMrU0NxdWNsWGpyTDZnVGJYaTR4MW1SMllLWlY2N3p0WHNO?=
 =?utf-8?B?UHYwdHJWM1AwVms3bG5WSlJtbS9XMDVqdFR3aHZtR3Z4NHVqcDk4NS9PSS9N?=
 =?utf-8?B?dWZqYTg1QThId21zdHZKQmEwNlhPV1dxVEcwWEdHZTZIemdVL1QxMEdLYVBm?=
 =?utf-8?B?Z25BcWp3VGx2N2Rlb0VLKzVDVDl3WXV3NHgyOTA0cjRxVmt2YUNuUTlockt0?=
 =?utf-8?B?YmFEbnBlenU2cGQ0cTNhVjNWOWVLN2sxdFcwalIwYUU1bG5qN0ZLRWRDNlIv?=
 =?utf-8?B?S3A4YVBXT1hkNFJvdHE3OWt6SWhkUHFXU2RJYnVVbkg3eGZ5RFl5d2tKWUJ5?=
 =?utf-8?B?anZTOFBKMzJjcldlSDJhSllPclRZdUFXd283V2NtbURockl6Mk1ZSUN0K3p5?=
 =?utf-8?B?bE0vTjNZY00zMFNBVTNpUTEzY254cVNycHJEZ2NRM2VwV1hBVnRyMk9TaDNP?=
 =?utf-8?B?T0JXb0Z1UjdDSyt6OFM0aCtlbmlXVkpTQUVWSFNPb2c0ZEV2VmNwQmNMTVRH?=
 =?utf-8?B?Tjljd3FKM01WWDhmR1VMazl3cFkyNGRBNVlab3MvdEVXNFVQQThrSHJqTnF1?=
 =?utf-8?B?QkY3akdOMFI5L2dWRDJ6MFkvMncrdGNFWVdwVldLL3FrM2wvNjd0S2FPR2l2?=
 =?utf-8?B?d2tzSXRmbGFwa2VNN1Yyem5lNXI3Q1BlOTFCVW1qZnZCUjFLbitlZzhQZjRD?=
 =?utf-8?B?dWxqSmVtS1VHeEhvQmVYZFhLY2dMUGEydkVvenFpZ0NUQ21wQ3ZuRnFDY2dx?=
 =?utf-8?B?UjV6UmFlWjNoL2hpanZPaHZSZ3pzeFplZkx0Q2svVkFQcyszOFBFUnhYelNO?=
 =?utf-8?B?emFON25WcXpEbm5jUnVMT3RVbUY3M0VFRVJBUUF1NENtWnAvcDVCOVdiZzlv?=
 =?utf-8?B?QnBrT3M1Sk1pU3E1RHU1QWlWS0o3dHR4T284NDNkOWVLSzhPZ2pLYVBkcjVO?=
 =?utf-8?B?THZlOVNWMllMUnRuZndhMTB2dzVVNU96dThZbHpHU04wTWNFb2ovZzZQdjNI?=
 =?utf-8?B?bVR3eko4aWh6TzREWTJ0dWxIaXV0MUlQVGkyVFZtWi95Zzk1eFdMVmphUWxC?=
 =?utf-8?B?VXFheXByWGUybVArL3p6cnRWaFdDdS9wbStiU1BUMVdneGNYN25NSGVCdXdk?=
 =?utf-8?B?bXpVMi93ODZROUZndEowUnZJakJwa2tuRkRXL2Z2WEdQa2pQU2pZbXdQSjUr?=
 =?utf-8?B?OXhyTWJIbjZXL3VHeXQvQjlOQ0FRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b10e3f-3ad7-4ba0-9a87-08d9b4736eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 02:36:52.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gw7Cdv0S2HtiqmKnVsJ9xoRbWiLATm0YF9Dgwtyt92uJJEBA/pL90JDoUf4UTFc244u4ycsU01IRMANGhlF0KQaGboO7RQZqkxz3BYsyLXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6990
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUNCiANCj4gKHN1YmplY3QgbGluZSBhbmQgY29tbWl0IG1lc3NhZ2U6IGZpbGVz
c3lzdGVtIC0+IGZpbGUgc3lzdGVtKQ0KVGhhbmtzLg0KIA0KPiBPbiAxMS8xMC8yMDIxIDE6MzMg
QU0sIFNoYW9wZW5nIFRhbiB3cm90ZToNCj4gPiBGcm9tOiAiVGFuLCBTaGFvcGVuZyIgPHRhbi5z
aGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCj4gPg0KPiA+IFRvIHVuaWZ5IHRoZSByZXR1cm4gY29k
ZSBvZiByZXNjdHJsX3Rlc3RzIHdpdGggdGhlIHJldHVybiBjb2RlIG9mDQo+ID4gc2VsZnRlc3Qg
c2V0LCByZXR1cm4gS1NGVF9TS0lQICg0KSBpZiByZXNjdHJsIGZpbGVzc3lzdGVtIGlzIG5vdA0K
PiA+IHN1cHBvcnRlZCBvciByZXNjdHJsIGlzIG5vdCBydW4gYXMgcm9vdC4NCj4gDQo+IENvdWxk
IHlvdSBwbGVhc2UgZWxhYm9yYXRlIGhvdyBjaGFuZ2luZyBrc2Z0X2V4aXRfZmFpbF9tc2coKSB0
bw0KPiBrc2Z0X2V4aXRfc2tpcCgpIGFjY29tcGxpc2hlcyB0aGUgZ29hbCBvZiB1bmlmeWluZyB0
aGUgcmV0dXJuIGNvZGU/DQo+IFdoYXQgaXMgd3Jvbmcgd2l0aCB1c2luZyBrc2Z0X2V4aXRfZmFp
bF9tc2coKT8NCg0KSW4gc2VsZnRlc3QgZnJhbXdvcmssIA0KaWYgYSB0ZXN0IG5lZWQgcm9vdCBw
cml2aWxlZ2VzLCBidXQgaXQgaXMgcnVuIGFzIHVzZXIgcHJpdmlsZWdlcywNCnRoZSB0ZXN0IHJl
c3VsdCB3aWxsIGNvdW50ZWQgYXMgYSBTS0lQIGl0ZW0sIGluc3RlYWQgb2YgYSBGQUlMIGl0ZW0u
DQoNCkZvciBleGFtcGxlLCANCigxKXRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21xdWV1ZS9tcV9v
cGVuX3Rlc3RzLmMNCjI2NyAgICAgICAgIGlmIChnZXR1aWQoKSAhPSAwKSANCjI2OCAgICAgICAg
ICAgICAgICAga3NmdF9leGl0X3NraXAoIk5vdCBydW5uaW5nIGFzIHJvb3QsIGJ1dCBhbG1vc3Qg
YWxsIHRlc3RzICINCjI2OSAgICAgICAgICAgICAgICAgICAgICAgICAicmVxdWlyZSByb290IGlu
IG9yZGVyIHRvIG1vZGlmeVxuc3lzdGVtIHNldHRpbmdzLiAgIg0KMjcwICAgICAgICAgICAgICAg
ICAgICAgICAgICJFeGl0aW5nLlxuIik7IA0KDQooMil0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvdGVzdF9rbW9kLnNoDQogIDUga3NmdF9za2lwPTQNCiAgNiANCiAgNyBtc2c9InNraXAgYWxs
IHRlc3RzOiINCiAgOCBpZiBbICIkKGlkIC11KSIgIT0gIjAiIF07IHRoZW4NCiAgOSAgICAgICAg
IGVjaG8gJG1zZyBwbGVhc2UgcnVuIHRoaXMgYXMgcm9vdCA+JjINCiAxMCAgICAgICAgIGV4aXQg
JGtzZnRfc2tpcA0KIDExIGZpDQoNClJlZ2FyZHMsIA0KU2hhb3BlbmcgVGFuDQo=
