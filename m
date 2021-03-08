Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8923316EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCHTCO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 14:02:14 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:43599
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229972AbhCHTBp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 14:01:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPvZ+KimN7rzBuat8iwSK/BdD0HCBZlA5Y/WFL4Wm/54tvHg16lIrE2b/8p9Np5sTkLh5ZVzI3y4RL0zLm+8IQTo7sFBAPtenfHJ4tlGlWSvXHAb+FKlJKtAKoyuXviwDfX0yd6emzGh8Rfffp8GeTiaYW8CnYsUIl4P/UsMKs6mgN05CazrEnjFCwXAkMJWBsbboKFXSG/Q+KuMPJ2EafdqS59Ty0Pt8dR2J4zxltDjc9rdqmvZWfvXIyEiGZJ6By4z+As2WFOeq1cSTrYi3mY0GJaaITmgPg/3/txwIbn4nBHyMB/LJbgRal5Xnivbx3QjCS7hJ2a+CEmxKovV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvWG/TSz2i4SuF3wqZBIEE9nmaujyceBgvEf+QYfSGc=;
 b=RUTQo5hdtTVHILqqdOpZqTXJ8qhdDzT/FbHXlPpv4OoHqTNKNP3CRcP2h/ovOgFsUN3kPNU2aXcYUre8xD4rmOd7r+guUrlAeaWcKqGMDbz8BZ10+RjMlqwv9uC+r0zjfrB8FHd6HppHWIa0b9/sSlOXA4+xDub4Mf5tlepgjIbwHduKHr7PmiYdj5PiltL4G/WcOFI9tWfmCYqNWtIBRQESOzK9cQzyZ6KGQA1nZ4vHhLkSWxm0wIPP61MELfoD00bfKhNu/HlFeTVWlvYo4ES4hD2Mut9GdZ4gcy2ft3P56jnP8huN3vJlehlB0nCi0tiyOmU1e9byU40exkLN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvWG/TSz2i4SuF3wqZBIEE9nmaujyceBgvEf+QYfSGc=;
 b=g0XWIU+yUcsceNlJ51NrIgnUhF4N6W80GNfLAPKCZ1p0E0iEFIW4QVTYVp1DfcFfOjt1s9bqcVmRPaFztPgvSaHN9H70zqGUr3Olxt0v83pYmid1aB28MZvdn28EH6IBO6wUMcap9rixFan5quKsoRwG1rdX0Ngkcd93Y6XSq7w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4673.namprd12.prod.outlook.com (2603:10b6:207:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Mon, 8 Mar
 2021 19:01:43 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 19:01:43 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "David Hildenbrand" <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Rientjes" <rientjes@google.com>,
        "Alex Shi" <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
Date:   Mon, 08 Mar 2021 14:01:36 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <9A4EF5F7-1BFF-4F8D-80B8-B559C05635BE@nvidia.com>
In-Reply-To: <8039e1d7-3442-f133-f4f6-fe934f02122e@redhat.com>
References: <20210308152221.28555-1-zi.yan@sent.com>
 <79458c46-b4b9-332b-77f7-44371502cbeb@redhat.com>
 <AD0AFA61-8DCF-467D-B961-ACFA1D33828C@nvidia.com>
 <8039e1d7-3442-f133-f4f6-fe934f02122e@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DED05D18-CFFF-4C8E-AD67-1A150585214C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::25) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.237] (216.228.112.22) by BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend Transport; Mon, 8 Mar 2021 19:01:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b43d05d-9dd4-49d2-ca7c-08d8e2649cde
X-MS-TrafficTypeDiagnostic: BL0PR12MB4673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4673C03AB8A8577DD86B9D22C2939@BL0PR12MB4673.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvP9cr27nqLylndRRbzmPBcNRLbFtPyzJhtwQ1O221cG+ue7peDpdEZKqX2iNYDNgb9WOEmGbHFBeQviPgL99NX9Lx1qhHx8e9mwNEmKndxh7ALSKNAMzs2RVLm5olKUKRa0leSDDoLh95Hz1cyUMv6NCRDqGMJMbzeqi7n/Jl/UqOo6/JEF5/7kkylsDktu+mChGxay/6xzcAAQzIcY4QWNctZlBLXPHGo+VPVyu7l0Tlx3dLlMyrx8mJI6ZHndL9kOc+e6igX8uhn75u0XHADXgyeWJRx48Tnr3dwWKehCwrMUf0WHXqSSEEjt+7GectSna46aTrzg7UR5JuHLkzQ+AK09o3UO+Hv/ZImsDsuAHv8/SJ13i+Vn1O14yM8fWkxZPlMAt4BrzwrshaY9KqL1ABYf6wER7IqHlI4FFccoc7bUL4e+T5VvY1gEUJSxX1+xkY8CqTIjgqk5i5LYbQlzakDJKDvc/ZiCCd3Ko7E/ckn+eDnM2sEZjG1nTk2xOGh7B50hhYzne051F0VCYqQc1MuT5Yvq5mMLeUMwBXy6oF/Cn6s/c42ydFhzcJRcUeckq1dH7LaFEkEzO76eDH+cr2i8zAxNf2MxmsTxmQuDZ8hF5X0w/K5U/SqEeF0n4qOw3zEwhpbeaG6L0TDhTxbAop6oSHLG9hZf1qR54hN07VtK6unvkkt2OYclGqMK0eveCGpgyVbjC4iZBhuT2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(2616005)(4326008)(86362001)(16576012)(316002)(5660300002)(36756003)(26005)(83380400001)(16526019)(2906002)(956004)(186003)(33656002)(7416002)(30864003)(8936002)(6666004)(235185007)(8676002)(6486002)(33964004)(6916009)(66556008)(66476007)(54906003)(478600001)(66946007)(966005)(53546011)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RndiNk9Kc0RpdWlpZ3V0M3dhZHFqK2tkb3cwbkxYZGkzY1R1Uml5Qm43S2R0?=
 =?utf-8?B?YTkwb0FhaTh3bklsM1RzOVAwNzg3K2hiTElid3pQVlRnd0pBUXNQY2hoWkhC?=
 =?utf-8?B?WlRqd2ZHQmpDYWJWd2c5SXR5Tk4wem5tZ2JySXZqc2xqR213Tk1IQ2dPS1JT?=
 =?utf-8?B?RVVLT0lSYkgrSldpUEpNbVhiVExJZEtBakRaSDZZRWpRMTNOR2JNeDlQUXJL?=
 =?utf-8?B?WU50SjVvUnFhaUtaTXB2aHNaNTBUR2pMU1RzQ2ZRRmFaN2oxSU5YMVFMV2dQ?=
 =?utf-8?B?OEVRQnBHaVkzRDJpMHNuVDlWOHlPc3FvSlV4eEVMSlR1RUo3ajJtazdJTmNJ?=
 =?utf-8?B?SXdaYjcwTTJ5NW44WnpkS2RENXNXeUlpQlVocTdvZ05tOHFXWldsa0U3cnVR?=
 =?utf-8?B?NUlocDk4TlR3MlhkRWIwSlNKQXV0Y2V1aGxQRUo2V2F2UVB1N3B3ZmdBWDZR?=
 =?utf-8?B?cEFuaDNtdjBpb1ppNHQzdlJKbW1acTVLTC9VTWJNM2w2SmNCNXNETzJIdS9m?=
 =?utf-8?B?R3c2Mll4TE5GcTM4VXlmUTRBOVZ5WnVmUDVSNmcwN3dtek42RWFPRXpGazdK?=
 =?utf-8?B?RmF0SDlPb0phU3JYZTcyVlp2K3hZL3dqbFJubjJTWGtscldhcGZRQ2RwcTNy?=
 =?utf-8?B?ZjJJcHdvY2hBcUw3MDN2ZytlMnU3Y2M3Z05FbzdMa1RNbWRhUHV2ak91bjdv?=
 =?utf-8?B?OVg1WmNDcGRNU0tZV2xiRnUvL1BOUk45NXh6Tm1teFBjUCtNOW5MeG15ckdJ?=
 =?utf-8?B?dGMycXdYSXIxK1dVdGN3VG4yK2toTzN1UVBiK0dpSEdybjFwU01GK2lhalFq?=
 =?utf-8?B?eXVWZWg1eVVoYUZCK3YvWkRRNjdsSXh1eTdHOWxQeTA5Rjc1b0V3MkVBOFhH?=
 =?utf-8?B?VXd3K0JkYTRHOE02RkJ2MXpVTFlnNnRQcTNhMTg2S0RBNUIzMGVaRFV4dGxs?=
 =?utf-8?B?bkFlUkhRN0FHYVNsNS9iL05zb2JrNzJrZ1JJak42andnUjZFVjVOQmlwOTYv?=
 =?utf-8?B?YVJ6NnlwUWYvMVh3V2g0bWxFVGovNmluNlFzZFdPYXliT1VKTStTUSt6dEh4?=
 =?utf-8?B?ZGZRMEgwajJmUHE5YVdqQjVHTit5cGw0TE1WQzErOUJMOGY3eGZnbE9sc0Qx?=
 =?utf-8?B?ZndYZXRjaG1Tb0Y1WTQ2d3hGS2hCb21XWDNsNkw1Lzc3UGYrWnQwZkUzZ0Fn?=
 =?utf-8?B?NUJXY2VJdFFEUEZRNmE2Q0ZGbzBXS25ZN1FKcnlLTy83b1JERXFKbTVZc0d4?=
 =?utf-8?B?OFR2SFBoMG9EYmdQNy9JWExwUFdiUUROb0k0K1paOXVMNVFhYlE4dGFqeC9Y?=
 =?utf-8?B?ZzE4Ujh0OWtUcHV3U1p0K0Ewa2tHaGdhMmVRRHM2S0VKMjV6N2o0OUJKdEdX?=
 =?utf-8?B?U3RBT1NuMnhWZnlCczUyQWVLaU9PczR6cXFCK2NiejZmM09Lb045bGY4SWJS?=
 =?utf-8?B?RjFkOTIwWktiL25SUzAxck9KZ0Y1V0xPVzYrRXA0UjNEZTVQeWE0aUJXcmJF?=
 =?utf-8?B?eE9nWWs2M2hBTXJpWjVuRkF0SUV1Y1BmRm44MUZ0UC9lOFpxbXM0bmN4dXRV?=
 =?utf-8?B?QXB5N0RCT1FsbXc5Yk4wMjBSSXMrT2JsQUZmMldyZ1Y2NFk4T3NETE9aVWx3?=
 =?utf-8?B?NFBnK0ZTV1M5elRLbVVtRVZnMmlaSUNJd0F2RkpUbE5uTFcrSVBUSkJKd1Fm?=
 =?utf-8?B?dG05T3BzcFZyWTdVcG5IWDA1ZUlBVmZmS3FlZjBPaEo5L3ZXbll5QzJWQkhl?=
 =?utf-8?Q?Zplrx9bCqRgslG3Bn8EJ4zFrbx47uh65Xue6yus?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b43d05d-9dd4-49d2-ca7c-08d8e2649cde
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:01:43.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95m6xYfEiFTAN9lI9VAcEYjfiFnw9/hepUFT78m1DkSQkHUUvKZSMs3+vEywNXE0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4673
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_DED05D18-CFFF-4C8E-AD67-1A150585214C_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 8 Mar 2021, at 13:11, David Hildenbrand wrote:

> On 08.03.21 18:49, Zi Yan wrote:
>> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
>>
>>> On 08.03.21 16:22, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with th=
e
>>>> given pid and virtual address range are split. It is used to test
>>>> split_huge_page function. In addition, a selftest program is added t=
o
>>>> tools/testing/selftests/vm to utilize the interface by splitting
>>>> PMD THPs and PTE-mapped THPs.
>>>
>>> Won't something like
>>>
>>> 1. MADV_HUGEPAGE
>>>
>>> 2. Access memory
>>>
>>> 3. MADV_NOHUGEPAGE
>>>
>>> Have a similar effect? What's the benefit of this?
>>
>> Thanks for checking the patch.
>>
>> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
>> nothing else will be done.
>
> Ah, okay - maybe my memory was tricking me. There is some s390x KVM cod=
e that forces MADV_NOHUGEPAGE and force-splits everything.
>
> I do wonder, though, if this functionality would be worth a proper user=
 interface (e.g., madvise), though. There might be actual benefit in havi=
ng this as a !debug interface.
>
> I think you aware of the discussion in https://lkml.kernel.org/r/d098c3=
92-273a-36a4-1a29-59731cdf5d3d@google.com

Yes. Thanks for bringing this up.

>
> If there will be an interface to collapse a THP -- "this memory area is=
 worth extra performance now by collapsing a THP if possible" -- it might=
 also be helpful to have the opposite functionality -- "this memory area =
is not worth a THP, rather use that somehwere else".
>
> MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT

I agree that MADV_HUGE_SPLIT would be useful as the opposite of COLLAPSE =
when user might just want PAGESIZE mappings.
Right now, HUGE_SPLIT is implicit from mapping changes like mprotect or M=
ADV_DONTNEED.

My debugfs interface is a little different here, since it splits the comp=
ound pages mapped by the PMD mapping
(of course the PMD mapping is split too), whereas madvise only splits the=
 PMD. I did not put it in a !debug
interface because I do not think we want to expose the kernel mechanism (=
the compound page) to the user and
let them decide when to split the compound page or not. MADV_HUGE_COLLAPS=
E is different, because we need
to form a compound THP to be able to get PMD mappings. But I am happy to =
change my mind if we find usefulness
in letting user split compound THPs via !debug interface.


>
> Just a thought.
>
>>
>> Without this, we do not have a way of splitting a specific THP
>> (the compound page) via any user interface for debugging.
>> We can only write to <debugfs>/split_huge_pages to split all THPs
>> in the system, which has an unwanted effect on the whole system
>> and can overwhelm us with a lot of information. This new debugfs
>> interface provides a more precise method.
>>
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    mm/huge_memory.c                              |  98 ++++++
>>>>    mm/internal.h                                 |   1 +
>>>>    mm/migrate.c                                  |   2 +-
>>>>    tools/testing/selftests/vm/.gitignore         |   1 +
>>>>    tools/testing/selftests/vm/Makefile           |   1 +
>>>>    .../selftests/vm/split_huge_page_test.c       | 318 +++++++++++++=
+++++
>>>>    6 files changed, 420 insertions(+), 1 deletion(-)
>>>>    create mode 100644 tools/testing/selftests/vm/split_huge_page_tes=
t.c
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 395c75111d33..818172f887bf 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -7,6 +7,7 @@
>>>>     #include <linux/mm.h>
>>>>    #include <linux/sched.h>
>>>> +#include <linux/sched/mm.h>
>>>>    #include <linux/sched/coredump.h>
>>>>    #include <linux/sched/numa_balancing.h>
>>>>    #include <linux/highmem.h>
>>>> @@ -2971,10 +2972,107 @@ static int split_huge_pages_set(void *data,=
 u64 val)
>>>>    DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_=
pages_set,
>>>>    		"%llu\n");
>>>>   +static ssize_t split_huge_pages_in_range_pid_write(struct file *f=
ile,
>>>> +		const char __user *buf, size_t count, loff_t *ppops)
>>>> +{
>>>> +	static DEFINE_MUTEX(mutex);
>>>> +	ssize_t ret;
>>>> +	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
>>>> +	int pid;
>>>> +	unsigned long vaddr_start, vaddr_end, addr;
>>>> +	nodemask_t task_nodes;
>>>> +	struct mm_struct *mm;
>>>> +	unsigned long total =3D 0, split =3D 0;
>>>> +
>>>> +	ret =3D mutex_lock_interruptible(&mutex);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret =3D -EFAULT;
>>>> +
>>>> +	memset(input_buf, 0, 80);
>>>> +	if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
>>>> +		goto out;
>>>> +
>>>> +	input_buf[79] =3D '\0';
>>>> +	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &v=
addr_end);
>>>> +	if (ret !=3D 3) {
>>>> +		ret =3D -EINVAL;
>>>> +		goto out;
>>>> +	}
>>>> +	vaddr_start &=3D PAGE_MASK;
>>>> +	vaddr_end &=3D PAGE_MASK;
>>>> +
>>>> +	ret =3D strlen(input_buf);
>>>> +	pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx]\n",
>>>> +		 pid, vaddr_start, vaddr_end);
>>>> +
>>>> +	mm =3D find_mm_struct(pid, &task_nodes);
>>>> +	if (IS_ERR(mm)) {
>>>> +		ret =3D -EINVAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	mmap_read_lock(mm);
>>>> +	/*
>>>> +	 * always increase addr by PAGE_SIZE, since we could have a PTE pa=
ge
>>>> +	 * table filled with PTE-mapped THPs, each of which is distinct.
>>>> +	 */
>>>> +	for (addr =3D vaddr_start; addr < vaddr_end; addr +=3D PAGE_SIZE) =
{
>>>> +		struct vm_area_struct *vma =3D find_vma(mm, addr);
>>>> +		unsigned int follflags;
>>>> +		struct page *page;
>>>> +
>>>> +		if (!vma || addr < vma->vm_start || !vma_migratable(vma))
>>>> +			break;
>>>> +
>>>> +		/* FOLL_DUMP to ignore special (like zero) pages */
>>>> +		follflags =3D FOLL_GET | FOLL_DUMP;
>>>> +		page =3D follow_page(vma, addr, follflags);
>>>> +
>>>> +		if (IS_ERR(page))
>>>> +			break;
>>>> +		if (!page)
>>>> +			break;
>>>> +
>>>> +		if (!is_transparent_hugepage(page))
>>>> +			continue;
>>>> +
>>>> +		total++;
>>>> +		if (!can_split_huge_page(compound_head(page), NULL))
>>>> +			continue;
>>>> +
>>>> +		if (!trylock_page(page))
>>>> +			continue;
>>>> +
>>>> +		if (!split_huge_page(page))
>>>> +			split++;
>>>> +
>>>> +		unlock_page(page);
>>>> +		put_page(page);
>>>> +	}
>>>> +	mmap_read_unlock(mm);
>>>> +	mmput(mm);
>>>> +
>>>> +	pr_debug("%lu of %lu THP split\n", split, total);
>>>> +out:
>>>> +	mutex_unlock(&mutex);
>>>> +	return ret;
>>>> +
>>>> +}
>>>> +
>>>> +static const struct file_operations split_huge_pages_in_range_pid_f=
ops =3D {
>>>> +	.owner	 =3D THIS_MODULE,
>>>> +	.write	 =3D split_huge_pages_in_range_pid_write,
>>>> +	.llseek  =3D no_llseek,
>>>> +};
>>>> +
>>>>    static int __init split_huge_pages_debugfs(void)
>>>>    {
>>>>    	debugfs_create_file("split_huge_pages", 0200, NULL, NULL,
>>>>    			    &split_huge_pages_fops);
>>>> +	debugfs_create_file("split_huge_pages_in_range_pid", 0200, NULL, N=
ULL,
>>>> +			    &split_huge_pages_in_range_pid_fops);
>>>>    	return 0;
>>>>    }
>>>>    late_initcall(split_huge_pages_debugfs);
>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>> index 9902648f2206..1659d00100ef 100644
>>>> --- a/mm/internal.h
>>>> +++ b/mm/internal.h
>>>> @@ -623,4 +623,5 @@ struct migration_target_control {
>>>>    	gfp_t gfp_mask;
>>>>    };
>>>>   +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes=
);
>>>>    #endif	/* __MM_INTERNAL_H */
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 62b81d5257aa..ce5f213debb2 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1913,7 +1913,7 @@ static int do_pages_stat(struct mm_struct *mm,=
 unsigned long nr_pages,
>>>>    	return nr_pages ? -EFAULT : 0;
>>>>    }
>>>>   -static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *me=
m_nodes)
>>>> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>>>    {
>>>>    	struct task_struct *task;
>>>>    	struct mm_struct *mm;
>>>> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/s=
elftests/vm/.gitignore
>>>> index 9a35c3f6a557..1f651e85ed60 100644
>>>> --- a/tools/testing/selftests/vm/.gitignore
>>>> +++ b/tools/testing/selftests/vm/.gitignore
>>>> @@ -22,3 +22,4 @@ map_fixed_noreplace
>>>>    write_to_hugetlbfs
>>>>    hmm-tests
>>>>    local_config.*
>>>> +split_huge_page_test
>>>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/sel=
ftests/vm/Makefile
>>>> index d42115e4284d..4cbc91d6869f 100644
>>>> --- a/tools/testing/selftests/vm/Makefile
>>>> +++ b/tools/testing/selftests/vm/Makefile
>>>> @@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D on-fault-limit
>>>>    TEST_GEN_FILES +=3D thuge-gen
>>>>    TEST_GEN_FILES +=3D transhuge-stress
>>>>    TEST_GEN_FILES +=3D userfaultfd
>>>> +TEST_GEN_FILES +=3D split_huge_page_test
>>>>     ifeq ($(MACHINE),x86_64)
>>>>    CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/tri=
vial_32bit_program.c -m32)
>>>> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/too=
ls/testing/selftests/vm/split_huge_page_test.c
>>>> new file mode 100644
>>>> index 000000000000..8ea8000fda62
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
>>>> @@ -0,0 +1,318 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * A test of splitting PMD THPs and PTE-mapped THPs from a specifie=
d virtual
>>>> + * address range in a process via <debugfs>/split_huge_pages_in_ran=
ge_pid
>>>> + * interface.
>>>> + */
>>>> +
>>>> +#define _GNU_SOURCE
>>>> +#include <stdio.h>
>>>> +#include <stdlib.h>
>>>> +#include "numa.h"
>>>> +#include <unistd.h>
>>>> +#include <errno.h>
>>>> +#include <inttypes.h>
>>>> +#include <string.h>
>>>> +#include <sys/types.h>
>>>> +#include <sys/stat.h>
>>>> +#include <fcntl.h>
>>>> +#include <sys/mman.h>
>>>> +#include <sys/time.h>
>>>> +#include <sys/wait.h>
>>>> +#include <malloc.h>
>>>> +#include <stdbool.h>
>>>> +
>>>> +uint64_t pagesize;
>>>> +unsigned int pageshift;
>>>> +uint64_t pmd_pagesize;
>>>> +
>>>> +#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pm=
d_size"
>>>> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_=
pid"
>>>> +#define SMAP_PATH "/proc/self/smaps"
>>>> +#define INPUT_MAX 80
>>>> +
>>>> +#define PFN_MASK     ((1UL<<55)-1)
>>>> +#define KPF_THP      (1UL<<22)
>>>> +
>>>> +int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_=
file)
>>>> +{
>>>> +	uint64_t paddr;
>>>> +	uint64_t page_flags;
>>>> +
>>>> +	if (pagemap_file) {
>>>> +		pread(pagemap_file, &paddr, sizeof(paddr),
>>>> +			((long)vaddr >> pageshift) * sizeof(paddr));
>>>> +
>>>> +		if (kpageflags_file) {
>>>> +			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>>>> +				(paddr & PFN_MASK) * sizeof(page_flags));
>>>> +
>>>> +			return !!(page_flags & KPF_THP);
>>>> +		}
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +
>>>> +static uint64_t read_pmd_pagesize(void)
>>>> +{
>>>> +	int fd;
>>>> +	char buf[20];
>>>> +	ssize_t num_read;
>>>> +
>>>> +	fd =3D open(PMD_SIZE_PATH, O_RDONLY);
>>>> +	if (fd =3D=3D -1) {
>>>> +		perror("Open hpage_pmd_size failed");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +	num_read =3D read(fd, buf, 19);
>>>> +	if (num_read < 1) {
>>>> +		close(fd);
>>>> +		perror("Read hpage_pmd_size failed");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +	buf[num_read] =3D '\0';
>>>> +	close(fd);
>>>> +
>>>> +	return strtoul(buf, NULL, 10);
>>>> +}
>>>> +
>>>> +static int write_file(const char *path, const char *buf, size_t buf=
len)
>>>> +{
>>>> +	int fd;
>>>> +	ssize_t numwritten;
>>>> +
>>>> +	fd =3D open(path, O_WRONLY);
>>>> +	if (fd =3D=3D -1)
>>>> +		return 0;
>>>> +
>>>> +	numwritten =3D write(fd, buf, buflen - 1);
>>>> +	close(fd);
>>>> +	if (numwritten < 1)
>>>> +		return 0;
>>>> +
>>>> +	return (unsigned int) numwritten;
>>>> +}
>>>> +
>>>> +static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t v=
addr_end)
>>>> +{
>>>> +	char input[INPUT_MAX];
>>>> +	int ret;
>>>> +
>>>> +	ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_st=
art,
>>>> +			vaddr_end);
>>>> +	if (ret >=3D INPUT_MAX) {
>>>> +		printf("%s: Debugfs input is too long\n", __func__);
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
>>>> +		perror(SPLIT_DEBUGFS);
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +}
>>>> +
>>>> +#define MAX_LINE_LENGTH 500
>>>> +
>>>> +static bool check_for_pattern(FILE *fp, const char *pattern, char *=
buf)
>>>> +{
>>>> +	while (fgets(buf, MAX_LINE_LENGTH, fp) !=3D NULL) {
>>>> +		if (!strncmp(buf, pattern, strlen(pattern)))
>>>> +			return true;
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static uint64_t check_huge(void *addr)
>>>> +{
>>>> +	uint64_t thp =3D 0;
>>>> +	int ret;
>>>> +	FILE *fp;
>>>> +	char buffer[MAX_LINE_LENGTH];
>>>> +	char addr_pattern[MAX_LINE_LENGTH];
>>>> +
>>>> +	ret =3D snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
>>>> +		       (unsigned long) addr);
>>>> +	if (ret >=3D MAX_LINE_LENGTH) {
>>>> +		printf("%s: Pattern is too long\n", __func__);
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +
>>>> +	fp =3D fopen(SMAP_PATH, "r");
>>>> +	if (!fp) {
>>>> +		printf("%s: Failed to open file %s\n", __func__, SMAP_PATH);
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +	if (!check_for_pattern(fp, addr_pattern, buffer))
>>>> +		goto err_out;
>>>> +
>>>> +	/*
>>>> +	 * Fetch the AnonHugePages: in the same block and check the number=
 of
>>>> +	 * hugepages.
>>>> +	 */
>>>> +	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
>>>> +		goto err_out;
>>>> +
>>>> +	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) !=3D 1) {
>>>> +		printf("Reading smap error\n");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +err_out:
>>>> +	fclose(fp);
>>>> +	return thp;
>>>> +}
>>>> +
>>>> +void split_pmd_thp(void)
>>>> +{
>>>> +	char *one_page;
>>>> +	size_t len =3D 4 * pmd_pagesize;
>>>> +	uint64_t thp_size;
>>>> +	size_t i;
>>>> +
>>>> +	one_page =3D memalign(pmd_pagesize, len);
>>>> +
>>>> +	madvise(one_page, len, MADV_HUGEPAGE);
>>>> +
>>>> +	for (i =3D 0; i < len; i++)
>>>> +		one_page[i] =3D (char)i;
>>>> +
>>>> +	thp_size =3D check_huge(one_page);
>>>> +	if (!thp_size) {
>>>> +		printf("No THP is allocatd");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	/* split all possible huge pages */
>>>> +	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + l=
en);
>>>> +
>>>> +	for (i =3D 0; i < len; i++)
>>>> +		if (one_page[i] !=3D (char)i) {
>>>> +			printf("%ld byte corrupted\n", i);
>>>> +			exit(EXIT_FAILURE);
>>>> +		}
>>>> +
>>>> +
>>>> +	thp_size =3D check_huge(one_page);
>>>> +	if (thp_size) {
>>>> +		printf("Still %ld kB AnonHugePages not split\n", thp_size);
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	printf("Split huge pages successful\n");
>>>> +	free(one_page);
>>>> +}
>>>> +
>>>> +void split_pte_mapped_thp(void)
>>>> +{
>>>> +	char *one_page, *pte_mapped, *pte_mapped2;
>>>> +	size_t len =3D 4 * pmd_pagesize;
>>>> +	uint64_t thp_size;
>>>> +	size_t i;
>>>> +	const char *pagemap_template =3D "/proc/%d/pagemap";
>>>> +	const char *kpageflags_proc =3D "/proc/kpageflags";
>>>> +	char pagemap_proc[255];
>>>> +	int pagemap_fd;
>>>> +	int kpageflags_fd;
>>>> +
>>>> +	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0) {=

>>>> +		perror("get pagemap proc error");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +	pagemap_fd =3D open(pagemap_proc, O_RDONLY);
>>>> +
>>>> +	if (pagemap_fd =3D=3D -1) {
>>>> +		perror("read pagemap:");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
>>>> +
>>>> +	if (kpageflags_fd =3D=3D -1) {
>>>> +		perror("read kpageflags:");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE=
,
>>>> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>>> +
>>>> +	madvise(one_page, len, MADV_HUGEPAGE);
>>>> +
>>>> +	for (i =3D 0; i < len; i++)
>>>> +		one_page[i] =3D (char)i;
>>>> +
>>>> +	thp_size =3D check_huge(one_page);
>>>> +	if (!thp_size) {
>>>> +		printf("No THP is allocatd");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE=
);
>>>> +
>>>> +	for (i =3D 1; i < 4; i++) {
>>>> +		pte_mapped2 =3D mremap(one_page + pmd_pagesize * i + pagesize * i=
,
>>>> +				     pagesize, pagesize,
>>>> +				     MREMAP_MAYMOVE|MREMAP_FIXED,
>>>> +				     pte_mapped + pagesize * i);
>>>> +		if (pte_mapped2 =3D=3D (char *)-1) {
>>>> +			perror("mremap failed");
>>>> +			exit(EXIT_FAILURE);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	/* smap does not show THPs after mremap, use kpageflags instead */=

>>>> +	thp_size =3D 0;
>>>> +	for (i =3D 0; i < pagesize * 4; i++)
>>>> +		if (i % pagesize =3D=3D 0 &&
>>>> +		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>>>> +			thp_size++;
>>>> +
>>>> +	if (thp_size !=3D 4) {
>>>> +		printf("Some THPs are missing during mremap\n");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	/* split all possible huge pages */
>>>> +	write_debugfs(getpid(), (uint64_t)pte_mapped,
>>>> +		      (uint64_t)pte_mapped + pagesize * 4);
>>>> +
>>>> +	/* smap does not show THPs after mremap, use kpageflags instead */=

>>>> +	thp_size =3D 0;
>>>> +	for (i =3D 0; i < pagesize * 4; i++) {
>>>> +		if (pte_mapped[i] !=3D (char)i) {
>>>> +			printf("%ld byte corrupted\n", i);
>>>> +			exit(EXIT_FAILURE);
>>>> +		}
>>>> +		if (i % pagesize =3D=3D 0 &&
>>>> +		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>>>> +			thp_size++;
>>>> +	}
>>>> +
>>>> +	if (thp_size) {
>>>> +		printf("Still %ld THPs not split\n", thp_size);
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	printf("Split PTE-mapped huge pages successful\n");
>>>> +	munmap(one_page, len);
>>>> +	close(pagemap_fd);
>>>> +	close(kpageflags_fd);
>>>> +}
>>>> +
>>>> +int main(int argc, char **argv)
>>>> +{
>>>> +	if (geteuid() !=3D 0) {
>>>> +		printf("Please run the benchmark as root\n");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	pagesize =3D getpagesize();
>>>> +	pageshift =3D ffs(pagesize) - 1;
>>>> +	pmd_pagesize =3D read_pmd_pagesize();
>>>> +
>>>> +	split_pmd_thp();
>>>> +	split_pte_mapped_thp();
>>>> +
>>>> +	return 0;
>>>> +}
>>>>
>>>
>>>
>>> -- =

>>> Thanks,
>>>
>>> David / dhildenb
>>
>>
>> =E2=80=94
>> Best Regards,
>> Yan Zi
>>
>
>
> -- =

> Thanks,
>
> David / dhildenb


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_DED05D18-CFFF-4C8E-AD67-1A150585214C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBGdJAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKXcEQAIeazvoqKZC8a5jDIPJrohzLb/Ruw/Fgb5Dc
HwLds0HNsGNfDfvQwiFV2JvXScy2pXi10r0roeBBXGUGeSrSec5yDIlJ5tluNdXT
ygILA4gzZlEY2J2He4P8knw762uj8geETOiZRlx5hZaHTqI11WWqCNcMMDpHCCTc
Pv+VyWodNiuEQNqdTtj0ZWkkcc6GN0x8l9vzNvTJlmErNWY4VM8JFPObor/MD7Bd
DOXbecnA7tWStwrAwFXkoGOWlyO23KkiCaa6SjqGgEt3GxGTAyT+nNnNKUU8EYAz
17HpXDTc7OCcHIrKn1jbQmYqctJ6iTKJneB4SE7q4TsVqj8fgr2mX1odlicbIYEa
jrMnd3ZLJin+ykDxzU3L8Novn2kXbez5lGndirQVmmgjTtNynlqHCsEfr9JZqa9H
hR4wINznZmmXnOhJBDpJEyVgkFwrEzb0f/9jnrFq4KAn/jJajGi3ovMiDxuWqReA
Ksb+h9dbtml9Zc9wIg+2aRTviReBZ+2wB4Nx+IWoqJO9j83kwOp7z/YDVJHsgn8c
yGD513VPoTPdeQWDsi3IDoDIXscG5kc73F6ZWTou426oNDM6t4HT+tXG+aG8kYPd
Au6bGgpckGpc/GfG9OP9+Vx3cs7dIwFC02ZrVuK65st0zVOpq9g41Qdru1KfqMf/
z/Tb834a
=srMZ
-----END PGP SIGNATURE-----

--=_MailMate_DED05D18-CFFF-4C8E-AD67-1A150585214C_=--
