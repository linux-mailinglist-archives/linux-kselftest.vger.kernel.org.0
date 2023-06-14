Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4473014A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 16:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbjFNOJe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbjFNOJd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 10:09:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835FD26AE;
        Wed, 14 Jun 2023 07:09:15 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35EE4nrU030630;
        Wed, 14 Jun 2023 07:08:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=q5X49LdogohVL/O2oq/Crg04NQqxejIHXf9S7xKKjlY=;
 b=jlSU/ch+NGmKlTsElWUq7mcff1ZSbn3h0y6xGTF5MQy05LRcC4QqLHqxrPz6nRiQ0Uew
 MLfbOL/XajAKaFPxp/YQKylINvTUEoSe4BmSbLHNONslb3mKVKSFITO9xSxlFuNgfNJj
 1yB1Uw4WLLIFykFdFvYlmkFyC1nvl6NkjhCjCvvUQyPfxRDZWowMnCx7u+QjDxSUkPsX
 tpkGTmxWH3RP1+MDQnlGctw3zVSg13wlt/d+9BI0bp88cGjIMnpSFrnhHP9+X+eZC2l6
 cU9EfEhKqiuQych9VC7FB7xql8PCIN7o2BAXJjW5EGGi+D98q1WuykmCc1YeZuO+NMiL Og== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by m0089730.ppops.net (PPS) with ESMTPS id 3r6q9e9uw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 07:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/KvsL5JhZwv37Lr/QEVc46FEJi6qK3bAXGhI+eDOub/9DqLaH50PIHenuh7nLdg8CNTaQEl+gvbWB4kcFq42FvNGsob3evn8DDA5FYvb6WcDd6n4Q5V+uYJEsxOArnwXJITAbjy8nrozssRqzqfzSxU9MgR0WB/LaFF4D7JcYAiltJiCPHyJgsGHV3P5hPI5MtwBs9LBf8/MZpshiDhmlPb26nqhaBV8NynoWiXtJsUkjMO8yZ199aMvQw835ynqhAimPELfs8af1oI8erA48pc7OjcCM/z4y1GxBW0OI+McHmxVMqd7Yv8J6Ij/jlH44B5lRZz2xkC1D+W8xfjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5X49LdogohVL/O2oq/Crg04NQqxejIHXf9S7xKKjlY=;
 b=nY0HWkD1j8+NTDe4hDoIJe4SKNHThb11FyjLdwRK+QskhsWlN9OMUggM3lol48NL/f3Kizj70Ds8ZMuBps9JZJKDnygqJJFWCr+2aWut0b2zLhtZ4jMgQ9qXOVlTCHeBRV3XnLWmu3c1T1X8rYj3+dIIwZLuehIOhoHcIzh55SwuXNmkHRLO7L7Wfzo8Mf09ytlS4nz6Y2iPYoVHkhpENm4u/BBemAlM1CWIJNDnHAdMhvYmMRJdH7pfqknM6WQQDLpCkgJdPIjzDQT0mQu59C6iidfEZ6cMXd/BX9Gn7rQgM3/EqS09IHGHl1YEPO4BLmvlqbDY2jcZqP5MufbXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4380.namprd15.prod.outlook.com (2603:10b6:303:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 14:08:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 14:08:49 +0000
Message-ID: <0b12a94a-e3e9-e2a2-389e-48a588d5ad6b@meta.com>
Date:   Wed, 14 Jun 2023 07:08:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests/bpf: Fix the address is NULL
To:     wuyonggang001@208suo.com, andrii@kernel.org, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614073443.4894-1-zhanglibing@cdjrlc.com>
 <7f34bd3ce377d9d89626c2df8fa584e0@208suo.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <7f34bd3ce377d9d89626c2df8fa584e0@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 119a00a5-4105-4a3e-2eda-08db6ce0dff6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBkZxW58cDi0cUT/DVIyal5Gl6bxW3TK/iAB9OZjcaAzrLOF1PwzY/07qk/wa3Lr9XfMaqdh2oF3LKAcjaSkJRwWwb/5o0cgTk4kXI5welAOBTacnmcSm/oTvl10axiae2XizHOesTFE3DYZxrGKnj9wCAJEQD6r3i/B0SfX8z5J+MocpYP9XZB15UBec8Qu9KT92VPHCrvdGbh6VmSk7QlyV95lchNhhPB708aCtgrET/GxfjEEEPv1kcV/+IlSylzvLxJF+NTJljm4/Jvu/XyeI1zb/gmej2GzQpMM8b9tAhtCRF7/jUrJ3Hdl1o7qtBGw+UhSV1RPIN8DFryV2TKy4Yb/78FzPR650+5MdGxCS+7cIdfdistLwafHevRca6A9tfMve+3XUM5z1FR+tT8mFM2qcr/wmQcwJMCnxWRf7lorFvxhcGWSa4r0HWdImv1F4pXkvsOFtq8XmeDH7JiCol/bz6TOVnjwG2nEKJBGmWVZVIXz3+/5ACnGmwmoS+qbGkKTUg0kkvXs+NXksCsIdW3nSKI41MPHQ1TLP2gvjRhM3n8NwK8qtHx8vjUynK2KVgG+CIzvN2kqi9/q+oybVJbc8EAsbHCRRf6QfqlEeXofOku4eSRAylggqit6c8jk87dwck21PxutPOKj0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(83380400001)(5660300002)(186003)(6506007)(2906002)(31686004)(2616005)(41300700001)(6512007)(8936002)(8676002)(6486002)(316002)(31696002)(53546011)(6666004)(36756003)(478600001)(38100700002)(86362001)(4326008)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2xEcW9KMXBjNnZuaWhOMVRoWFh2dld0bllzNmMzWWJjTytrQml0ajN2Z2k2?=
 =?utf-8?B?RVpVTklCUm5ublladWk1cG1CU1hEcklUMndyN2dTdkZPTmk1MmlQMExNaG9x?=
 =?utf-8?B?MmwrQXliM1ZmVm5GdkVtS1l5SGY1Ykp3L1BQaVNoOTIzeC9sVmplY045M2Uv?=
 =?utf-8?B?a21jY1MybGdnN0lwb2VpVmtOelVRbStycWdlcGNHa3NHc2dLZjdCMTk2SmFj?=
 =?utf-8?B?UDJxQU5EYTFkUGRsWkh6dkI0UGtZZnViODR6UDNxT3N0RHlUaFhVOXA2d1dz?=
 =?utf-8?B?UlBKa3p5NTRTYWpXNG5VY2pkMERCK2FHS1Roc0dLQi9wS2owdWFkTXExSm5w?=
 =?utf-8?B?TytmeWxBa0xNRGsxUVlBZi84YW5IUm1nMjhDKzNlNEN0eTlQZmJvOWx1alk1?=
 =?utf-8?B?OG95Q2dmNE0wV1JEcVdlME8zZ2llQ3Z6N25LTjhFTGc5ZTZEWVdWRlBtc0Vk?=
 =?utf-8?B?d0FCdjEySllxR25UWmFCc0p3UVFzRVNOWXFuWGhKMmxGS1hBRUIvRG8rZlYv?=
 =?utf-8?B?dlVwdiszMmRyWTN6dFZuV2k1M1pzY0trS3owRUdPSFg2VWpEM1cyaTRkYzBH?=
 =?utf-8?B?SkJtdEdlQ2FjdDJMUHFtQ1grVlBOejNaN2NhaFI4UzJXYWZYMGxsUDlQcEQw?=
 =?utf-8?B?OGpkdEV4dkh3VllXWkpHa1kvdkQ2NUlYYmtZSjlBK2YwbDFBZ1BhTDdHZ2hn?=
 =?utf-8?B?RUxTMDhDQ0JNTkthZnMyTFBhM3hOS1RxQUJCa0JKbVUyN2xZVVp4bGJIL0l0?=
 =?utf-8?B?UGEzMG9RK3YrUHJhNHFsTE1wYlIvamtMNmJMcHgvL3UxMzhpejlrc3FDMFpo?=
 =?utf-8?B?ektPYjZyV1FQNGZjQlR2NDNrb0VCT3NSeVB2K1pxS2dMZHdTMjkyQVQ1T2di?=
 =?utf-8?B?dlBacEhWSk5BTTl2dHd6UUZ2RXZ3eVNYMnhlOUlBbTBmNXVuY2xveTNUN2Qv?=
 =?utf-8?B?MG5Vd3cxdTBqaG83TVdybDgxUFhoa1M5OGhCdlA5NlFjcE1uQ1ZmTHhTbEQw?=
 =?utf-8?B?L0djMjlQdktaZmtzQmpMK0pTWnNrRlg0bWNOQmd1SXdwMGZzRHRQOGFLNmxr?=
 =?utf-8?B?M253Q1VLVXlyMmtMN0FEc3M1T0pYRUJMemxmWFNYVkEyUFV3bGxWNExVRUlB?=
 =?utf-8?B?dXY1QTZnMDMybjE2RFRMY0I2cFltZUNjNmRKOHVCWXdneGhFWGZsTHlGRmlt?=
 =?utf-8?B?UDdXeU5aNmRCU1kvTmVGUC9CU3dDNzN2OEJ4NEJZWEE0aSt0NGhUbENtUFd5?=
 =?utf-8?B?VHdiWHg3UTdHTTB0U1pJdjVqSU1TTVl1VW1qQWJJTGViRkZ0bUpPanV2a1U2?=
 =?utf-8?B?OWN5a0dZbnNhTHd0NUNUL3h3eHhDdGpGSHNudS9teGo0OHBHRVBPOTI0dGxj?=
 =?utf-8?B?dEEyc2EycW03T2dBeEUvWGZsLzJpU24wV2piNjl0VjIvZTFzZFpNY2w0dEt5?=
 =?utf-8?B?SHluaThTK0kzdm5sSUV0dTc3UG5mNGFQV2FkOWp2QkdIZnNvMy82amZZNStu?=
 =?utf-8?B?eXZIU2JuYWxXYVVkckRIZzNCT0xhbmY4ZURkNjc0RmpYSXl0NlZlMUZZM3Vh?=
 =?utf-8?B?SXo0ckoxUHB4L3NtQzc5RFl3MUc5eU9LTlNuM01WTDVOaCs2UW9SaUZ4Tm9o?=
 =?utf-8?B?KzVtY1o0V0dIRVFsOFZuL3ZRaW0vNzR1V2x0WXhRZlBvaGtJbVdreFlUdno3?=
 =?utf-8?B?eG5IZEJQYzFpMFVNdjA3elp6Sm9JUmFFSldwRE8xd29WZm5VVjMxQnRHdjBn?=
 =?utf-8?B?TG5QVVNKbm1sMjZWSi9XNUthM1lNeTFaV2gzeHdRbi80RldMMlBBQW4wbUc2?=
 =?utf-8?B?RTFKejhyTXJkRGR4SGhncU4yUGVseHJjOUt1cm4zUlJJOGZDaXVabEU4dlM2?=
 =?utf-8?B?OGtROFdEMVc2L0cwSW84WjBOS1RLZEVmejZtYWgwL3pla29oMC9TQnVBQkJx?=
 =?utf-8?B?QVBWSmx3Q3dtbEo2YUNleGNoclpiUDRTOUw0d3pvcnFLMWRlTU5ydDBQYm9Z?=
 =?utf-8?B?WGVlT1FZRVhNTk9QNU1HSjdHb014N0I2bkxwcUY4SUY2bm9uNmRHZ1FZVFFX?=
 =?utf-8?B?ZTU3S1hIdDV2ZXBhZDRDcTdEVVJNTjJzYzQ2WXZ5cXpNdENzVWVIbUlQdWkr?=
 =?utf-8?B?TkVXMTVlbUJEYUhyYWcwODRjWFFiYmpRUlBIYWhCcXd5QUtYNVo1Vmd0UitM?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119a00a5-4105-4a3e-2eda-08db6ce0dff6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 14:08:49.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2Zcs2Frn+Yi49mBFLH9hkeBFEi6CvLraYLTPh1ZbOkZYR7/rsbCqiDXboRTvUZI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4380
X-Proofpoint-GUID: y7KdZmynskLYtYmCXFknIxCCSR2ulidy
X-Proofpoint-ORIG-GUID: y7KdZmynskLYtYmCXFknIxCCSR2ulidy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
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



On 6/14/23 12:42 AM, wuyonggang001@208suo.com wrote:
> Fix the following coccicheck error:
> 
> tools/testing/selftests/bpf/progs/test_ksyms_weak.c:53:6-20: ERROR: test 
> of a variable/field address

I didn't see clang/gcc compiler warns about this. Maybe need some
additional flags beyond what current selftest/bpf already has
in order to trigger this warning?
If you feel this warning has some merit, could you propose
it to gcc/llvm community?

> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c 
> b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> index d00268c91e19..768a4d6ee6f5 100644
> --- a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> +++ b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> @@ -50,7 +50,7 @@ int pass_handler(const void *ctx)
>       /* tests non-existent symbols. */
>       out__non_existent_typed = (__u64)&bpf_link_fops2;
> 
> -    if (&bpf_link_fops2) /* can't happen */
> +    if (&bpf_link_fops2 != NULL) /* can't happen */
>           out__non_existent_typed = 
> (__u64)bpf_per_cpu_ptr(&bpf_link_fops2, 0);
> 
>       if (!bpf_ksym_exists(bpf_task_acquire))
> 
