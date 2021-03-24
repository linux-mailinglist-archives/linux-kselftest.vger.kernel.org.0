Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC598348241
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Mar 2021 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhCXT4q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 15:56:46 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:27105
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237836AbhCXT4I (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 15:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ39iU3rxWBy8hMuvsjwTDcCTBwZSqG9Ulu5V6KnMC5skvc9pf8hIb7SMseRc50q/+RWdssjErmRJPUymUWwCbE9B6pcmgExq4cBbXRIzOYKLGCweJz6+dwb6XDpWM5D2n6eR/uOMB0QZoaKtCupMF/TBA2B31kYo+nuCQyKz5s4mVkD/VhpO/gdXn/G3DRFRc0rrmnKgEQQZ7vxZvukotBz1eIgwk37H6SCM33CqRB/Pmyzn8JhTo5XbC8M+m/7p7+FNPA6+x9Dyiy4Qz0BjfgXj/SenEJ0jJG/VeLulvwxVWu+7sDzUTQCie0zfQQgBYHiH4tQ8ARUn4SAfqpnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfUtGF6q9i6V5IbJyqZ6+2DO78MaaBOmtOyna1I9rc4=;
 b=DZm5ZsEwQclfkpLJtJ/oYAKtn2sUkUXuyYjFBnNjI927RHeuR4gj8sVZYu1B7g6WS2/0XoiKsrCspg67rnb6WRt0EYKUgqfNLKReooot9tGvTA5r8DT7RtMImFNry47rzyiRd6fpkyz7cWZU+JUB879KTqGICSjgj6qe5acV6n232/LSDbnLZZlxQ6FiLrT4OvItVcGS5BO5PyhvFOUKbGbwssYZMHsjE9o1CVUMebBMc1qhUF6lTgoRe/tIIaSq6rZvKeFeRHPjq52s2jt+E1bVE+awRbL8WUEu4wxxwi19XRPRoAOeqWowhk2qJNWSFd6OBWYRICEMQLGVRnOvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfUtGF6q9i6V5IbJyqZ6+2DO78MaaBOmtOyna1I9rc4=;
 b=IIzilyZYgw3zHqncLBeuKDAjBEbETa2WHrJA+2s50S5piZNbYHPP1VqxVGekTq27i7IteOKj3Zuu1jxPnVjycG6EHstC+vudIc3qZrDzt69ZBAUXfvKJqv4gMw3/otEDoyt4MQGJQfhJdN0FR/J8YvZ3YbocBsRycDx54zTSXo2JphtHSy3frNolQHZahi3acX0dsM3bPle9d+Mo8IFyRwS3nEqsB6G5LefmZh7LL429TAVYiiLKOaBQ1dRjV1aGx6JUBmaqbNEQFULWz92ruty38i5GMCtv1zO2OWun29QNIct/o223jO014s8kVumSg0Mfy6FEFuOlzGrXsdGrmA==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4799.namprd12.prod.outlook.com (2603:10b6:208:a2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 19:56:04 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 19:56:04 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "David Rientjes" <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Yang Shi" <shy828301@gmail.com>,
        "Mika Penttila" <mika.penttila@nextfour.com>
Subject: Re: [PATCH v6 1/2] mm: huge_memory: a new debugfs interface for
 splitting THP tests.
Date:   Wed, 24 Mar 2021 15:55:58 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <3EB06925-1695-46E9-88E4-B85B4F1DBE8A@nvidia.com>
In-Reply-To: <3ef65bfc-5be6-eba4-f7e8-f5e64a554870@google.com>
References: <20210322200547.68587-1-zi.yan@sent.com>
 <3ef65bfc-5be6-eba4-f7e8-f5e64a554870@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B892BD91-F09C-41A3-BD38-7B4151D9DA85_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0287.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::22) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.1] (216.228.112.22) by BL1PR13CA0287.namprd13.prod.outlook.com (2603:10b6:208:2bc::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Wed, 24 Mar 2021 19:56:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36bf7a16-8574-4d8e-641c-08d8eefedb5f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4799BB5CC9BB5FA8537EC174C2639@MN2PR12MB4799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ka1mWNGOZEHgbckxQxa/lfzyhW+ZjsNvYqe6I/sprv4p0/1TDc9LULoWk9bYMaoJPNNtl4huqMRtihbpJ94iIkh1/MBMq5ZagUtQD7k3yHRgGl3K6bjaDVypnZwoK1qhtABiiFS61JDQOpj/uwyKGKy3LR0PThhjL2Zoyty2FvOTEHb9L9k5a6q9xQIX2vwag6ooghAf23TteIZWG9ugUUrptDQtn9YT88M1zNBOKKECB3c1dD5C37o+vTXNmkcwfuZM0qqNfnzW4W6DuBn+ZjYwK+ODpxPkA+ftwyEbFJXNEFpvHzoyuhP4l3uCtcwUvFZQjx3KGwm43E8w9W4bDEWwO1O5UsU+vaKuNmrNFrrgFkJMTlGpKIYbTa/5gZhCh1GxvfJDSQNuWRoOmdbKybYuWnbjB50d0F0fLXaoHRkzqpE0fK6z6jVIcwm2bzKmOX5s1IjlIN27AboYYCvbF0Nbbh6dPYDVyvOtzEjhyaGlNDLdAz+AU8nuYnOc2Gtz2pNGZH2shwfPhy0P3DqBKJom/PoSuuBduh+8ppoIzi2TnmZvqJqrwlS7JhtfYFaHCs2StjYsoGdYUhbBbAz3IVau9NC1UlWtaruI44ZyOqYsuCXJwhDu2mVhae0jNbVkjiTTwlbB4YykPc4vdXV1kBaDt91RRZN6VvabHe7PLGyBrk8Su4t2m5RIXTQ4t7lBQUuxYoO0XjI928076bhfp1KzrDhQyS7egEx9uImTVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(478600001)(2616005)(16576012)(66476007)(33656002)(38100700001)(235185007)(4326008)(16526019)(956004)(86362001)(66556008)(186003)(316002)(5660300002)(6916009)(66946007)(7416002)(8936002)(54906003)(36756003)(53546011)(2906002)(6486002)(6666004)(8676002)(83380400001)(33964004)(26005)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXgraTdaRG1EeUxCbXpaODZnSDhURGNsbHNYVlUzY0xWVzZ2cmlrbDhudXk0?=
 =?utf-8?B?cXphMkZoQ3BTMVl3QXhXL2Q5VWlWdkpNcURYNzhBdGNaNFBoQ01iZnRVL1Vx?=
 =?utf-8?B?VzNyZXpSd1VTNkFIK2hZYnY5RmhGU005TWl4Z2gybUhHaXNWWWtLOWU5Tjdj?=
 =?utf-8?B?a204eENJVGRreWZmN0Z3KzByQ1pITVFFOFBnYUYvS1RRZTEyNksxTHFSblFq?=
 =?utf-8?B?UmpZTDVWZStuYm9QVURmUjRPMHZtem9mSGJwcGI0Z0NlaDA5M1d4dUN5bHlk?=
 =?utf-8?B?WTFZOGtmc042U3RJYjNjaWJ6bE5CQ213MExlMkxBQW1JcFIrL1Y4V3g3VzZz?=
 =?utf-8?B?MktrcWtVMmUxYk5BYVYrOW5rTEVMVUhWT09XeXlRbVNvb1pjLzZUZ1dISzJ6?=
 =?utf-8?B?em1jaWttQ0VDVjg5YVdrVXJVTUl0azRYVkUzeVVTckNJSVBhTEIwNEFzSXEx?=
 =?utf-8?B?N2VuYStnYVR5YjR2RjEwMlMyNFBOUTdWSWtrOWJmVC9QWWp5anRsMGdYQ3FO?=
 =?utf-8?B?RnZqckQrcDVCdmZ1Qk44Z1Z6TDF3Q25nY3l5SEhIMEV4ZW9QbjZRR0x6M1Vx?=
 =?utf-8?B?YjFSSlFad2plaElZLzl5cDRBdko5cTFLZi9zVEwzRmFQMmZkMGFRa0RWaXBj?=
 =?utf-8?B?RTl0V1EyWXU5RFZyaW0vaTcxbi9NMFlQdVFTdEFMa2t2RFU2VjExcDRnN1Zx?=
 =?utf-8?B?cGhqaDBBcmU4dXZlWTdNdFpjR1FjdWRrTGVPSlNOd3hRU3E4TUxCVDY0MG1h?=
 =?utf-8?B?M0J6QU5DNStDYlAyNzM4Y2JpVXo2MVZqellOdi9xYmI0VjRjWTg3RDZhaWF1?=
 =?utf-8?B?NCtyWUdUbEpIOTcvUFJEVXdBazYwajhIQjZ0MllNQXphZlJNalZMVFlNSVo1?=
 =?utf-8?B?VWtMOWNHc2ZrVHFHbXdXUGZobkZ4RTl5WUVGajUzRkRaY05ZelVFWW82Zmtp?=
 =?utf-8?B?eDVFblRMVTkrOHVMSzlhZzMyTkR2eHZ1ZGoyTE00WE1XcGZUL0V5a3J6cFFK?=
 =?utf-8?B?Q0Y0ekdTSmxvQkZIb2tQbmtsOU92Q3BGRnZBYlE4a0M5ZU5KN0dyWE9XM3Fz?=
 =?utf-8?B?NnNNWDJrTXEraDFyeXFhdlRybUQ0R2VxZlptM0FDZVpGakQ1cVJScTdkQTRq?=
 =?utf-8?B?cU9waFdvQ3BjakVBZk5UWHg3bzhTbUZtYTNzYWliYzhJTWtJVk5lRmlkYk1K?=
 =?utf-8?B?NEJ1SzU5T2czaTZuelBkS1FEWHQzNUMzVDFVRzg5MGRqOTRHSUwzaGVVN2xP?=
 =?utf-8?B?R3Zad1pIRXhET05aMkhVS3VISjR6Zi85OU55aWU3RFB4YUlvbVpaam92d3h2?=
 =?utf-8?B?MHNLL0NsWi9sZ2FhOWw1WEE0Wm5lTHpkTWk5RTRyYXdSeVZENG9RNndPMlFi?=
 =?utf-8?B?bFdGTko5Szkwc2hIbUdlUVl0Y0FobzFmTjA1QXJTQkZkRWg1amh5K3B2K01j?=
 =?utf-8?B?R0JhOTBVOFpKZ2lEMno5L2llOGxxQTBMb0pJNGxmOXVrc01Wd3lVcm45a3Rr?=
 =?utf-8?B?clh3ZEs0bmRHQlV6bnI4WkdUb082NktCUDg5NmZ1ZTJMSTZpYXRvZjBXb0E1?=
 =?utf-8?B?OXZldVpSeEFZL2J1b1hqWlROVzE1SjdMd2tyRkhxREdQRG5rRVRlTTBRWUR3?=
 =?utf-8?B?dlFHdnp2eGxjcStlR1JLdnNSTVV0a0N6L29laDJRQ2xUZHJhdklZaTIzWCtt?=
 =?utf-8?B?akZaREUvOWEzRzM3YUV4MVYxWTBVMmpjY0VvbzlvbWxvNHc4a3gwNHN2WHdM?=
 =?utf-8?Q?LKczTPWuGtM76+dgrvcQmrpkUTGyQhB+AunWaRx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bf7a16-8574-4d8e-641c-08d8eefedb5f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 19:56:04.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyWagKhFIXG8+ub0wV0goaIxXXNpsC5rRCNHap9CQcZVxF/aTKqklc7o6Wx8W03Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4799
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_B892BD91-F09C-41A3-BD38-7B4151D9DA85_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 24 Mar 2021, at 15:16, David Rientjes wrote:

> On Mon, 22 Mar 2021, Zi Yan wrote:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> We did not have a direct user interface of splitting the compound page=

>> backing a THP and there is no need unless we want to expose the THP
>> implementation details to users. Make <debugfs>/split_huge_pages accep=
t
>> a new command to do that.
>>
>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>> <debugfs>/split_huge_pages, THPs within the given virtual address rang=
e
>> from the process with the given pid are split. It is used to test
>> split_huge_page function. In addition, a selftest program is added to
>> tools/testing/selftests/vm to utilize the interface by splitting
>> PMD THPs and PTE-mapped THPs.
>>
>
> I'm curious if this is the only use case or whether you have additional=

> use cases or extensions in mind?

At the moment, this is the only use case I have in mind. I am developing
1GB THP support and split huge pages to any lower order (this will be use=
ful
when Matthew Wilcox=E2=80=99s large page in page cache is in) and find th=
ere is no
way of splitting specific THPs (the compound pages) from user space.
So I added this interface for testing, mostly for splitting one or two
specified THPs. A potential extension might be to add a new <order>
parameter to test my split_huge_page_to_any_order(), after it gets in.

>
> Specifically, I'm wondering if you are looking into more appropriately
> dividing the limited number of hugepages available on the system amongs=
t
> the most latency sensitive processes?
>
> The set of hugepages available on the system can be limited by
> fragmentation.  We've found opportunities where latency sensitive
> processes would benefit from memory backed by thp, but they cannot be
> allocated at fault for this reason.  Yet, there are other processes tha=
t
> have memory backed by hugepages that may not be benefiting from them.
>
> Could this be useful to split a hugepage for a latency tolerant
> application, migrate the pages elsewhere, and make the now-free hugepag=
e
> available for a latency sensitive application (through something like m=
y
> MADV_COLLAPSE proposal?)

The idea sounds quite interesting and reasonable. In the scenario you des=
cribed,
I just wonder if we want to do SPLIT + COLLAPSE or we can combine them
into a single swap of THP and base pages (potentially using some extra fr=
ee
pages as tmp space). Because there is no guarantee that the split subpage=
s
can all be migrated and make space for a new THP, or other allocations mi=
ght
steal a free page from the split THP range, causing subsequence THP alloc=
ation
failure.

I am OK with exposing this via a proper user space interface and can prep=
are
a patch for it. I just want to know if there are other use cases of split=
ting
THPs (the compound pages).

>
> Couple questions inline.
>
>> This does not change the old behavior, i.e., writing 1 to the interfac=
e
>> to split all THPs in the system.
>>
>> Changelog:
>>
>> From v5:
>> 1. Skipped special VMAs and other fixes. (suggested by Yang Shi)
>>
>> From v4:
>> 1. Fixed the error code return issue, spotted by kernel test robot
>>    <lkp@intel.com>.
>>
>> From v3:
>> 1. Factored out split huge pages in the given pid code to a separate
>>    function.
>> 2. Added the missing put_page for not split pages.
>> 3. pr_debug -> pr_info, make reading results simpler.
>>
>> From v2:
>> 1. Reused existing <debugfs>/split_huge_pages interface. (suggested by=

>>    Yang Shi)
>>
>> From v1:
>> 1. Removed unnecessary calling to vma_migratable, spotted by kernel te=
st
>>    robot <lkp@intel.com>.
>> 2. Dropped the use of find_mm_struct and code it directly, since there=

>>    is no need for the permission check in that function and the functi=
on
>>    is only available when migration is on.
>> 3. Added some comments in the selftest program to clarify how PTE-mapp=
ed
>>    THPs are formed.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> ---
>>  mm/huge_memory.c                              | 151 ++++++++-
>>  tools/testing/selftests/vm/.gitignore         |   1 +
>>  tools/testing/selftests/vm/Makefile           |   1 +
>>  .../selftests/vm/split_huge_page_test.c       | 318 +++++++++++++++++=
+
>>  4 files changed, 464 insertions(+), 7 deletions(-)
>>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bff92dea5ab3..b653255a548e 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -7,6 +7,7 @@
>>
>>  #include <linux/mm.h>
>>  #include <linux/sched.h>
>> +#include <linux/sched/mm.h>
>>  #include <linux/sched/coredump.h>
>>  #include <linux/sched/numa_balancing.h>
>>  #include <linux/highmem.h>
>> @@ -2922,16 +2923,14 @@ static struct shrinker deferred_split_shrinker=
 =3D {
>>  };
>>
>>  #ifdef CONFIG_DEBUG_FS
>> -static int split_huge_pages_set(void *data, u64 val)
>> +static void split_huge_pages_all(void)
>>  {
>>  	struct zone *zone;
>>  	struct page *page;
>>  	unsigned long pfn, max_zone_pfn;
>>  	unsigned long total =3D 0, split =3D 0;
>>
>> -	if (val !=3D 1)
>> -		return -EINVAL;
>> -
>> +	pr_info("Split all THPs\n");
>
> Is this necessary to print?
This interface accepts three different split commands, so I would like to=
 explicitly
print what command is executed during my debugging.

>
>>  	for_each_populated_zone(zone) {
>>  		max_zone_pfn =3D zone_end_pfn(zone);
>>  		for (pfn =3D zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
>> @@ -2959,11 +2958,149 @@ static int split_huge_pages_set(void *data, u=
64 val)
>>  	}
>>
>>  	pr_info("%lu of %lu THP split\n", split, total);
>> +}
>>
>> -	return 0;
>> +static inline bool vma_not_suitable_for_thp_split(struct vm_area_stru=
ct *vma)
>> +{
>> +	return vma_is_special_huge(vma) || (vma->vm_flags & VM_IO) ||
>> +		    is_vm_hugetlb_page(vma);
>>  }
>> -DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_page=
s_set,
>> -		"%llu\n");
>> +
>> +static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>> +				unsigned long vaddr_end)
>> +{
>> +	int ret =3D 0;
>> +	struct task_struct *task;
>> +	struct mm_struct *mm;
>> +	unsigned long total =3D 0, split =3D 0;
>> +	unsigned long addr;
>> +
>> +	vaddr_start &=3D PAGE_MASK;
>> +	vaddr_end &=3D PAGE_MASK;
>> +
>> +	/* Find the task_struct from pid */
>> +	rcu_read_lock();
>> +	task =3D find_task_by_vpid(pid);
>> +	if (!task) {
>> +		rcu_read_unlock();
>> +		ret =3D -ESRCH;
>> +		goto out;
>> +	}
>> +	get_task_struct(task);
>> +	rcu_read_unlock();
>> +
>> +	/* Find the mm_struct */
>> +	mm =3D get_task_mm(task);
>> +	put_task_struct(task);
>> +
>> +	if (!mm) {
>> +		ret =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	pr_info("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
>> +		 pid, vaddr_start, vaddr_end);
>
> Hmm, does this need to be in the kernel log?

Since this is a debugfs interface, I expect it is only used for debugging=
,
which should be rare. pr_info would save us from the additional enabling
dynamic debug printing.

>
>> +
>> +	mmap_read_lock(mm);
>> +	/*
>> +	 * always increase addr by PAGE_SIZE, since we could have a PTE page=

>> +	 * table filled with PTE-mapped THPs, each of which is distinct.
>> +	 */
>> +	for (addr =3D vaddr_start; addr < vaddr_end; addr +=3D PAGE_SIZE) {
>> +		struct vm_area_struct *vma =3D find_vma(mm, addr);
>> +		unsigned int follflags;
>> +		struct page *page;
>> +
>> +		if (!vma || addr < vma->vm_start)
>> +			break;
>> +
>
> Should there be a cond_resched() right here?

I did not expect we are going to use this to split a lot of pages.
But I will add one here in case someone uses it that way.

>
>> +		/* skip special VMA and hugetlb VMA */
>> +		if (vma_not_suitable_for_thp_split(vma)) {
>> +			addr =3D vma->vm_end;
>> +			continue;
>> +		}
>> +
>> +		/* FOLL_DUMP to ignore special (like zero) pages */
>> +		follflags =3D FOLL_GET | FOLL_DUMP;
>> +		page =3D follow_page(vma, addr, follflags);
>> +
>> +		if (IS_ERR(page))
>> +			continue;
>> +		if (!page)
>> +			continue;
>> +
>> +		if (!is_transparent_hugepage(page))
>> +			goto next;
>> +
>> +		total++;
>> +		if (!can_split_huge_page(compound_head(page), NULL))
>> +			goto next;
>> +
>> +		if (!trylock_page(page))
>> +			goto next;
>> +
>> +		if (!split_huge_page(page))
>> +			split++;
>> +
>> +		unlock_page(page);
>> +next:
>> +		put_page(page);
>> +	}
>> +	mmap_read_unlock(mm);
>> +	mmput(mm);
>> +
>> +	pr_info("%lu of %lu THP split\n", split, total);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>> +#define MAX_INPUT_BUF_SZ 255
>> +
>> +static ssize_t split_huge_pages_write(struct file *file, const char _=
_user *buf,
>> +				size_t count, loff_t *ppops)
>> +{
>> +	static DEFINE_MUTEX(split_debug_mutex);
>> +	ssize_t ret;
>> +	char input_buf[MAX_INPUT_BUF_SZ]; /* hold pid, start_vaddr, end_vadd=
r */
>> +	int pid;
>> +	unsigned long vaddr_start, vaddr_end;
>> +
>> +	ret =3D mutex_lock_interruptible(&split_debug_mutex);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D -EFAULT;
>> +
>> +	memset(input_buf, 0, MAX_INPUT_BUF_SZ);
>> +	if (copy_from_user(input_buf, buf, min_t(size_t, count, MAX_INPUT_BU=
F_SZ)))
>> +		goto out;
>> +
>> +	input_buf[MAX_INPUT_BUF_SZ - 1] =3D '\0';
>> +	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vad=
dr_end);
>> +	if (ret =3D=3D 1 && pid =3D=3D 1) {
>> +		split_huge_pages_all();
>> +		ret =3D strlen(input_buf);
>> +		goto out;
>> +	} else if (ret !=3D 3) {
>> +		ret =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret =3D split_huge_pages_pid(pid, vaddr_start, vaddr_end);
>> +	if (!ret)
>> +		ret =3D strlen(input_buf);
>> +out:
>> +	mutex_unlock(&split_debug_mutex);
>> +	return ret;
>> +
>> +}
>> +
>> +static const struct file_operations split_huge_pages_fops =3D {
>> +	.owner	 =3D THIS_MODULE,
>> +	.write	 =3D split_huge_pages_write,
>> +	.llseek  =3D no_llseek,
>> +};
>>
>>  static int __init split_huge_pages_debugfs(void)
>>  {


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_B892BD91-F09C-41A3-BD38-7B4151D9DA85_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBbmU4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKB1IP/0NIIFWCHQnGgDGaU4pOBeY+F3YsZrqG6emq
wQrSKo4ZDz6vlYlh5QUqaXk2atYE3Wf5sHllJhRnnhUPyrb0snlxiM7/sHek6nvh
VioSmPZJ2k7sAwQgSiMf9DQfflMo1Fu7veVF3pi6bdI7Y2268xGgZdmuR5x0mxJl
2ACy6Emk92/qOCi+wnb3GbkBf+icjKMnmFlltfHPDqGMGIPE2SIpvzS2tz1Iglh0
0yQOvnHR0ib+1IszNPfRDw4EUjII+cf6SLsP2Uf1OBkI96EjeDUq6BExy33L2vtc
HJBErVzMvwUdBamNt7rdA6uw99W906A0Un2/fAWXuBGTp9Ii0M9BgxLU9hyze8w1
kC8njGmPyb6ADqczLTEivq6agdfCMA52F75stt6Fz2k9JMjRhA8EqspibIamjGJi
OdOmk5nmAX0jG42GLdlFimgc+y4aFtPRp0k2lNaW/bciqcuwRfX31rv7OvMsYbbG
s30CJN/lLOBGZCbciwQbvirU2GQlkz1I8Rq2jCNqfPsk+fPdSsgde8nqUCVhyKkC
n+X8dWsbo+V9LppPLysbi2uXw/qOw1Zz5qWA1t7MaiLrYXiKX9W9sFvGproa/Ot3
bQltbKc2x8pJ6qXLGcjllCfr86EbSfp4neZiXkrsqWs7Gtg8zS12HVcpie2iA766
1OAh4d4e
=lU73
-----END PGP SIGNATURE-----

--=_MailMate_B892BD91-F09C-41A3-BD38-7B4151D9DA85_=--
