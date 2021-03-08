Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2268E331337
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCHQSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 11:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhCHQRy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 11:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615220273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAKERpCHLMTHR/EN6LW8zp8SnXwV96ghX0fbXSQr+TM=;
        b=Yf0gMFmr35IdZHsKsHh0+R0b59Arh2hsUA5e9T7YdIfCWwGC8rRHt9o2GUyqY+E65Ll8rN
        Bdbbg8oXkpF3NumnbhFPWFXrVoW3oghclPSHXHlIuZUJ3vIJ2/OmCeoKT9wkUp6xv3DbcL
        kQ+p8t6kgRLZa3oza+TkBS7fc00MCu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-a2VnhaT7PxWG5bSKUSLfPA-1; Mon, 08 Mar 2021 11:17:50 -0500
X-MC-Unique: a2VnhaT7PxWG5bSKUSLfPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0762C817468;
        Mon,  8 Mar 2021 16:17:49 +0000 (UTC)
Received: from [10.36.113.123] (ovpn-113-123.ams2.redhat.com [10.36.113.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B721A101E39C;
        Mon,  8 Mar 2021 16:17:46 +0000 (UTC)
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>
References: <20210308152221.28555-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <79458c46-b4b9-332b-77f7-44371502cbeb@redhat.com>
Date:   Mon, 8 Mar 2021 17:17:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308152221.28555-1-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08.03.21 16:22, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with the
> given pid and virtual address range are split. It is used to test
> split_huge_page function. In addition, a selftest program is added to
> tools/testing/selftests/vm to utilize the interface by splitting
> PMD THPs and PTE-mapped THPs.

Won't something like

1. MADV_HUGEPAGE

2. Access memory

3. MADV_NOHUGEPAGE

Have a similar effect? What's the benefit of this?

> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c                              |  98 ++++++
>   mm/internal.h                                 |   1 +
>   mm/migrate.c                                  |   2 +-
>   tools/testing/selftests/vm/.gitignore         |   1 +
>   tools/testing/selftests/vm/Makefile           |   1 +
>   .../selftests/vm/split_huge_page_test.c       | 318 ++++++++++++++++++
>   6 files changed, 420 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 395c75111d33..818172f887bf 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/mm.h>
>   #include <linux/sched.h>
> +#include <linux/sched/mm.h>
>   #include <linux/sched/coredump.h>
>   #include <linux/sched/numa_balancing.h>
>   #include <linux/highmem.h>
> @@ -2971,10 +2972,107 @@ static int split_huge_pages_set(void *data, u64 val)
>   DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
>   		"%llu\n");
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
> +	unsigned long total = 0, split = 0;
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
> +	input_buf[79] = '\0';
> +	ret = sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_end);
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
> +	if (IS_ERR(mm)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
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
> +			continue;
> +
> +		total++;
> +		if (!can_split_huge_page(compound_head(page), NULL))
> +			continue;
> +
> +		if (!trylock_page(page))
> +			continue;
> +
> +		if (!split_huge_page(page))
> +			split++;
> +
> +		unlock_page(page);
> +		put_page(page);
> +	}
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	pr_debug("%lu of %lu THP split\n", split, total);
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
>   static int __init split_huge_pages_debugfs(void)
>   {
>   	debugfs_create_file("split_huge_pages", 0200, NULL, NULL,
>   			    &split_huge_pages_fops);
> +	debugfs_create_file("split_huge_pages_in_range_pid", 0200, NULL, NULL,
> +			    &split_huge_pages_in_range_pid_fops);
>   	return 0;
>   }
>   late_initcall(split_huge_pages_debugfs);
> diff --git a/mm/internal.h b/mm/internal.h
> index 9902648f2206..1659d00100ef 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -623,4 +623,5 @@ struct migration_target_control {
>   	gfp_t gfp_mask;
>   };
>   
> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes);
>   #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 62b81d5257aa..ce5f213debb2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1913,7 +1913,7 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
>   	return nr_pages ? -EFAULT : 0;
>   }
>   
> -static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>   {
>   	struct task_struct *task;
>   	struct mm_struct *mm;
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 9a35c3f6a557..1f651e85ed60 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -22,3 +22,4 @@ map_fixed_noreplace
>   write_to_hugetlbfs
>   hmm-tests
>   local_config.*
> +split_huge_page_test
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index d42115e4284d..4cbc91d6869f 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -42,6 +42,7 @@ TEST_GEN_FILES += on-fault-limit
>   TEST_GEN_FILES += thuge-gen
>   TEST_GEN_FILES += transhuge-stress
>   TEST_GEN_FILES += userfaultfd
> +TEST_GEN_FILES += split_huge_page_test
>   
>   ifeq ($(MACHINE),x86_64)
>   CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> new file mode 100644
> index 000000000000..8ea8000fda62
> --- /dev/null
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A test of splitting PMD THPs and PTE-mapped THPs from a specified virtual
> + * address range in a process via <debugfs>/split_huge_pages_in_range_pid
> + * interface.
> + */
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
> +uint64_t pagesize;
> +unsigned int pageshift;
> +uint64_t pmd_pagesize;
> +
> +#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_pid"
> +#define SMAP_PATH "/proc/self/smaps"
> +#define INPUT_MAX 80
> +
> +#define PFN_MASK     ((1UL<<55)-1)
> +#define KPF_THP      (1UL<<22)
> +
> +int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
> +{
> +	uint64_t paddr;
> +	uint64_t page_flags;
> +
> +	if (pagemap_file) {
> +		pread(pagemap_file, &paddr, sizeof(paddr),
> +			((long)vaddr >> pageshift) * sizeof(paddr));
> +
> +		if (kpageflags_file) {
> +			pread(kpageflags_file, &page_flags, sizeof(page_flags),
> +				(paddr & PFN_MASK) * sizeof(page_flags));
> +
> +			return !!(page_flags & KPF_THP);
> +		}
> +	}
> +	return 0;
> +}
> +
> +
> +static uint64_t read_pmd_pagesize(void)
> +{
> +	int fd;
> +	char buf[20];
> +	ssize_t num_read;
> +
> +	fd = open(PMD_SIZE_PATH, O_RDONLY);
> +	if (fd == -1) {
> +		perror("Open hpage_pmd_size failed");
> +		exit(EXIT_FAILURE);
> +	}
> +	num_read = read(fd, buf, 19);
> +	if (num_read < 1) {
> +		close(fd);
> +		perror("Read hpage_pmd_size failed");
> +		exit(EXIT_FAILURE);
> +	}
> +	buf[num_read] = '\0';
> +	close(fd);
> +
> +	return strtoul(buf, NULL, 10);
> +}
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
> +	ret = snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_start,
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
> +static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
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
> +	size_t len = 4 * pmd_pagesize;
> +	uint64_t thp_size;
> +	size_t i;
> +
> +	one_page = memalign(pmd_pagesize, len);
> +
> +	madvise(one_page, len, MADV_HUGEPAGE);
> +
> +	for (i = 0; i < len; i++)
> +		one_page[i] = (char)i;
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
> +	for (i = 0; i < len; i++)
> +		if (one_page[i] != (char)i) {
> +			printf("%ld byte corrupted\n", i);
> +			exit(EXIT_FAILURE);
> +		}
> +
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
> +void split_pte_mapped_thp(void)
> +{
> +	char *one_page, *pte_mapped, *pte_mapped2;
> +	size_t len = 4 * pmd_pagesize;
> +	uint64_t thp_size;
> +	size_t i;
> +	const char *pagemap_template = "/proc/%d/pagemap";
> +	const char *kpageflags_proc = "/proc/kpageflags";
> +	char pagemap_proc[255];
> +	int pagemap_fd;
> +	int kpageflags_fd;
> +
> +	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0) {
> +		perror("get pagemap proc error");
> +		exit(EXIT_FAILURE);
> +	}
> +	pagemap_fd = open(pagemap_proc, O_RDONLY);
> +
> +	if (pagemap_fd == -1) {
> +		perror("read pagemap:");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
> +
> +	if (kpageflags_fd == -1) {
> +		perror("read kpageflags:");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +
> +	madvise(one_page, len, MADV_HUGEPAGE);
> +
> +	for (i = 0; i < len; i++)
> +		one_page[i] = (char)i;
> +
> +	thp_size = check_huge(one_page);
> +	if (!thp_size) {
> +		printf("No THP is allocatd");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
> +
> +	for (i = 1; i < 4; i++) {
> +		pte_mapped2 = mremap(one_page + pmd_pagesize * i + pagesize * i,
> +				     pagesize, pagesize,
> +				     MREMAP_MAYMOVE|MREMAP_FIXED,
> +				     pte_mapped + pagesize * i);
> +		if (pte_mapped2 == (char *)-1) {
> +			perror("mremap failed");
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
> +	/* smap does not show THPs after mremap, use kpageflags instead */
> +	thp_size = 0;
> +	for (i = 0; i < pagesize * 4; i++)
> +		if (i % pagesize == 0 &&
> +		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
> +			thp_size++;
> +
> +	if (thp_size != 4) {
> +		printf("Some THPs are missing during mremap\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* split all possible huge pages */
> +	write_debugfs(getpid(), (uint64_t)pte_mapped,
> +		      (uint64_t)pte_mapped + pagesize * 4);
> +
> +	/* smap does not show THPs after mremap, use kpageflags instead */
> +	thp_size = 0;
> +	for (i = 0; i < pagesize * 4; i++) {
> +		if (pte_mapped[i] != (char)i) {
> +			printf("%ld byte corrupted\n", i);
> +			exit(EXIT_FAILURE);
> +		}
> +		if (i % pagesize == 0 &&
> +		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
> +			thp_size++;
> +	}
> +
> +	if (thp_size) {
> +		printf("Still %ld THPs not split\n", thp_size);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	printf("Split PTE-mapped huge pages successful\n");
> +	munmap(one_page, len);
> +	close(pagemap_fd);
> +	close(kpageflags_fd);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (geteuid() != 0) {
> +		printf("Please run the benchmark as root\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	pagesize = getpagesize();
> +	pageshift = ffs(pagesize) - 1;
> +	pmd_pagesize = read_pmd_pagesize();
> +
> +	split_pmd_thp();
> +	split_pte_mapped_thp();
> +
> +	return 0;
> +}
> 


-- 
Thanks,

David / dhildenb

