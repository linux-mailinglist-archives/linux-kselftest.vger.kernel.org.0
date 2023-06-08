Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4750672866F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjFHRil (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjFHRij (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 13:38:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88302D41;
        Thu,  8 Jun 2023 10:38:37 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 358GmP0f017891;
        Thu, 8 Jun 2023 10:38:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6ZGLPOZ7B59MnFxmgLZrfSFXluiUg/yVkLu9Rmp5/h8=;
 b=U56f/y9gV2z5ZqphG9dt0TMqX2Glvg8qEBgNgFOwSL5nhtn7+AdujzBH4ruKpYOfrrFF
 U9CPCEyic4302p1bKYl6hbF9B/wwLEbbwU12lViQp6fhIJGekvOGfDkNPURDRQmnOVGX
 a2HkESy4qjwlUhMICBFcbmcM4wKkma2hkOX1nZjPjAIZnj4dD3KUXwNNRLcwW58uWYT0
 13GSIIYb1jiVhoAoOn6e+mBxiLQIKROZkUii01qGfx2Q069TdV1zp7asBfGXzp79X5Te
 bTVIylfcKq2ZX8RYQ++EtlS7YrBOHok8fwKajU6yk2ptmx3//f4DPaC2BdUmzi2RYb1A pg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by m0089730.ppops.net (PPS) with ESMTPS id 3r35rxnhg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK92bMMmmgG09dv/wQTubYpSVg/NKbA4e80aUnFJBeaiOpln6jVqiSISeabnUdJAr3gjLeiywOkQz2rYdcZsvHElO9R7lxx00pgyAAW/k9FHtd8UAnOVKERBHpKzcEbWRTfHoMR2Wp+925XOnJdit18AZ1p+6w8+qyup35qx+EvNGhD6hUoksSdpJSoVdwbHCHLwH4N795io95fcM1gl9K3u4dD6d7belZdGWMOwj1X49p+1xHQZgAxr35ho2PHkJZ3PP8b/3apt90Qfx/nGn9lJDTVw2LB9+GvlKf/F55ihBuFm8JpZ/uLKjNg8G+IfJn+ee6vyvjPm+UUrgviTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZGLPOZ7B59MnFxmgLZrfSFXluiUg/yVkLu9Rmp5/h8=;
 b=HhHXMJRXYJFH5lvKOMXbreGyRuU5hgTi4E15enz4B2CQGcAvJF423B/af+KQdQOcruTnYU2JLFvI3tl3YDcSs/VL6XqspDErdQ8ldEpZ35L+pq7nojNglHJOXmvwg/Cn3p4WR4Dm6uCWK8ljGDXjegXCEVqwQ7R0hnycl2stCpCq9O5nNV4n17Ea57Gl/DsqQtQKyUhT2FeXIF7J25PYN7lmSlyRNfJuzpBzsX1RSOkQVX97eMYRepzvzV0sgLpmMjD0Qi00mh1I6tfAeKfDppq7gmSNyxGs1Q0lnyiPLGkbMwclbqNk9Cwld/yvPwAKYF/qFXntVpsJBLHQAUX52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA3PR15MB6076.namprd15.prod.outlook.com (2603:10b6:806:2f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 17:38:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 17:38:15 +0000
Message-ID: <33c52b4c-2a16-7578-f782-51267deff750@meta.com>
Date:   Thu, 8 Jun 2023 10:38:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH bpf v2 2/2] bpf: ensure main program has an extable
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
References: <cover.1686166633.git.kjlx@templeofstupid.com>
 <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0118.namprd07.prod.outlook.com
 (2603:10b6:510:4::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA3PR15MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e56f441-3450-4aa6-92cf-08db6847239f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ns4/pGRPHvgZgLZ/NPNRg8n5Hi05am6Rc5uHG7SiwgvqbmxYMMqLNJR3Gaz2sarXLYB+QA+bjx1wJl7LChK/25VvUcqn5wNtijxjYDvljuvrLysaOAhndt2pSGQj17EDzXELBukpLLcDOBtORjGim1U48pvfbCB+lVIXER9bWep8Q4jqNUJ2zb/1kSKpyHeo+x7ugGawaE7s5G3bcbLPRbQ5yYmRZANcdFA8SQ1eKRcEMcC4OGFeZr0KVMMt4ou8VssUWyrrEM8YKjlQzeL0U4BstHSgZA9M8dc0++vO0paFx3JkX7SBMSuLv5IL0hmx1Un4FtSdp2ts1aYm9fqLsJJzxgg2lmtAxubiKaAHz26IlVb/zh/RgJk6zcP/cZy7maA3YBXWjXDLBez2djAnRtjIVDYdZ2Eev9KfW/gYTCd35bXaMYHIamR4MKCt8+KRPvWDD9RrRDLiQxyGvp7gQYFNlmqd+J1jToeERo8wDJuZzF39sTm9HSQxVW0tjIPjB69ztyyuMBtokXASRI+p44S1RVsR3J2z/SKxtVf2kW5yvlEvvhmtVXKuEIMI0fqyIukiMjztpHFobC1BLco4Ib6LeaRq8tBuPeCB7pD5hL6Itj+iTMhMBnr/gWKlr+OOSdaTXcffotfZg/MuMEYGCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(6486002)(316002)(41300700001)(86362001)(31696002)(53546011)(6512007)(6506007)(7416002)(186003)(2616005)(2906002)(38100700002)(5660300002)(36756003)(8936002)(8676002)(66476007)(66946007)(66556008)(6666004)(478600001)(31686004)(54906003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGthQXdlMkJpWDVtckNoa0xsUmsxcjNUbmpCRVJYM0FvQWFoN09FZGxVcEdj?=
 =?utf-8?B?OHBBWTh1N3RtWEgwOGFpUTBPOHN1SUlTMzV3RUlTT3RjQm5Ud2FQUC9lYndM?=
 =?utf-8?B?ODJ6bEhqcDgyYitIU0tiME1jd3JOZ3ZFM0NsaVRkOEw1dGNnVDdkMFIrSmhV?=
 =?utf-8?B?RnZqdE1Dd2R0SVJLU3dORDBYbThZbXhia2owZDR5VGpITkVmR2pWUzVFS2NE?=
 =?utf-8?B?VXFMZHpNdWxFNWxIMVhld0dRSzVXU0VjZkdrbTFFMXFqSDhLTU9icVhBQWpX?=
 =?utf-8?B?V1d2Slg4bFc3OXZvblYyVnMvaXlXek9Oc0F4SDk3b2dSQ1ZJcGtndWRMNUl5?=
 =?utf-8?B?SzRJVVZpWjJncWlIakxVOE1tSWxrNkdWU1VhK1J6SVFiQWxHN0l3VDJwUWt1?=
 =?utf-8?B?a3ZlOUNjNHhFSC9Bb2I5UjN2Vm16d0NnZnBJd1VmaGtvQVd1Mk9BNGowZmZu?=
 =?utf-8?B?akxuS3Q3ZDVhUTNxSkpJNG9UUTE1ZUxoaDE2L2hsWHNYMitYTTdMZVFIRHZk?=
 =?utf-8?B?NHdaZ1ViVFRoZGFrMU1STkw5dUUzMGYzOHVUYTdYQzFlSncyODVJWVJpSTBw?=
 =?utf-8?B?My9BUU5ZRUI0WjdBMlZtSS9WdzVvZWUvNVFTb3RaVENwUVZVSHJIWTMxU0tX?=
 =?utf-8?B?aE40SXY0aHZlbFZLZmJUZlhBN25CdWpPSDBxOHZ6YTBrbjJnWnF3ZS9hODNG?=
 =?utf-8?B?WGhEK2EvcFlrUG0wTC9tODZzR3BYUitZRUdsQjNDMkJ6QURkcFhZM3JZQ3FV?=
 =?utf-8?B?aFk2SWpOdmRNazBNdDNKdFFQNTNNU3d0VEk3NjYzOUFLNDZvRmg5dTJjOVd6?=
 =?utf-8?B?VElwU05RTlRTL3BlWEZKT0kyUDRNWXFjbEhOcjYxdC9IUmc5c3QvYndkUjNt?=
 =?utf-8?B?UThlOUJ3UVVXajJZR29kRTAxeUdoaC8wejBESXJlaTJ0SWV1UW9PNHlVbjg4?=
 =?utf-8?B?QzBrRDh3NmVBWjVyTXljQWdpckw2UDFSNzNiYUNsaUp4MDJQQnA2SjBKZ2VM?=
 =?utf-8?B?YitZU0xtQ3A3anp2Y0xTdlJreE82UklBOEk2L1hVZUJuaFg2bjd5aWIwQnhr?=
 =?utf-8?B?Q0d3RW9lRjR4emlNM2EvU2F3cy90SktGN0Z5QmIzSS83WHBnb0xpamVqMDVu?=
 =?utf-8?B?UGtFZDR2OVVJY2pRVCs4YVVPOEtoWWZEbmtmQXhiQmY4Sjd1M2FxbThabDdX?=
 =?utf-8?B?UXFrMzk2QmxIc2k1aDQ3K3kxTnFhM1RvcCs2UCtrMnk3TmY1bi94eGJIaGVM?=
 =?utf-8?B?RG1NVUNpQm1vdmNWRE1McE1YeWpTb2VJaWNZaDh6R1ZybHJpY0hJcURsVDhj?=
 =?utf-8?B?QVBrcHg2VUVYaHh3emE2U3hHTEtkMjRmOTlENUhLd3NrbHNxWHNtaklCN3Yw?=
 =?utf-8?B?bSs4Rm1YNStxRXpUdjkxVWMrMUFIQVBYeEUvZnVueEpCMFB0OFlPdy9GU1Nv?=
 =?utf-8?B?dkhnenBGWldNWlpCQXRVOEZvYUZhTEpKR2g2aUNBUWlMZmF3endoNWdFbDJR?=
 =?utf-8?B?S0pzNEhUclVld3NNTzNvSkR3U20wQzJwbzlVS2dOejVaanh3VSt3V1VMQjVT?=
 =?utf-8?B?aTc5bnpWMmJHYjY0bVJVOS9tazg4bGRWV1JCMGhWOVpMdG0rTjlZbWtZZXdu?=
 =?utf-8?B?S3VpVXpuS29ndTd1a1FqWmVvTGZOdmpsK1RPL1ZKdm5oSnNBVUxpcHhFbmZy?=
 =?utf-8?B?VmROTnZ6bFA4WnBDTGdPTk5BMmkrTUw0SUhxa1dHeVlnTHAwbFFPeUtNVVd1?=
 =?utf-8?B?dlE3T1Q0SG5jaEMyWDd3dUQ5RzQ3cmtiMEhsK2t4VXBDV2Q2ZzdYT2FaTUla?=
 =?utf-8?B?bTRaNFNuM0dzYVNMTWs3ZUdNWTNkeHpSby9ORjZBZ2pIUlM5dXd0VGROU0Jo?=
 =?utf-8?B?Yytzd2Nzb1dkamgrYUZsQlpUYTdGNWdzQzAwSzhxVVJMZU5xQ3FEMWJIZzdN?=
 =?utf-8?B?M1RsUUIvNUZjZlNYOW5wVWNzYStocU9uUW92dVplMFdvMVZRZ1pnUW1oQ2lx?=
 =?utf-8?B?dDJXK1NLK0ZmVm9QVE5JRWtRMjl4TThTcHNIaXJmbElsVGFiVkVZRFpUMGgz?=
 =?utf-8?B?UysyQUsvbEx0QmdxbmtoTExrTjBJUVBheU9DQUhYTkFyZjJMYnN0b3RBc0hk?=
 =?utf-8?B?Q0s2NG5IZzlZRUVJejFlYVErM3JJcEs2UVBHOXpsdmNWVzFzVmNJQUIzNHc0?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e56f441-3450-4aa6-92cf-08db6847239f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:38:15.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8aPY9fHSWXPy/gXtf9f6m+D9m4O+lr5hGsNOkKrtpEAsZB0uqq95BuGegLilI2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6076
X-Proofpoint-GUID: cPY49ZeJkutA-I4M2OvnlP_sUd4N2d1K
X-Proofpoint-ORIG-GUID: cPY49ZeJkutA-I4M2OvnlP_sUd4N2d1K
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
> When bpf subprograms are in use, the main program is not jit'd after the
> subprograms because jit_subprogs sets a value for prog->bpf_func upon
> success.  Subsequent calls to the JIT are bypassed when this value is
> non-NULL.  This leads to a situation where the main program and its
> func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
> has an extable.  Extables are only created during JIT.  Now there are
> two nearly identical program ksym entries in the tree, but only one has
> an extable.  Depending upon how the entries are placed, there's a chance
> that a fault will call search_extable on the aux with the NULL entry.
> 
> Since jit_subprogs already copies state from func[0] to the main
> program, include the extable pointer in this state duplication.  The
> alternative is to skip adding the main program to the bpf_kallsyms
> table, but that would mean adding a check for subprograms into the
> middle of bpf_prog_load.

I think having two early identical program ksym entries is bad.
When people 'cat /proc/kallsyms | grep <their program name>',
they will find two programs with identical kernel address but different
hash value. This is just very confusing. I think removing the
duplicate in kallsyms is better from user's perspective.

> 
> Cc: stable@vger.kernel.org
> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>   kernel/bpf/verifier.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5871aa78d01a..d6939db9fbf9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17242,6 +17242,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>   	prog->jited = 1;
>   	prog->bpf_func = func[0]->bpf_func;
>   	prog->jited_len = func[0]->jited_len;
> +	prog->aux->extable = func[0]->aux->extable;
>   	prog->aux->func = func;
>   	prog->aux->func_cnt = env->subprog_cnt;
>   	bpf_prog_jit_attempt_done(prog);
