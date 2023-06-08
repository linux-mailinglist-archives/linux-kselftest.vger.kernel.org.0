Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E6A7285E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjFHRB4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 13:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFHRBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 13:01:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDA9210E;
        Thu,  8 Jun 2023 10:01:53 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358Gm4O7013270;
        Thu, 8 Jun 2023 10:01:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=PdPEeLcShbY1ElpI+6lXGh/TTjRUZYUMqKQzATGM7ls=;
 b=SHjjDh2S9GFZWBxMl3+7S1/QLDfk18Ibrczfu8P0bmnD5yA3jU6QIRMRouGHymwVpPcg
 DTHi5iZcRlWS6qLDChNNsf1wWS4jc7MQfx+TF+mIg83WQ00rTSZBDKUXVLZstRRazosM
 H5a5kai2F3G3kcrjLyoSFjG1oyKFf/IPGde792XZvKMrK9FXMIK6ybnf/10gh7Tb6Lik
 4QDF5h775vUysgvH7jUh7+8R/wUDpU+g+1NQPizdLnO7Uhr7mc9zNVFFcfAgU903ClAe
 /jzVZKii0o2XR6RqH5UTQ5HF8IvTc0ZCr2n8XP64sfVHVem5LVBUrNmybpryXLykE5Rt 0g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r39jx3ybf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUMrHGWt35iOrm8tldNOADbZboPvMElT0hGCZVE0L7KOmbfQi7EECkX/ppDsiqoTXdd7/63AltiJZLd8hv8VZ8C708TjcAv3QfKI8noizDpmqDF//DRv5TsXQJl3LwlIxhDZt7bkGT7mL3pSQMU1AiMlW81DGuFrNpTbVxpcrqdhcu+tKA2SF6Nh9EGBCZIcc0wjzLo/aVHzzx3uCSxXCW6k3DFOHrlz32PfRJPG0q9fTf4k0YOgqgtR5zWfjvOSJagkqnfIxFG9Tegd0dG0fwymLVRkek4Aw6dkuLtYxSk9wkRi8K+ojVB6lMRahd81d+iy7hfylL2OFZCD7Aw7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdPEeLcShbY1ElpI+6lXGh/TTjRUZYUMqKQzATGM7ls=;
 b=AUW2TpuD+Hbbv/ulNJXIxHp/W6KC2Tw8tKcrcIfKZI6deF7LpmOoAZG4NwGuJsH4P2++OPmv7dUN0G7JTz5aVVPksj+6hMBIM06O6Bh6obUm5z44ZW8En6EUiMofyOb/ND3v5cTVg7L4elSdfy7aad6fhjt5+gVgvx6ro3xPJE5+JXMtU6ZU3kwum+RNcgL3eGN6mNzFFVsuLru4dQM5QfcrdMh4PLn1UsWZ3I9mO6GsJe5XfEu5F1wnST5kARBbyzgeAZTRQ/t3q5z8m0jfyHsNSsFsPcprA4Y2VGBkkSQ2hzNU1lyUrAyNIXzBez9H/+6ujfn0MiBdm9SQCiIVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3907.namprd15.prod.outlook.com (2603:10b6:208:27a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 17:01:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 17:01:24 +0000
Message-ID: <2628543e-b7a1-9e30-f24e-275b920a7a54@meta.com>
Date:   Thu, 8 Jun 2023 10:01:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH bpf v2 1/2] selftests/bpf: add a test for subprogram
 extables
To:     Krister Johansen <kjlx@templeofstupid.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
References: <cover.1686166633.git.kjlx@templeofstupid.com>
 <c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx@templeofstupid.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3907:EE_
X-MS-Office365-Filtering-Correlation-Id: 263bedf3-16be-4af7-502d-08db6841fe0e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBsbbkmDAbNSv9bu9oRXylUQhtLkpeXa1XppHq/XMJvCM+uYhmdNLiBZZHoiQx8gadYYMM7jm8oDC36wRIauJtE2kMDpnR5vqqY1LCeBIajOtQrnQ4JaGpJ8A7tO26+xaHMDAup2Uj+AIWTMqismTsKB+qVfiqjIvq7sPDG6adQbJW8HajnleJxKlAK6++bGNyATWfx38V4Irkkl2ydLAHdKU/V7kK1T9tjr4GJ8baVjx7GE1C6MNFNBvDX5yZh43+9Cj+vJqbYpSIfXqSEI759Tvf4KPluTJOFAVwsbNSlenY6HMjVK4CiOL94D/icPyM0ikQXNAWEYV4sqeNvUD5Ey3ijrPxI9LjFde4J2yuzfdkpzV35xu6UsCON6cekj76oG7QZJ8L+XSVeCJxKU7Tkg3OGe6m1/KAh5jzIX4QB2KJJe37CWt4qYED/zRyTCGV/S6EuBPTEge073y32iwEoGaY6BnwqjkfdOn6ONwFUarMNAPSDphsPPl5WV5dc7hF2Jxp1CDSYp2h05EFVO9jwMj9geGReK59eo/qoyDGDyH3hsJBSVwN340SokjJPXrIHGnCwdjg2fhJVWWIUS/Dhn3EQWKpeiEoz+BAVyqoRH+wbowgcjR4JBL5M++qtpZ4QbuvhvD41H5tL9wlu4Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(66476007)(66556008)(66946007)(54906003)(8936002)(8676002)(5660300002)(36756003)(4326008)(478600001)(31686004)(316002)(6486002)(41300700001)(38100700002)(6512007)(6506007)(7416002)(186003)(2616005)(83380400001)(31696002)(86362001)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWUvSUtROXFxTXJnRmoyZlhYNGltRWJJNXJJRDJhV2NkcEF6c3VRRVZrV2U0?=
 =?utf-8?B?RS9Kb0RJRkFkcjh2RUd6dTJHRWtmUWZ5cVZEczQ0VFRrZ2F5ZVhrM0M4QUZx?=
 =?utf-8?B?eXhOM2FiZ2xudUdIVWM2Q3JLN1ZVV0pnNHNSajJQa3JmcWdHLzE4L2t3dGph?=
 =?utf-8?B?bDJ5QUxoNEI3SXFjYjQrQzlET09GRHNwWTUxQVc1L01mbmVoUEFGWTdsMmht?=
 =?utf-8?B?NXNJb2JudGhOVDZmbEh4Qmh3S3BFYkVPN01mZEZJUVRkWTBGUzd3MWZHOTFF?=
 =?utf-8?B?dER2aklBMVMrSXc5M214ajJRWUdOZVZGWXBURElaQVRtUE92SUpKRCtVVkVv?=
 =?utf-8?B?Tmk5blhJVnZKcFZ5QVBneFoyMndSNWNZVnFPYU1DbHRqaWpWbk92d2szZGpN?=
 =?utf-8?B?U2J5RHpTN00xRXBucS9leWpMSkV0cmFWbUxyM3Q2WEhkTWNPTTAzczhTU3lw?=
 =?utf-8?B?M1ViTTFmQUFxUnVQOHFaVUhVdTBObkRGc3VMdFczRTd3NnBFdGNVRUdvMUJa?=
 =?utf-8?B?eFlyaVQvOG1nbGhJTUkwMU5OM1dheXlmWENQVnkvbmZ5WEFDbERBT3hHNVoz?=
 =?utf-8?B?OEVFUTZ2SXpMMVpBaGVuR1dWWE9RbFZaS3dydWhPaGRZV2ZjQnN6TWVLeDRq?=
 =?utf-8?B?SnNVWHk3elEydnVmclZYRjMyV0FKYjhCV1FiaTNOczA0ZnNNWUJ4TkQxa1dE?=
 =?utf-8?B?Ulh3d3dpbTdLY25PaGNzT2RSZStSeHBtN3g1Qit0RGY3VmN3bzdOdEx3b2pl?=
 =?utf-8?B?VUszQWttVHhrbmwvcFhJUHM4ZzBLVi85ZUJDR3NZVmR6SWhTSSs4bjNneDZR?=
 =?utf-8?B?d0swZTJ5Tm1uLzcwbU1mc3FhZStxQmhQT0t3VzIvcUtOWlpSNmVMcXN4N3pU?=
 =?utf-8?B?b0dnaS9mNzA0U2phZFkxL3dSQUVDVndjUnJxVCtrSW56TTl3UCt4TkZnajY5?=
 =?utf-8?B?dUY2SEJrcUovUTNlTTdvdGZ0dmc2OVRyOTFmS0lndFZGMDRyY3VjQysrWE51?=
 =?utf-8?B?dFFva3RaZzJnNjZHcEN0bitqSFhOeGt2cVc5Nnhqc3JERUJaYWVIdmpHZ3FD?=
 =?utf-8?B?MHFJS2pVbjhsaklnTWQ4c2RRTno5dVlJZ0JHK3Q1N2drNklXa2RXb05XMVJC?=
 =?utf-8?B?NkVtNy8yR1o2RHU0Zk8rUkhZK1B1NG8wU3dxcko1b1ZmZjdYTCtNTkd3NUNh?=
 =?utf-8?B?UkUvUGdxTy9YZE5DTnRyMnJUK2dLTW9DSlNkQm9ucXZIL3kyaXlZQ29CVGxa?=
 =?utf-8?B?THRlUjlPVnlKelp4dXIrL2RCSXpremc1MEpOVWF2ekJjSERmSW02UVF5YnFN?=
 =?utf-8?B?Q2FaeGVzY0hIS2dwTmdLMDcvNzdGZ0dwZVlCYkJFNXQ3UFhyelkvMTM1YWFu?=
 =?utf-8?B?M0ZIS04rMzBsSnRid3FFaldaYTFCaG5oanpFV3hBUUxjM1ZxbHVVTndFUThK?=
 =?utf-8?B?MXgrTy9vdnJHTGwybnRlVkVUeVI3azdydFJMUmJabkdtVXd6V2NmZ1ptS0dF?=
 =?utf-8?B?d3cybm42cDdVUXRqa3B3WDY1MktYSnZSeXRwMDc3VlFuVm13eFpOWUtTNnNV?=
 =?utf-8?B?cXdpL056bzQyR3ViVmZ5SkVwTWdoRHFjOUE5VnZrRnFvZVdkakpJTllYQXoy?=
 =?utf-8?B?NzJzSFdoSXVkV0J6aEEvcU94dVdQRmxxNHJlL0o1dXdiYTYybXpJMVNJcHFT?=
 =?utf-8?B?RXl5RW8yTnVrZkFxQmNxWnpvQkNnSXZqc1ExQUxvTUtXbHFOd1Jud050TC9B?=
 =?utf-8?B?RlJTYTRjZEVKL2hia3gzVmNlVDZHRmpiWGdZUTc0TVJ5ZXk4eTJTODNQTTdK?=
 =?utf-8?B?NFJMOFlIUndGMzAzZk5OVmErcTFjS1JMMXVJNld0WFhpTFFBVGhYQkpYNmVE?=
 =?utf-8?B?MzFEVzVwaHc2ZFhrWTNKM25xQzJ2RW94dnppSG9LS2xMR1lrdkZzazFWd25W?=
 =?utf-8?B?aWk1VHdHcm9oenZOeG9Za01YNDJqeXJOQkZ6NHJxQVQxdGJUZlZIWitpOXV1?=
 =?utf-8?B?dEYzOXNDSm1MNEw2R2RadFFMRlVBYkVZdnIvbERhckxxdFBrb3M2ZkRTZ3lx?=
 =?utf-8?B?T1QwTUJUWWZ6bnZiN0pjUUZ6aUdaNkttSUFOamo1eDEvZmkrc1RvZWUzVlV3?=
 =?utf-8?B?ZXJWVHVDekFsbkx0bmVZME9WTm45VTk3eWRqZTNRNE5vblJNUWhJMnRJZFdS?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263bedf3-16be-4af7-502d-08db6841fe0e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:01:24.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MCx4kKlRCWOjI41mNhEi8IvaC0dt210D9O7NMQeD8V5db7VOARhS7a0TVxReJz/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3907
X-Proofpoint-ORIG-GUID: UqIqT94dncAuBTfQfJG3ZMZZTC_dNeIg
X-Proofpoint-GUID: UqIqT94dncAuBTfQfJG3ZMZZTC_dNeIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_12,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/7/23 2:04 PM, Krister Johansen wrote:
> In certain situations a program with subprograms may have a NULL
> extable entry.  This should not happen, and when it does, it turns a
> single trap into multiple.  Add a test case for further debugging and to
> prevent regressions.  N.b: without any other patches this can panic or
> oops a kernel.
> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>   .../bpf/prog_tests/subprogs_extable.c         | 35 +++++++++
>   .../bpf/progs/test_subprogs_extable.c         | 71 +++++++++++++++++++
>   2 files changed, 106 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> new file mode 100644
> index 000000000000..18169b7eedf8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Facebook */

This copyright is not correct.

> +
> +#include <test_progs.h>
> +#include <stdbool.h>

stdbool.h is not needed.

> +#include "test_subprogs_extable.skel.h"
> +
> +static int duration;
> +
> +void test_subprogs_extable(void)
> +{
> +	const int READ_SZ = 456;
> +	struct test_subprogs_extable *skel;
> +	int err;
> +
> +	skel = test_subprogs_extable__open();
> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +		return;

Please use ASSERT_* macros instead of CHECK macro. The same for below.
See some examples in prog_tests directory.

> +
> +	err = test_subprogs_extable__load(skel);
> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> +		return;

goto cleanup;

> +
> +	err = test_subprogs_extable__attach(skel);
> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> +		goto cleanup;
> +
> +	/* trigger tracepoint */
> +	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
> +
> +	test_subprogs_extable__detach(skel);
> +
> +cleanup:
> +	test_subprogs_extable__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> new file mode 100644
> index 000000000000..408137eaaa07
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Facebook */

the above copyright is not correct.

> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>

There is no CORE related operation in the program. The above header is 
not needed.

> +#include "../bpf_testmod/bpf_testmod.h"

This one is not needed too.

> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 8);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} test_array SEC(".maps");
> +
> +static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
> +{
> +	return 1;
> +}
> +
> +static __u64 test_cb2(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
> +{
> +	return 1;
> +}
> +
> +static __u64 test_cb3(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
> +{
> +	return 1;
> +}

We can just have one test_cb and used for all programs, right?
Or more subprograms increase the chance of the test failure?

> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
> +{
> +	long buf = 0;
> +
> +	bpf_probe_read_kernel(&buf, 8, ret);
> +	bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);

The above bpf_probe_read_kernel() things are not necessary, right?

> +	*(volatile long long *)ret;

just 'volatile long' should be enough.

> +	*(volatile int *)&ret->f_mode;
> +	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> +	return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
> +{
> +	long buf = 0;
> +
> +	bpf_probe_read_kernel(&buf, 8, ret);
> +	bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
> +	*(volatile long long *)ret;
> +	*(volatile int *)&ret->f_mode;
> +	bpf_for_each_map_elem(&test_array, test_cb2, NULL, 0);
> +	return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
> +{
> +	long buf = 0;
> +
> +	bpf_probe_read_kernel(&buf, 8, ret);
> +	bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
> +	*(volatile long long *)ret;
> +	*(volatile int *)&ret->f_mode;
> +	bpf_for_each_map_elem(&test_array, test_cb3, NULL, 0);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
