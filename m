Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7152C464506
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 03:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhLACrm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 21:47:42 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:41342 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234763AbhLACrl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 21:47:41 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2021 21:47:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638326661; x=1669862661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hCbTavEbMVeD3J0h0QYSUiqbYO4mjOFbl8PKpcrFGy0=;
  b=eM1pA53vPHyCP2N0sGrOE3f2UQ+xUuFscYVlQab9LfKYu5Hq2/SsWXb7
   U7gWHAw4KGcnR+iyZk1IhG0CqnzJMlCREvyiaYdxxcxv1xpxOh4hbfqp9
   ogKQKnxJGisW0giJ6lkaQ1d91LPhTwxOJVWrD9Ok1ildJoH/RztYsMqSm
   KmLrD66cIVqOtOOyAt4q3s01jXJwR5LgwOGKt9IdQ6QjH7VjDs9zeXzYR
   ARz+HKNQlNlvgHUOD+yHNZtlS2/eVEvvRIhnwN6fQxmyFivrf30aG4+Xw
   Xcvthk83zJjUarl3+ksOc1nk27lPPbLfcU2Oc6qm3uDoD4Zfhmq/tq4p/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="44796057"
X-IronPort-AV: E=Sophos;i="5.87,277,1631545200"; 
   d="scan'208";a="44796057"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:36:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ0EJ+Z5VBPK+SSLVmNu2ZfO1RdF4BlAUCMgdPrlOAB741w3cgo9yEXWBCBJameqBGaa6d2Z//ShFNRnXcnj1qoJGrTNxOmS8Tqc954GMXEX3O3chdq6ajLWGW2edWaUZMXsoC+dHY2HCUNHhcarqrvdGUHo7ehbhHX9RSETE95z86pzI6GwVEFIG9sMr1EEIxKoQVq4tQVmueD95B1pVVUP/Z916/RPklMuufasMV6AWNPHUMlPzp1TgIyoXCQmjyYpeshSpKTWW0iyBc2lKPjkYDgJeOCOH2r7oibc/2KzxemiRKkEtmMCQJgOAQkgXfUchdV82+SQZLGdfNtbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCbTavEbMVeD3J0h0QYSUiqbYO4mjOFbl8PKpcrFGy0=;
 b=UhMpYGQw1eQ5c5aknJ57F4otkhRRmWNTfrWvVrJ7H+o7RkczcBghPa2XgOUM4w2lMjcgNT8DUQ1+1V0TCV+2mrYU/u1s22MclmncQSSYp+JGeSWS/lFiKQKcSAuRLYmyP1xNeWhhu7G5v7jNk27H8QYzSIRSv+SlgClvLLnyYQEctGnabUrOYcoqqo4Auf2OYzzqwIhqg4EKgNjBb9qcsDolD+I4WaAkDmBCNfe3vjExt4VcLASQNkLcW09QPwmBL0HhiyLosGkweQsRMZxTuwrzfUah41IyqSbVO2FA5heaZl3iTN0fx0rnFz16g7TBlnHZ3Do2sgI+wIbf+ABNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCbTavEbMVeD3J0h0QYSUiqbYO4mjOFbl8PKpcrFGy0=;
 b=UAnO34Q1CTH3sgW96gb2XXU2k/XmesC8pcc1e2NmaMeqyWRmnEdluLv/yrIP+E2a3+Cqm0YvU7O7ZmN8Xl0fAZ0Y65GkvaT9TAsFQvCgFuY6c0xv0gqnqqCCloYrsvSEEHV6zEiSUtDhtSstKunc9ET7Dt2QaJX9u0fz8T3tonY=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB4061.jpnprd01.prod.outlook.com (2603:1096:404:c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 1 Dec
 2021 02:36:55 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 02:36:54 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Topic: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Index: AQHX1hYQoRVeRbEkHEuvqUlW5Aw+wawbAh2AgAIEFrA=
Date:   Wed, 1 Dec 2021 02:36:54 +0000
Message-ID: <TYAPR01MB633090B5A9DE4480D12CC9268B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
 <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
In-Reply-To: <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9M2I2YTIwMmMtMzRlYy00YzllLWE4ZmItNjQwNDY1NTA2?=
 =?utf-8?B?Yzg4O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMi0wMVQwMjoxNDozNlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea0327f-a693-4e4e-b0f3-08d9b4737066
x-ms-traffictypediagnostic: TYAPR01MB4061:
x-microsoft-antispam-prvs: <TYAPR01MB4061FE8C5B94BB411608907A8B689@TYAPR01MB4061.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsN9SwWNppb8xRDl8c5uJCBUuB8CYluLzBbgcljj2Euzuujh0Y314p8e5a05SJRc/j53tKbvlJJPn8ekqXfSXM1Mpl5cCWiNtgXXqO1XXPCbdyTVlay260bz3TrGdYIHLB4r43M9vALG8rShyb+I2HoFGeYBmgZiXa9nji+SlPK+qZKDU7sLO/qSpcZG+MW42jMCfHsiKzW8wIrPdq96K3JLfRm9fzaVF03yrg6ZKVIrLaQ67eFZ66VK5A0zThDWvbLSltQMZowflgF323i/3yOcr8TwlNgr+SFBFCcZXMvxcDyXTd2jr6bQkEe0hE09Vnk1GX4EINqMAUKP8Uv939Xuo5Vmehqpax3jfDd2DjoOWd4c7d1enXvvB79jPiCU6X9TxY61bfsVgxmu9TcKOfj0cTWkjdAPOUb+jlgcNl4fOuDvlAvXbOG95cYgLI0wgYArPP0adOxR3SjS+AbhonHLE9f9s3QtvZ+EucbVP+8a+4ipj9JdDR2IHSkHI4drmmdQKwLDxDGSdIJE237vR1tPSds6Y4suTfoVIheGMQje9EMBsUKjVBVvtXxYqYcTaQ0hPgLqKs7Sx6rsR+urqvPy2foIvH46iOkX6kxUv04fg4AWFuOrJ8UATeChZY8HiunS80YXf7IVBYtKNA/87yAdn+ZOpstpxKC9iC73pQ2ONwSJp8Nq+P/R5rBdE/b+5U9TG//6eZE+BaNflsRnUISBDefwA+0fSxIwx/5CIGyDEQBKCbCGlM1MEUyvS3ySLRLwXjutBZC23WYvCK52W+l6xnhHW8ctO03w7cZJU50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(508600001)(66446008)(4326008)(33656002)(66556008)(38070700005)(966005)(86362001)(66946007)(55016003)(52536014)(122000001)(6506007)(53546011)(83380400001)(9686003)(66476007)(64756008)(7696005)(316002)(54906003)(8676002)(85182001)(5660300002)(26005)(8936002)(82960400001)(110136005)(186003)(76116006)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUNRYUlOUVpJYnA5ZnBMdmgrOStsSW5Nc2s5MzVJMndrOVpqeHJVdEtxUHZV?=
 =?utf-8?B?SjQvNVVOUjJLYVBxdk1CZXFEWUM4d01qQ3lHcUhPS3JkVUlMUXIrSTBnTXlw?=
 =?utf-8?B?SFRIQ2ZSZkEwK3VJMVg3b2RDSGNickxURldmQ1NBME1xOTRhK0JSc3JRdjgr?=
 =?utf-8?B?K2U2aFBJOUF0UXpTaDR1RzVWWUNOeEZCRzNUM291cFNaR2kxdG1uZjJRUEIw?=
 =?utf-8?B?eFZ6U0h6YlZ3d0ljelpnaHZqVjB0RGZsM2tHNE9MQ05oZ2RpRnBxUS92Ujkr?=
 =?utf-8?B?NGJteEFWWkdUMXlId0tRd2YwOVJwM3ZmclhxcDBoTzJDbmhpbndRYmJOV3Ja?=
 =?utf-8?B?b0FlaVdIR3lhbkJRcmVyWWJRZHJkSmdWWFY2QVFQSTR4Uk1XOXdzUnhWZ2N3?=
 =?utf-8?B?MG1aZHZJN1VXNVR2cmt1c0NuMC9uMnpUNDU3V0o5Q0JtdTczaE5veG5BY0k5?=
 =?utf-8?B?MlZFSUpoU01tZ0JCNEQ5VTRTaENvbjdFTmJvSHF1Wko0Z1dLTUdHSDZxT1pS?=
 =?utf-8?B?cEtRaExHNStUYUMzd3JTT1dEUGpoMUVEWnNVdzYwcG1UbVAwZXZaTXg3cExr?=
 =?utf-8?B?dEZxVkw0RDdVYzgyK3NXTXpLaWV5c0FVeVN2ZmNnZlM1Z0FDMGJPNUJVZzQ3?=
 =?utf-8?B?eng4dUVyZHM3VVZBYU9tTmNOZ0I4K0IrWG9zcTNHSktwODM5cVJNbllHd0gy?=
 =?utf-8?B?Y21IN21YclJFQUc0a1Jqam9ZL3pXZEVhSFlnTEg5bXp5RGpVZ0VNcU5YYlNJ?=
 =?utf-8?B?Zmtad2dEWEFOY2pQWlc3TkJCRVRQdjArQXR3L201a2MxQWh2U2U3ek1WeG1o?=
 =?utf-8?B?ZGZOM05qS1ZPaTk2UVVyOUdxK1hrR2lTTWFpRDlVN3RZYlVOQ1FUQytqZkFP?=
 =?utf-8?B?TElIbXY0L2xhSkZjSVBiWnc2WHpyS3JNNkVJdzVPYlBLYnR2d2RxNm9IS0lw?=
 =?utf-8?B?TGlleUpPeVo0azZRQ2krU1VIMTlzZlRycG5yK0xvWUV3emFHYWovNENRa2Ra?=
 =?utf-8?B?Z2tWTFZGTXpkeWcyRHBJWnlXcWMrZTNKYWRubzFIZGh4K0pwNm92eW9GNEJI?=
 =?utf-8?B?Uk43VksxR0dYb1hqcnczbFgrUUorQ2xYK0JuQlFSL1NHMy9xN0V4eVJJbUlJ?=
 =?utf-8?B?ZmduekIxOHFBUGt6aFV4ZXA0VUtaZFhBWEV1bFNTc1BvVmdMeHJsTHhRNFND?=
 =?utf-8?B?NjRuTnpuM2dPZUQ2YkxFaTVQR1F3bENUcmZIaTBmOWFKOXBvQ0JEWG8xRDM2?=
 =?utf-8?B?ajZBL3lVTE05Zm41dnVCL1hrdStYWXk5cGZqY2ZCRkFjdVNFMXk0dFB4V3FK?=
 =?utf-8?B?bG1yaEoyQ3R0U2xQV0Q0QXBFT0JPdkJzMlpDLzIzYWtPYlp6SE44K1N6YjhK?=
 =?utf-8?B?NXhqSlZ0SVlKVHNZOC9qTHZWVnNXM1B2V01lQVVHMFpEb2c2UEtLbTRXTTNX?=
 =?utf-8?B?aXVBTjAxY1pUQ3VYKzk3K0RHNFJMc0g3czdLd1Z6dEw2d1U2T1gvckRKRXZB?=
 =?utf-8?B?UXhnM0cra1UvNWhzZXR6QlFYcUMvdlQ4QnpVUzFuaDliTGVXblBMRjM4VzBI?=
 =?utf-8?B?STdDaXdUekM0cS95STJDSUJZTVdmSldJV2F4R0hwN2ZVN3hlU0h3OFREc1NZ?=
 =?utf-8?B?WXQwOHJSbS9UVWI1SzR3UTJFU2Y3N1JSRGQ5OU5BQllTNnFjV1huZlRaNzRO?=
 =?utf-8?B?eHJhY3VJRHlsSHVneTFrWlRtRnlVU2EyZ1QvNzhkcnYxOUpqemo1b2VsVCtH?=
 =?utf-8?B?Mlp5akoyZFRNVUowUXdXS0xLVVRabS82c2dvL2JzLzFjSk1GY0ozUXE5a3Rt?=
 =?utf-8?B?TzlkR3NTdEVaZWhLTHlCTUd6ZXRiQTlUTG5QKzJrMWE3VXBYc29aWksvb1No?=
 =?utf-8?B?emFvWjZiVGhsUTFqQXpSY1QzT3lDK2xQaExSY1VSVWdmeUxwejBXTVJYaFNL?=
 =?utf-8?B?WE1UV1BHbVYxRzQyaG90ZFM4Q3hkTWYyVzlERzdSR0ZYWUt2YnBnbjVJaGM1?=
 =?utf-8?B?aTlvTnZCemNZU2JZYVpvb2pMVzJtMUZBRjM5Zzl1NFAwdGI4YjRJa003ck1x?=
 =?utf-8?B?SVVnbDhuQ2NKZVlmdWJYSmtHem0xMnBXb1NlV28yMEE3NExGQjlSd1FUc3Qz?=
 =?utf-8?B?NXRuRUx5K2NNME5VVmtKVDRKRWNXVUlIQXZVajBVMEJKZ2d2clN4U2JQcTh3?=
 =?utf-8?B?UkdaMVBOWlh4SjhvZEtiT3hNUUVpQ2VQMDhZeU9GTU1nWWJ4UDZNTk9hNGpJ?=
 =?utf-8?B?dk5RT1FTT1ZzeU9jOGNpWkN1VW13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea0327f-a693-4e4e-b0f3-08d9b4737066
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 02:36:54.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPWV2E5ixVSERVWBCpNoLYaF5OUZvmuFIjTOcZNEuEdrYT//ttJtMFcljZxu6xFwPxkMg2nr1Bypch3+dLn0zQfETVW2xGqEiMDgshyuDLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4061
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUNCg0KPiBPbiAxMS8xMC8yMDIxIDE6MzMgQU0sIFNoYW9wZW5nIFRhbiB3cm90
ZToNCj4gPiBGcm9tOiAiVGFuLCBTaGFvcGVuZyIgPHRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNv
bT4NCj4gPg0KPiA+IFRoaXMgY29tbWl0IGVuYWJsZXMga3NlbGZ0ZXN0IHRvIGJlIGJ1aWx0L3J1
biBpbiByZXNjdHJsIGZyYW1ld29yay4NCj4gPiBCdWlsZC9ydW4gcmVzY3RybF90ZXN0cyBieSBi
dWlsZC9ydW4gYWxsIHRlc3RzIG9mIGtzZWxmdGVzdCwgb3IgYnkNCj4gPiB1c2luZyB0aGUgIlRB
UkdFVFMiIHZhcmlhYmxlIG9uIHRoZSBtYWtlIGNvbW1hbmQgbGluZSB0byBzcGVjaWZ5DQo+IHJl
c2N0cmxfdGVzdHMuDQo+ID4gVG8gbWFrZSByZXNjdHJsX3Rlc3RzIHJ1biB1c2luZyBrc2VsZnRl
c3QgZnJhbWV3b3JrLCB0aGlzIGNvbW1pdA0KPiA+IG1vZGlmaWVkIHRoZSBNYWtlZmlsZSBvZiBr
ZXJuZWwga3NlbGZ0ZXN0IHNldCBhbmQgdGhlIE1ha2VmaWxlIG9mDQo+IHJlc2N0cmxfdGVzdHMu
DQo+IA0KPiBUaGUgYWJvdmUgc2VudGVuY2UgbWVudGlvbnMgdGhhdCBjaGFuZ2VzIHdlcmUgbWFk
ZSB0byB0aGUgcmVzY3RybCBzZWxmdGVzdA0KPiBNYWtlZmlsZSBidXQgaXQgZG9lcyBub3QgZGVz
Y3JpYmUgd2hhdCB0aGUgY2hhbmdlIGFjY29tcGxpc2ggb3Igd2h5IHRoZXkgYXJlDQo+IG5lZWRl
ZC4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/DQoNCkJlZm9yZSB0aGVzZSBjaGFuZ2VzIG9m
IE1ha2VmaWxlLCB3aGVuIHdlIHJ1biByZXNjdHJsIHRlc3QsDQp3ZSBuZWVkIHRvIGdvdG8gdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC8gZGlyZWN0b3J5LA0KcnVuICJtYWtlIiB0byBi
dWlsZCBleGVjdXRhYmxlIGZpbGUgInJlc2N0cmxfdGVzdHMiLA0KYW5kIHJ1biAic3VkbyAuL3Jl
c2N0cmxfdGVzdHMiIHRvIGV4ZWN1dGUgdGhlIHRlc3QuDQoNCldpdGggdGhpcyBwYXRjaCwgd2Ug
Y2FuIHJlc2N0cmwgdGVzdCBpbiBzZWxmdGVzdCBmcmFtd29yayBhcyBmb2xsb3cuDQpSdW4gYWxs
IHRlc3RzIGluY2x1ZGUgcmVzY3RybDoNCiAkIG1ha2UgLUMgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMgcnVuX3Rlc3RzDQpSdW4gYSBzdWJzZXQocmVzY3RybCkgb2Ygc2VsZnRlc3RzOg0KICQgbWFr
ZSAtQyB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyBUQVJHRVRTPXJlc2N0cmwgcnVuX3Rlc3RzDQoN
CkxpbnV4IEtlcm5lbCBTZWxmdGVzdHMgOg0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRt
bC9sYXRlc3QvZGV2LXRvb2xzL2tzZWxmdGVzdC5odG1sIA0KDQo+ID4gVG8gZW5zdXJlIHRoZSBy
ZXNjdHJsX3Rlc3RzIGZpbmlzaCBpbiBsaW1pdGVkIHRpbWUsIHRoaXMgY29tbWl0DQo+ID4gY2hh
bmdlZCB0aGUgZGVmYXVsdCBsaW1pdGVkIHRpbWUoNDVzKSB0byAxMjAgc2Vjb25kcyBmb3IgcmVz
Y3RybF90ZXN0cw0KPiA+IGJ5IGFkZGluZyAic2V0dGluZyIgZmlsZS4NCj4gDQo+IEhvdyBpcyBj
aGFuZ2luZyB0aGUgdGltZW91dCByZWxhdGVkIHRvIHRoZSByZXNjdHJsIGZyYW1ld29yayBjaGFu
Z2VzPyBJcyBpdCBub3QNCj4gYSBzZXBhcmF0ZSBjaGFuZ2U/DQoNCkluIHNlbGZ0ZXN0IGZyYW13
b3JrLCB0aGUgZGVmYXVsdCBsaW1pdGVkIHRpbWUgb2YgYWxsIHRlc3RzIGlzIDQ1IHNlY29uZHMN
CndoaWNoIGlzIHNwZWNpZmllZCBieSBjb21tb24gZmlsZSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rc2VsZnRlc3QvcnVubmVyLnNoLg0KRWFjaCB0ZXN0IGNhbiBjaGFuZ2UgdGhlIGxpbWl0ZWQg
dGltZSBpbmRpdmlkdWFsbHkgYnkgYWRkaW5nIGEgInNldHRpbmciIA0KZmlsZSBpbnRvIGl0cyBv
d24gZGlyZWN0b3J5LiBJIGNoYW5nZWQgdGhlIGxpbWl0ZWQgdGltZSBvZiByZXNjdHJsIHRvMTIw
cyANCmJlY2F1c2UgNDVzIHdhcyBub3QgZW5vdWdoIGluIG15IGVudmlyb25tZW50Lg0KDQpSZWdh
cmRzLA0KU2hhb3BlbmcgVGFuDQo=
