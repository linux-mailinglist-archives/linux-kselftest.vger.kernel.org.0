Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37183331702
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCHTLp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 14:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCHTLZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 14:11:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44913C06174A;
        Mon,  8 Mar 2021 11:11:25 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mm21so22505248ejb.12;
        Mon, 08 Mar 2021 11:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1e6aJf5bhX6+HpFUIlCAAVcviUQUZ1hL0QiPfhp9uNs=;
        b=GaE4JqP6/LO0b4oWXA6db/LNdUnEyM/rBxeyIOhPm1jvHgzA4WgR9uYhiLSFgjrNbg
         KoIWUZLbF1OUL7fAy/CnsAG5VdMShQ44a2HGV/tOHmkGEkBAplqYqPpjq+YzcdqgkgHf
         qR37E3dXVMqOIAd0tBRfFcqFewvu3ONNzxWiPAlCEw93S3C5qfl16bDBPUR5680WeYDQ
         HRog5J7m/mYti1yo7mmRzXvdJfVLSlvb2/zKdrpMYu7aHnYPBhEC/uGlSyz3EEwJchGG
         ckWO97wGu19MPUJVL3Jr8UW6Cesn4G/LSuftZfMaskRsPUwEIwaEx57ZXCBse5S+cEo4
         idMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1e6aJf5bhX6+HpFUIlCAAVcviUQUZ1hL0QiPfhp9uNs=;
        b=tTD0Zp2g6YKoKusew/08sSSo4h3BoiT3UJaY0LTJaisTpFa89NPpAVcfy6rzTExgvP
         Wi5kbNU1NufQSVeXsDexqJeYpwdZF5GL+xZ8wE8Y/MPOjrXdmRTcUGAlpL/IDk2J31zl
         nZuqpKt0Fh+hp0bfCY2+8WfjMI/jU6dCsAKvFzTWY+LE/w/cmXqW1tEUP50kUgpDNRzs
         5Ya1dA3/9ZBSsnwq++YEZSDbG5GItJH3r65FmoTIIA0xxuoPZShyb/DqkLByQ1/YU/7i
         iMHsI+KjsKaRTz9Qq4Q6iz72B1WI57/LzziHImbLAlMG9gwz4kMQK6HWH7mcgAGcExsq
         FHxA==
X-Gm-Message-State: AOAM5322pDays0nG1W7UA514aQlThh2NZe/kuatDxiBDjfx8FcZ3kV80
        Jgkp1tm41NgO5K7Fwzl5PfCfuU5MyWPl1Ba8mf4=
X-Google-Smtp-Source: ABdhPJzO3lTcHdPZhONiZbA8aZXhG/mzIFZztgTpizMB1reEIyO0/O7aYN4gD3S6YqYCRSYkb0E/67gQnRpIzwRvkwk=
X-Received: by 2002:a17:906:3088:: with SMTP id 8mr16264320ejv.499.1615230683931;
 Mon, 08 Mar 2021 11:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20210308152221.28555-1-zi.yan@sent.com> <79458c46-b4b9-332b-77f7-44371502cbeb@redhat.com>
 <AD0AFA61-8DCF-467D-B961-ACFA1D33828C@nvidia.com> <8039e1d7-3442-f133-f4f6-fe934f02122e@redhat.com>
 <9A4EF5F7-1BFF-4F8D-80B8-B559C05635BE@nvidia.com>
In-Reply-To: <9A4EF5F7-1BFF-4F8D-80B8-B559C05635BE@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 11:11:12 -0800
Message-ID: <CAHbLzkofsc4_wEGmMFKwkUrc1pg4Y7iZZ9QKAXggiyg8RuOMqA@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 8, 2021 at 11:01 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 8 Mar 2021, at 13:11, David Hildenbrand wrote:
>
> > On 08.03.21 18:49, Zi Yan wrote:
> >> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
> >>
> >>> On 08.03.21 16:22, Zi Yan wrote:
> >>>> From: Zi Yan <ziy@nvidia.com>
> >>>>
> >>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> >>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with th=
e
> >>>> given pid and virtual address range are split. It is used to test
> >>>> split_huge_page function. In addition, a selftest program is added t=
o
> >>>> tools/testing/selftests/vm to utilize the interface by splitting
> >>>> PMD THPs and PTE-mapped THPs.
> >>>
> >>> Won't something like
> >>>
> >>> 1. MADV_HUGEPAGE
> >>>
> >>> 2. Access memory
> >>>
> >>> 3. MADV_NOHUGEPAGE
> >>>
> >>> Have a similar effect? What's the benefit of this?
> >>
> >> Thanks for checking the patch.
> >>
> >> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
> >> nothing else will be done.
> >
> > Ah, okay - maybe my memory was tricking me. There is some s390x KVM cod=
e that forces MADV_NOHUGEPAGE and force-splits everything.
> >
> > I do wonder, though, if this functionality would be worth a proper user=
 interface (e.g., madvise), though. There might be actual benefit in having=
 this as a !debug interface.
> >
> > I think you aware of the discussion in https://lkml.kernel.org/r/d098c3=
92-273a-36a4-1a29-59731cdf5d3d@google.com
>
> Yes. Thanks for bringing this up.
>
> >
> > If there will be an interface to collapse a THP -- "this memory area is=
 worth extra performance now by collapsing a THP if possible" -- it might a=
lso be helpful to have the opposite functionality -- "this memory area is n=
ot worth a THP, rather use that somehwere else".
> >
> > MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT
>
> I agree that MADV_HUGE_SPLIT would be useful as the opposite of COLLAPSE =
when user might just want PAGESIZE mappings.
> Right now, HUGE_SPLIT is implicit from mapping changes like mprotect or M=
ADV_DONTNEED.

IMHO, it sounds not very useful. MADV_DONTNEED would split PMD for any
partial THP. If the range covers the whole THP, the whole THP is going
to be freed anyway. All other places in kernel which need split THP
have been covered. So I didn't realize any usecase from userspace for
just splitting PMD to PTEs.

>
> My debugfs interface is a little different here, since it splits the comp=
ound pages mapped by the PMD mapping
> (of course the PMD mapping is split too), whereas madvise only splits the=
 PMD. I did not put it in a !debug
> interface because I do not think we want to expose the kernel mechanism (=
the compound page) to the user and
> let them decide when to split the compound page or not. MADV_HUGE_COLLAPS=
E is different, because we need
> to form a compound THP to be able to get PMD mappings. But I am happy to =
change my mind if we find usefulness
> in letting user split compound THPs via !debug interface.

There might be a usecase for splitting THP earlier. MADV_DONTNEED
would put the THP on deferred split queue, then the THPs would get
split when memory pressure is hit. So someone might want to get the
free memory back sooner rather than waiting for reclaimer.

>
>
> >
> > Just a thought.
> >
> >>
> >> Without this, we do not have a way of splitting a specific THP
> >> (the compound page) via any user interface for debugging.
> >> We can only write to <debugfs>/split_huge_pages to split all THPs
> >> in the system, which has an unwanted effect on the whole system
> >> and can overwhelm us with a lot of information. This new debugfs
> >> interface provides a more precise method.
> >>
> >>>>
> >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>> ---
> >>>>    mm/huge_memory.c                              |  98 ++++++
> >>>>    mm/internal.h                                 |   1 +
> >>>>    mm/migrate.c                                  |   2 +-
> >>>>    tools/testing/selftests/vm/.gitignore         |   1 +
> >>>>    tools/testing/selftests/vm/Makefile           |   1 +
> >>>>    .../selftests/vm/split_huge_page_test.c       | 318 +++++++++++++=
+++++
> >>>>    6 files changed, 420 insertions(+), 1 deletion(-)
> >>>>    create mode 100644 tools/testing/selftests/vm/split_huge_page_tes=
t.c
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 395c75111d33..818172f887bf 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -7,6 +7,7 @@
> >>>>     #include <linux/mm.h>
> >>>>    #include <linux/sched.h>
> >>>> +#include <linux/sched/mm.h>
> >>>>    #include <linux/sched/coredump.h>
> >>>>    #include <linux/sched/numa_balancing.h>
> >>>>    #include <linux/highmem.h>
> >>>> @@ -2971,10 +2972,107 @@ static int split_huge_pages_set(void *data,=
 u64 val)
> >>>>    DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_=
pages_set,
> >>>>                    "%llu\n");
> >>>>   +static ssize_t split_huge_pages_in_range_pid_write(struct file *f=
ile,
> >>>> +          const char __user *buf, size_t count, loff_t *ppops)
> >>>> +{
> >>>> +  static DEFINE_MUTEX(mutex);
> >>>> +  ssize_t ret;
> >>>> +  char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
> >>>> +  int pid;
> >>>> +  unsigned long vaddr_start, vaddr_end, addr;
> >>>> +  nodemask_t task_nodes;
> >>>> +  struct mm_struct *mm;
> >>>> +  unsigned long total =3D 0, split =3D 0;
> >>>> +
> >>>> +  ret =3D mutex_lock_interruptible(&mutex);
> >>>> +  if (ret)
> >>>> +          return ret;
> >>>> +
> >>>> +  ret =3D -EFAULT;
> >>>> +
> >>>> +  memset(input_buf, 0, 80);
> >>>> +  if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
> >>>> +          goto out;
> >>>> +
> >>>> +  input_buf[79] =3D '\0';
> >>>> +  ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &=
vaddr_end);
> >>>> +  if (ret !=3D 3) {
> >>>> +          ret =3D -EINVAL;
> >>>> +          goto out;
> >>>> +  }
> >>>> +  vaddr_start &=3D PAGE_MASK;
> >>>> +  vaddr_end &=3D PAGE_MASK;
> >>>> +
> >>>> +  ret =3D strlen(input_buf);
> >>>> +  pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx]\n",
> >>>> +           pid, vaddr_start, vaddr_end);
> >>>> +
> >>>> +  mm =3D find_mm_struct(pid, &task_nodes);
> >>>> +  if (IS_ERR(mm)) {
> >>>> +          ret =3D -EINVAL;
> >>>> +          goto out;
> >>>> +  }
> >>>> +
> >>>> +  mmap_read_lock(mm);
> >>>> +  /*
> >>>> +   * always increase addr by PAGE_SIZE, since we could have a PTE p=
age
> >>>> +   * table filled with PTE-mapped THPs, each of which is distinct.
> >>>> +   */
> >>>> +  for (addr =3D vaddr_start; addr < vaddr_end; addr +=3D PAGE_SIZE)=
 {
> >>>> +          struct vm_area_struct *vma =3D find_vma(mm, addr);
> >>>> +          unsigned int follflags;
> >>>> +          struct page *page;
> >>>> +
> >>>> +          if (!vma || addr < vma->vm_start || !vma_migratable(vma))
> >>>> +                  break;
> >>>> +
> >>>> +          /* FOLL_DUMP to ignore special (like zero) pages */
> >>>> +          follflags =3D FOLL_GET | FOLL_DUMP;
> >>>> +          page =3D follow_page(vma, addr, follflags);
> >>>> +
> >>>> +          if (IS_ERR(page))
> >>>> +                  break;
> >>>> +          if (!page)
> >>>> +                  break;
> >>>> +
> >>>> +          if (!is_transparent_hugepage(page))
> >>>> +                  continue;
> >>>> +
> >>>> +          total++;
> >>>> +          if (!can_split_huge_page(compound_head(page), NULL))
> >>>> +                  continue;
> >>>> +
> >>>> +          if (!trylock_page(page))
> >>>> +                  continue;
> >>>> +
> >>>> +          if (!split_huge_page(page))
> >>>> +                  split++;
> >>>> +
> >>>> +          unlock_page(page);
> >>>> +          put_page(page);
> >>>> +  }
> >>>> +  mmap_read_unlock(mm);
> >>>> +  mmput(mm);
> >>>> +
> >>>> +  pr_debug("%lu of %lu THP split\n", split, total);
> >>>> +out:
> >>>> +  mutex_unlock(&mutex);
> >>>> +  return ret;
> >>>> +
> >>>> +}
> >>>> +
> >>>> +static const struct file_operations split_huge_pages_in_range_pid_f=
ops =3D {
> >>>> +  .owner   =3D THIS_MODULE,
> >>>> +  .write   =3D split_huge_pages_in_range_pid_write,
> >>>> +  .llseek  =3D no_llseek,
> >>>> +};
> >>>> +
> >>>>    static int __init split_huge_pages_debugfs(void)
> >>>>    {
> >>>>            debugfs_create_file("split_huge_pages", 0200, NULL, NULL,
> >>>>                                &split_huge_pages_fops);
> >>>> +  debugfs_create_file("split_huge_pages_in_range_pid", 0200, NULL, =
NULL,
> >>>> +                      &split_huge_pages_in_range_pid_fops);
> >>>>            return 0;
> >>>>    }
> >>>>    late_initcall(split_huge_pages_debugfs);
> >>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>> index 9902648f2206..1659d00100ef 100644
> >>>> --- a/mm/internal.h
> >>>> +++ b/mm/internal.h
> >>>> @@ -623,4 +623,5 @@ struct migration_target_control {
> >>>>            gfp_t gfp_mask;
> >>>>    };
> >>>>   +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes=
);
> >>>>    #endif  /* __MM_INTERNAL_H */
> >>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>> index 62b81d5257aa..ce5f213debb2 100644
> >>>> --- a/mm/migrate.c
> >>>> +++ b/mm/migrate.c
> >>>> @@ -1913,7 +1913,7 @@ static int do_pages_stat(struct mm_struct *mm,=
 unsigned long nr_pages,
> >>>>            return nr_pages ? -EFAULT : 0;
> >>>>    }
> >>>>   -static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *me=
m_nodes)
> >>>> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
> >>>>    {
> >>>>            struct task_struct *task;
> >>>>            struct mm_struct *mm;
> >>>> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/s=
elftests/vm/.gitignore
> >>>> index 9a35c3f6a557..1f651e85ed60 100644
> >>>> --- a/tools/testing/selftests/vm/.gitignore
> >>>> +++ b/tools/testing/selftests/vm/.gitignore
> >>>> @@ -22,3 +22,4 @@ map_fixed_noreplace
> >>>>    write_to_hugetlbfs
> >>>>    hmm-tests
> >>>>    local_config.*
> >>>> +split_huge_page_test
> >>>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/sel=
ftests/vm/Makefile
> >>>> index d42115e4284d..4cbc91d6869f 100644
> >>>> --- a/tools/testing/selftests/vm/Makefile
> >>>> +++ b/tools/testing/selftests/vm/Makefile
> >>>> @@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D on-fault-limit
> >>>>    TEST_GEN_FILES +=3D thuge-gen
> >>>>    TEST_GEN_FILES +=3D transhuge-stress
> >>>>    TEST_GEN_FILES +=3D userfaultfd
> >>>> +TEST_GEN_FILES +=3D split_huge_page_test
> >>>>     ifeq ($(MACHINE),x86_64)
> >>>>    CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/tri=
vial_32bit_program.c -m32)
> >>>> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/too=
ls/testing/selftests/vm/split_huge_page_test.c
> >>>> new file mode 100644
> >>>> index 000000000000..8ea8000fda62
> >>>> --- /dev/null
> >>>> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> >>>> @@ -0,0 +1,318 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * A test of splitting PMD THPs and PTE-mapped THPs from a specifie=
d virtual
> >>>> + * address range in a process via <debugfs>/split_huge_pages_in_ran=
ge_pid
> >>>> + * interface.
> >>>> + */
> >>>> +
> >>>> +#define _GNU_SOURCE
> >>>> +#include <stdio.h>
> >>>> +#include <stdlib.h>
> >>>> +#include "numa.h"
> >>>> +#include <unistd.h>
> >>>> +#include <errno.h>
> >>>> +#include <inttypes.h>
> >>>> +#include <string.h>
> >>>> +#include <sys/types.h>
> >>>> +#include <sys/stat.h>
> >>>> +#include <fcntl.h>
> >>>> +#include <sys/mman.h>
> >>>> +#include <sys/time.h>
> >>>> +#include <sys/wait.h>
> >>>> +#include <malloc.h>
> >>>> +#include <stdbool.h>
> >>>> +
> >>>> +uint64_t pagesize;
> >>>> +unsigned int pageshift;
> >>>> +uint64_t pmd_pagesize;
> >>>> +
> >>>> +#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pm=
d_size"
> >>>> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_=
pid"
> >>>> +#define SMAP_PATH "/proc/self/smaps"
> >>>> +#define INPUT_MAX 80
> >>>> +
> >>>> +#define PFN_MASK     ((1UL<<55)-1)
> >>>> +#define KPF_THP      (1UL<<22)
> >>>> +
> >>>> +int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_=
file)
> >>>> +{
> >>>> +  uint64_t paddr;
> >>>> +  uint64_t page_flags;
> >>>> +
> >>>> +  if (pagemap_file) {
> >>>> +          pread(pagemap_file, &paddr, sizeof(paddr),
> >>>> +                  ((long)vaddr >> pageshift) * sizeof(paddr));
> >>>> +
> >>>> +          if (kpageflags_file) {
> >>>> +                  pread(kpageflags_file, &page_flags, sizeof(page_f=
lags),
> >>>> +                          (paddr & PFN_MASK) * sizeof(page_flags));
> >>>> +
> >>>> +                  return !!(page_flags & KPF_THP);
> >>>> +          }
> >>>> +  }
> >>>> +  return 0;
> >>>> +}
> >>>> +
> >>>> +
> >>>> +static uint64_t read_pmd_pagesize(void)
> >>>> +{
> >>>> +  int fd;
> >>>> +  char buf[20];
> >>>> +  ssize_t num_read;
> >>>> +
> >>>> +  fd =3D open(PMD_SIZE_PATH, O_RDONLY);
> >>>> +  if (fd =3D=3D -1) {
> >>>> +          perror("Open hpage_pmd_size failed");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +  num_read =3D read(fd, buf, 19);
> >>>> +  if (num_read < 1) {
> >>>> +          close(fd);
> >>>> +          perror("Read hpage_pmd_size failed");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +  buf[num_read] =3D '\0';
> >>>> +  close(fd);
> >>>> +
> >>>> +  return strtoul(buf, NULL, 10);
> >>>> +}
> >>>> +
> >>>> +static int write_file(const char *path, const char *buf, size_t buf=
len)
> >>>> +{
> >>>> +  int fd;
> >>>> +  ssize_t numwritten;
> >>>> +
> >>>> +  fd =3D open(path, O_WRONLY);
> >>>> +  if (fd =3D=3D -1)
> >>>> +          return 0;
> >>>> +
> >>>> +  numwritten =3D write(fd, buf, buflen - 1);
> >>>> +  close(fd);
> >>>> +  if (numwritten < 1)
> >>>> +          return 0;
> >>>> +
> >>>> +  return (unsigned int) numwritten;
> >>>> +}
> >>>> +
> >>>> +static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t v=
addr_end)
> >>>> +{
> >>>> +  char input[INPUT_MAX];
> >>>> +  int ret;
> >>>> +
> >>>> +  ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_s=
tart,
> >>>> +                  vaddr_end);
> >>>> +  if (ret >=3D INPUT_MAX) {
> >>>> +          printf("%s: Debugfs input is too long\n", __func__);
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
> >>>> +          perror(SPLIT_DEBUGFS);
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +}
> >>>> +
> >>>> +#define MAX_LINE_LENGTH 500
> >>>> +
> >>>> +static bool check_for_pattern(FILE *fp, const char *pattern, char *=
buf)
> >>>> +{
> >>>> +  while (fgets(buf, MAX_LINE_LENGTH, fp) !=3D NULL) {
> >>>> +          if (!strncmp(buf, pattern, strlen(pattern)))
> >>>> +                  return true;
> >>>> +  }
> >>>> +  return false;
> >>>> +}
> >>>> +
> >>>> +static uint64_t check_huge(void *addr)
> >>>> +{
> >>>> +  uint64_t thp =3D 0;
> >>>> +  int ret;
> >>>> +  FILE *fp;
> >>>> +  char buffer[MAX_LINE_LENGTH];
> >>>> +  char addr_pattern[MAX_LINE_LENGTH];
> >>>> +
> >>>> +  ret =3D snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
> >>>> +                 (unsigned long) addr);
> >>>> +  if (ret >=3D MAX_LINE_LENGTH) {
> >>>> +          printf("%s: Pattern is too long\n", __func__);
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +
> >>>> +  fp =3D fopen(SMAP_PATH, "r");
> >>>> +  if (!fp) {
> >>>> +          printf("%s: Failed to open file %s\n", __func__, SMAP_PAT=
H);
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +  if (!check_for_pattern(fp, addr_pattern, buffer))
> >>>> +          goto err_out;
> >>>> +
> >>>> +  /*
> >>>> +   * Fetch the AnonHugePages: in the same block and check the numbe=
r of
> >>>> +   * hugepages.
> >>>> +   */
> >>>> +  if (!check_for_pattern(fp, "AnonHugePages:", buffer))
> >>>> +          goto err_out;
> >>>> +
> >>>> +  if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) !=3D 1) {
> >>>> +          printf("Reading smap error\n");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +err_out:
> >>>> +  fclose(fp);
> >>>> +  return thp;
> >>>> +}
> >>>> +
> >>>> +void split_pmd_thp(void)
> >>>> +{
> >>>> +  char *one_page;
> >>>> +  size_t len =3D 4 * pmd_pagesize;
> >>>> +  uint64_t thp_size;
> >>>> +  size_t i;
> >>>> +
> >>>> +  one_page =3D memalign(pmd_pagesize, len);
> >>>> +
> >>>> +  madvise(one_page, len, MADV_HUGEPAGE);
> >>>> +
> >>>> +  for (i =3D 0; i < len; i++)
> >>>> +          one_page[i] =3D (char)i;
> >>>> +
> >>>> +  thp_size =3D check_huge(one_page);
> >>>> +  if (!thp_size) {
> >>>> +          printf("No THP is allocatd");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  /* split all possible huge pages */
> >>>> +  write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + =
len);
> >>>> +
> >>>> +  for (i =3D 0; i < len; i++)
> >>>> +          if (one_page[i] !=3D (char)i) {
> >>>> +                  printf("%ld byte corrupted\n", i);
> >>>> +                  exit(EXIT_FAILURE);
> >>>> +          }
> >>>> +
> >>>> +
> >>>> +  thp_size =3D check_huge(one_page);
> >>>> +  if (thp_size) {
> >>>> +          printf("Still %ld kB AnonHugePages not split\n", thp_size=
);
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  printf("Split huge pages successful\n");
> >>>> +  free(one_page);
> >>>> +}
> >>>> +
> >>>> +void split_pte_mapped_thp(void)
> >>>> +{
> >>>> +  char *one_page, *pte_mapped, *pte_mapped2;
> >>>> +  size_t len =3D 4 * pmd_pagesize;
> >>>> +  uint64_t thp_size;
> >>>> +  size_t i;
> >>>> +  const char *pagemap_template =3D "/proc/%d/pagemap";
> >>>> +  const char *kpageflags_proc =3D "/proc/kpageflags";
> >>>> +  char pagemap_proc[255];
> >>>> +  int pagemap_fd;
> >>>> +  int kpageflags_fd;
> >>>> +
> >>>> +  if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0) =
{
> >>>> +          perror("get pagemap proc error");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +  pagemap_fd =3D open(pagemap_proc, O_RDONLY);
> >>>> +
> >>>> +  if (pagemap_fd =3D=3D -1) {
> >>>> +          perror("read pagemap:");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
> >>>> +
> >>>> +  if (kpageflags_fd =3D=3D -1) {
> >>>> +          perror("read kpageflags:");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRIT=
E,
> >>>> +                  MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >>>> +
> >>>> +  madvise(one_page, len, MADV_HUGEPAGE);
> >>>> +
> >>>> +  for (i =3D 0; i < len; i++)
> >>>> +          one_page[i] =3D (char)i;
> >>>> +
> >>>> +  thp_size =3D check_huge(one_page);
> >>>> +  if (!thp_size) {
> >>>> +          printf("No THP is allocatd");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOV=
E);
> >>>> +
> >>>> +  for (i =3D 1; i < 4; i++) {
> >>>> +          pte_mapped2 =3D mremap(one_page + pmd_pagesize * i + page=
size * i,
> >>>> +                               pagesize, pagesize,
> >>>> +                               MREMAP_MAYMOVE|MREMAP_FIXED,
> >>>> +                               pte_mapped + pagesize * i);
> >>>> +          if (pte_mapped2 =3D=3D (char *)-1) {
> >>>> +                  perror("mremap failed");
> >>>> +                  exit(EXIT_FAILURE);
> >>>> +          }
> >>>> +  }
> >>>> +
> >>>> +  /* smap does not show THPs after mremap, use kpageflags instead *=
/
> >>>> +  thp_size =3D 0;
> >>>> +  for (i =3D 0; i < pagesize * 4; i++)
> >>>> +          if (i % pagesize =3D=3D 0 &&
> >>>> +              is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpagefla=
gs_fd))
> >>>> +                  thp_size++;
> >>>> +
> >>>> +  if (thp_size !=3D 4) {
> >>>> +          printf("Some THPs are missing during mremap\n");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  /* split all possible huge pages */
> >>>> +  write_debugfs(getpid(), (uint64_t)pte_mapped,
> >>>> +                (uint64_t)pte_mapped + pagesize * 4);
> >>>> +
> >>>> +  /* smap does not show THPs after mremap, use kpageflags instead *=
/
> >>>> +  thp_size =3D 0;
> >>>> +  for (i =3D 0; i < pagesize * 4; i++) {
> >>>> +          if (pte_mapped[i] !=3D (char)i) {
> >>>> +                  printf("%ld byte corrupted\n", i);
> >>>> +                  exit(EXIT_FAILURE);
> >>>> +          }
> >>>> +          if (i % pagesize =3D=3D 0 &&
> >>>> +              is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpagefla=
gs_fd))
> >>>> +                  thp_size++;
> >>>> +  }
> >>>> +
> >>>> +  if (thp_size) {
> >>>> +          printf("Still %ld THPs not split\n", thp_size);
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  printf("Split PTE-mapped huge pages successful\n");
> >>>> +  munmap(one_page, len);
> >>>> +  close(pagemap_fd);
> >>>> +  close(kpageflags_fd);
> >>>> +}
> >>>> +
> >>>> +int main(int argc, char **argv)
> >>>> +{
> >>>> +  if (geteuid() !=3D 0) {
> >>>> +          printf("Please run the benchmark as root\n");
> >>>> +          exit(EXIT_FAILURE);
> >>>> +  }
> >>>> +
> >>>> +  pagesize =3D getpagesize();
> >>>> +  pageshift =3D ffs(pagesize) - 1;
> >>>> +  pmd_pagesize =3D read_pmd_pagesize();
> >>>> +
> >>>> +  split_pmd_thp();
> >>>> +  split_pte_mapped_thp();
> >>>> +
> >>>> +  return 0;
> >>>> +}
> >>>>
> >>>
> >>>
> >>> --
> >>> Thanks,
> >>>
> >>> David / dhildenb
> >>
> >>
> >> =E2=80=94
> >> Best Regards,
> >> Yan Zi
> >>
> >
> >
> > --
> > Thanks,
> >
> > David / dhildenb
>
>
> =E2=80=94
> Best Regards,
> Yan Zi
