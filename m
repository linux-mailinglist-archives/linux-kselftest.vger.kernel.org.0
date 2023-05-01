Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1A6F32CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjEAPYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjEAPYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 11:24:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0310C3;
        Mon,  1 May 2023 08:24:00 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34146re5005110;
        Mon, 1 May 2023 08:23:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=T+cBrEVAQ01z7y09K+yecS/vBBlKsGFnRfYWClhFs0k=;
 b=hFwaOkaGKuRt7OopDsCZhRm9jORCowgvJ6CG4E/9+cm6hOhEBJJ3uGlvsoIvIatyJNYi
 f2KWdVIqzK8DxS0DW3/xzeuDJAZt1pIvKR76lUixEjcJAlubF/6PkzEdopsI42RX1Tzk
 fSj46qgnITRTACwlFnRNIzgYu4ZvZpCpQjeo/CtCNm1HDh9F6hQWzw2jVoQPW06Z1vaV
 UTJiQQtRe3v+FddRefmP6VX5x53pnzD6aV9kSUhc3Jxkl/gkHQXjJGdTcdF0ljKbhAq6
 VgPvCNfmR0jw3pTi3UieVb7+zeTBtJ9y9r+yCXU4r+ypEfktMJtZUyIKgQnwAC75ygP9 FA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q923hufy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 08:23:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYUjrltNiPHQmqysGmVjwyO4q9q4eaFEBp2N4Rx4n4sh8qu5FtM5B6IafJ14nDC57FpwudhP8bkSXS9XICv/p+NgFG8lv2ToFp2wFy+ViO1YUxjTzLXAqeninnch/PzEUTHX2xHYF4PjAaE+g3tQ00uTA/t0wK04+jBtiiVJaWkk0ezmKr59mKd43R4xT3RrqRIq9JQgWbB6xwt2xhjVdIDNa5S2ut+/cCMYHQpnPxdeizsmLhXMBTYabrmTLSJaiOERydv4aL8le2qTOZeX3khlELqfzcGuK/OwRMDUxWUKb+14FPXTWjjVGW1l06dJvl5zqDjfivM9ZMJq7KqWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+cBrEVAQ01z7y09K+yecS/vBBlKsGFnRfYWClhFs0k=;
 b=iP+UaPbBvJ5eBJ7z/AorzRavoVx66dFRGHVcZDYeMFAcz+1CXyyH3MpG9efsdo9E1AdIt/78YE0vyKXgo+wy30BordCN4OlMxA+67uZs4vHckNZKo+6JCljnmwSx79rbfKRi/dFl3yoavCzeL/ZY2PJ94+bsvCrRkt8/p1cTbgt24feoFS5oohes6UaZ09S+we1nqWi36w2il/0cakgDu2g8TyBQCbUQ0NSHZIkWRD9NBsYYxEJqkT21LjY/mmFitu/iZ9Z4qyVAPPh9TA/c03OfTwjfCqpsPx0j1ZIS+e6yneCHRi2bXPx/34LJ8dIK4JId4NjZ20MLERX7l5IcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4483.namprd15.prod.outlook.com (2603:10b6:806:196::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Mon, 1 May
 2023 15:23:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:23:39 +0000
Message-ID: <533437a4-a76d-96e0-b04a-ab8eb7b5fb7f@meta.com>
Date:   Mon, 1 May 2023 08:23:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2] libbpf: Improve version handling when attaching uprobe
To:     Espen Grindhaug <espen.grindhaug@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <ZEV/EzOM+TJomP66@eg>
 <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com> <ZErK0M/qAi/VS8U8@eg>
 <0e7b884a-05c3-83c7-0de1-9bfe14ff77b3@meta.com> <ZE+4Ct7ZMecFy7YV@eg>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <ZE+4Ct7ZMecFy7YV@eg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf99f90-6bfa-46f7-8007-08db4a580a75
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wW/BXeM6nL9a0U/sIYNNe8F2VlJ9In3WefeWCssSSUFFy+vRBvVHH2WpZ9ExyxQeMWQSiE8tvigVRnyfIYtbdV1PVeCzepu3Ipznx3gUNJwsaiv3nx/FSJjoh3JmwEcQiJLRLU9dPWz8YvnXIVJCt2mTA4BSS3IBY1NTZWyFCHKI8b0I8as/O0RtmLDgRiOWQzAT/YpxrkUwlO9plQg440YBBB5U5K2zW0UNWlHSq57INBrOQrmExyvmDDZYUwd/8xKdjWu5lBVMk5JLjS9Uwj9q1sBB5cNdlssnhyuX3TUtAH2XD8k/bhC1fq2zDVeDvMwMYyqNgbsLCNSQmGcKfbdnz+dxV2pcRvH31pFIYSkFlFPUfVjzcAtZv8bl/AF4+LUCVnGuhIEY8zAYu5I5yk6pheKK+iU2FeYVPR9RQeEeopMfqfZ59xzcprsqFWzkYQeDIdIPzPJ5dR4QoEnQN/5Z9l3oKlOwCZxqzKi/Mh7rz8bI5pLQdw3x0LsT+Dyk37ZW26Qvpmiy9RmPFFrWvJOZ3rBrwRj/FEsJH6jE+FtQlJ3O5N7yfdsRjC7kdpjm+2WFWcnK2gfpYPF/uTSIx6aJwa3NtkFTHbSFbG2lliYczVR8k+sePHl5JtXwUppV/iQP1MhC7dI25zqp6nLfcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(31686004)(31696002)(86362001)(36756003)(38100700002)(2616005)(6512007)(6506007)(186003)(53546011)(83380400001)(6486002)(6666004)(478600001)(54906003)(66556008)(4326008)(66946007)(66476007)(41300700001)(8936002)(316002)(6916009)(5660300002)(7416002)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmE4VzlaNldzL0hJMFJqaDVZeXRjK3ltOXp3UEtsaHRQeUl0NS91aDdISlZj?=
 =?utf-8?B?bUZXUzQwcDkwWVc1K1dOVE5mZnU4NEZPWmNkalgvSG4vcmF0eElacEo2MXI0?=
 =?utf-8?B?cUlMYjJsQ2JKOFNVY3BzQzhHZmVwNnFLZGF1OUxuaXVyZWJJKzFXUGNaTVJl?=
 =?utf-8?B?Y2F6dzRNSm1OY2cxdUZmNTRQSU54VVU3VExpaEJuOFYvV3pGWkxIZDNBT0pR?=
 =?utf-8?B?ZmUyVGtqU2JrR3hHWk9wUXI5OEhHSWlMU24wd2owaXJLWldzSENENmVaeE5Y?=
 =?utf-8?B?VmxlM0VRTFFNREFaMUJIbE1JQ0twWWcvVjgrZ0w3d1lPbDY5SmJVUFBQYUdi?=
 =?utf-8?B?MStTOERJb28vQjNjRWR1M01Od2dwOVZYZE8yaElpdHR0UXlqVjdybm1seHR4?=
 =?utf-8?B?ZHhJMkVjWnk3MmtsN1UveUxicENxZVJEYTAvb3I1ZXZHNmdaQlZSWi9MeDB1?=
 =?utf-8?B?ZTlBR1ByOVdWeCtUMFV3QzdRWVJTNXg5bWQzVkd4ZFVjZCtjTzF4UU14RUVZ?=
 =?utf-8?B?MXNwOTB4VmVOdStEQWtya3cwZmJGSUViVW1JTmo5SUFCUzdOME5BZVpSNUUv?=
 =?utf-8?B?YjFMdDVqdGRaakhkbEIvak1EdFZCcEtSd2psMEh0TzFCZndrcTRRT0ViaEFY?=
 =?utf-8?B?ZjdYd2w0aTgyYkp4VHJGdXdQZkZOSEJJMDZHa1VjajRCZEprQkgyRGNFT2h3?=
 =?utf-8?B?V3R3enluMEJlUVdxSG9xTTBYQXptQ1RwUzRzbzJhYTIyVVBzYnRHK0MrS3Ft?=
 =?utf-8?B?S2E1YmpKYmRXT2o2a0RNaWJ5UVByNXZrV0x3c2t3bHBEVGs0TjRYSEp1VEFk?=
 =?utf-8?B?Rm5qOU9rUW80a3pHVnNHK2dJMVAwVW9yak5VWkw3bnlCNVVZak5PMzBWVUlx?=
 =?utf-8?B?blJpQ1VBaW1rOHJsOTl2dzE5bVdQTHA4QUV5Y1p5UkRUY09YUjNDdTZLK2Qr?=
 =?utf-8?B?b2p3dXlkL1pmQ09NY0FhVE1BUWFUZnNYTEVtZjlsb0t0Z3VidmZMV3ZrQmRu?=
 =?utf-8?B?Q1hBR3RZTHpqL3FlbFVwL1RlekZ5UW0xMFlBNEJXZmhpVDQwbTlDQnNJSXI5?=
 =?utf-8?B?bmFRekJLYldGRkxPNjlGYnZiRzFGMGZkS0VJbXNmeElaNmRPT2JBU1J4WS9O?=
 =?utf-8?B?aDR3V1MxejdFUG1XT0RIQ0gyTFpsZzdhTTZqZkt5TXJQUEI5SCtuT2dZSzNr?=
 =?utf-8?B?cjVCSWdrTUExZ0lGMkZPajlZbFN6U2tLMGlkSk4wY0hpMDg4bmZCQ2RNMDla?=
 =?utf-8?B?RmlaK2l4WjdpWWRudnNQUk9XQllkN2FiSWttSFV0cUF1NEUvQUQ3K0xKbmVJ?=
 =?utf-8?B?TEZLYTNTdE9DSU5xeFh3bENtM3o1b01kYVJKeTNPWnkxVDRWL3BQSzNSM3RQ?=
 =?utf-8?B?bTNjV1I4dEcrc2U1bE5Vd2lmR0RMSnAza3dWSTVYMTV6VkxmN0NBK1lvVU5U?=
 =?utf-8?B?K3JWdU5hT29JUjVsUGJIRnltK2VwV1ZQNkR6ckR0akZYcG9JaXBPSms0Yi92?=
 =?utf-8?B?dXgyUHpZd2FYeTFsOWk5RjF3VTI5VUcrYWpBd1k5Nk5KYmYxQjFYVUxRTHhL?=
 =?utf-8?B?a1hNeURTSmk4TUVvelR6c2pSTHlHR0hmcFcrbU90T0xjcit6dW5Db05VMlF5?=
 =?utf-8?B?VlJUVGNaT0NrMm1xVjJzY2N2UThackVDM1ZJdUQwWkJhTTJnQmFpVndoLzBO?=
 =?utf-8?B?V2FrVkZ4ZXAzOEJsTE8vR3loRitWeVc4dUZoWUJUWHJESStsM1I3NGx5Q25U?=
 =?utf-8?B?YVB6aVgxVjN5ejNkeHRpcjBTRXNaL2VvQjU0S2x6aWhZc0Jra2dxRHVLQ0d4?=
 =?utf-8?B?WE40ZXJyZ0pRWFZNMVlSc1JSWlZvZHhtd2MwaVVDSlBjL0ZiZzYvdURBRE9v?=
 =?utf-8?B?WW1wMzhqa0N3K2JTS2QwTmNTMU11UklBWDZsejR4NWc2eEJteUhsdEZIb0tV?=
 =?utf-8?B?YU1KeEsxSXp0ditpMHVlbkNUMHBRS2tQOEszZ0lqdEh1a0p4NHRyUVJWNEg3?=
 =?utf-8?B?aG41Y2lXUVVKNFFzRm0zOW83SjZ5U29naW54S1VFaWp4TlZzc2lLWm9KRjVE?=
 =?utf-8?B?VXFlL1MvK1A5VTNnMVd0Yk0rY2wrZUd3Q3BzVzkwWFB2THFZcFMwT1JDb0Mx?=
 =?utf-8?B?TXFRR0JRSlNXTENFNzBPalRrbW4wRW5CVEZHUnJpNm5FdVhQaFA3c1F4Y1VV?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf99f90-6bfa-46f7-8007-08db4a580a75
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:23:39.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Cq2ziBWxZA52q4GIcUb1oTheE5v1ZvZCIo+Y9BGvbkzqpjWarpcKOxpOP1spHFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4483
X-Proofpoint-GUID: iCwb99d2Kih9HnA1i0PirfFMcpSyEolP
X-Proofpoint-ORIG-GUID: iCwb99d2Kih9HnA1i0PirfFMcpSyEolP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/1/23 6:00 AM, Espen Grindhaug wrote:
> On Thu, Apr 27, 2023 at 06:19:29PM -0700, Yonghong Song wrote:
>>
>>
>> On 4/27/23 12:19 PM, Espen Grindhaug wrote:
>>> On Wed, Apr 26, 2023 at 02:47:27PM -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 4/23/23 11:55 AM, Espen Grindhaug wrote:
>>>>> This change fixes the handling of versions in elf_find_func_offset.
>>>>> In the previous implementation, we incorrectly assumed that the
>>>>
>>>> Could you give more explanation/example in the commit message
>>>> what does 'incorrectly' mean here? In which situations the
>>>> current libbpf implementation will not be correct?
>>>>
>>>
>>> How about something like this?
>>>
>>>
>>> libbpf: Improve version handling when attaching uprobe
>>>
>>> This change fixes the handling of versions in elf_find_func_offset.
>>>
>>> For example, let's assume we are trying to attach an uprobe to pthread_create in
>>> glibc. Prior to this commit, it would fail with an error message saying 'elf:
>>> ambiguous match [...]', this is because there are two entries in the symbol
>>> table with that name.
>>>
>>> $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
>>> 0000000000094cc0 T pthread_create@GLIBC_2.2.5
>>> 0000000000094cc0 T pthread_create@@GLIBC_2.34
>>>
>>> So we go ahead and modify our code to attach to 'pthread_create@@GLIBC_2.34',
>>> and this also fails, but this time with the error 'elf: failed to find symbol
>>> [...]'. This fails because we incorrectly assumed that the version information
>>> would be present in the string found in the string table, but there is only the
>>> string 'pthread_create'.
>>
>> I tried one example with my centos8 libpthread library.
>>
>> $ llvm-readelf -s /lib64/libc-2.28.so | grep pthread_cond_signal
>>      39: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
>> pthread_cond_signal@@GLIBC_2.3.2
>>      40: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
>> pthread_cond_signal@GLIBC_2.2.5
>>    3160: 0000000000096250    43 FUNC    LOCAL  DEFAULT    14
>> __pthread_cond_signal_2_0
>>    3589: 0000000000095f70    43 FUNC    LOCAL  DEFAULT    14
>> __pthread_cond_signal
>>    5522: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
>> pthread_cond_signal@@GLIBC_2.3.2
>>    5545: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
>> pthread_cond_signal@GLIBC_2.2.5
>> $ nm -D /lib64/libc-2.28.so | grep pthread_cond_signal
>> 0000000000095f70 T pthread_cond_signal@@GLIBC_2.3.2
>> 0000000000096250 T pthread_cond_signal@GLIBC_2.2.5
>> $
>>
>> Note that two pthread_cond_signal functions have different addresses,
>> which is expected as they implemented for different versions.
>>
>> But in your case,
>>> $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
>>> 0000000000094cc0 T pthread_create@GLIBC_2.2.5
>>> 0000000000094cc0 T pthread_create@@GLIBC_2.34
>>
>> Two functions have the same address which is very weird and I suspect
>> some issues here at least needs some investigation.
>>
> 
> I am no expert on this, but as far as I can tell, this is normal,
> although much more common on my Ubuntu machine than my Fedora machine.
> 
> Script to find duplicates:
> 
> nm -D /usr/lib64/libc-2.33.so | awk '
> {
>      addr = $1;
>      symbol = $3;
>      sub(/[@].*$/, "", symbol);
> 
>      if (addr == prev_addr && symbol == prev_symbol) {
>          if (prev_symbol_printed == 0) {
>              print prev_line;
>              prev_symbol_printed = 1;
>          }
>          print;
>      } else {
>          prev_symbol_printed = 0;
>      }
>      prev_addr = addr;
>      prev_symbol = symbol;
>      prev_line = $0;
> }'
> 
> 
>> Second, for the symbol table, the following is ELF encoding,
>>
>> typedef struct {
>>          Elf64_Word      st_name;
>>          unsigned char   st_info;
>>          unsigned char   st_other;
>>          Elf64_Half      st_shndx;
>>          Elf64_Addr      st_value;
>>          Elf64_Xword     st_size;
>> } Elf64_Sym;
>>
>> where
>> st_name
>>
>>      An index into the object file's symbol string table, which holds the
>> character representations of the symbol names. If the value is nonzero, the
>> value represents a string table index that gives the symbol name. Otherwise,
>> the symbol table entry has no name.
>>
>> So, the function name (including @..., @@...) should be in string table
>> which is the same for the above two pthread_cond_signal symbols.
>>
>> I think it is worthwhile to debug why in your situation
>> pthread_create@GLIBC_2.2.5 and pthread_create@@GLIBC_2.34 do not
>> have them in the string table.
>>
> 
> I think you are mistaken here; the strings in the strings table don't contain
> the version. Take a look at this partial dump of the strings table.
> 
> 	$ readelf -W -p .dynstr /usr/lib64/libc-2.33.so
> 
> 	String dump of section '.dynstr':
> 		[     1]  xdrmem_create
> 		[     f]  __wctomb_chk
> 		[    1c]  getmntent
> 		[    26]  __freelocale
> 		[    33]  __rawmemchr
> 		[    3f]  _IO_vsprintf
> 		[    4c]  getutent
> 		[    55]  __file_change_detection_for_path
> 	(...)
> 		[  350e]  memrchr
> 		[  3516]  pthread_cond_signal
> 		[  352a]  __close
> 	(...)
> 		[  61b6]  GLIBC_2.2.5
> 		[  61c2]  GLIBC_2.2.6
> 		[  61ce]  GLIBC_2.3
> 		[  61d8]  GLIBC_2.3.2
> 		[  61e4]  GLIBC_2.3.3
> 
> As you can see, the strings have no versions, and the version strings
> themselves are also in this table as entries at the end of the table.

I see you search .dynstr section. Do you think whether we should
search .strtab instead since it contains versioned symbols?

> 
>>>
>>> This patch reworks how we compare the symbol name provided by the user if it is
>>> qualified with a version (using @ or @@). We now look up the correct version
>>> string in the version symbol table before constructing the full name, as also
>>> done above by nm, before comparing.
>>>
>>>>> version information would be present in the string found in the
>>>>> string table.
>>>>>
>>>>> We now look up the correct version string in the version symbol
>>>>> table before constructing the full name and then comparing.
>>>>>
>>>>> This patch adds support for both name@version and name@@version to
>>>>> match output of the various elf parsers.
>>>>>
>>>>> Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
>>>>
>>>> [...]
