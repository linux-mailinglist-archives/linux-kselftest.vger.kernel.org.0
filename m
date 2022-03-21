Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BBE4E32D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 23:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiCUWq4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 18:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiCUWqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 18:46:52 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6B32BC1F;
        Mon, 21 Mar 2022 15:25:21 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:23:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647901399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0PoRxyCNZyFj70PP5U+yk5A784SR14yEEvMXF3ao0Hs=;
        b=k3HjKgHPWmG6ejRHhFTB2rDCs3QJDtzExJJx4o6gDhaPINlM2HuiQqqImId7++FRDOEh+R
        c8x8yyqNMrEOZkWzSFnLur9bdU3trTN+uBdC9u1P6K1cBWA5/rNavQAQ3vRlRlQJm/I7et
        74LhXGFharP361v63/BVHyaYt+f6Gk0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Message-ID: <Yjj6z3zYFUIKujHR@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-6-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321142128.2471199-6-zi.yan@sent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 21, 2022 at 10:21:28AM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
> Also add test cases for split_huge_page_to_list_to_order via both
> debugfs, truncating a file, and punching holes in a file.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

> ---
>  mm/huge_memory.c                              |  26 ++-
>  .../selftests/vm/split_huge_page_test.c       | 219 +++++++++++++++---
>  2 files changed, 201 insertions(+), 44 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 76db0092a1e2..7645bb12fcbc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2856,7 +2856,7 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
>  }
>  
>  static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> -				unsigned long vaddr_end)
> +				unsigned long vaddr_end, unsigned int new_order)
>  {
>  	int ret = 0;
>  	struct task_struct *task;
> @@ -2926,7 +2926,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		if (!trylock_page(page))
>  			goto next;
>  
> -		if (!split_huge_page(page))
> +		if (!split_huge_page_to_list_to_order(page, NULL, new_order))
>  			split++;
>  
>  		unlock_page(page);
> @@ -2944,7 +2944,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  }
>  
>  static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
> -				pgoff_t off_end)
> +				pgoff_t off_end, unsigned int new_order)
>  {
>  	struct filename *file;
>  	struct file *candidate;
> @@ -2984,7 +2984,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  		if (!trylock_page(fpage))
>  			goto next;
>  
> -		if (!split_huge_page(fpage))
> +		if (!split_huge_page_to_list_to_order(fpage, NULL, new_order))
>  			split++;
>  
>  		unlock_page(fpage);
> @@ -3009,10 +3009,14 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>  {
>  	static DEFINE_MUTEX(split_debug_mutex);
>  	ssize_t ret;
> -	/* hold pid, start_vaddr, end_vaddr or file_path, off_start, off_end */
> +	/*
> +	 * hold pid, start_vaddr, end_vaddr, new_order or
> +	 * file_path, off_start, off_end, new_order
> +	 */
>  	char input_buf[MAX_INPUT_BUF_SZ];
>  	int pid;
>  	unsigned long vaddr_start, vaddr_end;
> +	unsigned int new_order = 0;
>  
>  	ret = mutex_lock_interruptible(&split_debug_mutex);
>  	if (ret)
> @@ -3041,29 +3045,29 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>  			goto out;
>  		}
>  
> -		ret = sscanf(buf, "0x%lx,0x%lx", &off_start, &off_end);
> -		if (ret != 2) {
> +		ret = sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
> +		if (ret != 2 && ret != 3) {
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		ret = split_huge_pages_in_file(file_path, off_start, off_end);
> +		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
>  		if (!ret)
>  			ret = input_len;
>  
>  		goto out;
>  	}
>  
> -	ret = sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_end);
> +	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
>  	if (ret == 1 && pid == 1) {
>  		split_huge_pages_all();
>  		ret = strlen(input_buf);
>  		goto out;
> -	} else if (ret != 3) {
> +	} else if (ret != 3 && ret != 4) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end);
> +	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
>  	if (!ret)
>  		ret = strlen(input_buf);
>  out:
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> index 52497b7b9f1d..af01e7dca9c8 100644
> --- a/tools/testing/selftests/vm/split_huge_page_test.c
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -16,6 +16,7 @@
>  #include <sys/mount.h>
>  #include <malloc.h>
>  #include <stdbool.h>
> +#include <time.h>
>  
>  uint64_t pagesize;
>  unsigned int pageshift;
> @@ -24,10 +25,11 @@ uint64_t pmd_pagesize;
>  #define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
>  #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>  #define SMAP_PATH "/proc/self/smaps"
> +#define THP_FS_PATH "/mnt/thp_fs"
>  #define INPUT_MAX 80
>  
> -#define PID_FMT "%d,0x%lx,0x%lx"
> -#define PATH_FMT "%s,0x%lx,0x%lx"
> +#define PID_FMT "%d,0x%lx,0x%lx,%d"
> +#define PATH_FMT "%s,0x%lx,0x%lx,%d"
>  
>  #define PFN_MASK     ((1UL<<55)-1)
>  #define KPF_THP      (1UL<<22)
> @@ -75,23 +77,6 @@ static uint64_t read_pmd_pagesize(void)
>  	return strtoul(buf, NULL, 10);
>  }
>  
> -static int write_file(const char *path, const char *buf, size_t buflen)
> -{
> -	int fd;
> -	ssize_t numwritten;
> -
> -	fd = open(path, O_WRONLY);
> -	if (fd == -1)
> -		return 0;
> -
> -	numwritten = write(fd, buf, buflen - 1);
> -	close(fd);
> -	if (numwritten < 1)
> -		return 0;
> -
> -	return (unsigned int) numwritten;
> -}
> -
>  static void write_debugfs(const char *fmt, ...)
>  {
>  	char input[INPUT_MAX];
> @@ -106,11 +91,6 @@ static void write_debugfs(const char *fmt, ...)
>  		printf("%s: Debugfs input is too long\n", __func__);
>  		exit(EXIT_FAILURE);
>  	}
> -
> -	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
> -		perror(SPLIT_DEBUGFS);
> -		exit(EXIT_FAILURE);
> -	}
>  }
>  
>  #define MAX_LINE_LENGTH 500
> @@ -124,7 +104,7 @@ static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
>  	return false;
>  }
>  
> -static uint64_t check_huge(void *addr)
> +static uint64_t check_huge(void *addr, const char *prefix)
>  {
>  	uint64_t thp = 0;
>  	int ret;
> @@ -149,13 +129,13 @@ static uint64_t check_huge(void *addr)
>  		goto err_out;
>  
>  	/*
> -	 * Fetch the AnonHugePages: in the same block and check the number of
> +	 * Fetch the @prefix in the same block and check the number of
>  	 * hugepages.
>  	 */
> -	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
> +	if (!check_for_pattern(fp, prefix, buffer))
>  		goto err_out;
>  
> -	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1) {
> +	if (sscanf(&buffer[strlen(prefix)], "%10ld kB", &thp) != 1) {
>  		printf("Reading smap error\n");
>  		exit(EXIT_FAILURE);
>  	}
> @@ -184,7 +164,7 @@ void split_pmd_thp(void)
>  	for (i = 0; i < len; i++)
>  		one_page[i] = (char)i;
>  
> -	thp_size = check_huge(one_page);
> +	thp_size = check_huge(one_page, "AnonHugePages:");
>  	if (!thp_size) {
>  		printf("No THP is allocated\n");
>  		exit(EXIT_FAILURE);
> @@ -192,7 +172,7 @@ void split_pmd_thp(void)
>  
>  	/* split all THPs */
>  	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
> -		(uint64_t)one_page + len);
> +		(uint64_t)one_page + len, 0);
>  
>  	for (i = 0; i < len; i++)
>  		if (one_page[i] != (char)i) {
> @@ -201,7 +181,7 @@ void split_pmd_thp(void)
>  		}
>  
>  
> -	thp_size = check_huge(one_page);
> +	thp_size = check_huge(one_page, "AnonHugePages:");
>  	if (thp_size) {
>  		printf("Still %ld kB AnonHugePages not split\n", thp_size);
>  		exit(EXIT_FAILURE);
> @@ -249,7 +229,7 @@ void split_pte_mapped_thp(void)
>  	for (i = 0; i < len; i++)
>  		one_page[i] = (char)i;
>  
> -	thp_size = check_huge(one_page);
> +	thp_size = check_huge(one_page, "AnonHugePages:");
>  	if (!thp_size) {
>  		printf("No THP is allocated\n");
>  		exit(EXIT_FAILURE);
> @@ -284,7 +264,7 @@ void split_pte_mapped_thp(void)
>  
>  	/* split all remapped THPs */
>  	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
> -		      (uint64_t)pte_mapped + pagesize * 4);
> +		      (uint64_t)pte_mapped + pagesize * 4, 0);
>  
>  	/* smap does not show THPs after mremap, use kpageflags instead */
>  	thp_size = 0;
> @@ -371,20 +351,193 @@ void split_file_backed_thp(void)
>  	printf("file-backed THP split test done, please check dmesg for more information\n");
>  }
>  
> +void create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd, char **addr)
> +{
> +	size_t i;
> +	int dummy;
> +
> +	srand(time(NULL));
> +
> +	*fd = open(testfile, O_CREAT | O_RDWR, 0664);
> +	if (*fd == -1) {
> +		perror("Failed to create a file at "THP_FS_PATH);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 0; i < fd_size; i++) {
> +		unsigned char byte = (unsigned char)i;
> +
> +		write(*fd, &byte, sizeof(byte));
> +	}
> +	close(*fd);
> +	sync();
> +	*fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
> +	if (*fd == -1) {
> +		perror("open drop_caches");
> +		exit(EXIT_FAILURE);
> +	}
> +	if (write(*fd, "3", 1) != 1) {
> +		perror("write to drop_caches");
> +		exit(EXIT_FAILURE);
> +	}
> +	close(*fd);
> +
> +	*fd = open(testfile, O_RDWR);
> +	if (*fd == -1) {
> +		perror("Failed to open a file at "THP_FS_PATH);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	*addr = mmap(NULL, fd_size, PROT_READ|PROT_WRITE, MAP_SHARED, *fd, 0);
> +	if (*addr == (char *)-1) {
> +		perror("cannot mmap");
> +		exit(1);
> +	}
> +	madvise(*addr, fd_size, MADV_HUGEPAGE);
> +
> +	for (size_t i = 0; i < fd_size; i++)
> +		dummy += *(*addr + i);
> +
> +	if (!check_huge(*addr, "FilePmdMapped:")) {
> +		printf("No pagecache THP generated, please mount a filesystem "
> +			"supporting pagecache THP at "THP_FS_PATH"\n");
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +void split_thp_in_pagecache_to_order(size_t fd_size, int order)
> +{
> +	int fd;
> +	char *addr;
> +	size_t i;
> +	const char testfile[] = THP_FS_PATH "/test";
> +
> +	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
> +
> +	printf("split %ld kB pagecache page to order %d ... ", fd_size >> 10, order);
> +	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_size, order);
> +
> +	for (i = 0; i < fd_size; i++)
> +		if (*(addr + i) != (char)i) {
> +			printf("%lu byte corrupted in the file\n", i);
> +			exit(EXIT_FAILURE);
> +		}
> +
> +	close(fd);
> +	unlink(testfile);
> +	printf("done\n");
> +}
> +
> +void truncate_thp_in_pagecache_to_order(size_t fd_size, int order)
> +{
> +	int fd;
> +	char *addr;
> +	size_t i;
> +	const char testfile[] = THP_FS_PATH "/test";
> +
> +	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
> +
> +	printf("truncate %ld kB pagecache page to size %lu kB ... ", fd_size >> 10, 4UL << order);
> +	ftruncate(fd, pagesize << order);
> +
> +	for (i = 0; i < (pagesize << order); i++)
> +		if (*(addr + i) != (char)i) {
> +			printf("%lu byte corrupted in the file\n", i);
> +			exit(EXIT_FAILURE);
> +		}
> +
> +	close(fd);
> +	unlink(testfile);
> +	printf("done\n");
> +}
> +
> +void punch_hole_in_pagecache_thp(size_t fd_size, off_t offset[], off_t len[], int n)
> +{
> +	int fd, j;
> +	char *addr;
> +	size_t i;
> +	const char testfile[] = THP_FS_PATH "/test";
> +
> +	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
> +
> +	for (j = 0; j < n; j++) {
> +		printf("addr: %lx, punch a hole at offset %ld kB with len %ld kB ... ",
> +			(unsigned long)addr, offset[j] >> 10, len[j] >> 10);
> +		fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset[j], len[j]);
> +		printf("done\n");
> +	}
> +
> +	for (i = 0; i < fd_size; i++) {
> +		int in_hole = 0;
> +
> +		for (j = 0; j < n; j++)
> +			if (i >= offset[j] && i <= (offset[j] + len[j])) {
> +				in_hole = 1;
> +				break;
> +			}
> +
> +		if (in_hole) {
> +			if (*(addr + i)) {
> +				printf("%lu byte non-zero after punch\n", i);
> +				exit(EXIT_FAILURE);
> +			}
> +			continue;
> +		}
> +		if (*(addr + i) != (char)i) {
> +			printf("%lu byte corrupted in the file\n", i);
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
> +	close(fd);
> +	unlink(testfile);
> +}
> +
>  int main(int argc, char **argv)
>  {
> +	int i;
> +	size_t fd_size;
> +	off_t offset[2], len[2];
> +
>  	if (geteuid() != 0) {
>  		printf("Please run the benchmark as root\n");
>  		exit(EXIT_FAILURE);
>  	}
>  
> +	setbuf(stdout, NULL);
> +
>  	pagesize = getpagesize();
>  	pageshift = ffs(pagesize) - 1;
>  	pmd_pagesize = read_pmd_pagesize();
> +	fd_size = 2 * pmd_pagesize;
>  
>  	split_pmd_thp();
>  	split_pte_mapped_thp();
>  	split_file_backed_thp();
>  
> +	for (i = 8; i >= 0; i--)
> +		if (i != 1)
> +			split_thp_in_pagecache_to_order(fd_size, i);
> +
> +	/*
> +	 * for i is 1, truncate code in the kernel should create order-0 pages
> +	 * instead of order-1 THPs, since order-1 THP is not supported. No error
> +	 * is expected.
> +	 */
> +	for (i = 8; i >= 0; i--)
> +		truncate_thp_in_pagecache_to_order(fd_size, i);
> +
> +	offset[0] = 123 * pagesize;
> +	offset[1] = 4 * pagesize;
> +	len[0] = 200 * pagesize;
> +	len[1] = 16 * pagesize;
> +	punch_hole_in_pagecache_thp(fd_size, offset, len, 2);
> +
> +	offset[0] = 259 * pagesize + pagesize / 2;
> +	offset[1] = 33 * pagesize;
> +	len[0] = 129 * pagesize;
> +	len[1] = 16 * pagesize;
> +	punch_hole_in_pagecache_thp(fd_size, offset, len, 2);
> +
>  	return 0;
>  }
> -- 
> 2.35.1
> 
