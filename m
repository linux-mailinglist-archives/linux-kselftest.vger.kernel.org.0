Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB445469093
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 07:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhLFHB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 02:01:27 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:60898 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238108AbhLFHB1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 02:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638773879; x=1670309879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJFtc7T6bWaVvTtmMVCaESigQuzxN/M3XjZ69RMhVv0=;
  b=IPTI6LsA7eiLKkZIT83q/X4ImsdY1ppyudZEALkB8JT7DUeM6UJBm7DF
   W6MgzvO76nXU2QMQUvD05iYSjIxbcbNjswrsWc84vUOKtloMWMmqfMx0l
   t7YrHrmb3y59saTF8RKxEPd4oeCa+15WFYqTgKVnZoV+g6agwh/o/AdoQ
   C2FhqUhdFqy7xM2qBeaV1mlS3/5iIkkidCfoR1akvveHqq4EhUJInwAvo
   4q7BNyzCDuNbloK1X83sk6FcwytEm6Q3e2AP4/xFBZPN2JyADW/KdFpb3
   IVynTdxT2ZDjMznekMO/YI+jKlZWz/CXSxfBU+Y6aOG2Ih9A7pMWQYz1f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="45226702"
X-IronPort-AV: E=Sophos;i="5.87,290,1631545200"; 
   d="scan'208";a="45226702"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 15:57:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDKMhQJlzXEEqktPS1TtEiPi5RpSy+pbFgTJUEVOLiV7f7xLs2ovh5bMNoGjna2/rc7fPhQ/MFAGWmkHkX9rzEZ934PhuUg55BPcfT9BM35vB8dWXV28l6F3ZLu/NuuRaUBtFOwROrd+8F6EEN+CDvs33/2+G7jSScxuDpbihD0KFGVe4Be3q+Ezm/lK3/kG0F3xKQ6K7p/1CgigePara7F8+DWvjc1cJ73WUiiKD2+tuz8VHnTkyeyOeCrugNA9L/QKG9bcr2/e0/HRBNh6h7y2WxRFAdZDAea3Msb76M1RKIhseFLSHP4PZoFz+41WMdRUemZ1h3DqdwpG1k9pwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJFtc7T6bWaVvTtmMVCaESigQuzxN/M3XjZ69RMhVv0=;
 b=jBWU3LzMb/zo2RVkjWj01KwmxfddcdJE2bqtBZRBtmIMoHuh8GHBNd5MPaBIoBmjnXb24oWOrJxFePEYyzIFLtm6wi0W18iaEtQiap7pCKbzbK+CKEchMZaxg4mFe+rMOTfPgTEFsVo5uG5Hhbihf1p7dex1UGUbgBZz7EpmauCtthSe4SoSFYpyBX2K+w2hNVdtq2d4gos2Peo+LChfSoaifydXi/7ubomvlPNSa1el280IMEELdxEnP5AIVf7hSv1NHbCEMERjQnPMMWlDH7j7L+yHZeK4k8tKG8K/lklLM36db818VGOseN2ysK1ASyMH8qU3OFCXXBuMaEJ5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJFtc7T6bWaVvTtmMVCaESigQuzxN/M3XjZ69RMhVv0=;
 b=jraMwpRuSPqW3MZb+IyAOYofVsCRFPHteyA5Ya70OydafAnOC2CsOi7fbNnxLxfT1qAidQGS7pfxgyTZuFb4sQXH1H6dtHzFb93JNgZZZb9I9Uz4alATqgVMwc9i/rP1PJVu6ZAJt+Jlc357fGkIi2wXpCaNYpV+U4Q+HdZkKm0=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB4975.jpnprd01.prod.outlook.com (2603:1096:404:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 06:57:50 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::ad95:41d9:2c50:b83b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::ad95:41d9:2c50:b83b%3]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 06:57:50 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Topic: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Index: AQHX1hYQoRVeRbEkHEuvqUlW5Aw+wawbAh2AgAIEFrCAAXH5gIABl/cQgAF48wCAA51m0A==
Date:   Mon, 6 Dec 2021 06:57:50 +0000
Message-ID: <TYAPR01MB63309592B2B82329246319878B6D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
 <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
 <TYAPR01MB633090B5A9DE4480D12CC9268B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <6d4eb508-f551-4c12-2e15-34ab9b1dc49f@intel.com>
 <TYAPR01MB63304F1E1A04D48CA7632C658B6A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <e26efdc5-83f8-93e8-9aab-7e21ceb99254@intel.com>
In-Reply-To: <e26efdc5-83f8-93e8-9aab-7e21ceb99254@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MjUyYWVlMDctY2E3OC00M2VlLTg0MzMtNjU2ZDk4YWRj?=
 =?utf-8?B?YjBlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMi0wNlQwNjoyMDoxM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 628ef5af-87bc-4264-4585-08d9b885b7f4
x-ms-traffictypediagnostic: TYAPR01MB4975:EE_
x-microsoft-antispam-prvs: <TYAPR01MB49750BE6326F2DA6B5C6BE8D8B6D9@TYAPR01MB4975.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2y5Ci/7qPbs1F6YB2D9bWgNLCkhbPzmF0hFwGgnmNFzVss0Kt3CPtJ7Wlo8AwHvd9Mg2VQrCgjvIWqJDATfDHTZiHkywk/8EWvLO53eW+SalPQmhlCZ12HKgB3OlYAFaFId+kqQbxYR69gpJbRKBODGh0E+adPqfVOGye1SLVRznHutlL9t9VyNi/GKqQ6yDOh/etpdwFVAWBrqqVA/1RNuIwnbpioVaPEXKKfrTdpKjKArM6wwMRLdtPaVcf6ABrIz/Tpohh+mLVW2mb3FjgBvGuWg444POpdT6b6T1LddKEjBRHPmXzOkWq87WK44SGmDFvg0YGKVYJCi9AA7CFcv1IYU8ImIveZZn9oXKlL+DpvGF6qNVKD0MBYpUrlu+XDWbFLcfjWXfmYGHdegvctcwD2rUm/f302CjZ91R7KI4iKsTQtSyxFnv+BtckXZbNrNG6qnWlUSNRuu9GgzGtjdswDtsEiKF8y8VezKiy9KlLfzokuahFJjlo9JRI5ZTZlm/wLn45dGfKDeURFVwb+He6yhgkKWtNEBhZ0Yidt+rZtDaEqYCoUHVnoX5W4TM1wkFpIPC9xupfSxaDRPa9GXoJoFxSloyBURgPvK+S4Q8CYPfK+6TD2RdvuuY4sRJ3lt0xpp0pWimEX6+5S9uE54B2Fpk3zl+zJ1DMTJETHZ8srSn0aYd4YhAIiO+c7hOGqoNL/NV9tnAtOA0BiCZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(508600001)(53546011)(6506007)(186003)(26005)(71200400001)(85182001)(82960400001)(52536014)(86362001)(38070700005)(66946007)(122000001)(38100700002)(9686003)(83380400001)(316002)(54906003)(4326008)(8676002)(55016003)(7696005)(76116006)(66476007)(5660300002)(2906002)(66446008)(64756008)(6916009)(8936002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHA1VWtUUFVRakNiSGJBZjJRbVZBaC9zTERidENnUXFPOEVXSW12WVFISUFn?=
 =?utf-8?B?UzdacjFsUndValRWNHlNRFRyVExrUEJIK2pPZk5LU3ZlNTRuVGhkb2FXNldX?=
 =?utf-8?B?WHNhcTJMVlFxVnZqWUV5UkE2YVE5cm8wci9xaEZ5UWF3R0EyM1M1L0RuWVN2?=
 =?utf-8?B?SnhMOThlejg0OFB0V2V2Vk9ITS9uU1ZzZXYxaXdLY3BUSVdkK2xnbWVoOHNT?=
 =?utf-8?B?YWl6N053SnhTOEVoV2R6YW41bFJMbi9ZTC9HQTVOWm5zUHI5bGVtbktETGcz?=
 =?utf-8?B?VVBjODY3d3FlTGQyL0ZqeDRadjR1RVBKZXFiUXRkUmZiZk5RcGtlbERFSjNQ?=
 =?utf-8?B?UG5wbEUxblQwVDhsMTJrTXJFSEthRmUxMnRzSmZuMUxYR1M4bStpSzVrYVVz?=
 =?utf-8?B?ZFZ6UnA4VUpOU3ZCZWIzT0toeXQ3ZVdJZ3FabWZzRFRHTGNUV2c4aEtLRTlS?=
 =?utf-8?B?VWtKYlU1WHgyOG9MQTllNzJTei9PUUt6MEZFMnhrQmZkMTVJSzBZNjRnQXdS?=
 =?utf-8?B?QzIzSnVKN2Q3V0lCRUFCL1BNVWx4dTdvSENxUlhWNm1PaWpGdG9BU3NFRUho?=
 =?utf-8?B?eTdxUUNkVVVOempVdGI3OHZjdkdzWEdtWU1xWGZXbm9DMUlSa01WdGZxWExi?=
 =?utf-8?B?UmhTWjZENnc4bUpuZWNtZVhqazBjWFZlL2RWdXlWb09TaXVMbFBTYjNwdlM5?=
 =?utf-8?B?UU1EeU5TYldVRWVDZ1VaRGo3Zk1iV29hWC9PeVFhYUZOdmhhYzVPRmkyUnJX?=
 =?utf-8?B?ZDh1NDdtNjNsK2t3NldyeUk5SlRkNE5qRmlKaDhoLzRHZzBReGtyTEZwenVB?=
 =?utf-8?B?UkJHSU1BWmhxd3pjU1RPWDdoOVZnWHo4UURkdERON0xKS3hGMXl1bVZmOGFK?=
 =?utf-8?B?cFBzcFAxQ1JOSkhxQ2JPK3NQenZTN3N2REZpVE9EV3hCR3piMDR6NktuSUJn?=
 =?utf-8?B?VmNjT1d6RDk3VHlQMFphbW91VXRsMHFEVG8wdXM3Ry9KZktBbFRnQ3VueHYx?=
 =?utf-8?B?WmxZZGkwY3lnbE1STnpiVjc3Y1MrekthWkorN1dqd3p0cUFYMVJQR0REbFlO?=
 =?utf-8?B?ZVNMTk01WE5ucldMaEREU2JVeUNHeEFrMkc5Tit1WEtKUFZGcnJ0aHV0RGhl?=
 =?utf-8?B?VFF6emVlN1JoWURkeDJhUE9OZXh0SGNZNkZ1UHVWMS9NZHY4ZkRHMGdaMEFY?=
 =?utf-8?B?eGNZTE05elVzUEFXVkt0RzRVai9xVEwvalN2UnBoTVdxbmF4Nm81c1NoTTNL?=
 =?utf-8?B?bFlOazBoWUZucTBka3hTZDdvOXROUFBxbWpWYVlGYXowVCtES281TU1hNkNw?=
 =?utf-8?B?KytYT0R1TWdqbElpN1BBaVhydTJLSFliZlZxZFdINFc3aEVGaTVDcnBvV1Ju?=
 =?utf-8?B?STRldmc2dVREQUUrNUduYkN1V2lXMWptZXM0WkZLQ1RiOFQvS3hqdFhDSmhk?=
 =?utf-8?B?L2JYcmNjZXkwUEoweEp0MzlGL0xVd2J1Y2xWbEQwVmlNN0ZqUWN2RWtXZFox?=
 =?utf-8?B?VEhDbGs4VW1Edk1KN1Y4TjlqSXFvczE3VGFTcG5Pc3crN1IyNkE2NEE3Wk1q?=
 =?utf-8?B?a1Q1TDR1MnJaMG81VmJEdER2NFdNTHZwWEVmMiswMXhicjB5b3BpV1U3cWpL?=
 =?utf-8?B?YktxeUp4M0M3YzNZbGhXK3czS0cydkJHWFZWQ2cxL0ZnWGdoQytLOVl2RmYx?=
 =?utf-8?B?aXRza2RUZ25EcU93dU43eG54bXRpMkg5bVVJTEsyRVZKZ1k2ZFhWaXNScU5H?=
 =?utf-8?B?c3dmODVuOXRqS3g5b0pacTYyRGFLU2h4dFFsMUpTUEF4aU5zOWNQbXlxYVVN?=
 =?utf-8?B?OUdnOFlMeGNjQU8vSGk0RGRiLzJreTJRTnJVWU5EVkpvazJvc2JnbGlINDZj?=
 =?utf-8?B?bzZRUnJZVXA0Q3JQaWxOeVcxWXpFT2ptcTdISXd2cWhUOEtjTUwxa0JCNDhN?=
 =?utf-8?B?bzFqbHpXam1nMnJTcmhkR2l1RmJMK29MQWpyMzlINWZLZGRjMjY3SzZac0JD?=
 =?utf-8?B?aVVPR2NHSzFMN0Y2VzhrNll5ZVNWZ0U2bmd5L0tIUTdVRUF0ZUl4S2lqNzlJ?=
 =?utf-8?B?Q05UcTNPQVRXQXAycytPRUJURFVzNlJ2VDdwWXN0Ny9RQUNNVGYxVGJZMENr?=
 =?utf-8?B?UjEvY0FSbVY1bkZ5VmNMWG1HMFExMFpMc1hrZGFqa2IvTzNiTm5JZVB3TWFQ?=
 =?utf-8?B?Tnc3ckVla1pxRko3RlJ2QUk2QlZ6OUZuR2tRZnQrSFY4SW5zU2QycDFYczU4?=
 =?utf-8?B?MUZtOW02ZDlZUzdZeGFvSzJ4Ym1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628ef5af-87bc-4264-4585-08d9b885b7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 06:57:50.5411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfUAgYaYGxvJR8bjfcUVgU4CsFasi1oevQ0SMMsAsJaU15VGVz2t8Wur8WcRCgVm5mU+2VgamdAEElrC2V7zCeYJJXEVTArpU1FDxrr8BFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4975
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQogDQo+IE9uIDEyLzIvMjAyMSAxMToyMSBQTSwgdGFuLnNoYW9wZW5nQGZ1
aml0c3UuY29tIHdyb3RlOg0KPiA+PiBPbiAxMS8zMC8yMDIxIDY6MzYgUE0sIHRhbi5zaGFvcGVu
Z0BmdWppdHN1LmNvbSB3cm90ZToNCj4gPj4+PiBPbiAxMS8xMC8yMDIxIDE6MzMgQU0sIFNoYW9w
ZW5nIFRhbiB3cm90ZToNCj4gPj4+Pj4gRnJvbTogIlRhbiwgU2hhb3BlbmciIDx0YW4uc2hhb3Bl
bmdAanAuZnVqaXRzdS5jb20+DQo+IA0KPiA+Pj4+PiBUbyBlbnN1cmUgdGhlIHJlc2N0cmxfdGVz
dHMgZmluaXNoIGluIGxpbWl0ZWQgdGltZSwgdGhpcyBjb21taXQNCj4gPj4+Pj4gY2hhbmdlZCB0
aGUgZGVmYXVsdCBsaW1pdGVkIHRpbWUoNDVzKSB0byAxMjAgc2Vjb25kcyBmb3INCj4gPj4+Pj4g
cmVzY3RybF90ZXN0cyBieSBhZGRpbmcgInNldHRpbmciIGZpbGUuDQo+ID4+Pj4NCj4gPj4+PiBI
b3cgaXMgY2hhbmdpbmcgdGhlIHRpbWVvdXQgcmVsYXRlZCB0byB0aGUgcmVzY3RybCBmcmFtZXdv
cmsgY2hhbmdlcz8NCj4gPj4+PiBJcyBpdCBub3QgYSBzZXBhcmF0ZSBjaGFuZ2U/DQo+ID4+Pg0K
PiA+Pj4gSW4gc2VsZnRlc3QgZnJhbXdvcmssIHRoZSBkZWZhdWx0IGxpbWl0ZWQgdGltZSBvZiBh
bGwgdGVzdHMgaXMgNDUNCj4gPj4+IHNlY29uZHMgd2hpY2ggaXMgc3BlY2lmaWVkIGJ5IGNvbW1v
biBmaWxlDQo+ID4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9ydW5uZXIuc2gu
DQo+ID4+PiBFYWNoIHRlc3QgY2FuIGNoYW5nZSB0aGUgbGltaXRlZCB0aW1lIGluZGl2aWR1YWxs
eSBieSBhZGRpbmcgYSAic2V0dGluZyINCj4gPj4+IGZpbGUgaW50byBpdHMgb3duIGRpcmVjdG9y
eS4gSSBjaGFuZ2VkIHRoZSBsaW1pdGVkIHRpbWUgb2YgcmVzY3RybA0KPiA+Pj4gdG8xMjBzIGJl
Y2F1c2UgNDVzIHdhcyBub3QgZW5vdWdoIGluIG15IGVudmlyb25tZW50Lg0KPiA+Pg0KPiA+PiBV
bmRlcnN0b29kLiBNeSBxdWVzdGlvbiB3YXMgaWYgdGhpcyBjYW4gYmUgYSBzZXBhcmF0ZSBjaGFu
Z2Ugd2l0aCBpdHMNCj4gPj4gb3duIHBhdGNoPyBJdCBzZWVtcyB0byBtZSB0aGF0IHRoaXMgZGVz
ZXJ2ZXMgaXRzIG93biBwYXRjaCAuLi4gYnV0DQo+ID4+IGFjdHVhbGx5IGl0IGFsc28gcmFpc2Vz
IGFuIGltcG9ydGFudCBpc3N1ZSB0aGF0IHRoZSByZXNjdHJsIHRlc3RzIGFyZSB0YWtpbmcgYQ0K
PiBsb25nIHRpbWUuDQo+ID4+DQo+ID4+IEkgZG8gc2VlIGEgcnVsZSBmb3IgdGVzdHMgaW4gRG9j
dW1lbnRhdGlvbi9kZXYtdG9vbHMva3NlbGZ0ZXN0LnJzdDoNCj4gPj4gIkRvbid0IHRha2UgdG9v
IGxvbmciLiBUaGlzIG1heSBiZSBhIG1vdGl2YXRpb24gX25vdF8gdG8gaW5jbHVkZSB0aGUNCj4g
Pj4gcmVzY3RybCB0ZXN0cyBpbiB0aGUgcmVndWxhciBrc2VsZnRlc3QgdGFyZ2V0cyBiZWNhdXNl
IHdoZW4gYSB1c2VyDQo+ID4+IHdhbnRzIHRvIHJ1biBhbGwgdGVzdHMgb24gYSBzeXN0ZW0gaXQg
bmVlZHMgdG8gYmUgcXVpY2sgYW5kIHRoZSByZXNjdHJsIHRlc3RzDQo+IGFyZSBub3QgcXVpY2su
DQo+ID4NCj4gPiBJIHRoaW5rIDEyMHMgaXMgbm90IGxvbmcsIHRoZXJlIGFyZSA2IHRlc3RzIHdp
dGggYSBsaW1pdGVkIHRpbWUgb3Zlcg0KPiA+IDEyMHMsIGZvciBleGFtcGxlLCB0aGUgbGltaXRl
ZCB0aW1lIG9mIG5ldCB0ZXN0IGlzIHNldCAzMDBzLg0KPiANCj4gSSBhbSBub3QgZmFtaWxpYXIg
d2l0aCB0aGUgc3BlY2lmaWMga3NlbGZ0ZXN0IHJlcXVpcmVtZW50cyBpbiB0aGlzIHJlZ2FyZCBi
dXQgdGhlDQo+IHRlc3QgZHVyYXRpb24gaXMgc3VyZWx5IHNvbWV0aGluZyB0aGF0IG5lZWRzIHRv
IGJlIGtlcHQgaW4gbWluZC4gQ29uc2lkZXIgdGhlDQo+IHN5c3RlbXMgcGVyZm9ybWluZyBpbnRl
Z3JhdGlvbiB0ZXN0aW5nIG9uIGtlcm5lbHMgZXZlcnl3aGVyZSAtIHJ1bm5pbmcgdGhlDQo+IGtz
ZWxmdGVzdCBmcmFtZXdvcmsgaXMgYSByZWFzb25hYmxlIHRoaW5nIHRvIGRvIGFuZCB0ZXN0IGRl
bGF5cyB0aGF0IG1heSBzZWVtDQo+IHBhbGF0YWJsZSBvbiBhbiBpbmRpdmlkdWFsIHJ1biBtYXkg
bm90IGJlIGFwcHJvcHJpYXRlIGZvciBhbGwgdGVzdA0KPiBpbmZyYXN0cnVjdHVyZXMuDQo+IA0K
PiBOZWVkaW5nIHRvIGFsbW9zdCB0cmlwbGUgdGhlIG5lZWRlZCB0aW1lIGZyb20gdGhlIGRlZmF1
bHQgdGltZSBpcyBhIHJlZCBmbGFnIGFuZA0KPiByZWFsbHkgZGVzZXJ2ZXMgdG8gYmUgaW4gaXRz
IG93biBwYXRjaCB3aXRoIGEgbW90aXZhdGlvbi4gSSB3b3VsZCBhbHNvDQo+IHJlY29tbWVuZCBo
aWdobGlnaHRpbmcgdGhpcyBjaGFuZ2UgaW4gdGhlIGNvdmVyIGxldHRlci4gVGhpcyB3aWxsIGJy
aW5nIHRoZSBpc3N1ZQ0KPiB0byB0aGUgYXR0ZW50aW9uIG9mIHRoZSBrc2VsZnRlc3QgYXVkaWVu
Y2Ugd2hvIHdpbGwgcHJvdmlkZSBhIGJldHRlciBpbmZvcm1lZA0KPiBvcGluaW9uICh3aGV0aGVy
IHRoZXkgd2FudCBhIGxvbmcgcnVubmluZyB0ZXN0IGFzIHBhcnQgb2YgdGhlIGRlZmF1bHQgZnJh
bWV3b3JrDQo+IG9yIG5vdCkuDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQpJIHdpbGwgc2Vw
YXJhdGUgdGhlIHBhcnQgYWJvdXQgZGVmYXVsdCBsaW1pdGVkIHRpbWUgdG8gYSBuZXcgcGF0Y2gu
DQpJbiBvcmRlciB0byBnZXQgc29tZSBvcGluaW9ucyBhYm91dCBjaGFuZ2UgZGVmYXVsdCBsaW1p
dGVkIHRpbWUsDQpJIHdpbGwgYWRkIGEgZGVzY3JpcHRpb24gaW4gdGhlIGNvdmVyIGxldHRlciwN
CndoZW4gcG9zdGluZyB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMs
DQpTaGFvcGVuZyBUYW4NCg==
