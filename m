Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCA44FF28
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 08:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhKOHWQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 02:22:16 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:6849 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhKOHWK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 02:22:10 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 02:22:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636960756; x=1668496756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vdvhIK6vj1IwCRo9Xan8zwOnKzSunx+29UBp898rKM=;
  b=Y3ktnEq6A+5Ll3Z3xGccEnDMPXlPJmp9622Z0Zrkb4rgV+kjjPSXdNdV
   xSkvaMDKeDUbf5FoYatzW9DOVdPvK7vG+keXSaCBCqIpmJ2I4dYT7+4gg
   NCjWqfUv6LJrxZnocjvw6oo1Zf1PN9OXQKBVI+2Ui3xfHRWODA6of9epf
   G8W7DhnIKrG2pHAekZBrzvrc6DH4fJLM5AygEzZ7T1RyOcL/DdOucWFcA
   KsBxOuAxHiACIx1VZfcH339EF3FBBFJbmzj5QX7GdFjWGjAPXIadoyRAv
   AtAX1Xyh9MC1fNT0B6agSjWV7J3gFi5h6WKGboqqHc3qcvorrtqqrjQxU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="43629121"
X-IronPort-AV: E=Sophos;i="5.87,235,1631545200"; 
   d="scan'208";a="43629121"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:11:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFBMa23mOpu/apSbZonizNkHEiMQ6GVBE0EBMy5gDWolriczBkgCilxB3L0Vk5QlkiMQWiDH9xBOsKZ3mzA486HXaMWTC+pfnUvKa9DIctu4mMaIlqRi5gXaMGb7lVv1RzseZkIapvgpSONEiGksOMRYlUUCPo7eoYsgdZTFykP/D62jYMwo83GzqkMaWaSxMBMtGt92+AZB13nvquswTnLnhznkCVqnx8o4sQA+5UjQYZwAVeZynzVoxTDQ/MlpBeV4gExb7Upy4MrtqRIFED2LYZbunAikQcHk+4A4EsWJtKNGx9F10oyjuB/M3nqDt8jg+OGH7lmOEszxQF6PGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vdvhIK6vj1IwCRo9Xan8zwOnKzSunx+29UBp898rKM=;
 b=T28tE62WOEx4yLpsH2DiF9NPCPLkEHutaeQrlS/mYvPypftShMHc/eOpRYPqWe07402I6goakxGrBpnkrcMhERfqIgyiSOm5DgrfTUN55xX69K5fO98uQx9auCkRSu79twZKBR/yoTWjzRpetAlH7NEYCZExNe7brpjfFHBkU59nqmd7ioKtZVQeYKwr9APU4PPDgpneUOg2HE8laj1hcetp4CD6JcWf9b6Acr5N/cGI1ws8hXuY/zn0gv7KSpFzhvX9rf07bheVRtfa4VwXNRU/LXACnfVAlvNjGTM2h3uMVUrr489MwdRYaeIunCOqEDCANHlJ2sQkXHWfyCeTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vdvhIK6vj1IwCRo9Xan8zwOnKzSunx+29UBp898rKM=;
 b=Q8byufg3LHu1Lrn99wvbzDRm5uPJAS/s6KOsO12aja7d/Uzg0rX6QSeJg6Jj8ususlT4mWULl+WNUM+T+u27s+DhSQruupnAGhEqXG+vxoQ0mobehF1pJ2p0mmDeLgBke0N1GT1XYPqBYIdfdZUCA8NGz2qzyYC+BTijA5yjNrA=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB4921.jpnprd01.prod.outlook.com (2603:1096:404:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 07:11:34 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 07:11:34 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] selftests/resctrl: Skip MBM&CMT tests when Intel Sub-NUMA
Thread-Topic: [PATCH] selftests/resctrl: Skip MBM&CMT tests when Intel
 Sub-NUMA
Thread-Index: AQHX1gzvPrGEnxUS7EChQ1OBQ/zSUqwAMjmAgAP/wPA=
Date:   Mon, 15 Nov 2021 07:11:34 +0000
Message-ID: <TYAPR01MB63300DC31AFB0013808FC7948B989@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211110082734.3184985-1-tan.shaopeng@jp.fujitsu.com>
 <c23356c7-3af7-0aba-18b6-2e53ce18a164@intel.com>
In-Reply-To: <c23356c7-3af7-0aba-18b6-2e53ce18a164@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YjJlNWI2MzUtOGVhMy00NTAxLTk3NGEtMjQ2NDczOTMx?=
 =?utf-8?B?MDMyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0xNVQwNzowNDozMVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad8f5b22-88d0-41ea-60f3-08d9a807282e
x-ms-traffictypediagnostic: TY2PR01MB4921:
x-microsoft-antispam-prvs: <TY2PR01MB4921B9289ECF4815070C803C8B989@TY2PR01MB4921.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwuDz9/BqCFbc00P41fB/3Y+Xb0/U3JOgDeyCyUpziiJbAm3e+RN1DHjnXO2DY2O9RUH9gRoBR0ET4yWkMaJ6Wv1GLxFvF0LoRQSBCUAVy8hTn6UYlS+f87X6cypzQ+re67Pm6rlYQFt3AHmeu+n54chibhQ/cLvBWO1BKY51phJZh2AUXrvvv3dnQpI70moHXpmsIclf3av/vbUVjLuYeRtNs5iofsmOsgd2AXUJFUiDtPysUWVO2/KNPhkju7kCyPxeOnMXBmFKPbm0j4HTxnZiWrWZcULBIBQph0YHe0xVD/N+V00IFZYe2+CVosQ5iPQjCROTDcb+2UZjyMj+afzubhs0PKs3VG868q7Xs4l4zuIOt16t5Wk7MyJjyJOxxqd10Y6wZG5/V6ElhlVklXatNyFqxW5fYdlVSCo0Zt2LKnSyuF1Wx+Xs58aZUE3g9umy6DPrm7atwJb2nfzsqiq9aRTen9jqJFVXIgjx/pZCPmsMOw71cMSvKvTP54PW/RuUg5dO7Qcp5DVO5eYVuLDqCFBmJ5zFAKXi7UzTHb5637eVeste6fCeKDoFXv6fADJ3Eljfd+2fo7tzFmnl1l5H/yAJwtWKFMbOBkfLTmW9fk4Fr7aHStGuhQCW4jQUpML/cOuQz921F3KK0qkD5c5F731wnrmj59KRPNzpEyMNEU/SwcKl2YaxdFnYUgBH5x3Ba55jVgZCODVn/+/ILdroyP/Hht2xNXH4GH9kZcXkJzYSoFYb5o+km4J39/B7RtbnFwxXkxL4iRyslvktJTO7MfV5D4hzfrumW87wV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(85182001)(52536014)(76116006)(508600001)(6506007)(53546011)(316002)(5660300002)(2906002)(110136005)(71200400001)(82960400001)(66446008)(66476007)(64756008)(54906003)(66556008)(8676002)(66946007)(55016002)(38100700002)(83380400001)(966005)(33656002)(122000001)(9686003)(4326008)(186003)(86362001)(8936002)(38070700005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS9PWUVCSndpRkwwaGxveTlYQTdRRWt0Y3BubnNTNzF3WEZvY3Z1emR5REFk?=
 =?utf-8?B?WS8vdmJpRGU0QzEvc21pRVkvNlJtbXNoN1BxYTI0c0NnYWl1K0FnU0k4WVJC?=
 =?utf-8?B?Q3ROUzV4eVFMOXhFejhmNjdQNnJMbnBPRE1xUFF3aEF2Z0FpUjVlTnpCSXdh?=
 =?utf-8?B?YUM1MU42NFAxb0NJTGhHdGJZMnIvaFgxY3Y0NXd0T25MY0pObnRTTkZ0ejhR?=
 =?utf-8?B?Yk5ESklEejdsbjNDOHJmSGRvR255K3B5ZHRrNmRuaktqVGh0ZVNrVHozOVpo?=
 =?utf-8?B?aTE2VkFzUlc1TlNyQmZWVGFMMEErbzR4UzEwV2NnVWJzczd6OUFONXJGRkVJ?=
 =?utf-8?B?UlNpa1krR0F6bWwyYUxYOGxCb1JUaS9VR2dQbVZ1V2MwYm9zb3o2N3VaaU5n?=
 =?utf-8?B?U05QZnd0RDBzS3JKN01VREtWU3oySUgwdFZRd2ZUbTlqOFBISUJOQXV1bzBh?=
 =?utf-8?B?dWFyZTIwZUp2TGJFTC9wektGZlc4Tk40L2JYRm9JeTZVbVg1SXR4Q01FREVC?=
 =?utf-8?B?MHI4ckExN0xmZWhUK01qcGhPVVVIcy8xOEpvVlpPS3BLd2JSSWhvTVg3cklQ?=
 =?utf-8?B?ZG9FbVUxSnZuVU50QWh0Y054eHVpWjl1WnhQdE9wOWRiNnRwK2hnNHpZSzVU?=
 =?utf-8?B?aGkybWdvd0UvL1gwV1B1cmd6UDhJU1d5OWZaSHZwUHdCVEFiemNmeGZrVXI4?=
 =?utf-8?B?QURYYlQxNC9yVXpyMW5YVnN4WFdueGVQdm5xOE1CWHhOcFZGNUtUK3U4TlI0?=
 =?utf-8?B?bFZlMHpYVDhIcHFGeDlHcVcyTWNCajBzRTJHTUxRTHdCYjdJTGtiSXZnOW1Z?=
 =?utf-8?B?R0tzMDZaa0YzNHVGOWdYQTVIc002SWpSMEN6NGczSmR4VVZ3R0NpMGdEWG13?=
 =?utf-8?B?LzVpWjJFclY4VVpUVGNNZkVpakFwUG5Ielo3YU90SU55U1VaVUFkTSs2Y09N?=
 =?utf-8?B?YXlvbTdDdDBVNHo5SmZLUFI0aTJaNTlDbVY1V0Jlejl6RksxYXdsdWM4VXFC?=
 =?utf-8?B?THlCYWk2MDU1UUxucWRLc2ZzOVlicFVHR2g3NFlYVnJOL3I5YlRDYStHeTlj?=
 =?utf-8?B?d2Rlc2lpZGdqUDd1T3RpQXM1dXdRaUxaUitObXJ6bTlSTWkzbllCTUtibGJM?=
 =?utf-8?B?YldjeEZwenV6Zm84NHV1Ui83L2N0ZExVTnY2S2xzcGcvc3V2RVFxNk1SYWhY?=
 =?utf-8?B?NDR6cFlud1owQ0EwWU1VUHVmVWY4NXBYUnJXNldtYWxXMGRtVm5TcVMrb01x?=
 =?utf-8?B?QndSd3k5QVZONDBIb1MybCtIQlAxdlhXdmFBSHRFSkpBUnNFOG94MHYzTHI4?=
 =?utf-8?B?dXJRczhaRDlRR29Md05COUpEV2JVRmIyZE83V0prckpNc044QTJ6M3hkZVN2?=
 =?utf-8?B?TXFaV1VIS3IrcllqQnJNcjgwbXc3cDV6ckZIeUxTZlRBUXBTREcyUkI5N0dC?=
 =?utf-8?B?Sk55RmVDc01qVmlYSGQzbWRpU1lyeU82NUxuSEtOYk1RZEhPdkZOWFRncHF3?=
 =?utf-8?B?MXBUTWg2Y0JCODVKRG9XOGN6dnJ0NmpkV0g0bTBSSnkyN2NmNmx2QUF6cS9m?=
 =?utf-8?B?UDd5VXluS29HOVJ6dHJMSkx2ZllleVFYdHFrWUhDVFA2RVl5VXVHNXpmd0Nw?=
 =?utf-8?B?eGNFMDV3dnlpYXJmUFYvUDJBUVRWSXpjUGtmYmpGQmNmNG5FYUYxT3RWZUhF?=
 =?utf-8?B?TTU1RE1ONndsR3RacWFndGZlR0xzamtlNVRqOEExY21OSWpXcnM4YXhWUzRS?=
 =?utf-8?B?eTgrNjN0ZFhxRVdpTHdha2NTQUpFcjJtNlUyaXczendDTlN5VmdjNDBIYm1k?=
 =?utf-8?B?ZTZyeXBHSURBZ1NnYmJUR0hkblY0c0p1cTVRRzMwcjkwRjJlZ3VYeGcxM3pD?=
 =?utf-8?B?eDBFWWM2bmRvbEozVVB3NTNjbFpZSmkrV3lPWFhicXIyVDVVd1NPOE00WFlF?=
 =?utf-8?B?ZWZSRXBjRlJQS25vb2hVb1JrT08yUXZ6WUk1M0RESWUxekxZK2h2elUyN1E3?=
 =?utf-8?B?VnBLOHlYNnR4SHZOQWtTeWRVclQyc3hEa1RKUDhiQUlJbUdNWnlLNUdFbHIr?=
 =?utf-8?B?bGdJOUhOb0l4dy9GWUo3NE1DSENsT2FKY0NPdi9GSHpyb09meHoxV2RTYUgy?=
 =?utf-8?B?REJiUWhwdzZHR3ZaKzIyazBSRjZjZG5DVVYzYzY5ZHpPTGN4c0VZakY3TytG?=
 =?utf-8?B?Ni9hMG8wSld6M1FrUGU3R1pjcVowaUE5cFZLeVdNbHpuU2YyNlJSVWVwaEIz?=
 =?utf-8?B?VVhCZHduWGJzSHg2aEpDcE1KWTBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8f5b22-88d0-41ea-60f3-08d9a807282e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 07:11:34.0846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuWFVuTKW0mOn67CoRjDIADuivpIZb98XGnacngByk5i+tZ5RqwL7OMp6Kp5eWm1wwtDqe3qed4i3B35Q8JmwMPBbvsBMWvTzy848JzpD2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4921
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gMTEvMTAvMjAyMSAxMjoyNyBBTSwgU2hhb3BlbmcgVGFuIHdy
b3RlOg0KPiA+IEZyb206ICJUYW4sIFNoYW9wZW5nIiA8dGFuLnNoYW9wZW5nQGpwLmZ1aml0c3Uu
Y29tPg0KPiA+DQo+ID4gV2hlbiB0aGUgSW50ZWwgU3ViLU5VTUEgQ2x1c3RlcmluZyhTTkMpIGZl
YXR1cmUgaXMgZW5hYmxlZCwNCj4gPiB0aGUgQ01UIGFuZCBNQk0gY291bnRlcnMgbWF5IG5vdCBi
ZSBhY2N1cmF0ZS4NCj4gPiBJbiB0aGlzIGNhc2UsIHNraXAgTUJNJkNNVCB0ZXN0cy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNoYW9wZW5nIFRhbiA8dGFuLnNoYW9wZW5nQGpwLmZ1aml0c3Uu
Y29tPg0KPiA+IC0tLQ0KPiA+IEhlbGxvLA0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBJbnRl
bCBSRFQgcmVmZXJlbmNlIE1hbnVhbCwNCj4gPiB3aGVuIHRoZSBzdWItbnVtYSBjbHVzdGVyaW5n
IGZlYXR1cmUgaXMgZW5hYmxlZCwgdGhlIENNVCBhbmQgTUJNDQo+IGNvdW50ZXJzIG1heSBub3Qg
YmUgYWNjdXJhdGUuDQo+ID4gV2hlbiBydW5uaW5nIENNVCB0ZXN0cyBhbmQgTUJNIHRlc3RzIG9u
IEludGVsIHByb2Nlc3NvciwgdGhlIHJlc3VsdCBpcyAibm90DQo+IG9rIi4NCj4gPiBTbywgZml4
IGl0IHRvIHNraXAgdGhlIENNVCAmIE1CTSB0ZXN0IFdoZW4gdGhlIEludGVsIFN1Yi1OVU1BDQo+
IENsdXN0ZXJpbmcoU05DKSBmZWF0dXJlIGlzIGVuYWJsZWQuDQo+ID4NCj4gDQo+IEl0IGlzIG5v
dCBjbGVhciB0byBtZSB3aGljaCBleGFjdCBkb2N1bWVudCB5b3UgcmVmZXIgdG8gYnV0IEkgZGlk
IGZpbmQgYQ0KPiBSRFQgcmVmZXJlbmNlIG1hbnVhbCBhdCB0aGUgbGluayBiZWxvdyB0aGF0IGRl
c2NyaWJlcyB0aGUgcHJvYmxlbSB5b3UNCj4gbWVudGlvbjoNCj4gaHR0cHM6Ly93d3cuaW50ZWwu
Y29tL2NvbnRlbnQvZGFtL2RldmVsb3AvZXh0ZXJuYWwvdXMvZW4vZG9jdW1lbnRzLzE4DQo+IDAx
MTUtaW50ZWwtcmR0Y2FzY2FkZWxha2Utc2VydmVycmVmZXJlbmNlbWFudWFsLTgwNjcxNy5wZGYN
Cg0KWWVzLCBJIHJlZmVycmVkIHRoaXMgbWFudWFsLg0KDQo+IFdoYXQgaXMgbm90IG1lbnRpb25l
ZCBpbiB5b3VyIGRlc2NyaXB0aW9uIGlzIHRoYXQgdGhpcyBpcyBhIGhhcmR3YXJlDQo+IGVycmF0
YSBzbyB0aGUgdGVzdCBpcyBleHBlY3RlZCB0byBmYWlsIG9uIHRoZXNlIHN5c3RlbXMgYW5kIEkg
ZmluZCB0aGF0DQo+IGRpc2FibGluZyB0aGUgdGVzdCBmb3IgYWxsIHN5c3RlbXMgYmFzZWQgb24g
dGhpcyBoYXJkd2FyZSBlcnJhdGEgaXMgdG9vDQo+IGRyYXN0aWMuDQoNClVuZGVyc3Rvb2QuIEl0
IGlzIG5vdCByZWFzb25hYmxlIHRvIGRpc2FibGUgdGhlIHRlc3QgZm9yIGFsbCBzeXN0ZW1zIA0K
YmFzZWQgb24gdGhpcyBoYXJkd2FyZSBlcnJhdGEuIA0KV2hlbiBJIHJ1biByZXN0cmxfdGVzdCBv
biBJbnRlbChSKSBYZW9uKFIpIEdvbGQgNjI1NCBDUFUsIA0KdGhlIHJlc3VsdCBvZiBDTVQgJiBN
Qk0gaXMgIm5vdCBvayIsIGFuZCBJIHRvb2sgc29tZSB0aW1lIHRvIGRlYnVnIGl0LiANCkluIG9y
ZGVyIHRvIG90aGVyIHBlb3BsZSBjYW4gZG8gdGhlIHRlc3Qgc21vb3RobHksIEknZCBsaWtlIHRv
IHVwZGF0ZSB0aGUgDQpwYXRjaCB0byBkaXNhYmxlIHRoZSB0ZXN0IG9ubHkgb24gMm5kIEdlbmVy
YXRpb24gSW50ZWwgWGVvbiBzY2FsYWJsZSBwcm9jZXNzb3JzLiANCg0KUmVnYXJkcywgDQpTaGFv
cGVuZyBUYW4NCg==
