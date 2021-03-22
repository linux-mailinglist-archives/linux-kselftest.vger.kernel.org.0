Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB07344B58
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCVQaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 12:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhCVQ3x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 12:29:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BDAC061574;
        Mon, 22 Mar 2021 09:29:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so20048616edu.10;
        Mon, 22 Mar 2021 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yQvc43S8r83HTfxyOEbHMJvrQICL6Aq5HxThzdm6Ks=;
        b=a2GjEUZ1xP95PzLsG5fmHkO4GpwMpY7HUMMd4ayLoTo9cG/yg09LhITO4tawX3Gh2O
         S7N+ryWZy5GouSEmtD1mb8SThKNuqs8Z9yN3ngdtTwDlYUEwij8RGRgLq1b5TWRGEUd1
         lpEatp3TPzJo9OY97sCLpWhy9nfDF53L/h2iUXWniqZhnx142PstGYIRivRSbYwGo8Kg
         r9rWKcxnIt5xc3nKSVK8Z7oVtV74FsmAfOQ+zP3tJthYvxIRZt7w6HZ5+SZiVyVUS3XS
         fhbD029+04jfjdSQ9ATm5PtDSDdmIvSM8qmjNX3LIHLyZKFk8FWZuN6z7jV3s0P8r+kv
         T80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yQvc43S8r83HTfxyOEbHMJvrQICL6Aq5HxThzdm6Ks=;
        b=a56FoD21xO2pcrsouJlrk53frtqZGuW16YhpuNXRMaYmh2f+qUE66q5XnB7MHokMFx
         HuMU2tmxNldtqO1STsv9GPCrdpRuMeghKPerzhTdMVmzTd427fKJufJD8uehRS5gRDz3
         XpRWe/5hYVRFoNPDQehkhigi3h3LRcbne273jZIN9gYaiVIbZYjZAhAsOLtec+anXyQ1
         wT10dS754di2HmkSB1L/jj0IK7FC9LkaPa2IWWpC0BEulzax0fw3uZoLap3/ijuYyt5v
         DBp5BiDmib3oItHwb/a7/a5qi36kHXi3HzD3+6HjCK83UcUSOqJ/E8nrCVRtCda0mHkh
         xaoA==
X-Gm-Message-State: AOAM531MkV2kFgD71d2wO7ZYKH14dDLziuV5kVyf8+qpjiBEPlu9ugmt
        bA5vd/B3tkeb/VDegmE1Jfyk76G6MjHvcXj8Xwf2fK2h
X-Google-Smtp-Source: ABdhPJw/98e78zuT8+5qNEOuBX8v/LXRegZluDS1c2KWIdAv/JnGkF+H8KcV3lYGkdIQsLlPNh9FOV8aUahW5xm10/M=
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr363560edd.313.1616430590270;
 Mon, 22 Mar 2021 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210319005219.13595-1-zi.yan@sent.com> <CAHbLzkrys2K0A9uae+P5WqxfAMRCzurp9M-Rc3459808GAh_yg@mail.gmail.com>
 <176A4DF5-B5B9-47E2-9B9D-CD82989AC466@nvidia.com>
In-Reply-To: <176A4DF5-B5B9-47E2-9B9D-CD82989AC466@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 Mar 2021 09:29:38 -0700
Message-ID: <CAHbLzkrnfC8xcXhbgFpN4azZm5zEr0WO_JaBR-OTMsOT4QC4JA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: huge_memory: a new debugfs interface for
 splitting THP tests.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Mika Penttila <mika.penttila@nextfour.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 21, 2021 at 7:11 PM Zi Yan <ziy@nvidia.com> wrote:
>
> On 19 Mar 2021, at 19:37, Yang Shi wrote:
>
> > On Thu, Mar 18, 2021 at 5:52 PM Zi Yan <zi.yan@sent.com> wrote:
> >>
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> We did not have a direct user interface of splitting the compound page
> >> backing a THP and there is no need unless we want to expose the THP
> >> implementation details to users. Make <debugfs>/split_huge_pages accept
> >> a new command to do that.
> >>
> >> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> >> <debugfs>/split_huge_pages, THPs within the given virtual address range
> >> from the process with the given pid are split. It is used to test
> >> split_huge_page function. In addition, a selftest program is added to
> >> tools/testing/selftests/vm to utilize the interface by splitting
> >> PMD THPs and PTE-mapped THPs.
> >>
> >> This does not change the old behavior, i.e., writing 1 to the interface
> >> to split all THPs in the system.
> >>
> >> Changelog:
> >>
> >> From v5:
> >> 1. Skipped special VMAs and other fixes. (suggested by Yang Shi)
> >
> > Looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>
> >
> > Some nits below:
> >
> >>
> >> From v4:
> >> 1. Fixed the error code return issue, spotted by kernel test robot
> >>    <lkp@intel.com>.
> >>
> >> From v3:
> >> 1. Factored out split huge pages in the given pid code to a separate
> >>    function.
> >> 2. Added the missing put_page for not split pages.
> >> 3. pr_debug -> pr_info, make reading results simpler.
> >>
> >> From v2:
> >> 1. Reused existing <debugfs>/split_huge_pages interface. (suggested by
> >>    Yang Shi)
> >>
> >> From v1:
> >> 1. Removed unnecessary calling to vma_migratable, spotted by kernel test
> >>    robot <lkp@intel.com>.
> >> 2. Dropped the use of find_mm_struct and code it directly, since there
> >>    is no need for the permission check in that function and the function
> >>    is only available when migration is on.
> >> 3. Added some comments in the selftest program to clarify how PTE-mapped
> >>    THPs are formed.
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >>  mm/huge_memory.c                              | 143 +++++++-
> >>  tools/testing/selftests/vm/.gitignore         |   1 +
> >>  tools/testing/selftests/vm/Makefile           |   1 +
> >>  .../selftests/vm/split_huge_page_test.c       | 318 ++++++++++++++++++
> >>  4 files changed, 456 insertions(+), 7 deletions(-)
> >>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index bff92dea5ab3..9bf9bc489228 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -7,6 +7,7 @@
> >>
> >>  #include <linux/mm.h>
> >>  #include <linux/sched.h>
> >> +#include <linux/sched/mm.h>
> >>  #include <linux/sched/coredump.h>
> >>  #include <linux/sched/numa_balancing.h>
> >>  #include <linux/highmem.h>
> >> @@ -2922,16 +2923,14 @@ static struct shrinker deferred_split_shrinker = {
> >>  };
> >>
> >>  #ifdef CONFIG_DEBUG_FS
> >> -static int split_huge_pages_set(void *data, u64 val)
> >> +static void split_huge_pages_all(void)
> >>  {
> >>         struct zone *zone;
> >>         struct page *page;
> >>         unsigned long pfn, max_zone_pfn;
> >>         unsigned long total = 0, split = 0;
> >>
> >> -       if (val != 1)
> >> -               return -EINVAL;
> >> -
> >> +       pr_info("Split all THPs\n");
> >>         for_each_populated_zone(zone) {
> >>                 max_zone_pfn = zone_end_pfn(zone);
> >>                 for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
> >> @@ -2959,11 +2958,141 @@ static int split_huge_pages_set(void *data, u64 val)
> >>         }
> >>
> >>         pr_info("%lu of %lu THP split\n", split, total);
> >> +}
> >>
> >> -       return 0;
> >> +static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> >> +                               unsigned long vaddr_end)
> >> +{
> >> +       int ret = 0;
> >> +       struct task_struct *task;
> >> +       struct mm_struct *mm;
> >> +       unsigned long total = 0, split = 0;
> >> +       unsigned long addr;
> >> +
> >> +       vaddr_start &= PAGE_MASK;
> >> +       vaddr_end &= PAGE_MASK;
> >> +
> >> +       /* Find the task_struct from pid */
> >> +       rcu_read_lock();
> >> +       task = find_task_by_vpid(pid);
> >> +       if (!task) {
> >> +               rcu_read_unlock();
> >> +               ret = -ESRCH;
> >> +               goto out;
> >> +       }
> >> +       get_task_struct(task);
> >> +       rcu_read_unlock();
> >> +
> >> +       /* Find the mm_struct */
> >> +       mm = get_task_mm(task);
> >> +       put_task_struct(task);
> >> +
> >> +       if (!mm) {
> >> +               ret = -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       pr_info("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
> >> +                pid, vaddr_start, vaddr_end);
> >> +
> >> +       mmap_read_lock(mm);
> >> +       /*
> >> +        * always increase addr by PAGE_SIZE, since we could have a PTE page
> >> +        * table filled with PTE-mapped THPs, each of which is distinct.
> >> +        */
> >> +       for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
> >> +               struct vm_area_struct *vma = find_vma(mm, addr);
> >> +               unsigned int follflags;
> >> +               struct page *page;
> >> +
> >> +               if (!vma || addr < vma->vm_start)
> >> +                       break;
> >> +
> >> +               /* skip special VMA and hugetlb VMA */
> >> +               if (vma_is_special_huge(vma) || is_vm_hugetlb_page(vma)) {
> >
> > VM_IO vma should be skipped as well. And you may extract this into a helper?
>
> Sure. Any name suggestion? :)

How's about not_suitable_for_split() or suitable_for_split()?

>
>
> >> +                       addr = vma->vm_end;
> >> +                       continue;
> >> +               }
> >> +
> >> +               /* FOLL_DUMP to ignore special (like zero) pages */
> >> +               follflags = FOLL_GET | FOLL_DUMP;
> >> +               page = follow_page(vma, addr, follflags);
> >> +
> >> +               if (IS_ERR(page))
> >> +                       continue;
> >> +               if (!page)
> >> +                       continue;
> >> +
> >> +               if (!is_transparent_hugepage(page))
> >> +                       goto next;
> >> +
> >> +               total++;
> >> +               if (!can_split_huge_page(compound_head(page), NULL))
> >> +                       goto next;
> >> +
> >> +               if (!trylock_page(page))
> >> +                       goto next;
> >> +
> >> +               if (!split_huge_page(page))
> >> +                       split++;
> >> +
> >> +               unlock_page(page);
> >> +next:
> >> +               put_page(page);
> >> +       }
> >> +       mmap_read_unlock(mm);
> >> +       mmput(mm);
> >> +
> >> +       pr_info("%lu of %lu THP split\n", split, total);
> >> +
> >> +out:
> >> +       return ret;
> >>  }
> >> -DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
> >> -               "%llu\n");
> >> +
> >> +static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
> >> +                               size_t count, loff_t *ppops)
> >> +{
> >> +       static DEFINE_MUTEX(split_debug_mutex);
> >> +       ssize_t ret;
> >> +       char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
> >
> > Why not move buf len macro in the following patch to this patch? Then
> > you don't have to change the length again.
>
> Sure.
>
> Thanks for the comments.
>
> --
> Best Regards,
> Yan Zi
