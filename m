Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635292B4A48
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgKPQGn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 11:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbgKPQGn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 11:06:43 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF24C0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 08:06:41 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f11so25879381lfs.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eBI49tM4v1Bt7eLVCOqa1vopmhcAU6RnnYuW/UNt060=;
        b=IrjIDB8vowk449uWh6E/266sIEKw0dGMFTK3piPEZkPqnHTniBV0eBaq9c6z2XL6Nk
         ZLSlikntZzep/y5apbq+poU3quWwAfsH3NweRvq2j5ZJI1eHEUjBBX3IiVR3t59rUk1m
         OH8/djLdprekzHaJuAJrKJl9nGLb/vRe5JhQsyvTNecPFw4MbMPGduqnN15IllZcTplh
         y83olIpWE2P/Alt1nVPW0RSW2CfEmqcdbyI1a54jwWxpfBMdbk+nU8In5xPBSTgogc6q
         cR47irLghuajqvSQKppLEQPLzl5Weo4atf0icl41W45PwtGtxyqTMUCHHhIb6N/fAHSC
         U9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBI49tM4v1Bt7eLVCOqa1vopmhcAU6RnnYuW/UNt060=;
        b=bgPSdXf1j92AqhvovQMJJ/GP9aHDgzJN0Z+BuG8q+uYFufbuUdkVpBLOvjF1Jx/0GH
         2HguSqrRBL9BzbRwXiRdowsg8ECTusc8GoPNpl4bGt0tPk+Lvan//G3xAaCoZV/6oD+0
         Ucmus861O6a/Znuuansf/G5L5HiTJ2yGFxchOiGm/ba4lTo3rUVTe8/E24oZBbWARaXZ
         23ZxsaPUfOdzgz8n9nwn3gqCRPK1+xHaAS6MOo5gK1OhB0/tAxFbrlwGneC2TJKnJxSy
         bUZgUC9cP24pTb8gEETr4eczYzoyHWHA6s9qo+0MCFCfw9PpCHSwJpolDH3xZr5xz49a
         fyEg==
X-Gm-Message-State: AOAM530+utr0C0kMTYKDD/qE9R1EUJtWNxo0v69kvZk3QOp71PtDBKwE
        r81ez/eF4ZZsCJvK9Ja38A50IQ==
X-Google-Smtp-Source: ABdhPJyf85Zc/HOeEe2M/da3ODjNWj/3qMNCyaJUeKRlcFp6y/ksWYXK9VX8UMBURe0K2OgHkiNQPQ==
X-Received: by 2002:a19:5f0b:: with SMTP id t11mr39565lfb.326.1605542799939;
        Mon, 16 Nov 2020 08:06:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o3sm2775331lfo.217.2020.11.16.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:06:39 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 161D8100F5E; Mon, 16 Nov 2020 19:06:38 +0300 (+03)
Date:   Mon, 16 Nov 2020 19:06:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 1/6] mm: huge_memory: add new debugfs interface to
 trigger split huge page on any page range.
Message-ID: <20201116160638.po3euk3agkt4ragx@box>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111204008.21332-2-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 03:40:03PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Huge pages in the process with the given pid and virtual address range
> are split. It is used to test split huge page function. In addition,
> a testing program is added to tools/testing/selftests/vm to utilize the
> interface by splitting PMD THPs.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c                              |  98 +++++++++++
>  mm/internal.h                                 |   1 +
>  mm/migrate.c                                  |   2 +-
>  tools/testing/selftests/vm/Makefile           |   1 +
>  .../selftests/vm/split_huge_page_test.c       | 161 ++++++++++++++++++
>  5 files changed, 262 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 207ebca8c654..c4fead5ead31 100644
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
> @@ -2935,10 +2936,107 @@ static int split_huge_pages_set(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
>  		"%llu\n");
>  
> +static ssize_t split_huge_pages_in_range_pid_write(struct file *file,
> +		const char __user *buf, size_t count, loff_t *ppops)
> +{
> +	static DEFINE_MUTEX(mutex);
> +	ssize_t ret;
> +	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
> +	int pid;
> +	unsigned long vaddr_start, vaddr_end, addr;
> +	nodemask_t task_nodes;
> +	struct mm_struct *mm;
> +
> +	ret = mutex_lock_interruptible(&mutex);
> +	if (ret)
> +		return ret;
> +
> +	ret = -EFAULT;
> +
> +	memset(input_buf, 0, 80);
> +	if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
> +		goto out;
> +
> +	input_buf[80] = '\0';

Hm. Out-of-buffer access?

> +	ret = sscanf(input_buf, "%d,%lx,%lx", &pid, &vaddr_start, &vaddr_end);

Why hex without 0x prefix?

> +	if (ret != 3) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	vaddr_start &= PAGE_MASK;
> +	vaddr_end &= PAGE_MASK;
> +
> +	ret = strlen(input_buf);
> +	pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx]\n",
> +		 pid, vaddr_start, vaddr_end);
> +
> +	mm = find_mm_struct(pid, &task_nodes);

I don't follow why you need nodemask.

> +	if (IS_ERR(mm)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	mmap_read_lock(mm);
> +	for (addr = vaddr_start; addr < vaddr_end;) {
> +		struct vm_area_struct *vma = find_vma(mm, addr);
> +		unsigned int follflags;
> +		struct page *page;
> +
> +		if (!vma || addr < vma->vm_start || !vma_migratable(vma))
> +			break;
> +
> +		/* FOLL_DUMP to ignore special (like zero) pages */
> +		follflags = FOLL_GET | FOLL_DUMP;
> +		page = follow_page(vma, addr, follflags);
> +
> +		if (IS_ERR(page))
> +			break;
> +		if (!page)
> +			break;
> +
> +		if (!is_transparent_hugepage(page))
> +			goto next;
> +
> +		if (!can_split_huge_page(page, NULL))
> +			goto next;
> +
> +		if (!trylock_page(page))
> +			goto next;
> +
> +		addr += page_size(page) - PAGE_SIZE;

Who said it was mapped as huge? mremap() allows to construct an PTE page
table that filled with PTE-mapped THPs, each of them distinct.

> +
> +		/* reset addr if split fails */
> +		if (split_huge_page(page))
> +			addr -= (page_size(page) - PAGE_SIZE);
> +
> +		unlock_page(page);
> +next:
> +		/* next page */
> +		addr += page_size(page);

Isn't it the second time if split_huge_page() succeed.

> +		put_page(page);
> +	}
> +	mmap_read_unlock(mm);
> +
> +
> +	mmput(mm);
> +out:
> +	mutex_unlock(&mutex);
> +	return ret;
> +
> +}
> +
> +static const struct file_operations split_huge_pages_in_range_pid_fops = {
> +	.owner	 = THIS_MODULE,
> +	.write	 = split_huge_pages_in_range_pid_write,
> +	.llseek  = no_llseek,
> +};
> +
>  static int __init split_huge_pages_debugfs(void)
>  {
>  	debugfs_create_file("split_huge_pages", 0200, NULL, NULL,
>  			    &split_huge_pages_fops);
> +	debugfs_create_file("split_huge_pages_in_range_pid", 0200, NULL, NULL,
> +			    &split_huge_pages_in_range_pid_fops);
>  	return 0;
>  }
>  late_initcall(split_huge_pages_debugfs);
> diff --git a/mm/internal.h b/mm/internal.h
> index 3ea43642b99d..fd841a38830f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -624,4 +624,5 @@ struct migration_target_control {
>  
>  bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
>  void page_cache_free_page(struct address_space *mapping, struct page *page);
> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes);
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a50bbb0e029b..e35654d1087d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1851,7 +1851,7 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
>  	return nr_pages ? -EFAULT : 0;
>  }
>  
> -static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 62fb15f286ee..d9ead0cdd3e9 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -42,6 +42,7 @@ TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
> +TEST_GEN_FILES += split_huge_page_test
>  
>  ifeq ($(ARCH),x86_64)
>  CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> new file mode 100644
> index 000000000000..c8a32ae9e13a
> --- /dev/null
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include "numa.h"
> +#include <unistd.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <sys/time.h>
> +#include <sys/wait.h>
> +#include <malloc.h>
> +#include <stdbool.h>
> +
> +#define PAGE_4KB (4096UL)
> +#define PAGE_2MB (512UL*PAGE_4KB)
> +#define PAGE_1GB (512UL*PAGE_2MB)
> +
> +#define PRESENT_MASK (1UL<<63)
> +#define SWAPPED_MASK (1UL<<62)
> +#define PAGE_TYPE_MASK (1UL<<61)
> +#define PFN_MASK     ((1UL<<55)-1)
> +
> +#define KPF_THP      (1UL<<22)
> +#define KPF_PUD_THP      (1UL<<27)
> +
> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_pid"
> +#define SMAP_PATH "/proc/self/smaps"
> +#define INPUT_MAX 80
> +
> +static int write_file(const char *path, const char *buf, size_t buflen)
> +{
> +	int fd;
> +	ssize_t numwritten;
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd == -1)
> +		return 0;
> +
> +	numwritten = write(fd, buf, buflen - 1);
> +	close(fd);
> +	if (numwritten < 1)
> +		return 0;
> +
> +	return (unsigned int) numwritten;
> +}
> +
> +static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vaddr_end)
> +{
> +	char input[INPUT_MAX];
> +	int ret;
> +
> +	ret = snprintf(input, INPUT_MAX, "%d,%lx,%lx", pid, vaddr_start,
> +			vaddr_end);
> +	if (ret >= INPUT_MAX) {
> +		printf("%s: Debugfs input is too long\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
> +		perror(SPLIT_DEBUGFS);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +#define MAX_LINE_LENGTH 500
> +
> +static bool check_for_pattern(FILE *fp, char *pattern, char *buf)
> +{
> +	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
> +		if (!strncmp(buf, pattern, strlen(pattern)))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static uint64_t check_huge(void *addr)
> +{
> +	uint64_t thp = 0;
> +	int ret;
> +	FILE *fp;
> +	char buffer[MAX_LINE_LENGTH];
> +	char addr_pattern[MAX_LINE_LENGTH];
> +
> +	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
> +		       (unsigned long) addr);
> +	if (ret >= MAX_LINE_LENGTH) {
> +		printf("%s: Pattern is too long\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +
> +	fp = fopen(SMAP_PATH, "r");
> +	if (!fp) {
> +		printf("%s: Failed to open file %s\n", __func__, SMAP_PATH);
> +		exit(EXIT_FAILURE);
> +	}
> +	if (!check_for_pattern(fp, addr_pattern, buffer))
> +		goto err_out;
> +
> +	/*
> +	 * Fetch the AnonHugePages: in the same block and check the number of
> +	 * hugepages.
> +	 */
> +	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
> +		goto err_out;
> +
> +	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1) {
> +		printf("Reading smap error\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +err_out:
> +	fclose(fp);
> +	return thp;
> +}
> +
> +void split_pmd_thp(void)
> +{
> +	char *one_page;
> +	size_t len = 4 * PAGE_2MB;
> +	uint64_t thp_size;
> +
> +	one_page = memalign(PAGE_1GB, len);
> +
> +	madvise(one_page, len, MADV_HUGEPAGE);
> +
> +	memset(one_page, 1, len);
> +
> +	thp_size = check_huge(one_page);
> +	if (!thp_size) {
> +		printf("No THP is allocatd");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* split all possible huge pages */
> +	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
> +
> +	*one_page = 0;
> +
> +	thp_size = check_huge(one_page);
> +	if (thp_size) {
> +		printf("Still %ld kB AnonHugePages not split\n", thp_size);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	printf("Split huge pages successful\n");
> +	free(one_page);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	split_pmd_thp();
> +
> +	return 0;
> +}
> -- 
> 2.28.0
> 
> 

-- 
 Kirill A. Shutemov
