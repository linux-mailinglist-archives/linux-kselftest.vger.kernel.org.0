Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF764D425C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 09:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiCJIVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 03:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiCJIVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 03:21:03 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 00:20:02 PST
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839570CEB;
        Thu, 10 Mar 2022 00:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1646900403; x=1678436403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hXHoXQJuLU/cKq7n6jqA9gT9mElI4sCeIzwQZNxGB9M=;
  b=A2sPlZKo69IN06l+4q8p+49bTSovU9atcgUozbSSt7jNYeiVMRpwkRdR
   7AYbqMAYxpvypkQKXSZBp6z63DNqStv7mbfUkwiIl71oAlbg6SnXSi82z
   RiDXnTST7pEmxaRRH5xi9gjYiDabRoNHIGKNlr56IzcyJAkg8//m9GmPQ
   4M+hB7/wgSEJf2395pfgDl95dtajIhG5IXsjuEnafDlNHIuM0uWrF0kBI
   P5DCWAzbdh9+QxsusyewVeSQuwXpBsS+kXt0gAFZUkTtnNFzqOt8reCe5
   S+nXJHIuxqu4u4wZ3+LqJRej8Je+DhPZ2ZqAy077AuiHEwgkNbc5+mNP5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="51606249"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; 
   d="scan'208";a="51606249"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:18:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5ZQRXOZaQ9VmXsSOgHJu6uKep8iAe2avIuNPKAYCekdqaXwWIB7vK4HZAmOyLRN/oOEdLtGY8LBwvIueJrc1wbbCGnN4qERnRXMafx6i3cKszhGC3sn7O8CBi0Wz12X2H5naiTB12cFcoBf2VmZBObS8X5KqjW6lLLeOgEEtywDhiYqDoDL9jMnU8BIEMqprIfCGyPz8fcegAxrHmPJ6JmsZL5bO77jHzuG6b6yhhmbNVyyeR75H8zL+bMctEfafHRtjPaz8T4LFhPCuDugUMkaPpSQk3EzAmtDe3/tu5SVHjMPJ3916AZkb+uQ6ZeG4/sbbf0d4PBb+pcPt/ukGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLiIrydGtkkB3KOVEms/Qjy695JJV/yeWKshsz1ZnEE=;
 b=brWZmlPsWYpY0/zlOshi0QROb0AqVo2/O31mZXXaRrDyOS10eomObVKefEYtXYtAoMB0ooabekq8ZPQIictbdqCjwk+Am1mh6Wkqhzi5zJyyLd0eIOXnTnk1qPlf/Z5quuVrXZ0dhOiV4njjge/pvrPSjNuaBSHdwqt1GQliXvbHEwHmzRnmpjzSbwJ9Qrifcrwu2lGBXfgMyLgiTAyv1eAH2gEbx+cZ7XlOu4Wg/XHizUHpFRAEIGCosD0INSskWM0QaxTGp1TvMLvKhoOzWnKfdEsW3pwiW8sa4plk9uisCLC8fCAOsmaytXjzVGNMDazuo7B62XUK/6wwXNQsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLiIrydGtkkB3KOVEms/Qjy695JJV/yeWKshsz1ZnEE=;
 b=NGyqciIhalVF409lV3QvWIXYK0NCazL6nxmX+1B+7JviNRnpFNJqjFCuWGi5O3z4reJ5bs1vSTN8aMOLchu73NjJLrh3xYzUpBPoUA7JnHP59B+pG56EUcb35lSIvFUAlXm+2B/zbwA3uVKs7SneE7/OClHZOVkf+pC6q5hI7qg=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB6791.jpnprd01.prod.outlook.com (2603:1096:604:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 08:18:50 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:18:50 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Shuah Khan' <skhan@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed on Intel cpu
Thread-Topic: [PATCH v3] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed on Intel cpu
Thread-Index: AQHYL7RD0/HtLWYLGUq5/0oZbxMCdKy2CkIAgAJDRWA=
Date:   Thu, 10 Mar 2022 08:18:50 +0000
Message-ID: <TYAPR01MB63307F1C04270DD2D09ACF238B0B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220304103957.487660-1-tan.shaopeng@jp.fujitsu.com>
 <9647f7ed-6a02-8603-0de4-3292d4d13157@linuxfoundation.org>
In-Reply-To: <9647f7ed-6a02-8603-0de4-3292d4d13157@linuxfoundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-03-10T08:11:39Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=dab9cced-9c87-49f8-bb9f-cb9a5d643e5e;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdd75bb3-1ea8-4838-dabf-08da026e9b81
x-ms-traffictypediagnostic: OS3PR01MB6791:EE_
x-microsoft-antispam-prvs: <OS3PR01MB6791DA9A70E2EEE36FF876698B0B9@OS3PR01MB6791.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/4ctvHYGe+DOy5e24TKlxK4sF+fJzpCex58Hi8nPWl4Sq6UsOn5Mx+wt+RpAK6qRMUIW2anCalPvt+c8hLKRi1uSNSHu6Dv7NhzDxvmIfKrf3YXoqQQh1qoZWU44g2EEHFMgrFK3+bWlbVZeKbsTG6skVruCMscvBhYe5fNcc+78QAIYCm0Ws/7IlbxvwiH+HwbrDYuk0i7mAJq3X9cvXCLXBXApCoFyJF6JExyDEhYlWutku672lfb9fiH0kj33wscO4sTIHnG+xPKFqXK8XcjltOU/3vatCXWE3nbQyBsGaLOrnBBmJIgJyPedQcKUfACGjBW0561igNBSs86F6yyNLq6voRDoGR0+fc/3P+yb7OSIVfcDsnd6cQaXJQaCwk25F8+CIJYa/mQ5Mg3KXEFOlTz2Jaw2ZbIPAtEhhVXqvMQIK5xtoB+vFCnKY0DMZpTDn6JNmB9rhX1To1QSLNkuxsMHEPA8rO6aOI2h4Po7tMh9vOSqV/sNbDZu7/8f/SmYtnydXjPN4XTAN2bU+FWIdsFmeFivHbZEtDtXmWqmG8yOiUSWWKSLrcjrnj9t3NqvM1JsCjqljfrXYP/W7kqZ/VF98vLwN/0CagdqHsDgStljJDfQlguCsXTBkAD41o9iQxQgsYBHvaXiA6Zk7rS2o2y9vPoBbrYqm7V407sicOtXQ8xQW3x8U88IG3Tp77SQ6Q/5ibaECvFDivguw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(15650500001)(86362001)(71200400001)(26005)(5660300002)(38070700005)(33656002)(7696005)(9686003)(6506007)(55016003)(53546011)(8676002)(4326008)(508600001)(38100700002)(82960400001)(122000001)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(2906002)(83380400001)(52536014)(110136005)(54906003)(8936002)(85182001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dXdHSk4zNkdMa1ZCMTBlcGx0eU9vUWVHMHowS0pNaWsyTGJrSDh5NmxL?=
 =?iso-2022-jp?B?dWtjeU1TSUROcHgwaXd3anFwbHZwazVTZFhDT25HcFAvWjhUNmRrNGJt?=
 =?iso-2022-jp?B?aUROWTFZN0FhbEpiSVY0NmYxQ1FSMWxaamlaMnhTZ1JUTGsvSEFFM1NU?=
 =?iso-2022-jp?B?WXVXeVAvdTZlRFZEc3BkRWNuRGVWdWxsTGNjZXlIMHF2YW40aWVXK3ZU?=
 =?iso-2022-jp?B?SitqelVUbm9IL1dtcWx3VFM2V0F1RjNjeGIrTlVqdzZQS1dvWGNyMVZW?=
 =?iso-2022-jp?B?UG1TM0d0NU9aeHc3SjB4VS8wT0x5UnRmVVJLclhXSnRtWTRpR3ZtVVhO?=
 =?iso-2022-jp?B?a0s4bHZRVGNmWW9kcUJFNjNoRmFQUkNyS252VjU5RHdnT2pDSTFWMSsx?=
 =?iso-2022-jp?B?SWxLa1E1NTdrNlYxdzZ2SDJwdDBBQlpuK2EvdjVIMXdoYkxMN0xMVFNa?=
 =?iso-2022-jp?B?Y1dZditUUWhISFV4cG0rM1U3ZWlGRWR4TkRrcE1Fb21lUk5Md01xTnVB?=
 =?iso-2022-jp?B?ZFlkdThjV1N4a2JBdU9BVEdCaTNpcmtraWp0d2Fqa0pzWkF2cWZMclZY?=
 =?iso-2022-jp?B?bCtXczhhaUlMQXRGdjFTMDMrMGUvaGFzUGVsWjd4RjNQM2FiWXRrTTc2?=
 =?iso-2022-jp?B?cUplQnhzcytoek5tMlY0UWJ2T3UzblpXR29uUTdPRk44N3YzZ21wL1l4?=
 =?iso-2022-jp?B?YVBwdHBzUDFIaGJMR01ON1dWNG52dksxeHBCem5UdUI5bVBwcy85Unlj?=
 =?iso-2022-jp?B?Ny9HSUo1eWdvUEdVOFFPeE1nMTZ3d1ZualprRkR6YUlPcjB1dkVxelRh?=
 =?iso-2022-jp?B?MzY5U0t6SzkvcnJNSUtMMXdZcWZpcDVkc25Eay9VbmtrZ01jYkgrV1o2?=
 =?iso-2022-jp?B?QWRKeldRc3pvdFQ5SkFraVM2TGY5VWRCcEQvVkcrWUZDd09rZGt1amln?=
 =?iso-2022-jp?B?N0lLQzcyTHNoYmNxd0g0TlVJR1hvRDU0ZUU4MFZlTUYySnZLcldyL3dw?=
 =?iso-2022-jp?B?M296L2VLZkdKMW5IYzlWM3lEWW9iMERjWjBMZHlVS1NPM3MvR0FHMDE4?=
 =?iso-2022-jp?B?dVVVU0tPZGE2dlUzb2RINmZBOEZlbnZOY2ZTYjgwVllibmNjYUNMTmVH?=
 =?iso-2022-jp?B?SHhaTW0zWEZTdEcxanVwMUhOdGMwQW5qWWdCRDVKMHpmZ3phekdZOHJH?=
 =?iso-2022-jp?B?MnA0SWdaKzEyQVJuRWsyK1BBaUxhaDNxd3pTbmNUbk8wb2QwczhEbUx0?=
 =?iso-2022-jp?B?NUEyaE9HNG1BM1k5c2NsaDJXdjQxaVNpUHVmNGRiYXVRUVAxeTZzUVFJ?=
 =?iso-2022-jp?B?SzVOSGVjUjlkRlhiRHU4RmoxNXdWQXdCWWU1SDBuZHZobldYVEMwOHpy?=
 =?iso-2022-jp?B?cmNheE9EZUgwZ1owSWN2c2RoTW1BazZQdzdyNkhqWDJuZG9GRW5zOU5a?=
 =?iso-2022-jp?B?NW02dW9IVkV6R3BQNjN6RDk0eEowVSs1T3ZQVjNCcHMwL0QwZmZvRVly?=
 =?iso-2022-jp?B?TDE2OEVhb0NxWjFab1JySmR5TWFoWUU4R29RVkxJdXg3RytaTjc1emQ1?=
 =?iso-2022-jp?B?R3RZSXdBbWF4eUoxVWlEbEVZc0lmalgwQ055Y3hFMjBBam5vNldmemUw?=
 =?iso-2022-jp?B?TnIzNWpTNlJxMk1YdkUvMjNobGRTQzdNUDkvS3poZ0szODlIYm4rU0lG?=
 =?iso-2022-jp?B?bi9IajRVMTQ5OU1haWg0VVdaaVY5a2IzTi9VRFBWSlVER0ZCOVNleVIy?=
 =?iso-2022-jp?B?Z05XK2l3NVRUMUJuMXpPY3NMS1dCdlNmcVlWZFJyWWpLRm9SS3p0Vldy?=
 =?iso-2022-jp?B?M0pnbE8zMjRNOTlOTHNTL0FyZFhsTmhISEpBLzJZendTR2pkMzhMWTFQ?=
 =?iso-2022-jp?B?T2RUKzdkMGhHN0tUVjAyRVpkaUtndGhYR2liV29Qb1NFeStDMjdiSW8w?=
 =?iso-2022-jp?B?TlRCUUtwMGNGdy81V0dVbmpqTWJqWW1hZUJRMGoyamJMWE12RWdXMDRR?=
 =?iso-2022-jp?B?VWdsZUJoaFFZeTlIQy9pNlBJNWlzTlJIMUZIREdUakJ0TzNxaW1xODVL?=
 =?iso-2022-jp?B?ZlVPWUFBVmtFUkx4YXhKNEpCSVM2K0YxVS80c0FtRmNXRXdWUnIwU3kz?=
 =?iso-2022-jp?B?T0lHZklkTENGY3hvUEUvaGNnOXhmOTVnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd75bb3-1ea8-4838-dabf-08da026e9b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:18:50.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjOuy1KdcvPahV5twzMZ8eFINMAnvZBMP+5P2+9sDSILyaLsj/WTmoVraOXDItPk71fMRrCnRbCasGhs/QdUi+OU4Ws9mO1NO74lGX46GKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6791
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

> On 3/4/22 3:39 AM, Shaopeng Tan wrote:
> > According to "Intel Resource Director Technology (Intel RDT) on 2nd
> > Generation Intel Xeon Scalable Processors Reference Manual", When the
> > Intel Sub-NUMA Clustering(SNC) feature is enabled, Intel CMT and MBM
> > counters may not be accurate.
> >
> > However, there does not seem to be an architectural way to detect if
> > SNC is enabled.
> >
> > If the result of MBM&CMT test fails on Intel CPU, print a message to
> > let users know a possible cause of failure.
> >
> > Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > ---
> > Hello,
> >
> > In PATCH V2, I tried to detect whether SNC is enabled by NUMA info and
> > cpuinfo(socket_num), but it is not reliable and no future-proof.
> >
> > I just print a message to let users know a possible cause of "not ok",
> > When CMT or MBM test runs on Intel CPU, and the result is "not ok".
> >
> > This patch is based on v5.16.
>=20
> Also need to be rebased on mainline latest

I will rebased on mainline latest in next version.

> >
> >   tools/testing/selftests/resctrl/resctrl_tests.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c
> > b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index 973f09a66e1e..ec2bdce7b85f 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -14,8 +14,9 @@
> >   #define BENCHMARK_ARG_SIZE	64
> >
> >   bool is_amd;
> > +bool is_intel;
> >
>=20
> Why is this a global? I am not seeing a reason. These detect_*()s could b=
e
> moved to resctrl.h and get rid of globals.
>=20
> Instead of adding intel check to detect_amd() add detect_intel() or is_in=
tel()
> and have ut return true of it detects intel.

"is_amd" and "is_intel" are called many times,
in this way, detect_vendor is called only once.

Do you mean in the following way?
"/proc/cpuinfo" will be open/closed many times,
since is_amd()/is_intel() is called in serval places.
So, I think current is better. Do you have any thoughts.
----
bool detect_vendor_str(const char *vendor_str )
{
        FILE *inf =3D fopen("/proc/cpuinfo", "r");
        char *res;
        bool found =3D false;

        if (!inf)
                return found;

        res =3D fgrep(inf, "vendor_id");

        if (res) {
                char *s =3D strchr(res, ':');

                found =3D s && !strcmp(s,vendor_str);
                free(res);
        }
        fclose(inf);

        return found;
}

bool is_amd()
{
        return detect_vendor_str(": AuthenticAMD\n");
}
bool is_intel()
{
        return detect_vendor_str(": GenuineIntel\n");
}
----

> > -void detect_amd(void)
> > +void detect_vendor(void)
> >   {
> >   	FILE *inf =3D fopen("/proc/cpuinfo", "r");
> >   	char *res;
> > @@ -29,6 +30,7 @@ void detect_amd(void)
> >   		char *s =3D strchr(res, ':');
> >
> >   		is_amd =3D s && !strcmp(s, ": AuthenticAMD\n");
> > +		is_intel =3D s && !strcmp(s, ": GenuineIntel\n");
> >   		free(res);
> >   	}
> >   	fclose(inf);
> > @@ -70,6 +72,8 @@ static void run_mbm_test(bool has_ben, char
> **benchmark_cmd, int span,
> >   		sprintf(benchmark_cmd[5], "%s", MBA_STR);
> >   	res =3D mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
> >   	ksft_test_result(!res, "MBM: bw change\n");
> > +	if (is_intel && res)
> > +		ksft_print_msg("Intel CMT and MBM counters may be
> inaccurate when
> > +Sub-NUMA Clustering (SNC) is enabled. Ensure SNC is disabled in the
> > +BIOS if this system supports SNC.\n");
>=20
> This message is rather long. Please make it concise.

I will use the following message in next version.
"Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIO=
S configuration."

> >   	mbm_test_cleanup();
> >   }
> >
> > @@ -106,6 +110,8 @@ static void run_cmt_test(bool has_ben, char
> **benchmark_cmd, int cpu_no)
> >   		sprintf(benchmark_cmd[5], "%s", CMT_STR);
> >   	res =3D cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
> >   	ksft_test_result(!res, "CMT: test\n");
> > +	if (is_intel && res)
> > +		ksft_print_msg("Intel CMT and MBM counters may be
> inaccurate when
> > +Sub-NUMA Clustering (SNC) is enabled. Ensure SNC is disabled in the
> > +BIOS if this system supports SNC.\n");
>=20
> This message is rather long. Please make it concise.

"Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIO=
S configuration."

> >   	cmt_test_cleanup();
> >   }
> >
> > @@ -207,8 +213,8 @@ int main(int argc, char **argv)
> >   	if (geteuid() !=3D 0)
> >   		return ksft_exit_fail_msg("Not running as root, abort
> > testing.\n");
> >
> > -	/* Detect AMD vendor */
> > -	detect_amd();
> > +	/* Detect AMD/INTEL vendor */
> > +	detect_vendor();
> >
> >   	if (has_ben) {
> >   		/* Extract benchmark command from command line. */
> >

Best regards,
Tan Shaopeng
