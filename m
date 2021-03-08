Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5733167C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCHSrM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 13:47:12 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26689
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231203AbhCHSqw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 13:46:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8oHkLJpYWS158cRGU3T5NeOf4iC//AkytSORCucK5Ii3FjR9gURcemgvv6q1U8Vj3c3VzFHJxDgT/lB5sXcEQgFcPa30bjCemofzU7ILiYP13lxH7sGn+1VciGxckB7LkSAZ9KeuTYMtK9K16z0jjojXo+Xf8najI812Q/xYrjo6K/ObLBXpPsOh9L4+WXS2Sbrno7V7DOnZWrxXtH05MHMQe5TdfY5rZRSoW869pZg9DDjr5qYrKzUVEw0UPOzII9SSN+YJgSI9g3OVe4h4Aevdkz2LtbuRSyp6/q4ED6AbP0LDYGglaM4W7X2DM5bwJCaChZj7zV3g79jvxDuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEBC60EBeohgEmWYfGNHHD8mjxfAvVDc3z7dkC0HsWY=;
 b=XGynHVAIhyZ7qVtbZKg3b8yBWKsEuiOz5BzsmI/VI9hfx74kd+5W6abGcQY+FxHJYObZWgHw7QmDdeLEUJhxSvkgIRHmaZBuRbQYdPUkB8wc6Izv5GIyYrvUfovcg0pbfI2FAKl1LiimEKfnD8JFGZgeYY52dl7ls1R8onC6pp0MFJWghFP2FA4FGaskSK1R3gErEwoad8olldHrjqMfTlNd3dHU4QFH1tAUh1g1En5tZOuPdfKIQ+XtF5hXGPuXmZR1iT3RtO3NSyMhUk/4BjppRAHFSewT243ZeBUHtkVIgr4dL8NoN2/tYl6r5g+c41pmarlI+MS9lZpqJinT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEBC60EBeohgEmWYfGNHHD8mjxfAvVDc3z7dkC0HsWY=;
 b=P4WC8CgJPiA+dLty9krA+FS5QAEqVWliBTzDai4OtSfwUkekxtlglctibkVCRgB6FsabTkHIkXbYP8KdT+jmf58jzFlz0z4mnEnpPsu/Znw2qu4xr3iBxT6XMtCeTxbJUrUF8LM0KQhmR3mIZweOO59OY3gAMh3TFue3pBlnk/Y=
Authentication-Results: nextfour.com; dkim=none (message not signed)
 header.d=none;nextfour.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3919.namprd12.prod.outlook.com (2603:10b6:208:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 18:46:48 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 18:46:48 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Mika =?utf-8?q?Penttil=C3=A4?=" <mika.penttila@nextfour.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
Date:   Mon, 08 Mar 2021 13:46:42 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <B307F250-3872-4AFA-9D43-5DD6144C039C@nvidia.com>
In-Reply-To: <efac8763-8706-7b0b-17b9-4b0a4538fbf1@nextfour.com>
References: <20210308152221.28555-1-zi.yan@sent.com>
 <590175ca-ccf8-45d2-c108-e6225451e68a@nextfour.com>
 <efac8763-8706-7b0b-17b9-4b0a4538fbf1@nextfour.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7B85E765-878A-49BD-AC96-068ABBCFDDA0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.237] (216.228.112.22) by BL1PR13CA0120.namprd13.prod.outlook.com (2603:10b6:208:2b9::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend Transport; Mon, 8 Mar 2021 18:46:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c6c56d-b3b2-449d-9160-08d8e2628781
X-MS-TrafficTypeDiagnostic: MN2PR12MB3919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39196F0C0A98D857814A5621C2939@MN2PR12MB3919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0GHr9NQseiYHxU/krcIuf1F7tzfM719Ax0rL7RVagGp892U7I0VoXGndmiFKcnwA4i53hWztTitg0thH8qmYae/0cG6lbpuSv1fYDwRegbigKSmPT/Du3ZMvAsv7DG6d98zJmaejnqFbZ78ViByttEKzayS4RDzaida0y/gFcmUozRz099qDRXUTxk2xVf/iWAZotRaQaNnd4CgoGbPt1HOS+erBrTUHnphiB8dCpDgO9Xo2NPt3D96qOxhuF8fbIlZBlCy6k200JiDTdCUZxAZJ+RXYq2aahn7EEuSXMq8kR6RvnjoRLoSPUa1HaA13ApEKSiedXA49cW0VgJkjZhfELlMriKiwQCkACKB6PsfOEzdKNTSKZi0LGna9VMjb5kkdxdl9Y31wywIIRl13298PIGsTsUTaHgCIR/c5pNenpPQPyP3Lw1MI4ZVjvnDryYO6raNc3PEDQTRvM41WMr+J1YNmgzpSD8JYJoSLB9NwMCvect6LiJZbwwH/aw8LaghjLIZKIIWPzg/9oBm0i/rQIuC79giiOgUDCT6TRsdnxXq/y/QJ7k5b8b40vbe6IME6OSeww6ygeUxrsplqLYCzMYtB5gP0FTTG0tDS1QGsQ0ukkxM/uVxGjtPp7Ml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(5660300002)(8936002)(66556008)(66476007)(66946007)(4326008)(8676002)(235185007)(6666004)(53546011)(36756003)(86362001)(6486002)(33964004)(83380400001)(16576012)(54906003)(316002)(30864003)(6916009)(2906002)(186003)(16526019)(478600001)(956004)(2616005)(33656002)(26005)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFVxcGUwRnBvMHRSNkthaEVvVlFQY2xGc0t4YTdMczhzTHQrRktYcTY5eTRo?=
 =?utf-8?B?MzR1YjhFek5NT2dZUXlWbVdidEVqRUNJelM3ZmtMK1IyZnpPZmlKcHN6U1NF?=
 =?utf-8?B?WXNPQUpQY3ZRUDZNNGpjVkplZlZMUnJvb1dDQVZwWmw4bFp5YXJwMDNjdnhZ?=
 =?utf-8?B?RTd2dXl1dWx4QmxocWcxL0tMaDB0U1FDUklEWWRmbm9hampNcUY0K0tETkln?=
 =?utf-8?B?VjZBVm43YjR0M21aQkx6d2NiUnhrNE12TjArUmNMN2JUc1BXdzdsSmpXZy9I?=
 =?utf-8?B?SGFyU2E0K0NXWjJycnl0M0t2ZmZVa2NoWmRGQTUrUWJzWW9IRzc2cWQvRDR2?=
 =?utf-8?B?ay9hMnk0NnJFOEtvTWpFVkFRRUpNZGgyMFhhTngvcExyUG1acHRVMUpOV2JX?=
 =?utf-8?B?SjFKUmRrM1A4cFpzNENORUtvSndiRFR6dlpOWWYzaUJRV216VDhrQVZNNWdp?=
 =?utf-8?B?RkxKeVgyOGJ0UzVlMkpkV3VVUHg3Z3A0UTgzelpQaDZ3SW9NaEd3Vk5YZSsy?=
 =?utf-8?B?K1hWWkNKd2RyaWhMZVpCaG1JZXYzMTBqelU1c0ZHZTlYYksvR1ErSFRzY0Q3?=
 =?utf-8?B?R0lRdEV6a0lXaGFXYWsvOGRRVFc1elh6LytRN3YwN3RUSjlvL1ZVSzFCV0Zq?=
 =?utf-8?B?VkdNQTRPV1lQN24ySyt6ZUZqSExvNzVCWjBEQTZETlNKNXUxU0xIazQxUFIw?=
 =?utf-8?B?RTFhVGc3TEhZdnpkS2MwWi9ZV3ZZd2lzYWFVZHpjNEFVRDl1bnlkNERvVjB1?=
 =?utf-8?B?RTl2ckYzeVBXTk1GcmVrbjN2M0RTR2FVdzg2QUpXUkk5S1dWSUZidU5Mbmdn?=
 =?utf-8?B?dHUzNFR3UXBUbHdTdGdJYzN4V0JXaTZkYVFKQ3hKdEtLSkRUR3Jidi9ieFlj?=
 =?utf-8?B?bHJ4SE0rZ0lsVEtwcm04YnlNM21KOWRvUTFUR2JZQW1WWWFXNW1tdGZPNGFR?=
 =?utf-8?B?UjkxVmplemdnK0dLM3dwWERuQ1pVVlkvZWxUUFp1ZmZsMFBCT0d2ZzdRNTNk?=
 =?utf-8?B?UzJJdHZNWUVUbmZOK3Y2aXAwbEgxWklNZmR3OXkrcXYyZ1ZqcENxYURKQUo4?=
 =?utf-8?B?Zy9PQTNZL3ROT2xMUU9KTEI1eFlnMzFJc01XdXhGeGlhZlRHNUZJN2UxZmhP?=
 =?utf-8?B?dG9Eb1M5M09MZ0lCbk5CeGlrcVgzSTliU01uQ0F1Y0Ntek8zMnlNNkFDelA0?=
 =?utf-8?B?emZhL2dCZDR5bGphbnpIUmg1RnRGdThRZ0NZY0FNV0pPb09wSGFyLyt0anJB?=
 =?utf-8?B?RE1GNmQ2bFB4Y3lUb1VpOEZMQmNsN0R6dCtrbm5tYWcrNm0yN0k2YmVTRlpV?=
 =?utf-8?B?S01Hd05mZU92ODYxTm1ZRFlqTXZzNGdUcVJQZHVvU01SZ2pVS0FyQjVZVWZq?=
 =?utf-8?B?UHFVSWRCZVVXRG42dUlkZEQ2YnlPL3NkNDl5VTNCVkQvWUp1eTF1K2x4T0J6?=
 =?utf-8?B?SWpoOVZnSnpBN3BYdWgwcmZGM1hVdGdTSEJDTGlQMEdoK29TaXFWLy9zOUtO?=
 =?utf-8?B?MnJrdnRveTA1UjR5UUpOK3R6b0hjZHZ6SzFlU21zOVU2QmFxdmFzcFFxUzNB?=
 =?utf-8?B?dW5WVU9jQmxlRkdvMmc4WkhlRHdUMXh3QUI1dU9uQWczVVdBTno2N0hWNEtk?=
 =?utf-8?B?KzljdnZxMnhHM1c4NCtGUFQ4NkFINVpLbWd5WjNKM3Y2R3U3d3kza1dxa1c5?=
 =?utf-8?B?Ui9TOEQwcElOVTh6MEtuQ25kVTRWSkRKWFhaUk9ucFJ1TDRMVnpUZXlsRlg5?=
 =?utf-8?Q?Fa1nqrOICPHmvFQ54VbaPSbiULX7SvZ7nxY95kN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c6c56d-b3b2-449d-9160-08d8e2628781
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 18:46:48.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJG4xOZ1UKas+Vl6bpbDll6jwhhl4SYPjVd0B+dvbnn8TsEtmtgsBii/zgK3u9nk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3919
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_7B85E765-878A-49BD-AC96-068ABBCFDDA0_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ the rest of cc back and move your reply inline.

On 8 Mar 2021, at 12:47, Mika Penttil=C3=A4 wrote:
>>
>>
>> On 8.3.2021 17.22, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with the=

>>> given pid and virtual address range are split. It is used to test
>>> split_huge_page function. In addition, a selftest program is added to=

>>> tools/testing/selftests/vm to utilize the interface by splitting
>>> PMD THPs and PTE-mapped THPs.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>
>> Hi!
>>
>> I think your test program is not correct. The mremaps shrink to one pa=
ge, after the first mremap the pointers are bogus.
>> Also, mremap splits pmds with split_huge_pmd().. And those you can't s=
plit=C2=A0 with split_huge_page because it is a normal pmd.
>> Maybe you didn't indent to shrink to page size?
>>
>>
>> --Mika
> Hi,
>
> Sorry, wrote too fast.. the splits are okay of course from pte mapped t=
hp to plain pages (mremap -> split pmd -> debugfs write ->split pages).
> But the remap offsets are I think maybe not you wanted.


You mean I mremap the first PAGESIZE from first THP, second PAGESIZE from=
 second THP and so on to
create PTE-mapped THPs? I did it on purpose so split_huge_page can work o=
n different part of THPs.


>>
>>
>>> ---
>>> =C2=A0 mm/huge_memory.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 98 ++++++
>>> =C2=A0 mm/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>>> =C2=A0 mm/migrate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 2 +-
>>> =C2=A0 tools/testing/selftests/vm/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 tools/testing/selftests/vm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 .../selftests/vm/split_huge_page_test.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 318 ++++++++++++++++++
>>> =C2=A0 6 files changed, 420 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 tools/testing/selftests/vm/split_huge_page_=
test.c
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 395c75111d33..818172f887bf 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -7,6 +7,7 @@
>>> =C2=A0 =C2=A0 #include <linux/mm.h>
>>> =C2=A0 #include <linux/sched.h>
>>> +#include <linux/sched/mm.h>
>>> =C2=A0 #include <linux/sched/coredump.h>
>>> =C2=A0 #include <linux/sched/numa_balancing.h>
>>> =C2=A0 #include <linux/highmem.h>
>>> @@ -2971,10 +2972,107 @@ static int split_huge_pages_set(void *data, =
u64 val)
>>> =C2=A0 DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_hu=
ge_pages_set,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%llu\n");
>>> =C2=A0 +static ssize_t split_huge_pages_in_range_pid_write(struct fil=
e *file,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char __user *buf, s=
ize_t count, loff_t *ppops)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 static DEFINE_MUTEX(mutex);
>>> +=C2=A0=C2=A0=C2=A0 ssize_t ret;
>>> +=C2=A0=C2=A0=C2=A0 char input_buf[80]; /* hold pid, start_vaddr, end=
_vaddr */
>>> +=C2=A0=C2=A0=C2=A0 int pid;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long vaddr_start, vaddr_end, addr;
>>> +=C2=A0=C2=A0=C2=A0 nodemask_t task_nodes;
>>> +=C2=A0=C2=A0=C2=A0 struct mm_struct *mm;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long total =3D 0, split =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D mutex_lock_interruptible(&mutex);
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D -EFAULT;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 memset(input_buf, 0, 80);
>>> +=C2=A0=C2=A0=C2=A0 if (copy_from_user(input_buf, buf, min_t(size_t, =
count, 80)))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 input_buf[79] =3D '\0';
>>> +=C2=A0=C2=A0=C2=A0 ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid,=
 &vaddr_start, &vaddr_end);
>>> +=C2=A0=C2=A0=C2=A0 if (ret !=3D 3) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 vaddr_start &=3D PAGE_MASK;
>>> +=C2=A0=C2=A0=C2=A0 vaddr_end &=3D PAGE_MASK;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D strlen(input_buf);
>>> +=C2=A0=C2=A0=C2=A0 pr_debug("split huge pages in pid: %d, vaddr: [%l=
x - %lx]\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid, vaddr_start, v=
addr_end);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mm =3D find_mm_struct(pid, &task_nodes);
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(mm)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mmap_read_lock(mm);
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * always increase addr by PAGE_SIZE, since =
we could have a PTE page
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * table filled with PTE-mapped THPs, each o=
f which is distinct.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 for (addr =3D vaddr_start; addr < vaddr_end; addr=
 +=3D PAGE_SIZE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *vm=
a =3D find_vma(mm, addr);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int follflags;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vma || addr < vma->v=
m_start || !vma_migratable(vma))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FOLL_DUMP to ignore sp=
ecial (like zero) pages */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 follflags =3D FOLL_GET | =
FOLL_DUMP;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D follow_page(vma,=
 addr, follflags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(page))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!page)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_transparent_hugep=
age(page))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!can_split_huge_page(=
compound_head(page), NULL))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!trylock_page(page))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!split_huge_page(page=
))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
plit++;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_page(page);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_page(page);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 mmap_read_unlock(mm);
>>> +=C2=A0=C2=A0=C2=A0 mmput(mm);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 pr_debug("%lu of %lu THP split\n", split, total);=

>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&mutex);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +
>>> +}
>>> +
>>> +static const struct file_operations split_huge_pages_in_range_pid_fo=
ps =3D {
>>> +=C2=A0=C2=A0=C2=A0 .owner=C2=A0=C2=A0=C2=A0=C2=A0 =3D THIS_MODULE,
>>> +=C2=A0=C2=A0=C2=A0 .write=C2=A0=C2=A0=C2=A0=C2=A0 =3D split_huge_pag=
es_in_range_pid_write,
>>> +=C2=A0=C2=A0=C2=A0 .llseek=C2=A0 =3D no_llseek,
>>> +};
>>> +
>>> =C2=A0 static int __init split_huge_pages_debugfs(void)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debugfs_create_file("split_huge_pages"=
, 0200, NULL, NULL,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &split_huge_pages_fops);
>>> +=C2=A0=C2=A0=C2=A0 debugfs_create_file("split_huge_pages_in_range_pi=
d", 0200, NULL, NULL,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &split_huge_pages_in_range_pid_fops);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> =C2=A0 late_initcall(split_huge_pages_debugfs);
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 9902648f2206..1659d00100ef 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -623,4 +623,5 @@ struct migration_target_control {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_t gfp_mask;
>>> =C2=A0 };
>>> =C2=A0 +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_n=
odes);
>>> =C2=A0 #endif=C2=A0=C2=A0=C2=A0 /* __MM_INTERNAL_H */
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 62b81d5257aa..ce5f213debb2 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1913,7 +1913,7 @@ static int do_pages_stat(struct mm_struct *mm, =
unsigned long nr_pages,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nr_pages ? -EFAULT : 0;
>>> =C2=A0 }
>>> =C2=A0 -static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t=
 *mem_nodes)
>>> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct task_struct *task;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mm_struct *mm;
>>> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/se=
lftests/vm/.gitignore
>>> index 9a35c3f6a557..1f651e85ed60 100644
>>> --- a/tools/testing/selftests/vm/.gitignore
>>> +++ b/tools/testing/selftests/vm/.gitignore
>>> @@ -22,3 +22,4 @@ map_fixed_noreplace
>>> =C2=A0 write_to_hugetlbfs
>>> =C2=A0 hmm-tests
>>> =C2=A0 local_config.*
>>> +split_huge_page_test
>>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/self=
tests/vm/Makefile
>>> index d42115e4284d..4cbc91d6869f 100644
>>> --- a/tools/testing/selftests/vm/Makefile
>>> +++ b/tools/testing/selftests/vm/Makefile
>>> @@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D on-fault-limit
>>> =C2=A0 TEST_GEN_FILES +=3D thuge-gen
>>> =C2=A0 TEST_GEN_FILES +=3D transhuge-stress
>>> =C2=A0 TEST_GEN_FILES +=3D userfaultfd
>>> +TEST_GEN_FILES +=3D split_huge_page_test
>>> =C2=A0 =C2=A0 ifeq ($(MACHINE),x86_64)
>>> =C2=A0 CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/=
trivial_32bit_program.c -m32)
>>> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tool=
s/testing/selftests/vm/split_huge_page_test.c
>>> new file mode 100644
>>> index 000000000000..8ea8000fda62
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
>>> @@ -0,0 +1,318 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * A test of splitting PMD THPs and PTE-mapped THPs from a specified=
 virtual
>>> + * address range in a process via <debugfs>/split_huge_pages_in_rang=
e_pid
>>> + * interface.
>>> + */
>>> +
>>> +#define _GNU_SOURCE
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include "numa.h"
>>> +#include <unistd.h>
>>> +#include <errno.h>
>>> +#include <inttypes.h>
>>> +#include <string.h>
>>> +#include <sys/types.h>
>>> +#include <sys/stat.h>
>>> +#include <fcntl.h>
>>> +#include <sys/mman.h>
>>> +#include <sys/time.h>
>>> +#include <sys/wait.h>
>>> +#include <malloc.h>
>>> +#include <stdbool.h>
>>> +
>>> +uint64_t pagesize;
>>> +unsigned int pageshift;
>>> +uint64_t pmd_pagesize;
>>> +
>>> +#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd=
_size"
>>> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_p=
id"
>>> +#define SMAP_PATH "/proc/self/smaps"
>>> +#define INPUT_MAX 80
>>> +
>>> +#define PFN_MASK=C2=A0=C2=A0=C2=A0=C2=A0 ((1UL<<55)-1)
>>> +#define KPF_THP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1UL<<22)
>>> +
>>> +int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_f=
ile)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint64_t paddr;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t page_flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (pagemap_file) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pread(pagemap_file, &padd=
r, sizeof(paddr),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
(long)vaddr >> pageshift) * sizeof(paddr));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kpageflags_file) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
read(kpageflags_file, &page_flags, sizeof(page_flags),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (paddr & PFN_MASK) * sizeof(page_flags));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn !!(page_flags & KPF_THP);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +
>>> +static uint64_t read_pmd_pagesize(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int fd;
>>> +=C2=A0=C2=A0=C2=A0 char buf[20];
>>> +=C2=A0=C2=A0=C2=A0 ssize_t num_read;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 fd =3D open(PMD_SIZE_PATH, O_RDONLY);
>>> +=C2=A0=C2=A0=C2=A0 if (fd =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("Open hpage_pmd_si=
ze failed");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 num_read =3D read(fd, buf, 19);
>>> +=C2=A0=C2=A0=C2=A0 if (num_read < 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fd);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("Read hpage_pmd_si=
ze failed");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 buf[num_read] =3D '\0';
>>> +=C2=A0=C2=A0=C2=A0 close(fd);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return strtoul(buf, NULL, 10);
>>> +}
>>> +
>>> +static int write_file(const char *path, const char *buf, size_t bufl=
en)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int fd;
>>> +=C2=A0=C2=A0=C2=A0 ssize_t numwritten;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 fd =3D open(path, O_WRONLY);
>>> +=C2=A0=C2=A0=C2=A0 if (fd =3D=3D -1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 numwritten =3D write(fd, buf, buflen - 1);
>>> +=C2=A0=C2=A0=C2=A0 close(fd);
>>> +=C2=A0=C2=A0=C2=A0 if (numwritten < 1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return (unsigned int) numwritten;
>>> +}
>>> +
>>> +static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t va=
ddr_end)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 char input[INPUT_MAX];
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%l=
x", pid, vaddr_start,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
addr_end);
>>> +=C2=A0=C2=A0=C2=A0 if (ret >=3D INPUT_MAX) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s: Debugfs input=
 is too long\n", __func__);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(SPLIT_DEBUGFS);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +#define MAX_LINE_LENGTH 500
>>> +
>>> +static bool check_for_pattern(FILE *fp, const char *pattern, char *b=
uf)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 while (fgets(buf, MAX_LINE_LENGTH, fp) !=3D NULL)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strncmp(buf, pattern=
, strlen(pattern)))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn true;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return false;
>>> +}
>>> +
>>> +static uint64_t check_huge(void *addr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint64_t thp =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 FILE *fp;
>>> +=C2=A0=C2=A0=C2=A0 char buffer[MAX_LINE_LENGTH];
>>> +=C2=A0=C2=A0=C2=A0 char addr_pattern[MAX_LINE_LENGTH];
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D snprintf(addr_pattern, MAX_LINE_LENGTH, "=
%08lx-",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (unsigned long) addr);
>>> +=C2=A0=C2=A0=C2=A0 if (ret >=3D MAX_LINE_LENGTH) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s: Pattern is to=
o long\n", __func__);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +
>>> +=C2=A0=C2=A0=C2=A0 fp =3D fopen(SMAP_PATH, "r");
>>> +=C2=A0=C2=A0=C2=A0 if (!fp) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s: Failed to ope=
n file %s\n", __func__, SMAP_PATH);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!check_for_pattern(fp, addr_pattern, buffer))=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_out;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Fetch the AnonHugePages: in the same bloc=
k and check the number of
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * hugepages.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (!check_for_pattern(fp, "AnonHugePages:", buff=
er))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_out;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp=
) !=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Reading smap erro=
r\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +err_out:
>>> +=C2=A0=C2=A0=C2=A0 fclose(fp);
>>> +=C2=A0=C2=A0=C2=A0 return thp;
>>> +}
>>> +
>>> +void split_pmd_thp(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 char *one_page;
>>> +=C2=A0=C2=A0=C2=A0 size_t len =3D 4 * pmd_pagesize;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t thp_size;
>>> +=C2=A0=C2=A0=C2=A0 size_t i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 one_page =3D memalign(pmd_pagesize, len);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 madvise(one_page, len, MADV_HUGEPAGE);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 one_page[i] =3D (char)i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 thp_size =3D check_huge(one_page);
>>> +=C2=A0=C2=A0=C2=A0 if (!thp_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("No THP is allocat=
d");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* split all possible huge pages */
>>> +=C2=A0=C2=A0=C2=A0 write_debugfs(getpid(), (uint64_t)one_page, (uint=
64_t)one_page + len);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (one_page[i] !=3D (cha=
r)i) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintf("%ld byte corrupted\n", i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
xit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +
>>> +=C2=A0=C2=A0=C2=A0 thp_size =3D check_huge(one_page);
>>> +=C2=A0=C2=A0=C2=A0 if (thp_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Still %ld kB Anon=
HugePages not split\n", thp_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 printf("Split huge pages successful\n");
>>> +=C2=A0=C2=A0=C2=A0 free(one_page);
>>> +}
>>> +
>>> +void split_pte_mapped_thp(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 char *one_page, *pte_mapped, *pte_mapped2;
>>> +=C2=A0=C2=A0=C2=A0 size_t len =3D 4 * pmd_pagesize;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t thp_size;
>>> +=C2=A0=C2=A0=C2=A0 size_t i;
>>> +=C2=A0=C2=A0=C2=A0 const char *pagemap_template =3D "/proc/%d/pagema=
p";
>>> +=C2=A0=C2=A0=C2=A0 const char *kpageflags_proc =3D "/proc/kpageflags=
";
>>> +=C2=A0=C2=A0=C2=A0 char pagemap_proc[255];
>>> +=C2=A0=C2=A0=C2=A0 int pagemap_fd;
>>> +=C2=A0=C2=A0=C2=A0 int kpageflags_fd;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (snprintf(pagemap_proc, 255, pagemap_template,=
 getpid()) < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("get pagemap proc =
error");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 pagemap_fd =3D open(pagemap_proc, O_RDONLY);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (pagemap_fd =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("read pagemap:");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 kpageflags_fd =3D open(kpageflags_proc, O_RDONLY)=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (kpageflags_fd =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("read kpageflags:"=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 one_page =3D mmap((void *)(1UL << 30), len, PROT_=
READ | PROT_WRITE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M=
AP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 madvise(one_page, len, MADV_HUGEPAGE);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 one_page[i] =3D (char)i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 thp_size =3D check_huge(one_page);
>>> +=C2=A0=C2=A0=C2=A0 if (!thp_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("No THP is allocat=
d");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 pte_mapped =3D mremap(one_page, pagesize, pagesiz=
e, MREMAP_MAYMOVE);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 1; i < 4; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_mapped2 =3D mremap(on=
e_page + pmd_pagesize * i + pagesize * i,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pagesize, pagesize,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MREMAP_MAYMOVE|MREMAP=
_FIXED,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_mapped + pagesize=
 * i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pte_mapped2 =3D=3D (c=
har *)-1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
error("mremap failed");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
xit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* smap does not show THPs after mremap, use kpag=
eflags instead */
>>> +=C2=A0=C2=A0=C2=A0 thp_size =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pagesize * 4; i++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i % pagesize =3D=3D 0=
 &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
s_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
hp_size++;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (thp_size !=3D 4) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Some THPs are mis=
sing during mremap\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* split all possible huge pages */
>>> +=C2=A0=C2=A0=C2=A0 write_debugfs(getpid(), (uint64_t)pte_mapped,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (uint64_t)pte_mapped + pagesize * 4);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* smap does not show THPs after mremap, use kpag=
eflags instead */
>>> +=C2=A0=C2=A0=C2=A0 thp_size =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pagesize * 4; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pte_mapped[i] !=3D (c=
har)i) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintf("%ld byte corrupted\n", i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
xit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i % pagesize =3D=3D 0=
 &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
s_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
hp_size++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (thp_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Still %ld THPs no=
t split\n", thp_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 printf("Split PTE-mapped huge pages successful\n"=
);
>>> +=C2=A0=C2=A0=C2=A0 munmap(one_page, len);
>>> +=C2=A0=C2=A0=C2=A0 close(pagemap_fd);
>>> +=C2=A0=C2=A0=C2=A0 close(kpageflags_fd);
>>> +}
>>> +
>>> +int main(int argc, char **argv)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (geteuid() !=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Please run the be=
nchmark as root\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 pagesize =3D getpagesize();
>>> +=C2=A0=C2=A0=C2=A0 pageshift =3D ffs(pagesize) - 1;
>>> +=C2=A0=C2=A0=C2=A0 pmd_pagesize =3D read_pmd_pagesize();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 split_pmd_thp();
>>> +=C2=A0=C2=A0=C2=A0 split_pte_mapped_thp();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_7B85E765-878A-49BD-AC96-068ABBCFDDA0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBGcRIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKtxUP/2VNFvR9Ar4U1wZWiPpF+TXIMVWpL/DeybS+
hCPJ17zahcTdYC4LxE72JDWM8/FoOCZK+bxsnUUFUEAvVws+oT9CaCLfknTtPwQp
52MrvJg46pw1U0TTVwm703Jw7xTO7eugBNoShKahT9tVa1hiB+h22Cq/7lm948HS
nnH360mHZAmjFUpuVaaw2p7XaVaS7tjjKzYNnLTnY1SG3xQQv7UBQKy/CFaDNkI6
3eeXofzlvIU5b+IHjZfa7GdCQZNeAWZcI545MCEc2ZVjXituCQBTvsu0dUgy6Wd8
Fh5rkx2JAV3EG/4/9az/pML2C8QzD79MzP6nwP2hUS7Wmsq6UeEwsSUAfKkzgG++
qtufPEtMnqltmYZITunDfcUDqplSJUh4Lj+fuL+NkggNg8purDvfyr/pu+ldmdn3
RVZ2jR+fN1Hl11hqe8NIT/UfCjO8X37rKC69i3hn1vRuSXck489Xnm8VnWIExE5Y
v8KW/DB9oDZb7QZXex90v8HOukXbuY3R01bJHhff4yaoQUIyNLxZgwcKSLX7yf3f
RfZTDJW/T+3+g2z6REAaKMWM7IRZUg1shH1cgLxpb9+/4bU8tSQDEVxYS6qOap+e
2+VgwU8OMsA9gaTu7mjpx/lutGT/ZWKAxpvS2YumUU3ymtvLTDNzkVUOQF2lmkc2
xscXWnt9
=Mvb3
-----END PGP SIGNATURE-----

--=_MailMate_7B85E765-878A-49BD-AC96-068ABBCFDDA0_=--
