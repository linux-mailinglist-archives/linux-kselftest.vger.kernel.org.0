Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C260072A652
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 00:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjFIWkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 18:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjFIWkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 18:40:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3153A98;
        Fri,  9 Jun 2023 15:40:44 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 359LjodT014555;
        Fri, 9 Jun 2023 15:40:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XAxVyeY2eoaSKsLm7wSD2WmU7v7i/xV6ZzD2Z3QS7Yg=;
 b=lQqIapGDK2XdIQoD8yCFPXZgjENyM88KyfRjkc/OqtixwTtnra4s6E9QzY7IiqowzAor
 e/iOqJy+Sb9Hg9enXfepe2qZZ3f+IoG5V7wJ+EZWplYL8pFEfHsUOgUylMd84KH5dvOW
 LJsiQpx91EJx79lkVV17MYTPcawJ5qLfYAMc6WtYNEY4MVhMmj8Ul66tH+GySLjMMFZi
 2SltaIFggedFVwNFhn4pbLvM/zBhyQIVN/dRDCDzoxuvy8bkv9+94T9ZpvzSRx3nAoIK
 6tLXuILnpFvMt65YoFfiiPOU2m002ww3TmKo64j/3ElkGawlFXCpYQNwbhMeWsRrSxL2 8A== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3r4c9889mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+sUR8y4ASxv1mj43UKjMvPNo9/RgCd2gsgHGQ+4hpR9rubToU+2+siiJ5r3wZHGkxgj6fqkd5ejnpwFAMCr0PffOae4lXxSjZlVRdU8taWPk8D0huDD3niz6FAoCOIeL9G/2Eli9KHm9NWCl006M40nEATsyYBhXLeKGpQ34diWc9dq/EE4H3uSIw/BrDa4jbs8cPVnV+WXOfpAcAFpdGcdpZ8NFCw5fSWpexdZSJfgWa608vb8bNiA19hn7jCJdGJ1uRZf3NL831S0y6ROZ9GulHtfUGFdDqRNofiPJ3GM9Baxl70VJ9OxCU5YdcGaKX6iHJ2yM7OWPOn8ALPveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAxVyeY2eoaSKsLm7wSD2WmU7v7i/xV6ZzD2Z3QS7Yg=;
 b=QPFuERCNILpnUlmjV+We1kviosgcJ0AF654xedZBi8vHVcIakRbZRKdvybEIyKoFP8h/mUfqFIQU+6yNRFvhVExt20uF7WAZZ6Bz2vh2+YzxRAAz7YdFHszycQ9L9u7puBN6+FiD6yxB5Ulkxrk9RDD0hnbdH9xvjMV1zXMpja1zq3yeSvEisiBEQL4uhHebrNqE8ZBn+zGL0jH+U0oIXpz6jfJTD3FT37quQDE9UbjmTtjaQCD+h3ODYiMTsBBSTBsCl1hEllts1UVqDsE+LBWPlw7U6ua3AHyD6ErsKrcG1ajnW64gDUEEc7In4WOHIIZPeUIALLY02LM5ExLOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3767.namprd15.prod.outlook.com (2603:10b6:5:2b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 22:40:22 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 22:40:22 +0000
Message-ID: <fbd243be-7ee7-2c77-e124-11c192173981@meta.com>
Date:   Fri, 9 Jun 2023 15:40:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add a test for subprogram
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
References: <cover.1686345886.git.kjlx@templeofstupid.com>
 <6a8b4285d119652f78993af2955a213e7af58ba0.1686345886.git.kjlx@templeofstupid.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <6a8b4285d119652f78993af2955a213e7af58ba0.1686345886.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3767:EE_
X-MS-Office365-Filtering-Correlation-Id: ce728ff3-7308-493f-b309-08db693a8279
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMkE1wEqTNfx9wkRVpYXikrMmKV7D6z7JRwF+YhqE4OfYE/kqbeNaCfnCSsnwAO5NzCWEj0hFSFdNyhZukiZeEc3jeShukHfz7JkXBfmtU3pIAFg2iRS3lgbDdZfFXcJ11jUWCFt453ApyRX9+0HfT2KX0aEtnt0XYKHmMaWCDQNjVNhOFWcTBKK5jlAhLlUD+V+KkqG0+LjmeXiXwoLiXEC8u1JUG89Z5ua1JZOyRuqYpKlGYemEKOECMiYDIpWXn0u8cdSpf+x0rVtOsuqVLjJ5fYcDhXamLJzNlsCDjQFna8VKvjhLqJWox/qjOaD+p+FGhXOJgOXhUj+6YzX+D5mTgnTE6Jjdjy89ay/aWij8KV8yukR3H+/zj/240SLuUvlsKIghxKNpZ7prxzPHn1zpGu4+7t11I0k0BDUfGrfXWg3h4X9ISj15/SUeyRwaOo6iY5dKFLljlF9vLRSHXrARWrdQPcmfAoz6CNAibV6TVLkXEKmJOolaiMmr8PxV1cuXfuJTnDEtMFN6UN7LrObcvtmDrt/kaM/5HbQ5k1FOaOUAmwz7Kljecv8PlHf/s92CGsj5ne73t3dQl73tdjFBdIQ1ocMDvWCTvUuO3V/PSsqsM9DxU4GbkNt2VMOyEXpMz3finaHYh4Ljasoww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(186003)(478600001)(54906003)(36756003)(45080400002)(6486002)(6666004)(6506007)(6512007)(53546011)(41300700001)(83380400001)(316002)(38100700002)(2906002)(8676002)(5660300002)(8936002)(31686004)(7416002)(86362001)(66946007)(66476007)(66556008)(31696002)(2616005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZvcjFTNTRJMXpmNlVzbzNwNnhDbUt1TWFzb0ExWHJ1MVhrMTUxNmhmL2VQ?=
 =?utf-8?B?OVZwUVBoSWNvS3U5dGVPSEZ0bkh1OWx0Ykk2SXBIVmtvdFNBWFFNZUlkak5x?=
 =?utf-8?B?aDB6TW9KY2E3NllHUGpsRTlxZFFZVFQ5Rm5rWUVnOVo3ZWlQS1lHR0FqTHRC?=
 =?utf-8?B?enpuN2RVMGU3OFl6SzIzUVJXQlBpUTNxSk1nb3QxNDhMdGI5UVQ0amo0ME9i?=
 =?utf-8?B?bFI2WG5DV3QwcHJBcTVGcHBrcjIwUW1rSjRmSVcxTTk4SHFZR0pLTUNpaG1U?=
 =?utf-8?B?MGJzcmI0b05xblU3V1d2ZUR1T0NoNGRyZmRISDdmU0hDb3dlSDFlNkNDNWRG?=
 =?utf-8?B?Y1ZZMUdXRHdjZG4vK3dQYXg5SVB1OTcwVUVNeExSOXZZNGgyVzIxL0JIS0hD?=
 =?utf-8?B?dnQzQUQ3ZllrbWNDaEFNamNzWk9wcldtRHowUHBTOHZKKzV1ZktEYmpBWVMx?=
 =?utf-8?B?Q2QzRWlhanE3WEN5YkhyMkc3Wnl1dHZPS0lzRGt6Um1HNGJzanh0TWNLcnY2?=
 =?utf-8?B?Yk96Y1lIeDEvZGtXR3Q5Rlg3SHVMdWh1MHZaRmhCUXBQdDkwb1NLQm9LVHRP?=
 =?utf-8?B?MExhQ1hScjgrY214TXlIMHNpeHUya0RiVnFnUWNFemdOUjlMY3hGNEhtanVm?=
 =?utf-8?B?MjFURjBkeEViK2tvNFFHNGZxMmthaHV5SnZhVmNFWGxUNnYzaVJlUnAyak44?=
 =?utf-8?B?T3JQQVJoa3dHR2YwaXNHWlljVDNCZUJQY2RWa2lwWHkyV3pSaGtPc1dYUkVP?=
 =?utf-8?B?YndXR1ZWa2JFdmsyVk16U2o2am9hL1NKbVFudGVkTWxVZDNRS1RvaFpZa3lL?=
 =?utf-8?B?cnhTT2lmRWdWV1hUWWRtZ2ttSFN1VXJKUzNhZFFSeWVlcDhZNnlSczlMM3dq?=
 =?utf-8?B?cEJ4RWlINTlzYVhYTThMUU1CN1J2NEM5ZXN5MHNuODdzV05qeG1FR0tBQmdi?=
 =?utf-8?B?SmdNMVQzdlRqcUdFU21MWUdNT2U4SzQ0cE9Vd0p0UmJ3UllUWU02d1U5K25w?=
 =?utf-8?B?VDVodncrcTVmWTBrQ2lVUC9zYmwwZ1VsMVJURDN3TkNkbmxFTlRYSHJPN0px?=
 =?utf-8?B?ZWZIOTBjM2tVbll5bzdUclQ1ZUhBZlVDd1JvTlZpaWZheEd6eVNLWDBHQlo5?=
 =?utf-8?B?YitxTjd2clk5VkFlYTNVWFEydXByU0tMNEt3cTR0REN2ZTh2RGptMFZYSUE5?=
 =?utf-8?B?WkFQUWJKayttNXRSTnYrbE82bmxld0hteHBqOC9MT01COU9sWlUzVlkydFJ3?=
 =?utf-8?B?dS9Ib2NVbHFwK0h5UE5RN1g1dTBIZWdIKzB3b2dtbVhWNTZSZnNqbUFFU1NP?=
 =?utf-8?B?aGRQeVFUYWxzWENrTFg4dytITjNhYUFNV2pQNW9RVWhKRng4bGZzVUNmenJl?=
 =?utf-8?B?aDVmWU5KODJ5UXNXMloxZkQ3U0lzMUlWTDd2eC9rVC9BY3RNRE00VjYvOVA4?=
 =?utf-8?B?QzI4eEJ5V3BTMWV2clJoYng5QlhSNE1GRVU4Vkkyelg4S3VONWZ0bUQzNHFn?=
 =?utf-8?B?MEdFSituWlNIS1J6ZTRTRzN2d0FFOE5vUkpNZEsxMk16bTQ5U01FeVlRRm9y?=
 =?utf-8?B?Wkw0bk5hcy9tWHBJbitXNFcvekNVRzZnWndDTS9Jc3U4RFAyQXFnWlBaWDl2?=
 =?utf-8?B?dS9uSWJUMWc5Z2RqOTJPYkNZVXoxNWZ5d1Awa1d3eFM5RDVkdmJrSHFRWHRZ?=
 =?utf-8?B?ZmFMLzUyUWloYkJSYXJXd2tyRFpXTFYyMXVYa05yQkZvSUdsRDRodFBxVW8y?=
 =?utf-8?B?Y3FxTkcyREsxbUZnZnA0cFpvY0RLSjIrUHhnbFFya2NDMCttWnFyK3d1bCtj?=
 =?utf-8?B?SnNXM283ZUFGY1BsSWtFZW4vNlRjcDdjaVVFTE83cVNkMVpzQ1pweXZQcDg2?=
 =?utf-8?B?Vk5JNVprVGZlMU94dDg1NERBdHJCM05YREh3Q0g4cE5TKzlaTG5hSWdibzF0?=
 =?utf-8?B?SWZoekoxcGRrdENReXo1WCtySU51L3ZRNjByMnlJL0djc1M1TWxSWjJZM1FI?=
 =?utf-8?B?WllBZTFxNXRGbjVHSTZwNXpnR3J0KzNuZldkY3k4NzV3QWIxeGdzRHg4WWg1?=
 =?utf-8?B?aEw3dzdkTlgzbkpVMnhmblI4S3llSjBPeGFpR25tQXhWTnU0cjJ5T0gvbHpR?=
 =?utf-8?B?YWVIdlk4dldEVkhnbWN2T0FlRk1ISTJPcU9Fc3U4enpycFdVSnBFbExVYVBp?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce728ff3-7308-493f-b309-08db693a8279
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 22:40:22.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itHgggKYLLl0p0aSmOD9QjGkkqy69PSlUxSE0UTW3PUF8vKvUPOMSKi4njJ7Pjb9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3767
X-Proofpoint-ORIG-GUID: Y-GShzm_cYfMakN1HBQnZXuMfice7_tk
X-Proofpoint-GUID: Y-GShzm_cYfMakN1HBQnZXuMfice7_tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
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



On 6/9/23 2:40 PM, Krister Johansen wrote:
> In certain situations a program with subprograms may have a NULL
> extable entry.  This should not happen, and when it does, it turns a
> single trap into multiple.  Add a test case for further debugging and to
> prevent regressions.
> 
> The test-case contains three essentially identical versions of the same
> test because just one program may not be sufficient to trigger the oops.
> This is due to the fact that the items are stored in a binary tree and
> have identical values so it's possible to sometimes find the ksym with
> the extable.  With 3 copies, this has been reliable on this author's
> test systems.
> 
> When triggered out of this test case, the oops looks like this:
> 
>     BUG: kernel NULL pointer dereference, address: 000000000000000c
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 0 P4D 0
>     Oops: 0000 [#1] PREEMPT SMP NOPTI
>     CPU: 0 PID: 1132 Comm: test_progs Tainted: G           OE      6.4.0-rc3+ #2
>     RIP: 0010:cmp_ex_search+0xb/0x30
>     Code: cc cc cc cc e8 36 cb 03 00 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 48 8b 07 <48> 63 0e 48 01 f1 31 d2 48 39 c8 19 d2 48 39 c8 b8 01 00 00 00 0f
>     RSP: 0018:ffffb30c4291f998 EFLAGS: 00010006
>     RAX: ffffffffc00b49da RBX: 0000000000000002 RCX: 000000000000000c
>     RDX: 0000000000000002 RSI: 000000000000000c RDI: ffffb30c4291f9e8
>     RBP: ffffb30c4291f998 R08: ffffffffab1a42d0 R09: 0000000000000001
>     R10: 0000000000000000 R11: ffffffffab1a42d0 R12: ffffb30c4291f9e8
>     R13: 000000000000000c R14: 000000000000000c R15: 0000000000000000
>     FS:  00007fb5d9e044c0(0000) GS:ffff92e95ee00000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000000000000000c CR3: 000000010c3a2005 CR4: 00000000007706f0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     PKRU: 55555554
>     Call Trace:
>      <TASK>
>      bsearch+0x41/0x90
>      ? __pfx_cmp_ex_search+0x10/0x10
>      ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
>      search_extable+0x3b/0x60
>      ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
>      search_bpf_extables+0x10d/0x190
>      ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
>      search_exception_tables+0x5d/0x70
>      fixup_exception+0x3f/0x5b0
>      ? look_up_lock_class+0x61/0x110
>      ? __lock_acquire+0x6b8/0x3560
>      ? __lock_acquire+0x6b8/0x3560
>      ? __lock_acquire+0x6b8/0x3560
>      kernelmode_fixup_or_oops+0x46/0x110
>      __bad_area_nosemaphore+0x68/0x2b0
>      ? __lock_acquire+0x6b8/0x3560
>      bad_area_nosemaphore+0x16/0x20
>      do_kern_addr_fault+0x81/0xa0
>      exc_page_fault+0xd6/0x210
>      asm_exc_page_fault+0x2b/0x30
>     RIP: 0010:bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
>     Code: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 7f 08 49 bb 00 00 00 00 00 80 00 00 4c 39 df 73 04 31 f6 eb 04 <48> 8b 77 00 49 bb 00 00 00 00 00 80 00 00 48 81 c7 7c 00 00 00 4c
>     RSP: 0018:ffffb30c4291fcb8 EFLAGS: 00010282
>     RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
>     RDX: 00000000cddf1af1 RSI: 000000005315a00d RDI: ffffffffffffffea
>     RBP: ffffb30c4291fcb8 R08: ffff92e644bf38a8 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000800000000000 R12: ffff92e663652690
>     R13: 00000000000001c8 R14: 00000000000001c8 R15: 0000000000000003
>      bpf_trampoline_251255721842_2+0x63/0x1000
>      bpf_testmod_return_ptr+0x9/0xb0 [bpf_testmod]
>      ? bpf_testmod_test_read+0x43/0x2d0 [bpf_testmod]
>      sysfs_kf_bin_read+0x60/0x90
>      kernfs_fop_read_iter+0x143/0x250
>      vfs_read+0x240/0x2a0
>      ksys_read+0x70/0xe0
>      __x64_sys_read+0x1f/0x30
>      do_syscall_64+0x68/0xa0
>      ? syscall_exit_to_user_mode+0x77/0x1f0
>      ? do_syscall_64+0x77/0xa0
>      ? irqentry_exit+0x35/0xa0
>      ? sysvec_apic_timer_interrupt+0x4d/0x90
>      entry_SYSCALL_64_after_hwframe+0x72/0xdc
>     RIP: 0033:0x7fb5da00a392
>     Code: ac 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb be 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
>     RSP: 002b:00007ffc5b3cab68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>     RAX: ffffffffffffffda RBX: 000055bee7b8b100 RCX: 00007fb5da00a392
>     RDX: 00000000000001c8 RSI: 0000000000000000 RDI: 0000000000000009
>     RBP: 00007ffc5b3caba0 R08: 0000000000000000 R09: 0000000000000037
>     R10: 000055bee7b8c2a7 R11: 0000000000000246 R12: 000055bee78f1f60
>     R13: 00007ffc5b3cae90 R14: 0000000000000000 R15: 0000000000000000
>      </TASK>
>     Modules linked in: bpf_testmod(OE) nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common intel_uncore_frequency_common ppdev nfit crct10dif_pclmul crc32_pclmul psmouse ghash_clmulni_intel sha512_ssse3 aesni_intel parport_pc crypto_simd cryptd input_leds parport rapl ena i2c_piix4 mac_hid serio_raw ramoops reed_solomon pstore_blk drm pstore_zone efi_pstore autofs4 [last unloaded: bpf_testmod(OE)]
>     CR2: 000000000000000c
> 
> Though there may be some variation, depending on which suprogram
> triggers the bug.
> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>

Acked-by: Yonghong Song <yhs@fb.com>
