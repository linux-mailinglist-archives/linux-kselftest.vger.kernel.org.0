Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CC343690
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 03:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhCVCLm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Mar 2021 22:11:42 -0400
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:58112
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhCVCLm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Mar 2021 22:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8L4hWew0k34dcD9BrX6/ImMwr9v2AWOcOHn+TEoYG08WI6iNO6agzAduwyt3SHe4p61ytNw/y0GN2d5ZQc+FalHER/v91AqR5A2V2ndGQrZEqdbL8YTMqs+ZE48dugI3WIQ7f+MaGRLkGkjJgqh0EusX2y5PqRQrGyBp3PINd/+5hhDECv8rEJR0PQ577jUXGafUB+gir7wp0Ka5J9LAD+PSYlH0pw7+Q5uWFafDrev3rOrrAR5I+z+agsxhPnPPuGzQVkQUDByk0KP1zrlEH/XpkSlcgbJmtOh19UpF8kjRZ3JPD/oc9BDDNTFUu1ZVfrdrvbDLLrQY0e15+oEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJeXlJmGMvJsSevTx9/wr7cb2Hr9XyO1Ua5EwyqOAo=;
 b=mYfCo6NbF1Q9fjNTLNq7Pyq4vCWfSUE3psO/6MJNdcPUTwgmD11UNTBBNBHON293HkBdvOPav3PjcdsEXGzlEmJRuI+d/NrDYEOXiC+OSVZEV2ShOkVIXbn4zgr4B80y6N6IOSjPIQoRzRQgprzDuOCXoCaJ3HUkii/bF0AQGRxp+VNRAuJXeG6D9vp45shTVPaELfBjMwP/C7z6HYHq85qB5oSqZOqr+h2h5mPpXC2i1osNfEqNkCDZOiv3VPzRNNga2MYMQivc0BQEUfasm3bjixqyblPAIFJNWE43B1u8J/6jk/n3g5uMgflLSxtn5vi3HemOzXlyncRtU+uqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJeXlJmGMvJsSevTx9/wr7cb2Hr9XyO1Ua5EwyqOAo=;
 b=rshdd5w8/x8R1A3tEegUyzOH+SnZkoUaeAYo5QYGisZnjMsg6AMfGWyLjs1DhBG0nmURRKdVrgWQY566BDL9jpfMfbc3k7vu7jWx/3QYq9vDNKfrMGo1/toA7B8jcXcFDIPdDGzJEWmIu6madjK4FTj9l7/+EJujaIOKsIR83PtkH37uKDc4vgdx1WB8xhOq5PQuviHawtgWApKHs+u+rLLsEySCfYESA/r336SCIP6ZNdpYxalgQlghB5opwXe1oigOgChSw3tPL5F+avTFySsOmmz1qcdSKRAq1mizCZHLFAH7mMLR5iovOFaen2yJS5+Ki8fLK9C9MPbgA9wehg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Mon, 22 Mar
 2021 02:11:40 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 02:11:39 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mika Penttila" <mika.penttila@nextfour.com>
Subject: Re: [PATCH v5 1/2] mm: huge_memory: a new debugfs interface for
 splitting THP tests.
Date:   Sun, 21 Mar 2021 21:46:00 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <176A4DF5-B5B9-47E2-9B9D-CD82989AC466@nvidia.com>
In-Reply-To: <CAHbLzkrys2K0A9uae+P5WqxfAMRCzurp9M-Rc3459808GAh_yg@mail.gmail.com>
References: <20210319005219.13595-1-zi.yan@sent.com>
 <CAHbLzkrys2K0A9uae+P5WqxfAMRCzurp9M-Rc3459808GAh_yg@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2CBEA0E7-C676-40B1-8BAE-0E87836D1426_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.173.149] (216.228.112.22) by MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Mon, 22 Mar 2021 02:11:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7a90c34-b957-47bf-2215-08d8ecd7d39a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45345A8B290EA1AD5F2F0800C2659@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0duqerrFedpKrwnOJx/joNwYpUkMyi5IOnEVZfjwq06zsAi147kLPpPFR5RlTAktlhyV71T8y/Zni7o2G9bE+CxAlNNM8jyJ9vPNWaI5JHblewZoDPgFfrUGmX9o4BP/JfvMUuv+yS2lB9ULOqe9AEbppCSl5lTUGJ1TOYcyvJWKY0BorTvN0Hn7M6WtBsL3NmoV1zlbp79RPwYVVEFwmN/Qd2ziWIJ7GbKX0QUmUJUtnMTVKHohOCRZfoLcCv4TcwmfK2cX6U19i8+IiYs5jkfUp3lYAmOlcZbIIJZ1uRkZlw9/0jvwJC3FTNLDpqX0yHfGmY7e20FPn0TPR0k1boidiUZV8cmUQYajXKEPNf01FapY9zWlsXIevDbQHQpbbbNwKCVING8tI5vycQ/pFOPks86APNr/8FO4oyfjmxJn+zoyE+Ud4Q0p9vLpGggAVfiB6o1KJm9aVaZv/5g6xHpWkQ94lFh4m5UhFPUyTz9g6staVsvxgXYDXSZ65DQuyv/inutyHkZDhloNoAKL4kt+7RmaurYvTWyB6JUoG3ymfNA1LDi2xR2BjXhYXGsZga8mtr8WGsMmQQiQZ0dLz4Jd+V6OjZBu7q7h4OP7WO8n0nk3SFpTTH8bDvaW7cOnpY5lf+MaVoOqtoN76bOTmkb3SdN+mgsWbx9AwhcidZUt9wGWZ3/V6gdvyBnaXmht2zgaH0Lg1UkmonP1xIcZKOQAP79AoHIzFEcNI2n6WBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(83380400001)(53546011)(956004)(16526019)(4326008)(6666004)(2616005)(26005)(186003)(8676002)(66556008)(66946007)(2906002)(66476007)(86362001)(478600001)(38100700001)(5660300002)(33656002)(235185007)(6486002)(54906003)(8936002)(7416002)(316002)(36756003)(16576012)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Sn5o1ICPxxkg8HmmEdfv3vKoF9ePxDiIy6cu1/uINEao8A8zrjAhXZ53xJU4?=
 =?us-ascii?Q?JEpsXWEl+KWrkjP872c6oA926aR9HQRDUn8SpyPxcw3gmBX8ubtz4zUDlE/7?=
 =?us-ascii?Q?C1Ei/4F7WwzSHAYuNc3bsVyE2Oif/iXV7ACUqNAsbwyWVImedZ68pUnJrCOG?=
 =?us-ascii?Q?flTT0anDfqlwNt/m1YD6GJiKLPXma426ZVrtzjclIuyH/2lOCUh8JoWo1CmZ?=
 =?us-ascii?Q?CSVr6clDNvM1+2Karwfnic4a8H5txG+CQTUdpxuRmjG8KFilnKqcyY1T5jn0?=
 =?us-ascii?Q?MLSQAdX7O10ImgXkgjYPTN43w8RqWI66MdI0sPg0AnnBCQDxrm0DqbR3OEyC?=
 =?us-ascii?Q?nBb1clZkvt4phHmrnpfr1jgBvQYiXRk5BWARIR9leNcM0be8SY/4wdFExHYf?=
 =?us-ascii?Q?Zvm/Xc/4AqAIUAES5mFyoMdNH8dOlDbox5wK9oinSI4+Xo0tW3NcAZo6qPxm?=
 =?us-ascii?Q?DvZ9YHAJygOd4iIv6KPxm7HbfQuJ27DbG49g0nnaxIOVNHCt0zRI0y+f2xcY?=
 =?us-ascii?Q?b0/YJLNIn6IhELwbIBLIRoyCi1KTWh5BNjumDR++M/bEggHIiiVckJtxLg+B?=
 =?us-ascii?Q?SPi8Q8QlfphhziN4yt5cffQ+9gqjez/OkOexzGNEJp2IUWXB3B8jtyTRfnj6?=
 =?us-ascii?Q?qYhG9Wa/m6sZgohzt8ko7l6cuOGv9IJAu3w6jZlS6XTkwtHV1D2usXf6Afxi?=
 =?us-ascii?Q?rxDvm/UQigDELSqRNJqZ79R1d3qRM/KQ1pCaEWSoFtHT81LTq+nHYAi9A6CP?=
 =?us-ascii?Q?MhdCRpDZlA4EcG65QCTZECNxrXWgLJ5LWSHUMZIp4Vr2i20mhmLrrnN7GeJJ?=
 =?us-ascii?Q?pMaAWJ+UIW5YlU/AYprZURPARlmPhCuPfWxL+IEn6s9WuOPTaFOWx37YUU+E?=
 =?us-ascii?Q?SZUZaI5MCVIBV1Qs8KUdfkNPEGUDjsM9A1xdGDlI2VsdvU6dmosresksYzmf?=
 =?us-ascii?Q?UYAQpwy08+mzDfpN4W5kUphTK1Lps9LuNmZzz7QMkYUppHRs1th8swRoExci?=
 =?us-ascii?Q?5+XM3bQkZTLwzx++3ZNoWcYprH8l2UsgJ0p03/w6WSJu6MRNe0VZw/cgVG64?=
 =?us-ascii?Q?exZdt1GrlYxHai7X32+UV7xxlaH8PF5rs7nSC++jI6j93s0IQG1yXNnDgoJl?=
 =?us-ascii?Q?ZQy5RwZCd3hbfA8knqhWVN2svhx4dXvAjVFT7komBQWWV4Zy6HWOyde7mbnS?=
 =?us-ascii?Q?2MUzO/edxsrB2a7wgkoH7tkje1xW7zHSEsLrf44qvM1dSu9Sdfa0O04F22mL?=
 =?us-ascii?Q?h0do2/Y5rCobfFly9TrQbsth5M6sJdT6WjV8TJdRKngBBNuA8xg/SKWzTMQ1?=
 =?us-ascii?Q?/TnTEFTq0cn4HQvN3uvc/Exl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a90c34-b957-47bf-2215-08d8ecd7d39a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 02:11:38.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTzniMYpWNlkMapwrluAjhSoCeCLWPRu+i0l4dT1KW4Z0xqaoF1J5QMs6GMPOcCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_2CBEA0E7-C676-40B1-8BAE-0E87836D1426_=
Content-Type: text/plain

On 19 Mar 2021, at 19:37, Yang Shi wrote:

> On Thu, Mar 18, 2021 at 5:52 PM Zi Yan <zi.yan@sent.com> wrote:
>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> We did not have a direct user interface of splitting the compound page
>> backing a THP and there is no need unless we want to expose the THP
>> implementation details to users. Make <debugfs>/split_huge_pages accept
>> a new command to do that.
>>
>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>> <debugfs>/split_huge_pages, THPs within the given virtual address range
>> from the process with the given pid are split. It is used to test
>> split_huge_page function. In addition, a selftest program is added to
>> tools/testing/selftests/vm to utilize the interface by splitting
>> PMD THPs and PTE-mapped THPs.
>>
>> This does not change the old behavior, i.e., writing 1 to the interface
>> to split all THPs in the system.
>>
>> Changelog:
>>
>> From v5:
>> 1. Skipped special VMAs and other fixes. (suggested by Yang Shi)
>
> Looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>
>
> Some nits below:
>
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
>> 1. Reused existing <debugfs>/split_huge_pages interface. (suggested by
>>    Yang Shi)
>>
>> From v1:
>> 1. Removed unnecessary calling to vma_migratable, spotted by kernel test
>>    robot <lkp@intel.com>.
>> 2. Dropped the use of find_mm_struct and code it directly, since there
>>    is no need for the permission check in that function and the function
>>    is only available when migration is on.
>> 3. Added some comments in the selftest program to clarify how PTE-mapped
>>    THPs are formed.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c                              | 143 +++++++-
>>  tools/testing/selftests/vm/.gitignore         |   1 +
>>  tools/testing/selftests/vm/Makefile           |   1 +
>>  .../selftests/vm/split_huge_page_test.c       | 318 ++++++++++++++++++
>>  4 files changed, 456 insertions(+), 7 deletions(-)
>>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bff92dea5ab3..9bf9bc489228 100644
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
>> @@ -2922,16 +2923,14 @@ static struct shrinker deferred_split_shrinker = {
>>  };
>>
>>  #ifdef CONFIG_DEBUG_FS
>> -static int split_huge_pages_set(void *data, u64 val)
>> +static void split_huge_pages_all(void)
>>  {
>>         struct zone *zone;
>>         struct page *page;
>>         unsigned long pfn, max_zone_pfn;
>>         unsigned long total = 0, split = 0;
>>
>> -       if (val != 1)
>> -               return -EINVAL;
>> -
>> +       pr_info("Split all THPs\n");
>>         for_each_populated_zone(zone) {
>>                 max_zone_pfn = zone_end_pfn(zone);
>>                 for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
>> @@ -2959,11 +2958,141 @@ static int split_huge_pages_set(void *data, u64 val)
>>         }
>>
>>         pr_info("%lu of %lu THP split\n", split, total);
>> +}
>>
>> -       return 0;
>> +static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>> +                               unsigned long vaddr_end)
>> +{
>> +       int ret = 0;
>> +       struct task_struct *task;
>> +       struct mm_struct *mm;
>> +       unsigned long total = 0, split = 0;
>> +       unsigned long addr;
>> +
>> +       vaddr_start &= PAGE_MASK;
>> +       vaddr_end &= PAGE_MASK;
>> +
>> +       /* Find the task_struct from pid */
>> +       rcu_read_lock();
>> +       task = find_task_by_vpid(pid);
>> +       if (!task) {
>> +               rcu_read_unlock();
>> +               ret = -ESRCH;
>> +               goto out;
>> +       }
>> +       get_task_struct(task);
>> +       rcu_read_unlock();
>> +
>> +       /* Find the mm_struct */
>> +       mm = get_task_mm(task);
>> +       put_task_struct(task);
>> +
>> +       if (!mm) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       pr_info("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
>> +                pid, vaddr_start, vaddr_end);
>> +
>> +       mmap_read_lock(mm);
>> +       /*
>> +        * always increase addr by PAGE_SIZE, since we could have a PTE page
>> +        * table filled with PTE-mapped THPs, each of which is distinct.
>> +        */
>> +       for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
>> +               struct vm_area_struct *vma = find_vma(mm, addr);
>> +               unsigned int follflags;
>> +               struct page *page;
>> +
>> +               if (!vma || addr < vma->vm_start)
>> +                       break;
>> +
>> +               /* skip special VMA and hugetlb VMA */
>> +               if (vma_is_special_huge(vma) || is_vm_hugetlb_page(vma)) {
>
> VM_IO vma should be skipped as well. And you may extract this into a helper?

Sure. Any name suggestion? :)


>> +                       addr = vma->vm_end;
>> +                       continue;
>> +               }
>> +
>> +               /* FOLL_DUMP to ignore special (like zero) pages */
>> +               follflags = FOLL_GET | FOLL_DUMP;
>> +               page = follow_page(vma, addr, follflags);
>> +
>> +               if (IS_ERR(page))
>> +                       continue;
>> +               if (!page)
>> +                       continue;
>> +
>> +               if (!is_transparent_hugepage(page))
>> +                       goto next;
>> +
>> +               total++;
>> +               if (!can_split_huge_page(compound_head(page), NULL))
>> +                       goto next;
>> +
>> +               if (!trylock_page(page))
>> +                       goto next;
>> +
>> +               if (!split_huge_page(page))
>> +                       split++;
>> +
>> +               unlock_page(page);
>> +next:
>> +               put_page(page);
>> +       }
>> +       mmap_read_unlock(mm);
>> +       mmput(mm);
>> +
>> +       pr_info("%lu of %lu THP split\n", split, total);
>> +
>> +out:
>> +       return ret;
>>  }
>> -DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
>> -               "%llu\n");
>> +
>> +static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>> +                               size_t count, loff_t *ppops)
>> +{
>> +       static DEFINE_MUTEX(split_debug_mutex);
>> +       ssize_t ret;
>> +       char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
>
> Why not move buf len macro in the following patch to this patch? Then
> you don't have to change the length again.

Sure.

Thanks for the comments.

--
Best Regards,
Yan Zi

--=_MailMate_2CBEA0E7-C676-40B1-8BAE-0E87836D1426_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBX9tkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK5iYP+gKC+HcHQ95kBHvZJcBXN2woUPi74EoithCh
KNTiK8deBB5bgLI2GIhxPn6VACPi5S8lUCnfwQJhQOZ9G/YwTC2fjkL7Dsc/QtOb
mzrr6pvDkGQruEsenXePKZ/IioCkFYwhJ5DHsoj5S3B5ckxI7HoS8pamKg7XsUjC
3FQ9hQuqzCXbIb4GX0qn3CHbdSLvhBH+jxODNurjcNwudSHH6SuuYdiBee3lmOqB
0iOzVOVwu2IUloj+5QQat/BI6RLRIQwYB3LyfDO9wNwiZ1sr/WEDuudfPuRKtWr7
yCdy4DdYrbp9m5+vtGhA3mf+4g+lwFskhzDbtec0iFfqRZEvBqo8CmCpKjcFVA7r
31PW2Oi3ZNu5rw/oqb5NvDuXoHKXCwF/NmbfiGyBcPGfkCRGLnVDz1IBT/JKkp49
5moRD6M/698IQVML3WrFeTHOdGaQ7g98LOQhO5KOmodo1Wh1MHvlgEHn0zSfpB8t
8UqnW2ttrCHM224hmjhdNxQJi32mWzKYzhTUI+y6J3vox1s5p6WHN1FoQPiIbVpG
G6nOxyL4NNV+XdimCrlUXouFc7itvw/s90BIR0klMEvexDUgXd7ii5FWgjVZWjy6
JtnGvrGa6xGBIq+KyOgOH6iaJVt6x/hD8V8ejWaK2CYK9y6x8T3H4ldbnixNHBVD
K7RdTFku
=ZuEt
-----END PGP SIGNATURE-----

--=_MailMate_2CBEA0E7-C676-40B1-8BAE-0E87836D1426_=--
