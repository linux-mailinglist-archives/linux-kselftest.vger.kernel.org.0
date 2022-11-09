Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77D3622FB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiKIQJh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiKIQJg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 11:09:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16229270A;
        Wed,  9 Nov 2022 08:09:35 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9ExuF6031905;
        Wed, 9 Nov 2022 08:09:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yeEbT6Ku062+I3LEvL398tk7LA4lFQJpVy6P9+BncOY=;
 b=btW2rvp5zO6mEMGh20zpv++APkBtqSdCYpbFyy7HIXNa9zcPzDqPY032CtrtEE/EqL4l
 Id0JVyvH0pmS4FyyGva1NtypCp6ip48i6I3s1ox8qIQ5v4UWDJtBml9arPBOrY2q5EGu
 0bf5418UnvNpxbQZKgSWEgKsQul+Zd4E3i4vV3zDtPmTK9IVEprthwlLRHpRO2Q+XLWm
 WIouUnYW15xkrZaXauiJuhIMA5ajSAlOrEx2UOWH6mjcbAQOuNAd7/hOko1jRO0aWR/Y
 C3P7kw5DnCBj+0lCMjiQbI2RPmykW5AnKrILLS8XbgS3yYt3cPqm1sD/KgZZQgo1P6aC 3Q== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kref3rm2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 08:09:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYPqebwIogk/JKWaf67GDrIdXsDLQhdsZkYFQMfwxq50+da7ALW9BOI/MZVoDMOAJgrWXKRDf2eTcKMIgxOYL0QbrjQ1fxx9K8JXmPUHC1D42EZ1mxB4ly0ukh0BLz/wpuT8eKuCDCG14qZ2UUlzKyB0yW2ej7827P1ZVBJ4o48qkx2cpxWuDdDyM1xEXrjaz91u6BuN63JGNry/AlT7McealjhfwcnbZfdO8PlGFaF5fFWZzSaqIUzkZFCe+IrQwFC5UASwpCDyg+tgXj9TPJwB3psPtACkSeCdTEiQx8ISFdagykBk4supjy1ZBXC2KWwdyQLdp9wSIcW0zTO+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeEbT6Ku062+I3LEvL398tk7LA4lFQJpVy6P9+BncOY=;
 b=RyxM4amf0rPX3A3MBIkgUrjkKyME0vod3bsknQiVWaGj9WU8XkMI0OZTV7tBT1ahifQZzVLWyXZCOpvNbl6XGJPJIipgNzXGP+gwOK0QNFSfGW3puZjhf9tqdc6AAHogY9A/9PyS8zy621/U9rMGM2DSgE9PiEh3wX23sRqOnKZJWA4Mm9o9JVkLD57CeN3dZ9/BvcPpQKhwtsRMDgBIB3bGYPjgC7A9ae8u7UL0Pgi5IdMCo/mbGgR8V9qcO4/TGH5oeBpUDAiWKJbJwfPX+V8Wzo37p3JUta7eKuhd5w9g8sjZa2Y+fqS77JhwKO6JbddNynhpUZ+jN9AJmTLYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4753.namprd15.prod.outlook.com (2603:10b6:806:19c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Wed, 9 Nov
 2022 16:09:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 16:09:06 +0000
Message-ID: <7a4bb953-fc97-0cac-93eb-64a2489e21ff@meta.com>
Date:   Wed, 9 Nov 2022 08:09:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v1 1/2] maccess: fix writing offset in case of fault
 in strncpy_from_kernel_nofault()
Content-Language: en-US
To:     Alban Crequy <albancrequy@linux.microsoft.com>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org,
        Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <albancrequy@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20221108195211.214025-1-flaniel@linux.microsoft.com>
 <20221108195211.214025-2-flaniel@linux.microsoft.com>
 <a725e235-f4e9-84a3-a88b-dce274423a75@meta.com>
 <ab5a36cd-e9cc-074a-2fb6-858f5cc897e4@meta.com>
 <20221109122338.7e931640@neptune>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221109122338.7e931640@neptune>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c25c102-26d6-490b-5d63-08dac26cb9ff
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Z4536dZ14VQy9mG1n8HwkdAmIw7nWodPO7CIb28ssqZGzqnMp2uWrJSV1vryZjLVW/1Tqb60Vx5DEeUcyvVsSXi1AUSN5nHOS9lNIFiTWBusDtXGxtDawba1JWJiCzNFcYt36Mu0lUlBxkbTsTCxejeHOTUX1zEMLVwtQetP0P7L7PVCxtWEGBJ8d5Bp8ngSpYXOFSs78ZqimiYqGJs/XdoIPVWDAfyMQC2/vUEUu5CI6+/xML0aTsoaVLjYy+JrRRpWqhcK8LT5/xTTbn0Y4NlaGH5L17uYNt5A3e4BW9sq7P4yIrd1jMHw0z1UMYrvZbuE6a7sZhCFkPMYSEFbc5alOtkM9IctC9tEUiSMtQCSpMsOmewskXZOAphWtdp4c5lW6pgCIw8zwH7SFNGUIdQD6dGrqu5Gn43c6F4iR7zraz7umQLAav91Fxnty64iv4H/fgtucIag2DL9SYySK0A5Z1raTrESOkmXO6fZzNK4X4xjrbFY+lIfHoTm7UH0y4JqnzlxQ12VPlL3sYrLdkISNaLSHXnqt26FeqADpYb7SjkewEQS3g60pEdD8oQmpygr1COZSFVrtTORvaRlgojcM4Pyz1udvWJbp11lv1ui/3OQe7qV//Qkii75fRNqd3JiolVIZlg13OVGXHSeGIbAEFtI2BpfWEv+dpjVQyG8iP19Sx8WkrvNaa8Jj4whdb7e7bwNECjZlsMEId1shLBpFDQHPMTJbmCvi3cNfjQtTc1e8FPVnZuFzO1HMjAz9fE8ki5GwKu+O4nqgpbev7k0F6PFoZy+5R/JeAWfMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(83380400001)(186003)(2616005)(53546011)(6512007)(38100700002)(6506007)(6916009)(5660300002)(6666004)(2906002)(7416002)(8936002)(66946007)(66476007)(6486002)(41300700001)(8676002)(478600001)(66556008)(316002)(54906003)(45080400002)(4326008)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NSOHFZQkRHZ3pzbjdkYW1kbEFNNVEwZVU3ZHIzck5GN1RTVktEQk1jdDRz?=
 =?utf-8?B?a0VESXpHajYwekdmL1ZKaHQreHljRTczQU14em1hbmgyQUJNMU5ZUzVwUHMx?=
 =?utf-8?B?M01haGRhODhjKzBmOHhtZERJL1VvU0M0QmtYRkRTbGt1MzdZRFFDWU1uNU00?=
 =?utf-8?B?MXp0RW5RbytMeXlnSzIvQXZnUktRUFFlZnZ4SVUrbzl4dnB0MlZSNHRZK0Vi?=
 =?utf-8?B?cHVmNHZoN3d1a1JURzVDQVlMQi92Um4xaTBZeUxVa0lRZjRPSmtkVUl6dm55?=
 =?utf-8?B?bnFWNlpNMUdFSGJZaDZxYmZyQzN6MFFYdEdHYzNyYjhSVmxWQjR4M1hDS3dj?=
 =?utf-8?B?TmoxTFgzUTBPaU5jQjV1MFh5ODJhNElZQkhsSU5zYzVIMEQyck16V1Zwc0lS?=
 =?utf-8?B?TS8ySlhlL3VkcC9yd2VzZ2F5RzNLZG9yTFN4dVI3WWFhSGo0RTBxNksrVFVx?=
 =?utf-8?B?WjNoVERNek4xWnMxbnAzQk1QK0tiamU4R1ZJK2NpYU9BSGszSDdmQzNCUXZw?=
 =?utf-8?B?NlVZMkE1MGxkekdsZklseG5kclhaK1MxS2lWUFRiVm9HK2p5K2FiVEhsTmNu?=
 =?utf-8?B?eHhpSWs3eVlRYmUvSmd0azlFQUZVaEduZ05xeEQ1b2kvVldmSkhaTTNtbVpM?=
 =?utf-8?B?VzAxQVh3aXg0dytBRmNEZlJFTmlDcVcyK0VveUoxTDFCV3JsVFFaTlBZaFFE?=
 =?utf-8?B?aXNDakl0cXY5dDJ4RkI3Ky9RYjNmSFYzVmdhcFVvZHhTd1RzZUFhcmFrdFc1?=
 =?utf-8?B?MXpYa2RBR0ZjQUtGQXA5WEkrQ25sL1p1V3BtZk9BQW52ZUF1Rm5KZUozOW8w?=
 =?utf-8?B?N044MzEyclFKZFZZMVJsK1IxTEFIbDRFcDRJckZ1OGo2YjZZODFycnN3eVZI?=
 =?utf-8?B?WlFPLzBRVlljWWVObWJGdHRWayt0RVZxL0Y5OXI4ZHUwZXhWQ3E0SVE1NzA0?=
 =?utf-8?B?dmNPbFNENndiZEVDcmFod0dQS2hGbXNWMEFBcjEvckw5VjJ4UU5vc3FOcWJa?=
 =?utf-8?B?TkZ4RVVMZjVzeEp4QTFqLzNBR2VqeUdvT3BkNEEvWEo0V2E2VklkOW1iRkE0?=
 =?utf-8?B?aFdzYUs3dDcrR0pwS1lDSjFpeUxZQVREZHpyR0FPUk9PSnZtOSsxTFkwRWVw?=
 =?utf-8?B?ZFFGanZ2d2hiR29kOGdsazVYbUJ0QTFvMmlOMkVuUDQrYm0yUXRRTktuU1hF?=
 =?utf-8?B?cXdydXE3ZktnQ1NRV0Z1MUc2QnJabXhCdURjM2FScmM4ekE3TVB4cWN4cXd6?=
 =?utf-8?B?V1Eya1g3enFZWnBWNkhjMnc5TzlWb3ZQSE1KUlN0blA0djJOOEtQMnNQVDlh?=
 =?utf-8?B?N1dDLy9WVTZHdWZCNGZFUWlEMXJJdlZBRmN3ZWNOemk0alIzcy9nN1RCUEUr?=
 =?utf-8?B?d2NuMFdVL05nWlM0MTh5T1hCY2dndFRCMHR6UW8xNmtzRGczQWEvL1QxcmZ4?=
 =?utf-8?B?dHZaVWhyK3AraUxCWlFMaVpYcm5tL1JkbE9ESHV3UTZmS1hWbVJMcWpYcW00?=
 =?utf-8?B?OGRHZTJOS0M5bFhtZjJjTVN6OEVJTVJaajhmVXo3Y0NCZXNPVWdEa3QxLzVo?=
 =?utf-8?B?T0kvVGcyWkE5ZWcvaUQzc1JZWWZHZWtKMWEyaERXSW1ua1FiaFh1aFYxVFVi?=
 =?utf-8?B?cXEybDlGUUpYVm9HTGJHR282THZZSkJwVGl5VmtIamxHakN2ZkZzczQxeThB?=
 =?utf-8?B?NnVnVG14Tnk2LzdEQklnR2FXUnJFT0g5SWx6b3d0NmRjYjVuVFIzZk9mWE9G?=
 =?utf-8?B?WkQyOGRsYU95Vk85QUNPYTJTN3diSGdNZ0xMS1doUmgvb0FYQ0lET3BrWms2?=
 =?utf-8?B?RUVrTUpKVm92ZGJYb3Rpdzl0OFNpd0N0N09Jd1ZGVkV2QnRjaEJ5N21pQlJl?=
 =?utf-8?B?RisrcXdZcXdDVzNZc1ovOXhRWStOanFvVk9jTFBYS3FPRUZDME1ZcHNYZW1h?=
 =?utf-8?B?NmZUM2NHRW8ydmZLM3ZyWlBXMWxIaG5HODh3TkFtVm1iV2RTVjAwODhoRG9M?=
 =?utf-8?B?aVFxK0xvUU0vSDB0OHFybDlNQmFpbThkL3dsd09wZUZRK29nKyt6VjdTQktD?=
 =?utf-8?B?c0FDZkpYb014ZlVDTUpScGFGZjRXMGJvbURDUEdQajNpU0pQNHpTeHEwWW1G?=
 =?utf-8?B?TTArODJXdjdtWE9lajYwb1pHTjBjYjNZNzBJdXpyYnJicnJOZ1ErR1gvcG5r?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c25c102-26d6-490b-5d63-08dac26cb9ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 16:09:06.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHH9wjwxsCQtacxxKJOiL2OXTnATgyFrPUhSOwAoIvHKeSght/udRvwHYDBFe2Jj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4753
X-Proofpoint-ORIG-GUID: 02Dbg91Bdbbu2IUdZeB2O0HwRLXdh_Rq
X-Proofpoint-GUID: 02Dbg91Bdbbu2IUdZeB2O0HwRLXdh_Rq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/9/22 3:23 AM, Alban Crequy wrote:
> On Tue, 8 Nov 2022 12:38:53 -0800
> Yonghong Song <yhs@meta.com> wrote:
> 
>> On 11/8/22 12:35 PM, Yonghong Song wrote:
>>>
>>>
>>> On 11/8/22 11:52 AM, Francis Laniel wrote:
>>>> From: Alban Crequy <albancrequy@microsoft.com>
>>>>
>>>> If a page fault occurs while copying the first byte, this function
>>>> resets one
>>>> byte before dst.
>>>> As a consequence, an address could be modified and leaded to
>>>> kernel crashes if
>>>> case the modified address was accessed later.
>>>>
>>>> Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
>>>> Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
>>>> ---
>>>>    mm/maccess.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/maccess.c b/mm/maccess.c
>>>> index 5f4d240f67ec..074f6b086671 100644
>>>> --- a/mm/maccess.c
>>>> +++ b/mm/maccess.c
>>>> @@ -97,7 +97,7 @@ long strncpy_from_kernel_nofault(char *dst,
>>>> const void *unsafe_addr, long count)
>>>>        return src - unsafe_addr;
>>>>    Efault:
>>>>        pagefault_enable();
>>>> -    dst[-1] = '\0';
>>>> +    dst[0] = '\0';
>>>
>>> What if the fault is due to dst, so the above won't work, right?
>>>
>>> The original code should work fine if the first byte copy is
>>> successful. For the first byte copy fault, maybe just to leave it
>>> as is?
>>
>> Okay, the dst is always safe (from func signature), so change looks
>> okay to me. Probably mm people can double check.
> 
> My understanding was that the bpf verifier is supposed to check that the
> dst pointer is safe. But I don't know where it is done, and I don't
> know how it can check that the dst buffer is big enough.

Yes, the verifier ensures the buffer actually has the capacity
for the buffer size. So we are fine here for 'dst' buffer.

> 
>>>    
>>>>        return -EFAULT;
>>>>    }
>>>>
>>>> -- 
>>>> 2.25.1
>>>>   
>>
> 
