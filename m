Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB71D6F13CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjD1JFu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 05:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjD1JFs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 05:05:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0ED270C;
        Fri, 28 Apr 2023 02:04:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S7iI15008361;
        Fri, 28 Apr 2023 09:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6OE6bTtkusBZODtGZJBC8+Ez6k+w4v1jzjBcILj74xE=;
 b=2OExsJ9wn6Qg8DzAzfQGW//mCJSjVlKG+LmzTO5OXWsRjw+6YZ+N8JE/w4ACJ2sBT9LS
 sQATRxr3r8mdPJPEfHB1l2OEP3LnLQgkkVPFbJXe9p8b7D6siO+UjCZkRz1wwP3uL1hf
 sCXOa+upX1nsqCeKRqAYT0KTj5XjOWH9RcW4qsOBsvM4/ZKBk++ICm+fjDIw4X932jS4
 UW8n3l7FvdcMuel14NtDHFo/sPvt9hrIvSL6n2cg1x8jPgSFBGtJF6mBJEzuSUVqCuSt
 W94mNhsIrA1MeTZIydrA/Zyn6LpgT7sTx0WcnPC0KnPpN+ojH3YNK4DXWR1UqunJ94n5 5g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460ddqpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 09:04:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33S8FNIv013368;
        Fri, 28 Apr 2023 09:04:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461a9pcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 09:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECyCkhcwNDZM12rB+6Rt5EIrG+XXV7dm8ZjOl6JHjsHAMIRZAv80XOtCNRhrxePEb4ZYH3191m8Aa/LCcbSHMZjiLGnMnwY3r5LWDOwtHKozRYkZEpNnPguFZ5qNLrLmtdKfoMwlofh4NzzMLewYumL+4SvXFucJ7HQAdgMwuNpVhDoifbtVMtHMazrAhgxZJEDoe2ak9sO5X6S1qcHr2o7Y3u7X8o1AVzSR000z8VDi7ucIj/R03LRmMwyv5s1ODXEViH3VRZI3JVNEkF2hi6691r0h+DFhlgm3CAjk+pdqcnWqR2CF35Bb7dyLctwQ9FWWXN8HM2Z4fmnmxImdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OE6bTtkusBZODtGZJBC8+Ez6k+w4v1jzjBcILj74xE=;
 b=noTAIBXCAmbekpdwTQD5IyOGZrUP0jWXsm+YvTnkQhsp9d/mOwHcC9WuxjzC20SlCI++5tOmpXsWVN+qD3oGV1PePeZGDuuloGwGBB7/rfFQi2DTwv5JSRxChudD6tR7UJrK8OLxYu6hgEnH9foZMX6a3n2sivxmNFzPtdSvFurBoUj/PRv3Ml2Q249XCPxtjtcLKCG7ZnoaNKrwqmfPckJ32QqUX75PxC4Lt3T1sjYAr5T/7SL+/6ScFTJEdnJquymaRo3DLx/9CA57Dzs1gKJm7wKuQebrCsCbpHWzinydSrM3nbgl/7RSJ6xDHVYUhacy0qSMFqKBMm/eyUD/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OE6bTtkusBZODtGZJBC8+Ez6k+w4v1jzjBcILj74xE=;
 b=lz6YVGv6R+CtAfEHHxy4d8ngrFgp0uSDJc/FAucqcGS3nOXn/BSPHY3OdDCjDr7CDb2pYMeVe3+G+OKlZzEbGalNvlsAXTwM5eRJ0wMq5wyoVyfgEYCtYzcGNiWhR410hKwAIlyrqWZFVmYf0Batre65RRCVtcMj19l+9G1uTRw=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 09:04:03 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 09:04:03 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
In-Reply-To: <CAEf4BzatBnBH8RHczLerMsW4NvTtx6xj5COjGzVvTkRxfciw4Q@mail.gmail.com>
        (Andrii Nakryiko's message of "Thu, 27 Apr 2023 16:42:40 -0700")
References: <20230406004018.1439952-1-drosen@google.com>
        <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
        <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
        <CAEf4BzZ_4kcM5=Jo3JoWQWugS3wkrtoteyM8YqkykFvYywG+kg@mail.gmail.com>
        <CA+PiJmTsEsUi3c5soodZHxS_PvMPnJG-4bFvdfpLq-kPZ0j4UQ@mail.gmail.com>
        <CAEf4BzatBnBH8RHczLerMsW4NvTtx6xj5COjGzVvTkRxfciw4Q@mail.gmail.com>
Date:   Fri, 28 Apr 2023 11:03:57 +0200
Message-ID: <874jp0bcoy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 24476aa2-4d5c-4683-cc1a-08db47c7831f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOy+KQ9/bbHoVIw6x2KMekavOFP45uKBCcuZ2yHA37E0VU0cPrqeOtreJyvY2I9sbrPwsNwLcrSvpHG4Y0o3/6S6hRkiKjI1SsE9pZxeK84I4bcgZtSyum8bUHY3MzUJzqqqwMJdCF5WSCwEWPWEZSavEjsLwmZH2usq1YxYMbZs/7JFJTLksQklHcjUE7ifW1tdJ1oE/2Or93KHAxEPEA3JcsPEnDQ7T0pmL5QQ0jVZQMttGZXvRF8thUO4Rd8svCWgTK0PXlwD7SQU5awt5v5v+6AHXkfwaA7Gg0oIxfIKkBfJt3GCNOc99bgBdPDPIHVNIjXZ6p4/Vt2K+rV6eFBXibcN/sRNwz4XxgiVcz4axCESeN/BUHcP8OhqN482AIFopPsnGc2n045y0VvRVgAK1esyTmIgv4dTMSskiDjkIsKvzvkMrSZZvEWJYHDgrCRhzzbBnUWIpb8tY9vR5KpaLoX21ytBJc3RlnhasaCmJpaGKZYA+gr3Of+shj8JyfvD5zVglQITzIkedte7UonI1rN3m5iVTlDdWUU2QXTxVCjHKZFpl+S6a36oV1/N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(2616005)(83380400001)(186003)(54906003)(6486002)(6666004)(6512007)(6506007)(478600001)(53546011)(86362001)(36756003)(7416002)(41300700001)(316002)(8676002)(8936002)(5660300002)(66556008)(66946007)(4326008)(6916009)(66476007)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW4vSkJVcGxlT1NUN2FrSHByWGJnK0VTYnpOaGhRbVk1Q2d5RjhDVUxsZWJt?=
 =?utf-8?B?QkNLREFxMUMrMXpEVkhReW1ZdVdIZmRoY0ZlRTlXbWNwUC9ySUMzQlRkWGcv?=
 =?utf-8?B?QmpVUk9sUUl5UjBkd3cydXB1SmdUcGpib1FxYkNJM0k2WTFDakNMTWFWeDZh?=
 =?utf-8?B?N010RUpPS2oxMDVpY1lVaHowV3U5Q1hORzNYaTR1dFFWQzd1bWdDeEdZU0hH?=
 =?utf-8?B?Rm9ucC9pTWE0ZU1yTGZKb1hsdjBUYXNPN3RwNHdaSytQRkY5NmFzMjRZUEho?=
 =?utf-8?B?K0ZWZU9Qakx4VmdUR3ZpcG0zMktIZTdTc2xlanFXK2ZWUDhhWDBHTWpqcndH?=
 =?utf-8?B?cFdCbEZyV3N0YWlueHZlZ214Z2ZVdkhiTUhRWkNzWVZYNjQvN2R3b3hyT21h?=
 =?utf-8?B?eDhEaUY4ZzU2TGdidmVtUVQ5Wm85cG5tcXpXUEovQW0zZzdKYVNCRGppZmVG?=
 =?utf-8?B?L3U4L21QeFoxbDZCNEpHcmFONThzZ05sbjMxZUFGbTlHZUlzTkplQUV2cVVa?=
 =?utf-8?B?bW42L2w2Z0VkUzJwS0tBKzVCcE5SNlMrODY3eHFtVG8wczcwRXBnN0piSUlx?=
 =?utf-8?B?aHptNFhTN2M0UE1vR1IrSnkyWTU5ellIY1YvU0MxR2VmNm9qb0pZY2EzRzV5?=
 =?utf-8?B?SUVMYytDWHpoMWtYQmp1R3JtMVBWMmxtc3RuMFp3d2d3Wm1DOE0vS2JHRkwz?=
 =?utf-8?B?RXdOMmFuZjNLaVp2bk1jYzM3Rktxd1pyWFV6dk44VHdVaXFVejJhVDZCdHl4?=
 =?utf-8?B?cG5RRVVVRkQrNWo5aWNTWVd6UWExcXhjTEpreCtyYW82NFJ2SGlLWitSZkNk?=
 =?utf-8?B?VWUvYnh1cngyaHdtU291WXh2eERaRndITHdneHNCU2Y4QzJkVTVTMTB6dkZ1?=
 =?utf-8?B?WnI2VEZxRGJpVEF0Z25jcGhHYWM0ZVdmRjhtb2NLNVFPL3YvQjY3SktFbkhs?=
 =?utf-8?B?eTZpb0RwcHN5cVlHUVhvWWUyaXg4Zy9IeWVRNS9TVVRreWtHSEdCTklWbkFX?=
 =?utf-8?B?WWtNWWFXSTkzWUFqUTNucWFOSGpPVUtvNXFRT0E5bHhrN3ZGeGk1YW1xc2pS?=
 =?utf-8?B?WFBQQ2xNUXlydjZKV3F5OTVwL0tGUWZ6eVpBT3pNd3dJZTRqd1J0cUhacTl4?=
 =?utf-8?B?cmFlTFV6d3NvOWs2NWR5NG1OK3JWRmx4OFVJb2tmMHZlVnQzclFKbjVtNnlB?=
 =?utf-8?B?U0kzUWZIcWM2TWphK1V2T0lLQVlWbDVZM2hVN1hhbWZFRGR0My93T2I2UWRp?=
 =?utf-8?B?NEE5MzhqbkcrMExqZWk3VDlZMTRCcFc3K240S0toMmRuVDVpQVhVMlg0Wnox?=
 =?utf-8?B?akkwdmY3Y0toTmZSU0FZRmVCM3hEWlJEeXBvL3pQSWtMUGtSK1VHYndJNkNB?=
 =?utf-8?B?K0RZRXRJeXJYcDFWQUVTL0hJb1AyV3cxSVhMUk9HTS9sU2dqMSsycElRSlF4?=
 =?utf-8?B?UkVLZ29POElyTThWamlZMlp3L0lNWUpzWWNHVGl5S0NLdGVMQk9IK2JZSC9J?=
 =?utf-8?B?R3dUcC9ZZ0FCNzVHd0w3U1Z6cWo4RmNmT2pleEtmVEdGU0J2dllzSXdPZld4?=
 =?utf-8?B?ZjVPcUJkbDF5MHZ2Vm00RHZLc1czL3c3ZVo1WlVQc2VpdldnaVdFMWhQUld1?=
 =?utf-8?B?M2RiNVQyYWtvLzNVTng1UHVtL2dNdVlQdUtrbGlScFg3TWRReGUvdmh2MCt5?=
 =?utf-8?B?aDVoWUkyMCszVjhKME9lejZjU3o1aVNrQ05mK3VvMXUybE0vMmUrQytmTTlC?=
 =?utf-8?B?cFMrVlZaVW0vZk5VYzdTa2dOQk5qTzNsVXlSS0NvUVJDdjVWZkF3eGIzMDNl?=
 =?utf-8?B?V3F0eGRxZDc4WHNPVU9VUkovTzNpMUJaZ25zb0FrdG5rYVV6VmttdWVJZlZi?=
 =?utf-8?B?UnVYTEVnL1VtbzdUMzN0NTlNdXBXdUd4SklJc29ibWxUd1NyaTV6YXFnR1Bm?=
 =?utf-8?B?ek5EeWtuWm5wSmRqNEdSY3BRWHVRb0lBTVJzZWVpSFBDRlUrZVM5bkVDNS95?=
 =?utf-8?B?UG1OS3RqbitvNWdPdUFvbEQwOXZoNlE2YnpwQXNVQ2VmRWFsOWtWNHRldXVk?=
 =?utf-8?B?Q0o4TVZaeWNVazlZM1d4TVd6cnIzL29Xb05Ya2VaME1CVDMrQ3FncHFYSyt1?=
 =?utf-8?B?eTVXQXY2TzlOaTdMUUFha08xMm1pb0FOUzFQVGNjUFFPWVVhQkJMSGhGckdP?=
 =?utf-8?B?Qm1PRmsySmcvaVY1czNEYzJaSWU1RThYUGdiVDRxQW56ek9vY29ZWjF5MXQw?=
 =?utf-8?B?Wno3SXVyZURKd1lzSG1EVkNLRFhBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U2RYYUFoajh1dVJ2bDBvM3BrQm9UWW9jUDRmanNXT0VVaUhmdjY2T2FVK2cw?=
 =?utf-8?B?ek0xaVZuVmNYWXY5UGUzdTcxZDJoQUxxaGpaV0N3a0trblNlTzJDd0hmWDJ3?=
 =?utf-8?B?ODhPVFU4dmJEalIzemJ0YjFyUUJmVTIwbE1nN0hndWRtT0hmc3JiQ01nZXBY?=
 =?utf-8?B?Z2lTUXRvbXZidnRRZ0RaaEFvVVIxTHM1VUtZTVJyUE9MUEVkdFFqVFpJSnF0?=
 =?utf-8?B?b1c5L0MveXhTa0JSZWdJQ2RBbjJJZXhpWHA2cGtNUDVpbDZjSGhxY29zZ3Zk?=
 =?utf-8?B?dVJoL1o5V05jNTB1dzNoOFBKTXpFNXV5Znh2dG1nb2szbjhZU1JGMEFPUE1p?=
 =?utf-8?B?Vm9mMG1Zd3BpYXpPeiszME9qeGlRNHAyTGZKN05wRXo5YTNTT2NLYkNaMmFM?=
 =?utf-8?B?Y1NsNk1oMnM4NUdkN01aTE9tUUlaallVQjg3bzFZNjgydUVMTkY0bWtpUy9V?=
 =?utf-8?B?SXlRc3ZIelZCSXBKY0l5WGNkMk5jQlozRjRuUmZNS1V2LzZtY0VEZVZuZno1?=
 =?utf-8?B?d2dOdzF5R1ovMTNBZGlOWW1PTWVPcW9UYWdxaGplRUFpdGtlamU0WnpOMWlF?=
 =?utf-8?B?N2VnVzUxaXB6RERpejFLTWs5endJWEVyVnp3Znphd2QxYi84Z1ZwZlZnM0RO?=
 =?utf-8?B?MkdhV29ucWp6cmRzZ0RpbUUwMktJWTNzODhXMTZtMS9mOW9vdUxuYzZUNnZ3?=
 =?utf-8?B?NTFtVndjUytDRlo3ZGtVbmltY3pzWDdCRmRsSDVRRHhQbzlwY3JQR2MvQU1m?=
 =?utf-8?B?WS9zb2JmeVI1NTNKL3prRjJqeDdwRmd5ZXFUZ2s5bnVPemovOXdDZjZrdWI0?=
 =?utf-8?B?TEtjTGFyY1hIa2ZFa3UwZWhwNTN1V1BqVnAxR2VqbU1kT1dMNGhodW9VVFE5?=
 =?utf-8?B?Y3VpT2xkU3BDbmJpdEhkM1NZVDFFcFk0T3hDYnVsVURWd1F3UklTR1pwWGoz?=
 =?utf-8?B?NkExTWM0UFpvMzMrVlBKOWJncnF1KzhXcnN0MURqV3diR0QrSnBRelJUZUV0?=
 =?utf-8?B?QzZocFpXY0FnVElFMmh6dytZWVJkdTN1eUFXNHJsVTRyOVZxRFovUUlXb1ho?=
 =?utf-8?B?ZkY2UGxrZyswQWU5Z3ExRUpLem1udGVUcmt6RGd0T1RiaFZmRnVOanl2VmFh?=
 =?utf-8?B?NTZ5bVZCTzNDcE9mK21pdDNDc1RaakxWdlNwUmxBMnd5QUxwbDRVcDNHdHIw?=
 =?utf-8?B?WVdldFhYbUsvY0ZBZitnZmdQOG8vYmpLb2JZY2dvSC9tV1VVajV6SjJEa1pr?=
 =?utf-8?B?dk1JaUZuNVE5OHJWSy8yT2loSTJmMmVOUkdsK3lGK3ZVTDlkWmo2Y2ZEOFVv?=
 =?utf-8?Q?4sWZD7N8PuZH8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24476aa2-4d5c-4683-cc1a-08db47c7831f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 09:04:03.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtlGARhMWV4d/TqdTu2lwBsT/0z0s8kQSGQJLNZFspngEy90UAfKTwC7W7+Qk9IMx5UcqmfurdRtU7D6eymPAhzBSHOW6Us7467oZ+elD9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280073
X-Proofpoint-GUID: QcblucfBX1rLLrkurL_pnt2oc6Z__IrZ
X-Proofpoint-ORIG-GUID: QcblucfBX1rLLrkurL_pnt2oc6Z__IrZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Thu, Apr 27, 2023 at 4:36=E2=80=AFPM Daniel Rosenberg <drosen@google.c=
om> wrote:
>>
>> On Wed, Apr 26, 2023 at 4:39=E2=80=AFPM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>> >
>> > Don't know, show the sequence of commands you are running?
>> >
>> > I have linux source in ~/linux, and KBUILD_OUTPUT set to
>> > ~/linux-build/default. And it only takes this:
>> >
>> > $ cd ~/linux
>> > $ make -j90 # build kernel
>> > $ cd tools/testing/selftests/bpf
>> > $ make -j90 # build selftests
>> >
>> > And that's it.
>>
>> I've tried the same, modulo some paths. I'm pretty sure it's version
>> related at this point.
>> The current issue I'm seeing is "error: indirect call in function,
>> which are not supported by eBPF" when using GCC-BPF for
>> progs/bind4_prog.c
>
> I don't think GCC-BPF is able to compile selftests properly just yet.
> So I guess the problem is that you do have some version of gcc-bpf in
> the system and selftest's Makefile tries to build gcc variants of
> test_progs? That's bad (I don't have GCC-BPF locally, and everyone
> else apparently as well).
>
> So for now just `make BPF_GCC=3D` ? CC'ing Jose, we should probably
> agree on some criteria of "GCC-BPF is really capable of building
> selftests" and adjust Makefile to only attempt GCC BPF build in that
> case.

Being able to run the selftests is our goal at the moment, but we are
not there yet, no.

What about making the kernel build system to emit a visible warning
before it builds the GCC variants of the tests programs?  Something like
"this is experimental and will likely fail".

>>
>> Currently using clang 16.0.0 and gcc 12.2.0-14.
>> I did manage to get it to build by just commenting out TEST_GEN_PROGS
>> +=3D test_progs-bpf_gcc
