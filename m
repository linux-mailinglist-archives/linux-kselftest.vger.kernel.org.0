Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A194C495B7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 09:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379328AbiAUIAN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 03:00:13 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:56788 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379326AbiAUIAL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 03:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642752011; x=1674288011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r1Sbl376T3aE/woHN73QCkdGeILVjY3XHrQLpdfQKOI=;
  b=lNa0xUDOKtw2KSOX5bZqHRqt9iXblIO+X5lI5xEmChNIbAN95VYB0h5C
   9MSzxfIHxdoqSklQ+dftdNjoCLva6CbrnJ5p6b0E2LwdvGgk50Z4sQqW7
   yFytF3LgoK3zYih8UUzSO+1z0JOxvtV6VRrm5FGC91iarVnPk4rrIbW8P
   jkBUZOmP0Wh0h/a/p76sG019EaTcAf+5ZC5PkVRilofkImGHCVX0C3h/D
   k3JT+RtPoQesUQLXj35Roch1CPgeRxDb/N7fQ/DIBHZo4VD2SK/dvi2WS
   Ui9ykOtTgnkRdiSLSlmYPUlL90u6gBiuHzucZgG+r9nrjQiE96ycYtqTS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="48206514"
X-IronPort-AV: E=Sophos;i="5.88,304,1635174000"; 
   d="scan'208";a="48206514"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:00:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erwLylxdvAImob+6u2Ms4jnmZlfasyVWl8zgYNPveU5rZ0WIL+ospdFfZnUR4l3agc8/7XLKt6CzWcN+0uc/g9Ce9WCqrZWClAzSXJE5Cz7ylzJ7bcSnNi0MLQ4021gYaux4mh4jebYwPi/r7Y813g6QwaM8UE4LmN2YPp/TQ4gpQTQAjPD6766N8ACoeOMZRq7Zo9fgGHVbg/RTOCOnHw66Rrr0QnjPmabY7Z+CmWNMJv42+8VLtawjZF1l8/8+5tYzNC5yFsIkKEv+UfPR300R2lbdbBCK/w42dsOGX3AZ4CFeQEVs7rXbszRxOqfvYK6O8b+Ny6HgihRovw3IzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCoYhd2f4aJvrjcitnnwvaQqJFUQqw/ynQkMsiv1w8Q=;
 b=ejIcOztdJpM103KauWV40khTGeLOAJD8DKylHM9eqrwI+GE2SbHgIElUNVTnNWhKk++Jdkc0b5kN9WhhwraDjmlnKY89hGDZZDs10u7hzPLjxb1//EKwc7eyA0seLKJe4MFOYf6X3CspmfHSL5P+6CQcnZvj7RBZd3AJtXnp5iR1/m3Nq5mQWCxu2NEps0Blq3I1XqLjP0fIbaj/Blay5KVTetkm+Y6hjHDad2Lsv8m78cc4h1aHfRqio53Iym1YAg1QQIGf9Uyo0NHW40EWj8XOFMW8BNUAuvlr3Jo3F4KkqAHgv0jaNNvSCSZ76Ql7l1gUVC3Y9hst4PTvbBImmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCoYhd2f4aJvrjcitnnwvaQqJFUQqw/ynQkMsiv1w8Q=;
 b=KqdilVT25wM1Pv8QC1x9UQ4Uk7ZIJZV4CQZVDkJDyzTztv+l3quHF5hiw5fpPnmloFer10W9Lax50WuiGfMB2lvdCkTSLZF0poFKq+sliplZl4lFCIb6KBaBN0Gi8erINk8E3gGTVpTYSiBIJpaRk8OjGDFHZJgC8F+3gLlOyW0=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB7872.jpnprd01.prod.outlook.com (2603:1096:400:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Fri, 21 Jan
 2022 08:00:03 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%5]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 08:00:03 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Thread-Topic: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Thread-Index: AQHX8Ajkoh1qZfqmsUSkznAFwBN9i6xW1zkAgBaAhyA=
Date:   Fri, 21 Jan 2022 08:00:03 +0000
Message-ID: <TYAPR01MB633065A420048BC4A2161ADB8B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
 <b05d487e-bb8b-56df-8304-6e91323e9d83@intel.com>
In-Reply-To: <b05d487e-bb8b-56df-8304-6e91323e9d83@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-01-21T07:53:01Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=0f5d19c0-82ee-4255-a6d3-68ebc61379f0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f858f644-76f6-4eb7-2983-08d9dcb40804
x-ms-traffictypediagnostic: TYCPR01MB7872:EE_
x-microsoft-antispam-prvs: <TYCPR01MB78729941548CDA867AB358448B5B9@TYCPR01MB7872.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBCsb7pgbemDFp8oWCt/UsJG7FvP/svA+cOBYi+yt2U2gl/poAX5bK5jswQqdRV+FQR6XuwVMkO/Di76JNnRSxbo5UvkIpIyl5rHVzThliztErbexXs4vNXXmks1usIufskuJ/f9gZL5pYT/B3xaFHBOg5IKirDGPYw7LcTH7RXdV/wwnh/Nmt5wKo6XC21ahF3QS2RZp5NGbc68BC+nmBkGo2dgGGgE6+j5qipyQ0LpKN91N8Jxn7R3XZ3MXO+iBS7/bQ/fwtHdWVQzDtZFVpbm/BObjZozyXo/ZI2dKYDNcY05fbzL8/ss880EgY/phCDSgF9Dy899a4Zmm7Ydz1nlxJqw+dt+5t0woMZv3BZHwkEngbnxJs4JrYT9wRNBGF/kceYX3EogXYMNMzQt1ieKx2WHX2QN4X9SDV2eMnt+mYUuBw47mSOs4egbDxfrhls8qhVHM83luMnd5MnRfJBBfVPj04+OYYojGGYh7nWbpk8mOsgfXzDPZNh0E99avyf/zHztUAXoHod1HKyHvwhEpOwQVROOBr6zDXy+y5bR/k3lxS9+elJZDV5Zi4CXDOQfpHqEyB1P40QwuR0P3VBTFeB5iMQeqRtQe/Q/FDJUTk90HQoi6HbB1nodGuGYtG7ZsAp/x3emZSTaCFycJtThGnJ+GRldyb4+ZbPVnLCSV7jzNxRBtZRJmYfBLN50Fvzq1P/KENjlJWGaXWK/HA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(508600001)(186003)(52536014)(8676002)(2906002)(6506007)(86362001)(54906003)(9686003)(53546011)(85182001)(8936002)(55016003)(110136005)(316002)(33656002)(5660300002)(26005)(38070700005)(15650500001)(71200400001)(83380400001)(66556008)(38100700002)(76116006)(66946007)(66476007)(66446008)(64756008)(82960400001)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NEEyZUpQVWhDK1Z2SmJWMktwalYzclFoYW1IK3phajdoYVVXRUxuT1BX?=
 =?iso-2022-jp?B?SmxlZ2hKaDE1RndLRzhoZVNhalZRUSsvUGhCQkdPS2x1aEFDU0IxZmZM?=
 =?iso-2022-jp?B?clpBOXRlV2N0aUZwdldraWNRR2w4MUlGRzc0TlRmajhBdlo1R0J0c3o0?=
 =?iso-2022-jp?B?bWtyWk96UnF3Z3cvMUlKZU4yOUo0OHJlcndlaG83VFJ1U1djdHR2OThu?=
 =?iso-2022-jp?B?VVowTEtncXZ4WVl6cmNkcHBDOGVjeFVFcDI2TlZZWGxMTFBLRXh6Y1Mz?=
 =?iso-2022-jp?B?bG9DWmJRK1BZcXQwcG1rRXc4cEhZdDdOUDN1UkUxejBCU3ZmcFkyM2s1?=
 =?iso-2022-jp?B?TGdERW9QYU5sM2Q4MmI0TUJ4MDE5V3AxQkFxbGhFWUI5MzRMWXo4OEVo?=
 =?iso-2022-jp?B?R2RBT3FaOFhkUFFXbExZTnVpTTNJR2VDS1NDSnVKWEdOWHpuMUdpR0s3?=
 =?iso-2022-jp?B?Z0NHQStHVmVOMjFwR0NHSTlRWjdIQk9GaXE1THhZNTRyRlVQdnZQVVBX?=
 =?iso-2022-jp?B?bTYrYk9tNmdOM0JpbmVlKzBDbVJMUXBGSUJ2VCtPT1U2QllLWWowV0wv?=
 =?iso-2022-jp?B?M3JVSHJOdWdYWU1iN3ZMYzd0dUFUdjVmQkt1WU9KWGVtSmlQWlZFL1ZF?=
 =?iso-2022-jp?B?ZCtDWDB5azVobnc0eWhLSFZkdGFYTWovbGpNUEM3cll3R1FPVHVZaTFv?=
 =?iso-2022-jp?B?UnpObGZhaUEwZEdja2xMM2FOam1VaEloUm9NK2JhRWFROHQwN2gzem4z?=
 =?iso-2022-jp?B?Zm55VldmTTg2cVlSNUl3ZGs2TjZXaXlBZnZJTDd5anJiZjJ4M2l2M0k2?=
 =?iso-2022-jp?B?cDNWc1F5VEJNOXV6RXBTbXovOFFDYlphSzZMZmdIK2FSMFpIck1JSUs5?=
 =?iso-2022-jp?B?THh2L04xcWNESnZDaGVhMXJSc1RoL1dHQ3lldGZqL21rTjhZUXVndkV1?=
 =?iso-2022-jp?B?OWFuMHY4cHFuZHNlN1R4RnIxSjlmS2xjQUh1d2NOc3dWTTc2Z09hL21M?=
 =?iso-2022-jp?B?cXQ4Mm5YcFkxdlA0T0tBdVorUVBMdEJ2cmRENzZQdllUVmpYR2JkQSt2?=
 =?iso-2022-jp?B?c0F4UGZqT3pTTm9aR1lrdVZMUGN3SWozOFc0bzdSc3RZTWtDakRHSlQy?=
 =?iso-2022-jp?B?eWl5NCtvVkhiY1dCQTZjK0lwZXZjWmpsL082UTluUEFwRVNCNjFWZUVL?=
 =?iso-2022-jp?B?SjRNUVpwcUNaOXdmK2VKVUphazVFYVVONFpDTG02amJWelJiYkI2SXdk?=
 =?iso-2022-jp?B?a2tvQS9aRUJ0WWovbkd2N290WGR2WGg5bVZkSzRoaHI0ak44ZmZlejhm?=
 =?iso-2022-jp?B?TVVuMXplQ2ducGVtUkYyZTN5U1ljd01pWWIvamk4SHhhT0hMSUVFTHF5?=
 =?iso-2022-jp?B?VlowVndGWTdTc1JoTWk0T0dzRkRtL1pSZXROc2Z6UjBiMnJWZHhlS2U2?=
 =?iso-2022-jp?B?eExtU016YzBBaXlpN3A5TmhlcmlNM214dmlRT2ptQWNYSlpZZ2ltZjRi?=
 =?iso-2022-jp?B?ckF0NHV2OCt5TGRmc0Y0OC80amFWRmFBZ1dxamo3VlIySjNSek1TRnhQ?=
 =?iso-2022-jp?B?N0E0dkRrOERtS2U2eE1XdGNjNHlYOWV0U3BnM2YvbGIrem0vL2lEaUdn?=
 =?iso-2022-jp?B?MzArRy9ZWVkrNkZ5UXhlMnR6K05TMFlWVVh6QVlJUVRxQmpQS3ozZ1hi?=
 =?iso-2022-jp?B?aEEzLzd4clJOMXpLTW8rczlVdWlReWdjaDF0UHRZMldzcmhwOUhmcUdG?=
 =?iso-2022-jp?B?eVFMOU5SZlY0YXpHMkRZekVsRzRMVDFxSXRpcWRTRDYvTUg0M1NnQ2lI?=
 =?iso-2022-jp?B?bVlCNDg1Q0NiRFVFTzFUNlBSamsyOVJoTkxGQ1BLeFhnTzVXSDRyWDBm?=
 =?iso-2022-jp?B?K1lzSXZsaXRjNFViSGVlRTFTbWcrK1RKZXlaaXNqVTNER05GTGxaNUpD?=
 =?iso-2022-jp?B?dDFJM2VKaGhwbFVyQ3dGYlVUOHJPRmVEWk4yNmp5RzBtUzBUODZsbFcx?=
 =?iso-2022-jp?B?ZXFYRmdINGdEdzREMVVXbW9KUGc2dTZzOW5oMWpGS1NHQlBwT0J0OHNr?=
 =?iso-2022-jp?B?Smd3YWpIL3RKVW82RXdXM0Mxc3RySkt5U2RWc2pwUGttQXFkV055WSt4?=
 =?iso-2022-jp?B?TE9abkRibjY0Q2IvczNjMTl1bk0rYlU5VTNmK09BSjRpVlZZWU9QREtR?=
 =?iso-2022-jp?B?bkluSDBORG1ZRFFzK1JkNzlUQWlVTG1FLzZHWVZBZms5V3BweGtpZzM1?=
 =?iso-2022-jp?B?Umgyc1BlR2lCRnJZNUxKRi92UE1vYnJGQVNvY1o2N1BhOUFQY21TeTdj?=
 =?iso-2022-jp?B?enF0ZERxT0hPODhYVnYwY29qbHhQZUZHbG5rTmtFMi9Ib0F3RmZ5TTJl?=
 =?iso-2022-jp?B?aEtQRVhtRVJWbDVibUtvTXZFbDAyWUJwNjVGWDkrbmRuKzhsb2xnSHNy?=
 =?iso-2022-jp?B?dDNZVkdnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f858f644-76f6-4eb7-2983-08d9dcb40804
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 08:00:03.6194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVIEBA+Rg0Nj2hU2esbmPxHEijDbo5xfLJheIaoK6kQTAk1fAjTIJx8ywX1+IHYvDJit7/pcVEUPfCqteCy1xwwowx7U0Z6ITDDM4vU0rTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7872
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

> On 12/13/2021 2:03 AM, Shaopeng Tan wrote:
> > If the result of MBM&CMT tests is failed when Intel Sub-NUMA is
> > enabled, print a possible causes of failure.
> > Since when the Intel Sub-NUMA Clustering(SNC) feature is enabled, the
> > CMT and MBM counters may not be accurate.
> >
> > Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > ---
> > Hello,
> >
> > According to the Intel RDT reference Manual, when the sub-numa
> > clustering feature is enabled, the CMT and MBM counters may not be
> > accurate.
> > When running CMT tests and MBM tests on 2nd Generation Intel Xeon
> > Scalable Processor, the result may be "not ok".
> > If result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled,
> > fix it to print a possible cause of failure, instead of SKIP these
> > tests in v1.
> >
> > Thanks,
> >
> >  tools/testing/selftests/resctrl/Makefile      |  1 +
> >  tools/testing/selftests/resctrl/cmt_test.c    |  5 ++-
> >  tools/testing/selftests/resctrl/mbm_test.c    |  5 ++-
> >  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
> >  .../testing/selftests/resctrl/resctrl_tests.c | 36
> +++++++++++++++++++
> >  tools/testing/selftests/resctrl/resctrlfs.c   | 26 ++++++++++++++
> >  6 files changed, 73 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/resctrl/Makefile
> > b/tools/testing/selftests/resctrl/Makefile
> > index adfd92145e12..6d257f40e6ac 100644
> > --- a/tools/testing/selftests/resctrl/Makefile
> > +++ b/tools/testing/selftests/resctrl/Makefile
> > @@ -1,6 +1,7 @@
> >  #SPDX-License-Identifier: GPL-2.0
> >
> >  CFLAGS +=3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2
> > +LDLIBS +=3D -lnuma
> >
> >  TEST_GEN_PROGS :=3D resctrl_tests
> >  EXTRA_SOURCES :=3D $(wildcard *.c)
> > diff --git a/tools/testing/selftests/resctrl/cmt_test.c
> > b/tools/testing/selftests/resctrl/cmt_test.c
> > index 8968e36db99d..c5a49444c5a0 100644
> > --- a/tools/testing/selftests/resctrl/cmt_test.c
> > +++ b/tools/testing/selftests/resctrl/cmt_test.c
> > @@ -136,8 +136,11 @@ int cmt_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
> >  		return ret;
> >
> >  	ret =3D check_results(&param, n);
> > -	if (ret)
> > +	if (ret) {
> > +		if (sub_numa_cluster_enable)
> > +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
> is enabled, the
> > +CMT counters may not be accurate.\n");
> >  		return ret;
> > +	}
> >
> >  	cmt_test_cleanup();
> >
> > diff --git a/tools/testing/selftests/resctrl/mbm_test.c
> > b/tools/testing/selftests/resctrl/mbm_test.c
> > index 8392e5c55ed0..7dc1bdf2d0b8 100644
> > --- a/tools/testing/selftests/resctrl/mbm_test.c
> > +++ b/tools/testing/selftests/resctrl/mbm_test.c
> > @@ -136,8 +136,11 @@ int mbm_bw_change(int span, int cpu_no, char
> *bw_report, char **benchmark_cmd)
> >  		return ret;
> >
> >  	ret =3D check_results(span);
> > -	if (ret)
> > +	if (ret) {
> > +		if (sub_numa_cluster_enable)
> > +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
> is enabled, the
> > +MBM counters may not be accurate.\n");
> >  		return ret;
> > +	}
> >
> >  	mbm_test_cleanup();
> >
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h
> > b/tools/testing/selftests/resctrl/resctrl.h
> > index 1ad10c47e31d..4b8ad4fbd016 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -76,6 +76,7 @@ extern pid_t bm_pid, ppid;
> >
> >  extern char llc_occup_path[1024];
> >  extern bool is_amd;
> > +extern bool sub_numa_cluster_enable;
> >
> >  bool check_resctrlfs_support(void);
> >  int filter_dmesg(void);
> > @@ -85,6 +86,7 @@ int umount_resctrlfs(void);  int
> > validate_bw_report_request(char *bw_report);  bool
> > validate_resctrl_feature_request(const char *resctrl_val);  char
> > *fgrep(FILE *inf, const char *str);
> > +char *fgrep_last_match_line(FILE *inf, const char *str);
> >  int taskset_benchmark(pid_t bm_pid, int cpu_no);  void
> > run_benchmark(int signum, siginfo_t *info, void *ucontext);  int
> > write_schemata(char *ctrlgrp, char *schemata, int cpu_no, diff --git
> > a/tools/testing/selftests/resctrl/resctrl_tests.c
> > b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index 3be0895c492b..bbab4a7f37ed 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -8,12 +8,15 @@
> >   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> >   *    Fenghua Yu <fenghua.yu@intel.com>
> >   */
> > +#include <numa.h>
> > +#include <string.h>
> >  #include "resctrl.h"
> >
> >  #define BENCHMARK_ARGS		64
> >  #define BENCHMARK_ARG_SIZE	64
> >
> >  bool is_amd;
> > +bool sub_numa_cluster_enable;
> >
> >  void detect_amd(void)
> >  {
> > @@ -34,6 +37,35 @@ void detect_amd(void)
> >  	fclose(inf);
> >  }
> >
> > +void check_sub_numa_cluster(void)
> > +{
> > +	FILE *inf =3D fopen("/proc/cpuinfo", "r");
> > +	char *res, *s;
> > +	int socket_num =3D 0;
> > +	int numa_nodes =3D 0;
> > +
> > +	if (!inf)
> > +		return;
> > +
> > +	res =3D fgrep_last_match_line(inf, "physical id");
> > +
> > +	if (res) {
> > +		s =3D strpbrk(res, "1234567890");
> > +		socket_num =3D atoi(s) + 1;
> > +		free(res);
> > +	}
> > +	fclose(inf);
> > +
> > +	numa_nodes =3D numa_max_node() + 1;
> > +
> > +	/*
> > +	 * when the Sub-NUMA Clustering(SNC) feature is enabled,
> > +	 * the number of numa nodes is twice the number of sockets.
> > +	 */
> > +	if (numa_nodes =3D=3D (2 * socket_num))
> > +		sub_numa_cluster_enable =3D true;
> > +}
>=20
>=20
> Unfortunately there does not seem to be an architectural way to detect if=
 SNC
> has been enabled and the above test is fragile wrt the assumptions about =
the
> topology of the system. What we need is a reliable and future-proof test =
but I do
> not know what that should be.

I understand your concerns.
At least I know SNC affects on the 2nd Generation Intel Xeon.
So, how about just printing information when the test is running on 2nd Gen=
eration Intel Xeon?
That is, when the result of MBM&CMT test is "not ok"
and if running cpu model is 2nd Generation Intel Xeon,=20
then print information about the possibility of failure (SNC may be enabled=
).
How about this idea?
Or, do you think we should drop this patch at all?

Best regards,
Tan Shaopeng
