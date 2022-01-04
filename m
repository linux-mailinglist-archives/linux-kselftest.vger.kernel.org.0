Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5656D483F50
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 10:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiADJms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 04:42:48 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:7130 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbiADJmr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 04:42:47 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 04:42:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641289367; x=1672825367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JW7aP5GUmFOPyTToC8cRyG53ODet/0bs/OCqKTjY4UE=;
  b=fubY9U5mlTBzEF0pw8CFGJtLopwNGR7IIIinlrGFFpwIVMw10RS7MLUF
   mrfVZ3QJwOBwbb8vj39eoDAnPIaKyskgRz3+L7kEqceRgHyscEL5pCTie
   WEwnx5UFtjViMBnCtVvaLSyHHuXrFnet+xl/e4MlLaAhFiHuPJvDREXfJ
   piHLNMyLivBlMPd/NYgr39Moc5x7B2xamwEL3cIM8L347oKlFnrwhbHio
   97c4BWQlk7uKzXJXnk6zaqbhsEeEc1bKfzI5A3w4LVL0VbDiXBNxpU0Wz
   tQ8Z+rhrw04g9mw64cM9mXO8GjcSs2g4fuX0R2HC6RF33qpKa/0EXESa7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="46950566"
X-IronPort-AV: E=Sophos;i="5.88,260,1635174000"; 
   d="scan'208";a="46950566"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 18:35:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIe3j7rsuAOwGUcHuHmeeGc4UGfsf/JQZFDI5GmEWtfzl9rXcpjxBwHTiIdfF0gOThvwgAECHosChOIacWYUbRy3tkYUInUdYYNn6k8KtUo2P/mTW8WDQtEr0e9H4W+JaxSYqzXoh4dWsTT6QfsxQS4uQGF9YJ81DcLmpb9hDKK3pbjLfQxCvdc7Ab7cBUsYvYILp76mE9Z+7AefkiJZynPznrYJZtj2IcGLkKvMHiRfYgjFWrVh5/8rmpPTdhIknfTL4cbRxRnXcSq5JexruSXFhUKxLFzzw/HdDoEzD5EcbasP/AKqXTkSCzrreA69xn1y8YoTmTG+tVIK4TeXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjBtxrsTot7ZFy9sDe6AG0cGAUSWX0tO/6Lyt+gWjyw=;
 b=CvzaX93ELhCrMmSczX8XhR6IEaYNYv6C1+rXXhWwVRn3fluDx0agl+G0Fl/QC7vR0M3N5/EiflTjfusZVmUinhr88dFVszvznYTUSSTgYCIGu4j3rOcIjvBVEEQ/9XKcSkAy+cw8y3RLnRLW+MAqSPnPnuwiB3FN69jG8PmsbdsRShde3Af7+EILfgV4rmBmHlPvYQGMpDkuRgTeUHXdfKLBlVhGobimILgW0/GH31f/vgJsbRhemyRJv3qAFMqjAqUybV+6jT6Q7Z7Q1137XfzMif5ZrY5yw+etzoSBTNTH+iS4mIjYWR1jYme5g+duKcNUMPgFgrL4l7N37ZnCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjBtxrsTot7ZFy9sDe6AG0cGAUSWX0tO/6Lyt+gWjyw=;
 b=O+Ra6GUdWExiiBglYhJ2SCi/0U1X7s/ZNqoGsEBmZpPLhjWP7EpYQiaBWTaDtXI8IqQfbcDNnyrUWNLQfWHN8UcZCgUddyDPKjk+BLlBNg3H1JmjWtTf+Yr+WRUixG1g84anlTfpdK9HXIE/EWcqDxVO6i6e/xvPU439Idb7yLw=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB1967.jpnprd01.prod.outlook.com (2603:1096:404:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:35:34 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1c9c:6e45:49b:757c]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1c9c:6e45:49b:757c%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:35:34 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 0/5] selftests/resctrl: Add resctrl_tests into
 kselftest set
Thread-Topic: [PATCH v2 0/5] selftests/resctrl: Add resctrl_tests into
 kselftest set
Thread-Index: AQHX8Ai8jQFzlVX2+Umsv+Svcky506xSuzAQ
Date:   Tue, 4 Jan 2022 09:35:33 +0000
Message-ID: <TYAPR01MB6330A02E7877CCC71F5BBD9A8B4A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
In-Reply-To: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZDM5NDdlOWQtZjNkMy00NzcxLTk3MzAtZjIy?=
 =?iso-2022-jp?B?YjM3ODY4NjRiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDEtMDRUMDk6Mjk6NTNaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0522b7c-26be-4395-868e-08d9cf658e99
x-ms-traffictypediagnostic: TYAPR01MB1967:EE_
x-microsoft-antispam-prvs: <TYAPR01MB1967BB04C250E45ADD32345E8B4A9@TYAPR01MB1967.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8KK4QI/jL0qFqvvV6X9FRxvTs2P2tAby6kaiayaxUEZ0T2IJ8J15J5txRV9gnh2RRKLtifB/HNoxX8lfB3qxJj3/O150V21FzKBys4oRLbsUYJbnhcobonMZOuPShigUVtYoSH+0nP3sVx0MbBVxLDU/ifXvA1DZifaAFOtQVGCTSkvHzdYC/TSoQyx3vzuxbtlYUJeG2xXl6lKlSqpEUm5ngokF5IKRfHIBRrscXYPTTm5QiSbm8jY3mIHR/pCOOiWCB8IL0yg1AckV6YA/sILD6kctI7643CLjrOdEAKpb5goAT2ZKoLE3/gVIcWbkcJl+X09uOChkph5MQXgSYxVK4lZXaQ2ipn3gTvlg8aoz4SMBehbqhih8XvOBy65LIYOj8E//EOwRjQyg/BK3B5s5OwSLyXBL+aVry7q4EmDVW6Ujp20CdQsdk1/f8fzdCLQiASEiKQ3KacZqVPPHj15ymk2UlOfXGo4ECCmGFY0aFsNOLFJqcQxHnACpmw0bMVl0IQW7LEYd/HJIRoKktFYy9sXLa2n/X7TSRkkgWo2KeWm9QH1X+7kD+abJl3gUaNpsV0XeFA5Wegf1IdRgaWlwhaPOl3UJEZY7tuwumfBH17KODryS9XKfTCn7+rY/c0KOeUNHsabjSXTn4mYs6HaiWEp/2WgKJlDCv8taw+KdncYfM9oApuk4tiEAdjPpKrecCp2G2BTbvmtWZ3tW93zenVz3nvaS5OOCrnUIXY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(110136005)(4326008)(5660300002)(82960400001)(66946007)(6506007)(55016003)(85182001)(9686003)(83380400001)(54906003)(186003)(86362001)(66446008)(52536014)(38100700002)(8676002)(8936002)(33656002)(64756008)(38070700005)(7696005)(76116006)(26005)(316002)(122000001)(66556008)(71200400001)(66476007)(2906002)(485434002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eURNWWlPbVhFbEJYRm1zUWJqUEIxSnJvZlc3dlhhM3FBM1JUTDk0MnpT?=
 =?iso-2022-jp?B?TDVZTzhuaDZLeFdzS2h4N0x1T3dQbXRWMElPaTgzL2tDL1hsM3l5UmtL?=
 =?iso-2022-jp?B?TEtiNDN1bzQyYy9wZ1VWUUU2UmVlWk9ITkJuOTFlZFJuM2pvaUJENGMz?=
 =?iso-2022-jp?B?QUtCQTJNTGEyWXU1bW9OV3R0Z0gyREF6eUp1UlZNZGg4a1BWdzNlbmxa?=
 =?iso-2022-jp?B?UURvdUFmU0E3akZlL3ROUStTRkRlSFdHY2xYY1B5em1zdHJ2LzQwOWtw?=
 =?iso-2022-jp?B?RitPbzBpS1MySmtncjZlc3VkUWFVUk13THl1RUQ1aHlrMDRGd1JBTW5k?=
 =?iso-2022-jp?B?KzIwWlVuOVlMc2hWTXZMbnJRcmdHU0tGbStwUzZJYmordXJLdk9iQzFp?=
 =?iso-2022-jp?B?bkRJYmQ5cnMyYWFYT1FYWFJ1R2ZCMlRmZm5YSkN2bnduZEptOHZRL3Zq?=
 =?iso-2022-jp?B?OTFyR2VFNEZiaFo3alMyYm0xMnJLUXl0dHcrdmV5T0Nxb0xTUVNOMlpa?=
 =?iso-2022-jp?B?WGRtOGkyTEJETmhIeHNYWDhFYUVJUHFNVk5jRE1rV1gyU0RSbTkzS0Zu?=
 =?iso-2022-jp?B?S0YwSVFTQXV4UUM2SkJHcUFhanBoUE8rZ1ZNbG55eGtjYlVDb3UwK1Nz?=
 =?iso-2022-jp?B?dHF6a3hoQWlXWE5YZ3NySkJuZ2NRTkNZalRKWTI2RE5DakpjWDZoeHJT?=
 =?iso-2022-jp?B?RVFQQ1Z2M1UzWG9GcWorM0E4UUtOdjk0Vkl5VkxmcDgwQm1EWERiWWpl?=
 =?iso-2022-jp?B?ZjRHWjdJbW01OUJLQnY2d2VnWDV1THk5WEFHT2hwRS9kRFF5QVh2VHAz?=
 =?iso-2022-jp?B?VjF0MHFGUlRZQTM1dXZ1RHc1K1VGWE8vNnVMSkI2L0JZTjJBZFRkZTJl?=
 =?iso-2022-jp?B?UnNpaHIvaG1odTNCMXMwVURrZjFkZ2h6S2ZaakZhWE4rOTYxY1ZyUnpE?=
 =?iso-2022-jp?B?SC9JVDJNRjVWOTN2N3hoWTNwOHdIYVh2ZThuSE1TYXAxMkR0d3lyVFEz?=
 =?iso-2022-jp?B?K0Z5NExiYmRTUmJ2eE04MWQ3YWxDa3dENFNCRnlkWHNCeElrYnRzWEpm?=
 =?iso-2022-jp?B?SGNnMnN2OHluZ1FNbVZkMHMvT094ZEJqNTRYRTJ2cVFRQ29yOEREN3Y0?=
 =?iso-2022-jp?B?ZWw1VnM2TzJYU241bFNTTTBlZThtcWVxMmxrZXhJQ0JkL2VJSFZnVDhQ?=
 =?iso-2022-jp?B?WGh6MTZ5am5KdjVhWjFGQjV3eno5WmZ1a3c4Mnh2Z3grcVB0VnpzRjZS?=
 =?iso-2022-jp?B?cU9NdHM3MkwwNVowSFV6SlhqTW9xcW4zekxsOGFyZUVWZkk4S0t5RWJ0?=
 =?iso-2022-jp?B?VnVONm5KMmczc3pCa2VEM01YV052Z3l3RjNkb0VtM2w3Smo5NmIvUUxu?=
 =?iso-2022-jp?B?Z1hNQTNDcmc1MHhweVdmWUM4c0htc2ZMeFltUFYrMlZ2TE9kaU1EaTZM?=
 =?iso-2022-jp?B?TVplL1UxNE9wOEpwUk1DYWZZQ3VrdDl4eFF6MnN0eTFhS2h2RUkya0Rw?=
 =?iso-2022-jp?B?ZXByTUl4Y3lxdXV0VkNsT25WWHY2Qi8rTnJKSHNaUmJrUXJUcGdQZ2Zt?=
 =?iso-2022-jp?B?Q3Z3dnB5YXBPcnoyNmNyME1IYnM3VHNsZ0tFa1E4MlhndThCMWxLaGZt?=
 =?iso-2022-jp?B?cXNxMEZRSitDY3VjNC9MdDZNOGNlcTRtR2tyNmh2bDg1dDF4WWJoMWhS?=
 =?iso-2022-jp?B?N2NpcXE3b0N6Q05JMXg3b0hoN29hTm4wZDNuVmVPbkFTMkZKbEJFZnpE?=
 =?iso-2022-jp?B?WlJUamR3amhBMXRERGYzV1d5ZXJnMGpzb2pqc1lPY0xjYjdvdkxTanpC?=
 =?iso-2022-jp?B?RkJLc3BPY1hYWmVVYjEyVGVnZXY3Z2IzcDhsK3pHRWxiazJWMFZIbU51?=
 =?iso-2022-jp?B?L2RpaElxSU9Tdy82cERXRFBXZmFrQlV4QTRROVhYTDJVUE9ubUlSR21C?=
 =?iso-2022-jp?B?MUxGSXJENUlXckhrdFE5aHNMMUJkZCs5ZFM2emVrbGZXa0FmbGgyQmln?=
 =?iso-2022-jp?B?MU15Q2M0ekYyWStFbHluL1VXL2FSU1gwMDN6amVBVG03a2pEQ0d4V0Vy?=
 =?iso-2022-jp?B?VjdOcmg3blU1eGx5WEszVHZWbzRiZStQbnp3TzdTQ09WZEF6WFczdGZh?=
 =?iso-2022-jp?B?a3owUks0cUJUQ29QaDFsaUFWMTlnNUxZVUFjeXRBQ2lKeWNDQlFMSFBa?=
 =?iso-2022-jp?B?dkNpc28zOUhPcTViSEhSOEZOWndCcWpKUnkxbEVHUGZvZ3lyY3gwTGhx?=
 =?iso-2022-jp?B?dEk1Y3dlWVljZXpWc3JJb3hkVDRGT2VDV3BKc2pTRE9qeWU4K3IxNlZJ?=
 =?iso-2022-jp?B?L3UwVVNrN1A4djBpckJwSVJUZXRWcjd5VTVRdkt1STROYlpibnBDK3NL?=
 =?iso-2022-jp?B?bDJvbnVxY21EVlYxc0VxN3lHRXptcHdVYWdHQlZoVVVzeXlBUk9rcm03?=
 =?iso-2022-jp?B?czBWdTRBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0522b7c-26be-4395-868e-08d9cf658e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 09:35:34.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qKRVPCJ6JhMJE3pKzlAe99UacMtIjrORKzJ/HkKSud3uhf/huopq7MDDuDIAG3dEuEf8k9NzvbyJ3rlow+2tyWmu8hQGpXRvRT95WwqvmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1967
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Friendly ping for a review.

>
> Hello,
>=20
> The aim of this series is to make resctrl_tests run by using kselftest fr=
amework.
> - I modify Makefile of resctrl_test and Makefile of selftest, to
>   build/run resctrl_tests by using kselftest framework.
> - I set the limited time for resctrl_tests to 120 seconds, to ensure the
>   resctrl_tests finish in limited time.
> - When resctrl file system is not supported or resctrl_tests is not run
>   as root, return skip code of kselftest.
> - If it is not finish in limited time, terminate resctrl_tests same as
>   executing ctrl+c.
>=20
> Difference from v1:
> - I change the order of patches according to Reinette's review.
> - "LDLIBS + =3D -lnuma" has no dependencies on this patch series, delete
>   it from [PATCH v2 2/5].
> - I separate the license info of Makefile into a new patch [PATCH v2
>   3/5].
> - I separate "limited time" into a new patch [PATCH v2 4/5].
> (There is no change in [PATCH v2 1/5] and [PATCH v2 5/5]) In addition, I =
think
> 120s is not a problem since some tests have longer timeout (e.g. net test=
 is
> 300s), please let me know if this is wrong
>=20
> Thanks,
>=20
> Shaopeng Tan (5):
>   selftests/resctrl: Kill the child process created by fork() when the
>     SIGTERM signal comes
>   selftests/resctrl: Make resctrl_tests run using kselftest framework
>   selftests/resctrl: Add license to resctrl_test Makefile
>   selftests/resctrl: Change default limited time to 120 seconds for
>     resctrl_tests
>   selftests/resctrl: Return KSFT_SKIP(4) if resctrlfile system is not
>     supported or resctrl is not run as root
>=20
>  tools/testing/selftests/Makefile              |  1 +
>  tools/testing/selftests/resctrl/Makefile      | 20 +++++++------------
>  .../testing/selftests/resctrl/resctrl_tests.c |  4 ++--
> tools/testing/selftests/resctrl/resctrl_val.c |  1 +
>  tools/testing/selftests/resctrl/settings      |  1 +
>  5 files changed, 12 insertions(+), 15 deletions(-)  create mode 100644
> tools/testing/selftests/resctrl/settings
>=20
> --
> 2.27.0

