Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E352342927
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Mar 2021 00:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCSXiQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCSXhn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 19:37:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB66C061760;
        Fri, 19 Mar 2021 16:37:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b9so12264456ejc.11;
        Fri, 19 Mar 2021 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qL8I//q4nfJLBksnS4IPlr1lJ6YTtuJjT/STNUqhfiU=;
        b=D+y6GF2tuTDze6oGqxIQo1x6UEGR/34uEvK5Nn76MoCmjkYch4ZmFHEX+172TUAwVC
         Xb82qYAe9AfwuiJmXqWD2/HYBL9LksnzDGT4lQ35MgcPAqvTVvoXNlSYyXilWn0qk0j/
         Rs0gax0YJTNfqtFsIoy3vrsc3QiDgQIyqcjma3pdcYfDqdpJPGKUyAeFkCyGvDW1Vxeq
         cslYJjpVndyBuNrejPanEXSCePBfkIG1kJG/cmKjvb10bs1oH98mPp2HFZFx6uielOhO
         TPL4q3wgdijqMWkiUJ5214+Nu263TFNrs/42cKXIra4OGB+rSYxG9Wf2pm2Tx9jzn8/J
         Rlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qL8I//q4nfJLBksnS4IPlr1lJ6YTtuJjT/STNUqhfiU=;
        b=PQHbrgz6sslHTbegqdAhoNDUnlYRkZKSJ2tPJJLT1OSJZ+qKgOvN8intuBcTXQCOei
         gFR2rENdi9XsfXTHElufzkAt+129F+edrXysktgrVkTPVFMez4B9GuyTWJrPWWNRenD9
         ViItevs8F3nzUMr4ElWLhz0YBmduF3nvWLOQo+MNEPI/x14OdXTyX7NdmDMWXWKp+vXq
         6LJOVY5UPzl1t6NFtlWxMGq6UaWot8h02vwzmfjRm0+RfsssitwKkmiqRlZA4pE93nz8
         icgIXsz+SmNr2KJH+HyqAkWTxU+tXYGvqd6WfiJsGNNHsLHOGaPbAkCGvZN5uX4IMzzP
         BF/A==
X-Gm-Message-State: AOAM531UXg5ywRVlMcnIlR05VvYfbO+cKWXL1r13Am1XFBGytawvM0aj
        M4gmX7bzjP+j8kIxePJuqhKXkIR7jSASGPeJFAA=
X-Google-Smtp-Source: ABdhPJz/iSiH0ygsZqXlbtWFVxT+ISI5TFPXtnfpUflxZshwfpPJW7s5Xa4iRessYfSDnVpLIDoRW61HJtkkUeE/+g8=
X-Received: by 2002:a17:906:789:: with SMTP id l9mr7065823ejc.161.1616197060686;
 Fri, 19 Mar 2021 16:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210319005219.13595-1-zi.yan@sent.com>
In-Reply-To: <20210319005219.13595-1-zi.yan@sent.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 19 Mar 2021 16:37:28 -0700
Message-ID: <CAHbLzkrys2K0A9uae+P5WqxfAMRCzurp9M-Rc3459808GAh_yg@mail.gmail.com>
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

On Thu, Mar 18, 2021 at 5:52 PM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> We did not have a direct user interface of splitting the compound page
> backing a THP and there is no need unless we want to expose the THP
> implementation details to users. Make <debugfs>/split_huge_pages accept
> a new command to do that.
>
> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> <debugfs>/split_huge_pages, THPs within the given virtual address range
> from the process with the given pid are split. It is used to test
> split_huge_page function. In addition, a selftest program is added to
> tools/testing/selftests/vm to utilize the interface by splitting
> PMD THPs and PTE-mapped THPs.
>
> This does not change the old behavior, i.e., writing 1 to the interface
> to split all THPs in the system.
>
> Changelog:
>
> From v5:
> 1. Skipped special VMAs and other fixes. (suggested by Yang Shi)

Looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

Some nits below:

>
> From v4:
> 1. Fixed the error code return issue, spotted by kernel test robot
>    <lkp@intel.com>.
>
> From v3:
> 1. Factored out split huge pages in the given pid code to a separate
>    function.
> 2. Added the missing put_page for not split pages.
> 3. pr_debug -> pr_info, make reading results simpler.
>
> From v2:
> 1. Reused existing <debugfs>/split_huge_pages interface. (suggested by
>    Yang Shi)
>
> From v1:
> 1. Removed unnecessary calling to vma_migratable, spotted by kernel test
>    robot <lkp@intel.com>.
> 2. Dropped the use of find_mm_struct and code it directly, since there
>    is no need for the permission check in that function and the function
>    is only available when migration is on.
> 3. Added some comments in the selftest program to clarify how PTE-mapped
>    THPs are formed.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c                              | 143 +++++++-
>  tools/testing/selftests/vm/.gitignore         |   1 +
>  tools/testing/selftests/vm/Makefile           |   1 +
>  .../selftests/vm/split_huge_page_test.c       | 318 ++++++++++++++++++
>  4 files changed, 456 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bff92dea5ab3..9bf9bc489228 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
> +#include <linux/sched/mm.h>
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/highmem.h>
> @@ -2922,16 +2923,14 @@ static struct shrinker deferred_split_shrinker = {
>  };
>
>  #ifdef CONFIG_DEBUG_FS
> -static int split_huge_pages_set(void *data, u64 val)
> +static void split_huge_pages_all(void)
>  {
>         struct zone *zone;
>         struct page *page;
>         unsigned long pfn, max_zone_pfn;
>         unsigned long total = 0, split = 0;
>
> -       if (val != 1)
> -               return -EINVAL;
> -
> +       pr_info("Split all THPs\n");
>         for_each_populated_zone(zone) {
>                 max_zone_pfn = zone_end_pfn(zone);
>                 for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
> @@ -2959,11 +2958,141 @@ static int split_huge_pages_set(void *data, u64 val)
>         }
>
>         pr_info("%lu of %lu THP split\n", split, total);
> +}
>
> -       return 0;
> +static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> +                               unsigned long vaddr_end)
> +{
> +       int ret = 0;
> +       struct task_struct *task;
> +       struct mm_struct *mm;
> +       unsigned long total = 0, split = 0;
> +       unsigned long addr;
> +
> +       vaddr_start &= PAGE_MASK;
> +       vaddr_end &= PAGE_MASK;
> +
> +       /* Find the task_struct from pid */
> +       rcu_read_lock();
> +       task = find_task_by_vpid(pid);
> +       if (!task) {
> +               rcu_read_unlock();
> +               ret = -ESRCH;
> +               goto out;
> +       }
> +       get_task_struct(task);
> +       rcu_read_unlock();
> +
> +       /* Find the mm_struct */
> +       mm = get_task_mm(task);
> +       put_task_struct(task);
> +
> +       if (!mm) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       pr_info("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
> +                pid, vaddr_start, vaddr_end);
> +
> +       mmap_read_lock(mm);
> +       /*
> +        * always increase addr by PAGE_SIZE, since we could have a PTE page
> +        * table filled with PTE-mapped THPs, each of which is distinct.
> +        */
> +       for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
> +               struct vm_area_struct *vma = find_vma(mm, addr);
> +               unsigned int follflags;
> +               struct page *page;
> +
> +               if (!vma || addr < vma->vm_start)
> +                       break;
> +
> +               /* skip special VMA and hugetlb VMA */
> +               if (vma_is_special_huge(vma) || is_vm_hugetlb_page(vma)) {

VM_IO vma should be skipped as well. And you may extract this into a helper?

> +                       addr = vma->vm_end;
> +                       continue;
> +               }
> +
> +               /* FOLL_DUMP to ignore special (like zero) pages */
> +               follflags = FOLL_GET | FOLL_DUMP;
> +               page = follow_page(vma, addr, follflags);
> +
> +               if (IS_ERR(page))
> +                       continue;
> +               if (!page)
> +                       continue;
> +
> +               if (!is_transparent_hugepage(page))
> +                       goto next;
> +
> +               total++;
> +               if (!can_split_huge_page(compound_head(page), NULL))
> +                       goto next;
> +
> +               if (!trylock_page(page))
> +                       goto next;
> +
> +               if (!split_huge_page(page))
> +                       split++;
> +
> +               unlock_page(page);
> +next:
> +               put_page(page);
> +       }
> +       mmap_read_unlock(mm);
> +       mmput(mm);
> +
> +       pr_info("%lu of %lu THP split\n", split, total);
> +
> +out:
> +       return ret;
>  }
> -DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
> -               "%llu\n");
> +
> +static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
> +                               size_t count, loff_t *ppops)
> +{
> +       static DEFINE_MUTEX(split_debug_mutex);
> +       ssize_t ret;
> +       char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */

Why not move buf len macro in the following patch to this patch? Then
you don't have to change the length again.

> +       int pid;
> +       unsigned long vaddr_start, vaddr_end;
> +
> +       ret = mutex_lock_interruptible(&split_debug_mutex);
> +       if (ret)
> +               return ret;
> +
> +       ret = -EFAULT;
> +
> +       memset(input_buf, 0, 80);
> +       if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
> +               goto out;
> +
> +       input_buf[79] = '\0';
> +       ret = sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_end);
> +       if (ret == 1 && pid == 1) {
> +               split_huge_pages_all();
> +               ret = strlen(input_buf);
> +               goto out;
> +       } else if (ret != 3) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end);
> +       if (!ret)
> +               ret = strlen(input_buf);
> +out:
> +       mutex_unlock(&split_debug_mutex);
> +       return ret;
> +
> +}
> +
> +static const struct file_operations split_huge_pages_fops = {
> +       .owner   = THIS_MODULE,
> +       .write   = split_huge_pages_write,
> +       .llseek  = no_llseek,
> +};
>
>  static int __init split_huge_pages_debugfs(void)
>  {
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 9a35c3f6a557..1f651e85ed60 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -22,3 +22,4 @@ map_fixed_noreplace
>  write_to_hugetlbfs
>  hmm-tests
>  local_config.*
> +split_huge_page_test
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index d42115e4284d..4cbc91d6869f 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -42,6 +42,7 @@ TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
> +TEST_GEN_FILES += split_huge_page_test
>
>  ifeq ($(MACHINE),x86_64)
>  CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> new file mode 100644
> index 000000000000..2c0c18e60c57
> --- /dev/null
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A test of splitting PMD THPs and PTE-mapped THPs from a specified virtual
> + * address range in a process via <debugfs>/split_huge_pages interface.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <inttypes.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <malloc.h>
> +#include <stdbool.h>
> +
> +uint64_t pagesize;
> +unsigned int pageshift;
> +uint64_t pmd_pagesize;
> +
> +#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
> +#define SMAP_PATH "/proc/self/smaps"
> +#define INPUT_MAX 80
> +
> +#define PFN_MASK     ((1UL<<55)-1)
> +#define KPF_THP      (1UL<<22)
> +
> +int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
> +{
> +       uint64_t paddr;
> +       uint64_t page_flags;
> +
> +       if (pagemap_file) {
> +               pread(pagemap_file, &paddr, sizeof(paddr),
> +                       ((long)vaddr >> pageshift) * sizeof(paddr));
> +
> +               if (kpageflags_file) {
> +                       pread(kpageflags_file, &page_flags, sizeof(page_flags),
> +                               (paddr & PFN_MASK) * sizeof(page_flags));
> +
> +                       return !!(page_flags & KPF_THP);
> +               }
> +       }
> +       return 0;
> +}
> +
> +
> +static uint64_t read_pmd_pagesize(void)
> +{
> +       int fd;
> +       char buf[20];
> +       ssize_t num_read;
> +
> +       fd = open(PMD_SIZE_PATH, O_RDONLY);
> +       if (fd == -1) {
> +               perror("Open hpage_pmd_size failed");
> +               exit(EXIT_FAILURE);
> +       }
> +       num_read = read(fd, buf, 19);
> +       if (num_read < 1) {
> +               close(fd);
> +               perror("Read hpage_pmd_size failed");
> +               exit(EXIT_FAILURE);
> +       }
> +       buf[num_read] = '\0';
> +       close(fd);
> +
> +       return strtoul(buf, NULL, 10);
> +}
> +
> +static int write_file(const char *path, const char *buf, size_t buflen)
> +{
> +       int fd;
> +       ssize_t numwritten;
> +
> +       fd = open(path, O_WRONLY);
> +       if (fd == -1)
> +               return 0;
> +
> +       numwritten = write(fd, buf, buflen - 1);
> +       close(fd);
> +       if (numwritten < 1)
> +               return 0;
> +
> +       return (unsigned int) numwritten;
> +}
> +
> +static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vaddr_end)
> +{
> +       char input[INPUT_MAX];
> +       int ret;
> +
> +       ret = snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_start,
> +                       vaddr_end);
> +       if (ret >= INPUT_MAX) {
> +               printf("%s: Debugfs input is too long\n", __func__);
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
> +               perror(SPLIT_DEBUGFS);
> +               exit(EXIT_FAILURE);
> +       }
> +}
> +
> +#define MAX_LINE_LENGTH 500
> +
> +static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
> +{
> +       while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
> +               if (!strncmp(buf, pattern, strlen(pattern)))
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +static uint64_t check_huge(void *addr)
> +{
> +       uint64_t thp = 0;
> +       int ret;
> +       FILE *fp;
> +       char buffer[MAX_LINE_LENGTH];
> +       char addr_pattern[MAX_LINE_LENGTH];
> +
> +       ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
> +                      (unsigned long) addr);
> +       if (ret >= MAX_LINE_LENGTH) {
> +               printf("%s: Pattern is too long\n", __func__);
> +               exit(EXIT_FAILURE);
> +       }
> +
> +
> +       fp = fopen(SMAP_PATH, "r");
> +       if (!fp) {
> +               printf("%s: Failed to open file %s\n", __func__, SMAP_PATH);
> +               exit(EXIT_FAILURE);
> +       }
> +       if (!check_for_pattern(fp, addr_pattern, buffer))
> +               goto err_out;
> +
> +       /*
> +        * Fetch the AnonHugePages: in the same block and check the number of
> +        * hugepages.
> +        */
> +       if (!check_for_pattern(fp, "AnonHugePages:", buffer))
> +               goto err_out;
> +
> +       if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1) {
> +               printf("Reading smap error\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +err_out:
> +       fclose(fp);
> +       return thp;
> +}
> +
> +void split_pmd_thp(void)
> +{
> +       char *one_page;
> +       size_t len = 4 * pmd_pagesize;
> +       uint64_t thp_size;
> +       size_t i;
> +
> +       one_page = memalign(pmd_pagesize, len);
> +
> +       if (!one_page) {
> +               printf("Fail to allocate memory\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       madvise(one_page, len, MADV_HUGEPAGE);
> +
> +       for (i = 0; i < len; i++)
> +               one_page[i] = (char)i;
> +
> +       thp_size = check_huge(one_page);
> +       if (!thp_size) {
> +               printf("No THP is allocated\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* split all THPs */
> +       write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
> +
> +       for (i = 0; i < len; i++)
> +               if (one_page[i] != (char)i) {
> +                       printf("%ld byte corrupted\n", i);
> +                       exit(EXIT_FAILURE);
> +               }
> +
> +
> +       thp_size = check_huge(one_page);
> +       if (thp_size) {
> +               printf("Still %ld kB AnonHugePages not split\n", thp_size);
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       printf("Split huge pages successful\n");
> +       free(one_page);
> +}
> +
> +void split_pte_mapped_thp(void)
> +{
> +       char *one_page, *pte_mapped, *pte_mapped2;
> +       size_t len = 4 * pmd_pagesize;
> +       uint64_t thp_size;
> +       size_t i;
> +       const char *pagemap_template = "/proc/%d/pagemap";
> +       const char *kpageflags_proc = "/proc/kpageflags";
> +       char pagemap_proc[255];
> +       int pagemap_fd;
> +       int kpageflags_fd;
> +
> +       if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0) {
> +               perror("get pagemap proc error");
> +               exit(EXIT_FAILURE);
> +       }
> +       pagemap_fd = open(pagemap_proc, O_RDONLY);
> +
> +       if (pagemap_fd == -1) {
> +               perror("read pagemap:");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       kpageflags_fd = open(kpageflags_proc, O_RDONLY);
> +
> +       if (kpageflags_fd == -1) {
> +               perror("read kpageflags:");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
> +                       MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +
> +       madvise(one_page, len, MADV_HUGEPAGE);
> +
> +       for (i = 0; i < len; i++)
> +               one_page[i] = (char)i;
> +
> +       thp_size = check_huge(one_page);
> +       if (!thp_size) {
> +               printf("No THP is allocated\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* remap the first pagesize of first THP */
> +       pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
> +
> +       /* remap the Nth pagesize of Nth THP */
> +       for (i = 1; i < 4; i++) {
> +               pte_mapped2 = mremap(one_page + pmd_pagesize * i + pagesize * i,
> +                                    pagesize, pagesize,
> +                                    MREMAP_MAYMOVE|MREMAP_FIXED,
> +                                    pte_mapped + pagesize * i);
> +               if (pte_mapped2 == (char *)-1) {
> +                       perror("mremap failed");
> +                       exit(EXIT_FAILURE);
> +               }
> +       }
> +
> +       /* smap does not show THPs after mremap, use kpageflags instead */
> +       thp_size = 0;
> +       for (i = 0; i < pagesize * 4; i++)
> +               if (i % pagesize == 0 &&
> +                   is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
> +                       thp_size++;
> +
> +       if (thp_size != 4) {
> +               printf("Some THPs are missing during mremap\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* split all remapped THPs */
> +       write_debugfs(getpid(), (uint64_t)pte_mapped,
> +                     (uint64_t)pte_mapped + pagesize * 4);
> +
> +       /* smap does not show THPs after mremap, use kpageflags instead */
> +       thp_size = 0;
> +       for (i = 0; i < pagesize * 4; i++) {
> +               if (pte_mapped[i] != (char)i) {
> +                       printf("%ld byte corrupted\n", i);
> +                       exit(EXIT_FAILURE);
> +               }
> +               if (i % pagesize == 0 &&
> +                   is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
> +                       thp_size++;
> +       }
> +
> +       if (thp_size) {
> +               printf("Still %ld THPs not split\n", thp_size);
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       printf("Split PTE-mapped huge pages successful\n");
> +       munmap(one_page, len);
> +       close(pagemap_fd);
> +       close(kpageflags_fd);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       if (geteuid() != 0) {
> +               printf("Please run the benchmark as root\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       pagesize = getpagesize();
> +       pageshift = ffs(pagesize) - 1;
> +       pmd_pagesize = read_pmd_pagesize();
> +
> +       split_pmd_thp();
> +       split_pte_mapped_thp();
> +
> +       return 0;
> +}
> --
> 2.30.2
>
