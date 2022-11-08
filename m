Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705E620999
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 07:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiKHGjD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 01:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiKHGjC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 01:39:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A941BE9F;
        Mon,  7 Nov 2022 22:39:01 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80V3a6008200;
        Mon, 7 Nov 2022 22:38:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yZ/PQ81oczH/qHAp6SO6WPGajotVdGvsI4PxQjF8IYI=;
 b=ZdkH0ulYoYz2ZVZ1hwUyKM2VIIfBQbf0r7AJ+OTNBHaktm0duC0QNucqbzQFFPAsZd0g
 jgvFBPvJf8X8QRSTkiDX9qzcya2+lA6XRCuE4QjWM49P0J639bjnFlXBZUyr7QeJ3exi
 FAcIqFjRx4SHfEauoXNEeIQNb7FnerMuyTaf7w/NG6Ub4m5+vzakt4A+OKF9b326Z07a
 HxA+0d2uCvdsyOQH3zJEMXwK5xNJ3x4UU7bi0vq6J2TlOBQXMu/CfnVGdBEt5BFiHv+5
 B/ju3sMn6zhiUZ5mR4oxiHkRAoAr9upqy7u80pLDhnJQCidVSwJJCd9iqmfBCDOoBkKd 2Q== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqcmqsure-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 22:38:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C33EBUqIWefs6yYai14eU/8rl6KanHcdu6DPYFK1emnqPHUwi3DktM7qz99jbuphi9aG6mLlfTLxIeyZRw8s1RXirJNPTa4gv5Yk99qqNxWHIlLO7ad6RjFCGkx+GJrO+D04rpWkpAfe9oBlQ00hIs6haLwHXuZi6CBT5SvgrX/eoYdTaWkReER5Np+KA0CY9Yn2jaXhtHoa0fAJ2VMgwM4WoKgEeR8HHdZBPq03O26zw3OQLRiUPi/WpPojpyvd9R6dBvvyNZjxgB4pkvAMCS8B9HKHZUvAWSaluPd8rj37ywaX9ualAJWD3/ta3erv9ZFrzsVBBnkxxHyxw4ie5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ/PQ81oczH/qHAp6SO6WPGajotVdGvsI4PxQjF8IYI=;
 b=PEWr/nUgetopE5oVB9nPnAK4SrDUVz6JwgbZbIZZwAzXGrUv/jyUYjDdLZ3D42ll5NT3lJtHttCsH6MEAi7CBuXrazQyVQtOlX73Fjw3JJgKi9ZeXUae1F2pUOvxSMOxrf9DYG5GKkXeQqhi0st5MvSqonH4mUqGzoB5soGDdTqmMQYt6kTOvFUg97ClzjvVrYY7aIe/KLTifOQ6NO3v7WGMFyqxTu6fd69aN65XPPjaZt/DZhpR9h3Tu8LY+ISITxNAvquVZuRi0+Tc7Yjcntih3joPporqep8xjn4g0/K6hPCRunR+Uo1m2ZhCjVkXD07hBWzX+O1EFAQyoccn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2660.namprd15.prod.outlook.com (2603:10b6:408:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 06:38:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 06:38:34 +0000
Message-ID: <52f848ad-fc12-c360-bb91-c1d9cd14853f@meta.com>
Date:   Mon, 7 Nov 2022 22:38:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] selftests/bpf: Fix test_progs compilation failure in
 32-bit arch
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
        sunyucong@gmail.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221108015857.132457-1-yangjihong1@huawei.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108015857.132457-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB2660:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b06fcf-4efb-4a8a-19ff-08dac153dbed
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOsmtPuoXYf+nX6krFAFMI4NFGQbXY2iZe4rJ81m9N/QnLLKzUH8gJYsrdsQyU0LajFFOSZ7AvvLtcRPJ+H6V8fJP9QYEmuJxua+1E7qLt/7PPIWZ6d6xAoiUam2KGjEee/aSlw9ZFH+UA8/ETTkednygvdBxLBiuHAIfusM/MchOcw/dDKYfxuZAiATeYrpxNimDMhT+QbCHnxjXlFfODwp4YKwOjDsHU1po85cyFq/IW8YzHrwtRB303QFtdN2e1Y6qCnfF9/ZL99krm5Kf/zQgPi5ZlM/y44g/hoK2Rr6NxQseSYxeoD+cqQser/OUSH0uqmDyXoTkBjZxb/AyI2jlTHHRzQn/7v0Egk5BcSGxIatzNaG59kbzlVOlN8rx/vAx4CZN3NzljwP8r8d5H/XJIvFXPGbswXGi5upXt4pI3Pvowo+a5ndD3P6OXebPAar/F7dmdUqOrs+nnEkrx7olv6sk2Ke0kARSoO//5rJykqF9Ag6dE4KKPrWtgCLgyjQVnW6g1RJam9perSxJp9ubc2juGogKtboMXG/eMu1dS6RwvAMARWP/dRaxGaNtrW27mtfaNV2R8xjy1CrbOjlGN5ayqVVZjqw9XbfiQ78XXWTlnyDPXdWD3UNY/FCBweu+5slj6mMchbyIM77FDgubwHPTFI0CqJaLKE75TF50mVz/4HCqNLWhrNIHzYZKTwpy5livzsDyksQWeGnLPgqjSrQW3ALfmsyAZdyMx8gVPK0sEnSO9lXGN1iMvwe2jTlSPEi6yuvMxh8yAU9L4J8Z4qk/EpTw2zhChQf49FGh0m27OCOqM5zdXukxrvM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(41300700001)(6506007)(36756003)(6666004)(316002)(2906002)(38100700002)(86362001)(921005)(31696002)(6512007)(66946007)(66556008)(478600001)(2616005)(7416002)(4744005)(66476007)(8676002)(5660300002)(6486002)(186003)(53546011)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhBVTJLQVlpc3JaemVHMkcxYlhDa1M1VlRFeXFJMjZJVFJLcGFEa29SQXda?=
 =?utf-8?B?dDgxT3d2dWVKS2pacE1MaitjVG9EdmtaS2dJQ0JaKzNjU0dlRXRiS0xmdlY3?=
 =?utf-8?B?Tk9IaWdDdE9FMkNoRVI2MHdod2Z3WjhpeGhlYjJNWHhXMVF4ODZaS0M4V3ZR?=
 =?utf-8?B?THBzaVU2Q1JRbHRwNDhGOXprd0QyMm1UQnRoZnFhYldESGJVRXNiS1dqc2F0?=
 =?utf-8?B?cENuSnpOWFlQQ3UybWF4b0ZsK2VVUDc3dVZuZlFGSlpPM0JvRXErQ2FnbDlR?=
 =?utf-8?B?eWNZcVVETEI5WXdBU2dwWkRJTzZpemtydzVPRlZwUDR5QTFmR2xUTnVJbkJR?=
 =?utf-8?B?RXFzRHA4bS9nRFFwU056Zk4valhpSnRvSGk1RHBKWFFMY2Yvd2ZyVGc5bFZT?=
 =?utf-8?B?TkEyVDhTZS9Kdkc3ZE1TNnVPWndPbUgwQUk2MWduWXo3bDArMHFtSHBSY1Bq?=
 =?utf-8?B?MVJtVC9ISEJHWU1MdTN6SHZHbmxPSEZiQmJxUGExRFJzdEx2a2xuV2dxQ3Mx?=
 =?utf-8?B?TFh6enVTMHBwT2E1M1NiLy9ZMFJ2UUxCS0hoUmt3UmJmVjVsT0NmYUx3c2dI?=
 =?utf-8?B?MjcyVmdmSnB1MlMzUU5VNXlmY2Iyc1ZyVm95MGFldkcvQlhrRE5IU0kweThw?=
 =?utf-8?B?VEJOSWYzdVRXMHNtb0M4N2paeFpHSTh3d3NSUFN5SHdUSXB0VmhYRG8yUkhi?=
 =?utf-8?B?czBKdlNmb09MdGhCdDg4RCswU0IxdXBnRXp6bmtCLytvRHRvMTlKN0k2cFo3?=
 =?utf-8?B?N1gwUCtXMm9JZGxuNlBJMUthZDdBaGU2Z09IVkZEdm84dm1pUE1UVXBaTXJt?=
 =?utf-8?B?T3FhTTdrcVg2eldhTHpycXV2UkZ4amRqL2JjYThDcGMzWEhNT2lTS0dpdFlG?=
 =?utf-8?B?cGdzRGtjQVl6ZDdhK2RSNU44am5WRkY1ajhHOXpIcGM3T0FTRERtY0pmUHcy?=
 =?utf-8?B?QXc5QUwzZWxDd2gzeVZlRk1JcFJLTDllT0luT2w0Wm1YejVyc0lDZzBiOUZW?=
 =?utf-8?B?dHNZUWlhdmRBWU55WVQ4VDV3UWZjdGM0QXU4OHhzZ2liNE1JeGYzVE0wZVQv?=
 =?utf-8?B?bGcweFRmeHdkeUk0cVdrWitPY3BEVXkrRGVtbXVwT1NWNVlBZTdwVGc1bWxk?=
 =?utf-8?B?QlV1LzAvSXgvWjhSbUhoMVBJV0pXbUFjZ3lod2M1SVlreENIWjExTXZ1Y1A2?=
 =?utf-8?B?ekV2NWJZN3FRVEVOZFRwaGtENDBDbmtUVUdiRkU4Tld2a3daYUVUYkhWUzBR?=
 =?utf-8?B?YXpWZFRheDlzYlVzcHl4bmdyUFBTbjNGcTlVdkJVN2hQb1k4SzFVK2paQzcx?=
 =?utf-8?B?N21VSm5wemJQVzFxN3g1Yk9LbWpNVHlPNGRCakRRM0drK2xxZjQ1RDMxMXNK?=
 =?utf-8?B?SFVOTTNMOWF3Qjh6aVhwVER6cW80TW9JTVh4OEtITUVEZWR0WFVkZkoyT1dM?=
 =?utf-8?B?SXYza0RwajEyV1RqY3NpRVFxdXFJc08yaThVeHVzYUZRa1NmT01sT1N0WitK?=
 =?utf-8?B?c28vU2pxbW5zVlk3TExXWnFSMGNKcW1mU1hYT0wwaVZDRlpwSWJ4QStPUFVM?=
 =?utf-8?B?dE5uY05mWWhwcUtxL1lMYVdkWDg5NTBFU29GTTNuN2UxSzZhQzVmdVpDVXoy?=
 =?utf-8?B?dG5VWUxzdmpFSVp0cmtOVDFjdS9JUWdVOWRFb0J5andCOFN6bUxKUit2eU1C?=
 =?utf-8?B?V1hYTTVMYmtBbUV4UUNqb29lV09OT3gzL0RLbnZ0YWtUbWVYNUFJTEdmMVh1?=
 =?utf-8?B?Z0dhZzRpZnZDQ2xmVi9td2J1UEY3TldmdUdKSlJ0SEppamZob2JZbXlmeXB5?=
 =?utf-8?B?eXhYejFRYmZnSnlCL2U5N3doZ2Y5aE1MTk83NFdPblVISzA5ZCt0VTFhZHdH?=
 =?utf-8?B?ckRLYzd5eEcvQWVLWUxyejZla28xaW8zL2NnQ0duVmNyZmwwL0FHd1hsVDNC?=
 =?utf-8?B?NEg2VC8zdXR0THg3SjRobE01MkZmbE0rUXFZS2VnNkppbDlGUWNEaS9xQTQ2?=
 =?utf-8?B?RVMrV0lRZ3BrTjZnRDdQWTZzV25BRHRmZGdId0ZwVFU4Zlg3Q2h6WVB6RVdM?=
 =?utf-8?B?OTV5YXFoU1AzQ0p2S1BjREZzbDVySWVVY3BMSEdZOHQ3T3o1cWVlbW5NNXBD?=
 =?utf-8?B?VTFweGNBbHpydk1VdUlhSGdCcklGRHJUeTcrcUQ2SHhHeU5Eb1R2UXNtZDEv?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b06fcf-4efb-4a8a-19ff-08dac153dbed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:38:34.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8SgBSiYPldhZqJZJKAkm9v5+tXabaJb2dBMRzIa6/ky+Z+2JyF87cnzgEYnd/AW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2660
X-Proofpoint-GUID: NHgpkUM3xQ5uTHwJSnf785nOl-kTj9Zs
X-Proofpoint-ORIG-GUID: NHgpkUM3xQ5uTHwJSnf785nOl-kTj9Zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/7/22 5:58 PM, Yang Jihong wrote:
> test_progs fails to be compiled in the 32-bit arch, log is as follows:
> 
>    test_progs.c:1013:52: error: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>     1013 |                 sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
>          |                                                  ~~^
>          |                                                    |
>          |                                                    long int
>          |                                                  %d
>     1014 |                         strlen(msg->test_log.log_buf),
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                         |
>          |                         size_t {aka unsigned int}
> 
> Fix it.
> 
> Fixes: 91b2c0afd00c ("selftests/bpf: Add parallelism to test_progs")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
