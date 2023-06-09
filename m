Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A31728EB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 05:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFIDxo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 23:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIDxn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 23:53:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD461BE2;
        Thu,  8 Jun 2023 20:53:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3592MmaM005131;
        Thu, 8 Jun 2023 20:53:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=O4ggu1nA10sjCipcwOJ5AV/6iItrZpMgdRTNDWMgEOQ=;
 b=g9FYCSm8HAQQxo3TILSez4AJTHtoTZVkOFXVPQdN04JrBaSRB0v3C7ErdWS/A6NK26v1
 AJ2gU1sXGgnRC7PeVyW+5wqjO4Z638c7YXeUdvSS/nEG6+7P+/ChgIe77qlZb/YhT9yR
 G9Ni0OwV3h1czrR0GnHsFjHKw0+zB+jnP6RpL2g6n79uoQD7q8lUDZ3x6hKo1+YbDsoU
 zg4MXrVIC9jvg1W58ogCbhZ7gBsehjlKFgt50uZwWVRGa6221xyXdI1TEaLTx5UoYUnY
 tnumrGHtWDtUMXPzFhlrZlsq8sfZKKb1FVCO23PXjEpmgioNnsjfdLj3OXJ6uZvvuxAV Zg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r36g60sak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 20:53:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAN+PulR8SIkhKfWrflZo0xb+cD2wTtGjgxXx0hY/oPfqa2eZ8x5GCjKbmAKH32kb16IJC2IVxyQ1c+YDL3UV3mAtqoNW36bCk+Ngqa6RHoPPS+BHgB9A4qWPXdSFn2WvM0+T18WMH8qJIvYNoYPCM6DYKPAXAp8tAHsvMm939be/xFEk8XFQPi6vzSt5Lf1T6cyG1hwILIrpdPl2SJCOX6b/JLD6SldBsCvjjPaBkFT1Us78iXgvC3fvqPQUlygfMmhVKeAr116DxC8QnvxQtVPh5H9F9s6k3lcwkkIS6fNPyxdAoj9376cBHkOa9vGE2gCZe068wHmaF167GCZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ggu1nA10sjCipcwOJ5AV/6iItrZpMgdRTNDWMgEOQ=;
 b=YtxW74bhQiVgWgw18ig9kRdrai3ZdttxRIY2wkPFycaid4Af8w1x0uFYcaDtVf2u0VbxB3rfvS+mCR30iRTpc3aOJe7L5ansfA4NEhVOJEBqWw22X+0kwPSfCPIZXYujeVW17uK7r6OSOo7/5BQUVmFpiUNgxBI2ZSRDyGTg5/ro2QA/ZvMsBcrXZtn8+onPnqOQ348tV6SETQm6wnJR46YuyXkRZEVrzaJsKnbks1D1UV5x4WZu4s2yqXWRsfOoBtFoNvv8MMyxbjtBQOcIoO14+z4RlKAPRGVD7VVyOkOonI7SvhuRTvGHq0KcttgV6AKWA704ENZ4Rrdv8AHNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4624.namprd15.prod.outlook.com (2603:10b6:510:8c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 03:52:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:52:41 +0000
Message-ID: <49a8216a-4333-a044-ceea-c59980913966@meta.com>
Date:   Thu, 8 Jun 2023 20:52:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram
 extables
Content-Language: en-US
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1686268304.git.kjlx@templeofstupid.com>
 <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6ff9c2-705b-4386-e6cc-08db689cf92d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S25UkXj2mto44E6New7x+mjZLjI+F/xMAQQrw+8VlwzwZbdrAhahPS9BGqjuzdEIsvYfTa8A4BJiOSKtGZOuPorJN3/G0BDb3hPrgF0P8hgMWZe3GE4wrcwKJvvvirpdWW2V8x11O4L1c0ZE5R7ahnHyZ2KX7c50kQt4If8krt/49iUK+qQOcvM89vYkHMariZ6Pk0EN5KVAx+LPZw21F94+rFZ1MyHHAhCgP7tqEqb382M42sfMgddTpebnQOL9hj17zXPyBTawfrVFDIDUXxNoIYWMrQbzuEhgYsUttGh7kp2mGB/K/PChmF1ZL4HRYpkvZHpVeQr9pxqaHP3M1HvXLC8L/H3LPWxSiP11DkKVvXdKkp+Inyaxs9yGAQMRDpES0DYbLoRmp+rvzHW9FtTba5ZSSUsdMfCPXinrusKR8UzB2b583T7NU/hpFU+cq5SDR2inX8vpHWh4SBzt+HE8F6SLev3APDwNqyrGoz+6mrsQtreLeIlD9MA4SWoz+V2mfjYaReIqxK5xSE3e8pdHzcHjGaYL2VNimHAbDEKq0V/EgEBFB6HXy0ST/qs/KbTxb/kOezitnvehqY+Zm8vURGzu/bs3ARU2/A7HHT+5yqIoq77Rl4hPzUTDvtIwOU2Ijao/UHn4mUn7YaWp1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(41300700001)(86362001)(83380400001)(7416002)(6486002)(478600001)(36756003)(316002)(8676002)(8936002)(66476007)(31696002)(4326008)(66946007)(66556008)(54906003)(5660300002)(38100700002)(6666004)(2906002)(6512007)(186003)(6506007)(31686004)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEQxd3JaNzhtN0E1QWRISjN0b0xCYXgzSXZsRitHUjBWRjVPTnV6cGpIck5q?=
 =?utf-8?B?ekYyeVVoMko3ZEU0d2NWS3E1UUNiNWZ3dzRtMStLMk5UWmhkdWlqN3o2Ukhz?=
 =?utf-8?B?anJ5WFhLQUFPYUg1VkNmN2UvZ0hGN05zZzV4NkVTYTJ4eGFsWmdHR3I2aUhU?=
 =?utf-8?B?Mnh2YU55Zjh0Yjc0OEgvelpWbkVTSi83NVJJU2J6UXNEY21ldzQ3MzlESFpZ?=
 =?utf-8?B?TWlxY2RhVmk0eFoxSFhZVjF3WHd0UzFpSjRGSDdhQmVuU0xSQ0I4aTU3OURG?=
 =?utf-8?B?SEpRMW5vWnUzM2pyOER6YUN3Q3pNQnRIUE1ubXREZWZQejVWNTEzdjRBbXlN?=
 =?utf-8?B?V3pDdEl6V2JDR0sycG5tMWVCbXdudFZZZ1JwMFVjMVYybUpNcHZQSE96Y2xS?=
 =?utf-8?B?NlhHdERxYUlLa0ZpRHJIbXU2WVVnaG9LOElsYTdsMWJXei8zQVY0cytCT2hQ?=
 =?utf-8?B?enRjckFQUnhCYkNmbi90dmdPZ0YxVjJQN015ZTZiZ2dNVHdzREFPeTM2Nmow?=
 =?utf-8?B?ZWZ6WGdXYVFtRDUzOXUvOVNQZzNobUpKc0k4OEJqYWV5a1FzeXNXNVpBK0tP?=
 =?utf-8?B?bzlTb3BZbWRqcHYzVXg4V2gzelg4cWhWNXhIT3kyUEVDM3RLSExvSGRKZnd5?=
 =?utf-8?B?eno1WjRMZThxYTFYWWt4ZDJMT1RiYTZmYlBLN09GampFaDc4OTdFZ0VkeGps?=
 =?utf-8?B?SXN3cUtJTDBOa3VMRFl5bkxsSmx4aWRYa21ZYytsZjdCMUpRamx4WlorNGZu?=
 =?utf-8?B?NXNDSVEyUGFYVGNhUE9xRGxBdUF5OGtPTU9IS0lIOUhxZnM1c0VkTWV1MnBE?=
 =?utf-8?B?VEdGTGVvUUpvZ2RKNEJxY1h6M1QzVXQzQitQVm5NcFpzKzRIbTVleThvSjlG?=
 =?utf-8?B?VSszcW4ya0ZyVkwvK1ZKY1FRMmYxNFlRN3ZtczMrU2FGTUNIRHBZVzYrcGNV?=
 =?utf-8?B?WkNFSDM1N2UvMHlHYWEvSG5JV0xpd2tBbk5EeTR5MnpXOHVKYjRKSWdBb2Z6?=
 =?utf-8?B?Q2o5Q2lpVk9FT1FuTCtLck1ZU3VtWGUwckUySHVHTzl2NVZiK0tQTVhWUkF4?=
 =?utf-8?B?L1NldkhONnY5akZHVGFFVDY2QjlRRk5ZWS8wbWNUWEdZQkFaQjYxWkxObG1p?=
 =?utf-8?B?TGxiSkx4d3NmUWlzUUtJU0JScE9Sc29nZ3ZLbVBvS1ZKNmxpZW53aDFnVGVy?=
 =?utf-8?B?b1pwbm5ISENWdGtWOW1FSkJQR2txdVdQTUFUKzlaV25ycUNiVGoxdVQycXZa?=
 =?utf-8?B?NjlodzJKWEJUbndha2ttZTB1eURwZjRTb29IczJYQ3VSelpvZ1hLNW0zZndV?=
 =?utf-8?B?MG4zcGxZdGU1SzF5SnJIVno5K2VpcDNtcDExTCtxcXhDczZYUUQxdW1kOWNm?=
 =?utf-8?B?Y2ZydWphWjRTS3VXS3laRjRMMzgyam1UVWtpd015dTRCQzVIVlBvakYvOEZX?=
 =?utf-8?B?SkNkamRzbkZxTjVYc1k0d0tvS016NUNxRUVaUGU1MnZsTFhNeW1VOVpCVm9u?=
 =?utf-8?B?MGVaWlZqUVZHMExqajZUdjZjUWc0eGlyeUlXU0JlQU54b3JQQUxWR040eGE5?=
 =?utf-8?B?aitHSVMyc1ZFdkR4enlVK3VFbnJpb0MwQ2tlYkM3R2oxcU9RQnFHQXBtWFgr?=
 =?utf-8?B?dFg0VkhKYUNYQm82a0ltSFF5T1lvYnhoRjFRUUcySmNaVWI0bi95MlpNVVFv?=
 =?utf-8?B?QmZueUdDZ3BFRkpKemxDODN1WWRBRldpbW1UTUJudFVLRFRJNmRhditoeXRB?=
 =?utf-8?B?Zk5ucWk3OUtmTjhmUDVOS1QwTlBUeEZQcSszSzRNQkNYVzh6M2I0akZ2RVh0?=
 =?utf-8?B?c2ttaWlwb2wzTjE4ZEhHL1Q2N2FleTM3eDdTTFV0Z0NvYUhxNmxjYndrM3Nv?=
 =?utf-8?B?LzY1cjFPTVE5Y1BiaUliamQ2Z29MZlVKdFY1WlR5bUVlenJidmZ0VmVWSzYw?=
 =?utf-8?B?V2h2K0tPYkRjemh6Q3Zyd3VDWW01TEdhbm5nUDdxOW1DUEZZUTZsQXVQaFpU?=
 =?utf-8?B?RFE4SnlFQTVVM0Jmc0tYOGJPQmhwbFRSbjQxQ2RlMGl3UEZ0aWxkRlJkZWhu?=
 =?utf-8?B?RjE5VDRUWnA4ZTExUjQyTzBGS3Jid3V6UXR6emFoMjBRelhzcG0wWjMxbm4v?=
 =?utf-8?B?RVdzN2psQjVJcjFnYnRKMkxjNlE3UFU4OW5vNHJWUmtaa2lGVzZDWW9uZE5Q?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6ff9c2-705b-4386-e6cc-08db689cf92d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 03:52:40.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8wpTLZwA9GDDWCX1qUNh0jHVzV8dmmka+jJjzPq1XKFxURGvALbOhSBvyE68crK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4624
X-Proofpoint-ORIG-GUID: OBP3Xchy1-O1cRGMaRmK0esp2ZjxBL6D
X-Proofpoint-GUID: OBP3Xchy1-O1cRGMaRmK0esp2ZjxBL6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_01,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/8/23 5:11 PM, Krister Johansen wrote:
> In certain situations a program with subprograms may have a NULL
> extable entry.  This should not happen, and when it does, it turns a
> single trap into multiple.  Add a test case for further debugging and to
> prevent regressions.  N.b: without any other patches this can panic or
> oops a kernel.

It would be great if you can add the panic call stack in the commit message.

Please also mention that three identical bpf programs in the test
significantly increased the 'oops' chance. Just one program may
not be able to trigger the issue.

> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>   .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
>   .../bpf/progs/test_subprogs_extable.c         | 46 +++++++++++++++++++
>   2 files changed, 77 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> new file mode 100644
> index 000000000000..2201988274a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "test_subprogs_extable.skel.h"
> +
> +void test_subprogs_extable(void)
> +{
> +	const int READ_SZ = 456;

There is no need to use uppercase for READ_SZ.
Just do
	const int read_sz = 456;
is sufficient.

> +	struct test_subprogs_extable *skel;
> +	int err;
> +
> +	skel = test_subprogs_extable__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err = test_subprogs_extable__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;

You can combine the above open and load with a single one
    test_subprogs_extable__open_and_load().

> +
> +	err = test_subprogs_extable__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* trigger tracepoint */
> +	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");

I think we should at least ensure that the program is triggered. For 
example, add a global variable 'triggered' in the program and
triggered will be set to 1 in the program if the program is running.
Here check
	skel->bss->triggered
must be 1.

> +
> +	test_subprogs_extable__detach(skel);
> +
> +cleanup:
> +	test_subprogs_extable__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> new file mode 100644
> index 000000000000..c3ff66bf4cbe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
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
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
> +{
> +	*(volatile long *)ret;
> +	*(volatile int *)&ret->f_mode;
> +	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> +	return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
> +{
> +	*(volatile long *)ret;
> +	*(volatile int *)&ret->f_mode;
> +	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> +	return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
> +{
> +	*(volatile long *)ret;
> +	*(volatile int *)&ret->f_mode;
> +	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
