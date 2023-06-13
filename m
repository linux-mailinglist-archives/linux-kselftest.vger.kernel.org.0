Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1072E46E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjFMNnT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjFMNnS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 09:43:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158CA0;
        Tue, 13 Jun 2023 06:43:17 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CMkEMK005413;
        Tue, 13 Jun 2023 06:42:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=3v90fWiaRXsvHkqN3i92wN1g/5sJM3WgQ+0tys61Wa0=;
 b=KVkPqOtpVfiVZie2mYWwfeAv6y+kOZAZKhNTv540tXlb/pbZ7EB0yNQE092nBwIcfxw8
 Z0/Xh/sqDj/+GINXI8nhuj5fOzIerseCnY7qVZFOVY/lToqklRCy52kgImkNS/+7ZACZ
 m3a3jcElsnSSZxJ/lFM60eNM+XhFXo6LC/kgTJgBqZvvFs7lmlLsdppFrx7scCh6pJmS
 ygSZMbbHx8TxVJryinjmMy0m5d+sqc+dNkaelEUw7KOYORNDqNCJJLlzaml4bn2jmIvA
 i8GI2qHb/oifpOD0v7cp4OCPVqK0OXTJZNvmzIki9IkFHT2t25KAmdplW56K4vUgv4mz Jg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r6caymkyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 06:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP7J4qRyEGH9n6eanVRPJH4cZalja3Z5JSYzd6qxydy1IvzwjKvrdI2RsIi0djdBvFcttKdC+JX7Ul1NXFula6Zo8eGOgsimpwzX5JXBSD0z3LoiHN06a/D6mE/Udaj0eD+y7g31AgEbNtCDmEbrdog3gqtkK/5AdWFfRiyj0Ts/T4ZFBE55jGOvjpunl+vj9nQ5AkAv0U7NgsM9cAD0BXf0qrwFWBqhi7wTNAf13roqrlM3LXccgCYKnKAUuWT1BzNLblmMTa/mkaJyLgKKg6DHEJyaTIwfqPjbWTpQzG7wrvC4+AwlxPKNmwN4pa2QCgAxE++t4xqfg7ho7dBCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v90fWiaRXsvHkqN3i92wN1g/5sJM3WgQ+0tys61Wa0=;
 b=a1l/p+MSOLkxWRY8qzdhWJr9c3dK17T6CmTgQKmB8tbkqdcKPX5Pf02xJA6i/vl0QdaYDO9NS0ksi6VlL3KBxC80P87Q7EVU7TC3O1E1OeZjTjV1YkX+tmzqfGPwxsdosmQoMfJAjuD4cA61RL2ewhw+6dGXH7+uojXt0A24hJ5zXWG0HuJeJIrZNQEZH+d2ZngwkWuSQ7150CG+QOxPthiBczdyAm0nnkU5cj+7s07SvfIJ5X9toQLz4ib36qf4iRwYCiGamieHHsvfPI8ZRX9XrCIY7BT34U8guguo2jEUFt35dn2a1ZRfObsZoKJjG9EQFViWdwWvW5v+fxqTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS7PR15MB5376.namprd15.prod.outlook.com (2603:10b6:8:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 13:42:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 13:42:44 +0000
Message-ID: <53510828-ee5b-1d91-0f85-b79da4422741@meta.com>
Date:   Tue, 13 Jun 2023 06:42:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests/bpf: Remove unneeded variable "ret"
Content-Language: en-US
To:     baomingtong001@208suo.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, shuah@kernel.org, jakub@cloudflare.com,
        Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230613084315.62021-1-luojianhong@cdjrlc.com>
 <6228af14241b831be4bae6ebcd63799e@208suo.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <6228af14241b831be4bae6ebcd63799e@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS7PR15MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d264678-d35b-4be3-f442-08db6c141104
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOweqKx2Cn1ujkHxh0kIOKLbQ1++2AWHXWhgCFhWGAOjO+7PJnM8awzGUrFtd/DnyPSsflInltY3jJMqlh2/bcJds1VNQB9eL+H/dK5Q92s2ey+NuGlu4b/PUzkBhh2CMCxTv61SXRZ2D8qpXPvdwk+9A9fLj3C7X7sbjfgA3o4OEnburHupoDzrjexAydJAqCjBbuO/62uta1uZYxsr8z2Y5P3d0KowXmtuiQvBL/76is/pZlwobWp6YYR2tObDM9N4hLPlhuBq+a0tRCrnhMkbjAZeLHSe+sEYVrhMCN3oVV++x/5RT4mFto9dH6AqZdJzh7xY07NKF7YcDhPSKBhPxIOvwItYg1zlauLuNbdSJg8HsBN/lDvK2wOp1zQYiJZWKEFjHJAMClVM1sYsBkIrLB+IJQKwicIDqas4b/JNFP0cM1ZDp6hLnGgXgt4zO719wwNMRyp291aXtzA5r5BStP+qhDlleWdKIjDM2ISSbY1KPWjCdl2Unl8Qat/D9aH3Dslj52TYhjxFtSMrzYSRFqy++c/CnoTJSHHhe1s8/8s3pPRg9Q2+sw2PeRr0+a7iIJaWGP/XAMSMQvWYnHJ4FsxarQo32KcAhmAvsQdjVN+tcBmUOjqa0dnvtGPVtH9xm/3NLpW+xy12p7ndEti74cI3OX2cMUTq9DJo+fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(7416002)(31686004)(2906002)(41300700001)(5660300002)(316002)(66556008)(6916009)(66946007)(4326008)(8936002)(8676002)(66476007)(478600001)(6666004)(36756003)(6486002)(6506007)(83380400001)(53546011)(86362001)(31696002)(2616005)(186003)(6512007)(38100700002)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZYRWhlQjdPdlo2NmRWUDZNVURDeE4xUkt5SFVMWnFmME9QUVVtK3pCSzhr?=
 =?utf-8?B?QjU2VXU1M081TGV0dFlXYW5zVm4xTG1RaFlGVEFpdm1CYnozbHZ6NHpvdHdw?=
 =?utf-8?B?Yzkra2NrN0VSRmI2TzdlNDB6ZHBDSDZTVndhd0ZaUit6THVlUVhnU2FBSnJM?=
 =?utf-8?B?QjlJTlVtZGh1NVhjbUZWYzdod25OSEpIa3k0TW4vb2xqd1JOOE92OS9aUTE1?=
 =?utf-8?B?V2Z3bnZEcE50bnkvTnJneFhadTRHb1BXZHAxSDluTFNQRXU4VFk4Q2xsS0cz?=
 =?utf-8?B?WUFPcmFQWnBDZ0M0ZzNUVmZQYVVyM3RLYlBreXFiNkgyQVUwOG5rTUc5M1E4?=
 =?utf-8?B?NFE1a0c3Z3hubmRkMENERDF2VHBHUGhGVVRnTTEyWHVjd2ZjWGhXOXJxSCs1?=
 =?utf-8?B?WDZaVFI5YldDcCs4bS9VV1NVWnI1Q0FyaHlIUW1yb2N0cEYzcURWRGthT3Vw?=
 =?utf-8?B?WCtHLy9meEhqQnZhamUwb01ZbDNBZE9yR3JHcTNKTEpNc3V0UDBwZlduVjZN?=
 =?utf-8?B?dCtkTW9OVTJLVDlvV1AxZkNJeGJ2UFlWVnFyUVlIV0ZTa2dzT1c4OE1JN0hl?=
 =?utf-8?B?MkM1bXBqN0huNjdxVXJZQnpod2hkcWMzSFIvVWwrbEwyNWV5cFY4ajVCVzNa?=
 =?utf-8?B?SHkvbFBhbHVHaDFKeGRWQW5xd3pILzl6YUs0eG1JL2tPM3NsOVNGQWMraXpP?=
 =?utf-8?B?dFZmYnl6VERiOURqbytOTmpVcmhrMXB3N1Q0R3JFZVUvcjIwR3M3WmNBZUE1?=
 =?utf-8?B?cjN4SmJTa3BIaHM2dXNpZGMvQWxONVY2Y1o0b1V0MXNUNk9UbVJVUzY0eUFp?=
 =?utf-8?B?c3hUc0l5OFczVy9XY2ZLN0hnR0pKOFNjRTNGNk1SS3hTbU5wU1BTNWVoa3hs?=
 =?utf-8?B?bVRlQWMvYzZsdUVYQ25yNjRIZjJFOTcvQW0zWEFYR1BIdFlNY0Y4dkxrTDRE?=
 =?utf-8?B?THV3Qm5aNUZRVnlnT0dwYzRNZERKa0k2L3Q1R2ozWkkzYmJmOTZ5TkN6Q1Ev?=
 =?utf-8?B?cnFpMGJ3YytsbXhCZnpnalhvdVJmWU5UMWJXNGFwSFBSbWUxNEJCQWF6MktD?=
 =?utf-8?B?bzhpSmd2SjRmcS9NbHNHaStNcWw3WGc3MWVlc1Y1YzFFYW5BY2xGN2NDcUNi?=
 =?utf-8?B?WTArT2RuaU5NTGNleEo3dm1kc2xnYUorZ093ZUxET1ZGUTg1MUtrbEFad3RI?=
 =?utf-8?B?R2h4Z1NwZEdoMkVzMHhwa1RRczBka3NadUQydk9IWWRXYlk5aHRPeEFjaDZl?=
 =?utf-8?B?S1R3Wi9udndYdWM3akVQRzJnVlR3ZnNDNFBrd2JSVXlaRWcvN3BQSjYxZHls?=
 =?utf-8?B?UXcxVnFWVnFSa1ExYkFXRmlwM3ZObCtydHhvMlNySmpXSWVyMWIvMkpHM1Jj?=
 =?utf-8?B?b0I2VzJRdVR2KzJjRHZIOVF0Y2Z0MnoxcXM0UE1GNy9vT2t2ME5CWHROWXlx?=
 =?utf-8?B?QkIxYk5FaS9sRFdNMUZIbVkybnJjYWw5WXUyVXNJeTVpa045L1VTb3c3L3NR?=
 =?utf-8?B?bHVQeGRQaTBwN0JqN1gzUFdZbjgySXh4eFBOWjluMzZSdXUvS1hqZ1F4c0ww?=
 =?utf-8?B?R2c5azBtc0JKeS9YMm5NdFM4aEZLTnh6aVZYamxDVjlvcnhjNlJKMU5seHp4?=
 =?utf-8?B?Wm5lY3hRdldKazVIdWQ5aEgwUktNR3E2NVhSaVpndWZiYm5wMjNRb2VmNGla?=
 =?utf-8?B?aFhXRFZLZlJ0alJ4Vmtac3ZjTGh5bEZYTDFEa09iSjg1SEVXUFFhbXpBVStp?=
 =?utf-8?B?TXFZcmVoRXlwa1BoMHFIcDZUS0h5TEtDdEdFWWdyR1ZEU0hxYnFKL1czeDNO?=
 =?utf-8?B?WTBRREt4SWx3blVXM2VmR21YT2RUc2ljaDI5TFhudlBWYkdOUHJjQnpQTWVn?=
 =?utf-8?B?Y09UYWsvSklITzVQeTc1UUhyWVE2V3dSRDdqejJwYUdlUko2SldCclEvc05K?=
 =?utf-8?B?dEJFeHVyUm5HOFU1bzNKbnhtNitLSkNTMzB1YXFkMzdjY3pMa2FkN05EU2JT?=
 =?utf-8?B?ZyszcXRjNFZvcFBoS3JudFp2VC9Vb0dJSHJlVm9yL01ITjR5REJra0Zkc2ZE?=
 =?utf-8?B?ZlUweVZRV1dYaTlOOTE4SkpaNGt3dGdVSHRDTmN2UmNkVG5uZ2hqUXh6N0Rp?=
 =?utf-8?B?NTZ3UkkwV3gwYlE1WU15bW5KaUkvbDNwU294K2Y3VUFIUVZTNkdPQld5NzBF?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d264678-d35b-4be3-f442-08db6c141104
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 13:42:44.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlB4ua3G/1kC4yKy3fs2gA/7/gSbw3z2nkYUtYjIPB/p3NfufV81MHqvdYJ7N2Rp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5376
X-Proofpoint-ORIG-GUID: Vi-1QOw2i1I9377wftmZI0mpvtj90gUP
X-Proofpoint-GUID: Vi-1QOw2i1I9377wftmZI0mpvtj90gUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
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



On 6/13/23 1:50 AM, baomingtong001@208suo.com wrote:
> Fix the following coccicheck warning:
> 
> tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c:28:14-17: Unneeded 
> variable: "ret".
> 
> Return "1".
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>   tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c 
> b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
> index 4a9f63bea66c..7f0146682577 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
> @@ -25,10 +25,9 @@ static __noinline
>   int subprog_tail(struct __sk_buff *skb)
>   {
>       /* Don't propagate the constant to the caller */
> -    volatile int ret = 1;
> 
>       bpf_tail_call_static(skb, &jmp_table, 0);
> -    return ret;
> +    return 1;

Please pay attention to the comment:
    /* Don't propagate the constant to the caller */
which clearly says 'constant' is not preferred.

The patch introduced this change is:
     5e0b0a4c52d30   selftests/bpf: Test tail call counting with bpf2bpf 
and data on stack

The test intentionally want to:
   'Specifically when the size 

     of data allocated on BPF stack is not a multiple on 8.'

Note that with volatile and without volatile, the generated
code will be different and it will result in different
verification path.

cc Jakub for further clarification.

>   }
> 
>   SEC("tc")
