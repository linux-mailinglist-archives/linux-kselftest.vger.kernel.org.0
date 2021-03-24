Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD903481BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Mar 2021 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhCXTRS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 15:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbhCXTQV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 15:16:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEDBC0613DF
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Mar 2021 12:16:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y5so18095730pfn.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Mar 2021 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5kk7kGcUMLXn9AF+VvHdt3yODemQew7HtAejeNNetfk=;
        b=O+dfjqd8NRvkeQjRaduHrLWpKUlhsIDjfFVfa3f07NKbN9Fhb6X4gvNXGMuLr/xM1P
         ILEaiEkbX5xTjTV3FfaxHNPyTYhNMytEwTthnm925o1Sb3nymsWBO+LrK2HsrgwEK0Ko
         YC6LF41vVRf3CNeZYZDA/bfB4DEJBPyXTeg8pjLW12MjQ9qVT+dzk5AaeqgQ0Ba4jaE1
         tr3jmG5bFOnqAtG5Ierd2WNzf6ECe0jjUC3xqxKaT9SIehiJlngoKdWssY5O6uABLmNr
         hfqNfUAyivKTA08tf0uSlTEbBkIiIRdR/AhwkbRb2tA2xrnUHcJRgfpeAL1/jw7p/kqp
         n/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=5kk7kGcUMLXn9AF+VvHdt3yODemQew7HtAejeNNetfk=;
        b=pbNmQVvkkyR43Oog4XzaFPz62jLrL2s7AVVY5VZTHu0lGKwA7NVc/Ho6n7sgSBlz33
         D/77zkvW7X/k/lL8t1I1A6JVDpo/IiOzyJlbii7IY9nT4+Vvg7Y9keScDrvQiaaLr17D
         EFNw5YlddJVqKMo/YgTpkWDK/OFfe5j6ZzbR0y3lOhszBVfW113NLYv3x1vxelGGV+PB
         6QYTF662eE7oKAThvKtoVyqczF4rXc2PGEQOJKTL02uC9qZSqMVapU/IVp3TcZikxKK2
         INr94BEb0f/3r+3drumEzSdEFbuI6dlUBBCNisyNJamgrdSNwdPacCRjsXQffRzO1CRi
         Irqw==
X-Gm-Message-State: AOAM530+i5QOiihDSrCD7wUdVPhuQp8BS5eKdJGCYrsEASFUAnct2+tn
        yo783mLi21FazG05hQgvu/c9CQ==
X-Google-Smtp-Source: ABdhPJw3Q7OXamkYlVjlFLA9pq76DmQnsdTF+2kQw/CLU+xDab7bZ8DlAnNmwiJo8e4CEupRaYLcAA==
X-Received: by 2002:aa7:86c1:0:b029:203:900:2813 with SMTP id h1-20020aa786c10000b029020309002813mr4399007pfo.35.1616613376801;
        Wed, 24 Mar 2021 12:16:16 -0700 (PDT)
Received: from [2620:15c:17:3:4192:718f:4827:be5] ([2620:15c:17:3:4192:718f:4827:be5])
        by smtp.gmail.com with ESMTPSA id l10sm3143107pfc.125.2021.03.24.12.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:16:15 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:16:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Zi Yan <ziy@nvidia.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Mika Penttila <mika.penttila@nextfour.com>
Subject: Re: [PATCH v6 1/2] mm: huge_memory: a new debugfs interface for
 splitting THP tests.
In-Reply-To: <20210322200547.68587-1-zi.yan@sent.com>
Message-ID: <3ef65bfc-5be6-eba4-f7e8-f5e64a554870@google.com>
References: <20210322200547.68587-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 22 Mar 2021, Zi Yan wrote:

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

I'm curious if this is the only use case or whether you have additional 
use cases or extensions in mind?

Specifically, I'm wondering if you are looking into more appropriately 
dividing the limited number of hugepages available on the system amongst 
the most latency sensitive processes?

The set of hugepages available on the system can be limited by 
fragmentation.  We've found opportunities where latency sensitive 
processes would benefit from memory backed by thp, but they cannot be 
allocated at fault for this reason.  Yet, there are other processes that 
have memory backed by hugepages that may not be benefiting from them.

Could this be useful to split a hugepage for a latency tolerant 
application, migrate the pages elsewhere, and make the now-free hugepage 
available for a latency sensitive application (through something like my 
MADV_COLLAPSE proposal?)

Couple questions inline.

> This does not change the old behavior, i.e., writing 1 to the interface
> to split all THPs in the system.
> 
> Changelog:
> 
> From v5:
> 1. Skipped special VMAs and other fixes. (suggested by Yang Shi)
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
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/huge_memory.c                              | 151 ++++++++-
>  tools/testing/selftests/vm/.gitignore         |   1 +
>  tools/testing/selftests/vm/Makefile           |   1 +
>  .../selftests/vm/split_huge_page_test.c       | 318 ++++++++++++++++++
>  4 files changed, 464 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bff92dea5ab3..b653255a548e 100644
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
>  	struct zone *zone;
>  	struct page *page;
>  	unsigned long pfn, max_zone_pfn;
>  	unsigned long total = 0, split = 0;
>  
> -	if (val != 1)
> -		return -EINVAL;
> -
> +	pr_info("Split all THPs\n");

Is this necessary to print?

>  	for_each_populated_zone(zone) {
>  		max_zone_pfn = zone_end_pfn(zone);
>  		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
> @@ -2959,11 +2958,149 @@ static int split_huge_pages_set(void *data, u64 val)
>  	}
>  
>  	pr_info("%lu of %lu THP split\n", split, total);
> +}
>  
> -	return 0;
> +static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
> +{
> +	return vma_is_special_huge(vma) || (vma->vm_flags & VM_IO) ||
> +		    is_vm_hugetlb_page(vma);
>  }
> -DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
> -		"%llu\n");
> +
> +static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> +				unsigned long vaddr_end)
> +{
> +	int ret = 0;
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	unsigned long total = 0, split = 0;
> +	unsigned long addr;
> +
> +	vaddr_start &= PAGE_MASK;
> +	vaddr_end &= PAGE_MASK;
> +
> +	/* Find the task_struct from pid */
> +	rcu_read_lock();
> +	task = find_task_by_vpid(pid);
> +	if (!task) {
> +		rcu_read_unlock();
> +		ret = -ESRCH;
> +		goto out;
> +	}
> +	get_task_struct(task);
> +	rcu_read_unlock();
> +
> +	/* Find the mm_struct */
> +	mm = get_task_mm(task);
> +	put_task_struct(task);
> +
> +	if (!mm) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	pr_info("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
> +		 pid, vaddr_start, vaddr_end);

Hmm, does this need to be in the kernel log?

> +
> +	mmap_read_lock(mm);
> +	/*
> +	 * always increase addr by PAGE_SIZE, since we could have a PTE page
> +	 * table filled with PTE-mapped THPs, each of which is distinct.
> +	 */
> +	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
> +		struct vm_area_struct *vma = find_vma(mm, addr);
> +		unsigned int follflags;
> +		struct page *page;
> +
> +		if (!vma || addr < vma->vm_start)
> +			break;
> +

Should there be a cond_resched() right here?

> +		/* skip special VMA and hugetlb VMA */
> +		if (vma_not_suitable_for_thp_split(vma)) {
> +			addr = vma->vm_end;
> +			continue;
> +		}
> +
> +		/* FOLL_DUMP to ignore special (like zero) pages */
> +		follflags = FOLL_GET | FOLL_DUMP;
> +		page = follow_page(vma, addr, follflags);
> +
> +		if (IS_ERR(page))
> +			continue;
> +		if (!page)
> +			continue;
> +
> +		if (!is_transparent_hugepage(page))
> +			goto next;
> +
> +		total++;
> +		if (!can_split_huge_page(compound_head(page), NULL))
> +			goto next;
> +
> +		if (!trylock_page(page))
> +			goto next;
> +
> +		if (!split_huge_page(page))
> +			split++;
> +
> +		unlock_page(page);
> +next:
> +		put_page(page);
> +	}
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	pr_info("%lu of %lu THP split\n", split, total);
> +
> +out:
> +	return ret;
> +}
> +
> +#define MAX_INPUT_BUF_SZ 255
> +
> +static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppops)
> +{
> +	static DEFINE_MUTEX(split_debug_mutex);
> +	ssize_t ret;
> +	char input_buf[MAX_INPUT_BUF_SZ]; /* hold pid, start_vaddr, end_vaddr */
> +	int pid;
> +	unsigned long vaddr_start, vaddr_end;
> +
> +	ret = mutex_lock_interruptible(&split_debug_mutex);
> +	if (ret)
> +		return ret;
> +
> +	ret = -EFAULT;
> +
> +	memset(input_buf, 0, MAX_INPUT_BUF_SZ);
> +	if (copy_from_user(input_buf, buf, min_t(size_t, count, MAX_INPUT_BUF_SZ)))
> +		goto out;
> +
> +	input_buf[MAX_INPUT_BUF_SZ - 1] = '\0';
> +	ret = sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_end);
> +	if (ret == 1 && pid == 1) {
> +		split_huge_pages_all();
> +		ret = strlen(input_buf);
> +		goto out;
> +	} else if (ret != 3) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end);
> +	if (!ret)
> +		ret = strlen(input_buf);
> +out:
> +	mutex_unlock(&split_debug_mutex);
> +	return ret;
> +
> +}
> +
> +static const struct file_operations split_huge_pages_fops = {
> +	.owner	 = THIS_MODULE,
> +	.write	 = split_huge_pages_write,
> +	.llseek  = no_llseek,
> +};
>  
>  static int __init split_huge_pages_debugfs(void)
>  {
