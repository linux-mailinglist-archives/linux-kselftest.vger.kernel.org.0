Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4160B541
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Oct 2022 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiJXSSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 14:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiJXSRn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 14:17:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC9427CFE7;
        Mon, 24 Oct 2022 09:59:06 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n83so11440101oif.11;
        Mon, 24 Oct 2022 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFtcdv54aP9ASW/XFNtV2qBUzg/ccYHeumFq6e607dg=;
        b=bEWM4Jl82pIorE3Zk+AfNgpkcbAv0OW3qUdEGqbJAfjsDP5hweQCjFFpRfnXVE/m3t
         m8ELTMXzCCJiUw4pQybuySP7ckyO3MmU41fFpi4JO4aF8ewxRE+1yOHQzUC3b8zScALU
         gR4IE0HoldN+RR6Ocq1KGwHI/eCtK5mbHwLuTV/iIttUUkJas4aj2TagGsP376TACxh6
         mIF8F9hr/EDzrIfwkWPx+qT9n8zEj33Nat+mSdvDxEq/OCAWVOkcj4lTqYd8ZqWa4oFz
         in5tIlQJszOMSWaQDM5zLTFa3+4/tJyk2OncKsio4I8byq8v53AYDSuUowLfrA4L3Xw4
         EILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFtcdv54aP9ASW/XFNtV2qBUzg/ccYHeumFq6e607dg=;
        b=u1TmSmNLuLfan2nv9mvD/dKTtbJdZsfR7t/+MjYLza4Jfk9qJ32SLYkX9fi86kNs+3
         Mb4zuw4fW1bRrYimVsc9vVYbaSsDFyvCOr5W8dpC6aq4EauaJOzbGUQPvBd4GKwEN305
         jY4ysl0pWw+sVe5YE7Jz4NnWjX6VtkBOTZnY2E7EabEXBl13rHCzg96Gi4jayL60fzpD
         TsHftnfTSyAuvqnOPPEi2MM1k+dGownOEM8FuBP5CqqJOtm/czOSNI7yXCrFcQt6X7C5
         zdQGXYKc3UiGN37zAlPnGp9mPkp1C81DekStxkI+aaR3IBEAgP8fdLe33kVVY/QI2qy2
         0QOQ==
X-Gm-Message-State: ACrzQf1SPGJj3gas7eHVmxFtz6VjkWxxPx/G3TBldIjnpIJVreFtWM/S
        1YioDRRjCNiTIOdXm618BjA=
X-Google-Smtp-Source: AMsMyM58H7ry9RDCAUP95PbMom0mi87VCMzL0rGEGwAvsrCydBoHF4V0ekUkyak68ZQnzNSTNMNnmw==
X-Received: by 2002:a05:6808:16a9:b0:353:ebec:603d with SMTP id bb41-20020a05680816a900b00353ebec603dmr30766786oib.75.1666630657878;
        Mon, 24 Oct 2022 09:57:37 -0700 (PDT)
Received: from macondo ([2804:431:e7cc:c8c9:7827:901c:d11e:a7e8])
        by smtp.gmail.com with ESMTPSA id w21-20020a9d6395000000b00663d45bb5c3sm1638623otk.33.2022.10.24.09.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:57:37 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:57:31 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v1 1/7] selftests/vm: anon_cow: test COW handling of
 anonymous memory
Message-ID: <Y1bD+8CMzlqkbPwU@macondo>
References: <20220927110120.106906-1-david@redhat.com>
 <20220927110120.106906-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927110120.106906-2-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 27, 2022 at 01:01:14PM +0200, David Hildenbrand wrote:
> Let's start adding tests for our COW handling of anonymous memory. We'll
> focus on basic tests that we can achieve without additional libraries or
> gup_test extensions.
> 
> We'll add THP and hugetlb tests separately.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/vm/.gitignore     |   1 +
>  tools/testing/selftests/vm/Makefile       |   4 +-
>  tools/testing/selftests/vm/anon_cow.c     | 401 ++++++++++++++++++++++
>  tools/testing/selftests/vm/run_vmtests.sh |   3 +
>  tools/testing/selftests/vm/vm_util.c      |   7 +
>  tools/testing/selftests/vm/vm_util.h      |   1 +
>  6 files changed, 416 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/vm/anon_cow.c
> 
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 7b9dc2426f18..8a536c731e3c 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +anon_cow
>  hugepage-mmap
>  hugepage-mremap
>  hugepage-shm
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 4ae879f70f4c..bc759534ec28 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -25,7 +25,8 @@ MAKEFLAGS += --no-builtin-rules
>  
>  CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>  LDLIBS = -lrt -lpthread
> -TEST_GEN_FILES = compaction_test
> +TEST_GEN_FILES = anon_cow
> +TEST_GEN_FILES += compaction_test
>  TEST_GEN_FILES += gup_test
>  TEST_GEN_FILES += hmm-tests
>  TEST_GEN_FILES += hugetlb-madvise
> @@ -95,6 +96,7 @@ TEST_FILES += va_128TBswitch.sh
>  
>  include ../lib.mk
>  
> +$(OUTPUT)/anon_cow: vm_util.c
>  $(OUTPUT)/madv_populate: vm_util.c
>  $(OUTPUT)/soft-dirty: vm_util.c
>  $(OUTPUT)/split_huge_page_test: vm_util.c
> diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
> new file mode 100644
> index 000000000000..9d2b15c829e6
> --- /dev/null
> +++ b/tools/testing/selftests/vm/anon_cow.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * COW (Copy On Write) tests for anonymous memory.
> + *
> + * Copyright 2022, Red Hat, Inc.
> + *
> + * Author(s): David Hildenbrand <david@redhat.com>
> + */
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <dirent.h>
> +#include <assert.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest.h"
> +#include "vm_util.h"
> +
> +static size_t pagesize;
> +static int pagemap_fd;
> +
> +struct comm_pipes {
> +	int child_ready[2];
> +	int parent_ready[2];
> +};
> +
> +static int setup_comm_pipes(struct comm_pipes *comm_pipes)
> +{
> +	if (pipe(comm_pipes->child_ready) < 0)
> +		return -errno;
> +	if (pipe(comm_pipes->parent_ready) < 0) {
> +		close(comm_pipes->child_ready[0]);
> +		close(comm_pipes->child_ready[1]);
> +		return -errno;
> +	}
> +
> +	return 0;
> +}
> +
> +static void close_comm_pipes(struct comm_pipes *comm_pipes)
> +{
> +	close(comm_pipes->child_ready[0]);
> +	close(comm_pipes->child_ready[1]);
> +	close(comm_pipes->parent_ready[0]);
> +	close(comm_pipes->parent_ready[1]);
> +}
> +
> +static int child_memcmp_fn(char *mem, size_t size,
> +			   struct comm_pipes *comm_pipes)
> +{
> +	char *old = malloc(size);
> +	char buf;
> +
> +	/* Backup the original content. */
> +	memcpy(old, mem, size);
> +
> +	/* Wait until the parent modified the page. */
> +	write(comm_pipes->child_ready[1], "0", 1);
> +	while (read(comm_pipes->parent_ready[0], &buf, 1) != 1)
> +		;
> +
> +	/* See if we still read the old values. */
> +	return memcmp(old, mem, size);
> +}
> +
> +static int child_vmsplice_memcmp_fn(char *mem, size_t size,
> +				    struct comm_pipes *comm_pipes)
> +{
> +	struct iovec iov = {
> +		.iov_base = mem,
> +		.iov_len = size,
> +	};
> +	size_t cur, total, transferred;
> +	char *old, *new;
> +	int fds[2];
> +	char buf;
> +
> +	old = malloc(size);
> +	new = malloc(size);
> +
> +	/* Backup the original content. */
> +	memcpy(old, mem, size);
> +
> +	if (pipe(fds) < 0)
> +		return -errno;
> +
> +	/* Trigger a read-only pin. */
> +	transferred = vmsplice(fds[1], &iov, 1, 0);
> +	if (transferred < 0)
> +		return -errno;
> +	if (transferred == 0)
> +		return -EINVAL;
> +
> +	/* Unmap it from our page tables. */
> +	if (munmap(mem, size) < 0)
> +		return -errno;
> +
> +	/* Wait until the parent modified it. */
> +	write(comm_pipes->child_ready[1], "0", 1);
> +	while (read(comm_pipes->parent_ready[0], &buf, 1) != 1)
> +		;
> +
> +	/* See if we still read the old values via the pipe. */
> +	for (total = 0; total < transferred; total += cur) {
> +		cur = read(fds[0], new + total, transferred - total);
> +		if (cur < 0)

Hi David, 
I was looking at some coccinelle reports for linux-next and
saw the following warning for this comparison:

  WARNING: Unsigned expression compared with zero: cur < 0

I think 'cur' needs to be of type 'ssize_t' for this comparison to work.

The same warning is reported for the variable 'transferred' above, and
also for do_test_iouring() and do_test_vmsplice_in_parent() in
"selftests/vm: anon_cow: add liburing test cases".

> +			return -errno;
> +	}
> +
> +	return memcmp(old, new, transferred);
> +}
> +
> +typedef int (*child_fn)(char *mem, size_t size, struct comm_pipes *comm_pipes);
> +
> +static void do_test_cow_in_parent(char *mem, size_t size, child_fn fn)
> +{
> +	struct comm_pipes comm_pipes;
> +	char buf;
> +	int ret;
> +
> +	ret = setup_comm_pipes(&comm_pipes);
> +	if (ret) {
> +		ksft_test_result_fail("pipe() failed\n");
> +		return;
> +	}
> +
> +	ret = fork();
> +	if (ret < 0) {
> +		ksft_test_result_fail("fork() failed\n");
> +		goto close_comm_pipes;
> +	} else if (!ret) {
> +		exit(fn(mem, size, &comm_pipes));
> +	}
> +
> +	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
> +		;
> +	/* Modify the page. */
> +	memset(mem, 0xff, size);
> +	write(comm_pipes.parent_ready[1], "0", 1);
> +
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +
> +	ksft_test_result(!ret, "No leak from parent into child\n");
> +close_comm_pipes:
> +	close_comm_pipes(&comm_pipes);
> +}
> +
> +static void test_cow_in_parent(char *mem, size_t size)
> +{
> +	do_test_cow_in_parent(mem, size, child_memcmp_fn);
> +}
> +
> +static void test_vmsplice_in_child(char *mem, size_t size)
> +{
> +	do_test_cow_in_parent(mem, size, child_vmsplice_memcmp_fn);
> +}
> +
> +static void do_test_vmsplice_in_parent(char *mem, size_t size,
> +				       bool before_fork)
> +{
> +	struct iovec iov = {
> +		.iov_base = mem,
> +		.iov_len = size,
> +	};
> +	size_t cur, total, transferred;
> +	struct comm_pipes comm_pipes;
> +	char *old, *new;
> +	int ret, fds[2];
> +	char buf;
> +
> +	old = malloc(size);
> +	new = malloc(size);
> +
> +	memcpy(old, mem, size);
> +
> +	ret = setup_comm_pipes(&comm_pipes);
> +	if (ret) {
> +		ksft_test_result_fail("pipe() failed\n");
> +		goto free;
> +	}
> +
> +	if (pipe(fds) < 0) {
> +		ksft_test_result_fail("pipe() failed\n");
> +		goto close_comm_pipes;
> +	}
> +
> +	if (before_fork) {
> +		transferred = vmsplice(fds[1], &iov, 1, 0);
> +		if (transferred <= 0) {
> +			ksft_test_result_fail("vmsplice() failed\n");
> +			goto close_pipe;
> +		}
> +	}
> +
> +	ret = fork();
> +	if (ret < 0) {
> +		ksft_test_result_fail("fork() failed\n");
> +		goto close_pipe;
> +	} else if (!ret) {
> +		write(comm_pipes.child_ready[1], "0", 1);
> +		while (read(comm_pipes.parent_ready[0], &buf, 1) != 1)
> +			;
> +		/* Modify page content in the child. */
> +		memset(mem, 0xff, size);
> +		exit(0);
> +	}
> +
> +	if (!before_fork) {
> +		transferred = vmsplice(fds[1], &iov, 1, 0);
> +		if (transferred <= 0) {
> +			ksft_test_result_fail("vmsplice() failed\n");
> +			wait(&ret);
> +			goto close_pipe;
> +		}
> +	}
> +
> +	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
> +		;
> +	if (munmap(mem, size) < 0) {
> +		ksft_test_result_fail("munmap() failed\n");
> +		goto close_pipe;
> +	}
> +	write(comm_pipes.parent_ready[1], "0", 1);
> +
> +	/* Wait until the child is done writing. */
> +	wait(&ret);
> +	if (!WIFEXITED(ret)) {
> +		ksft_test_result_fail("wait() failed\n");
> +		goto close_pipe;
> +	}
> +
> +	/* See if we still read the old values. */
> +	for (total = 0; total < transferred; total += cur) {
> +		cur = read(fds[0], new + total, transferred - total);
> +		if (cur < 0) {
> +			ksft_test_result_fail("read() failed\n");
> +			goto close_pipe;
> +		}
> +	}
> +
> +	ksft_test_result(!memcmp(old, new, transferred),
> +			 "No leak from child into parent\n");
> +close_pipe:
> +	close(fds[0]);
> +	close(fds[1]);
> +close_comm_pipes:
> +	close_comm_pipes(&comm_pipes);
> +free:
> +	free(old);
> +	free(new);
> +}
> +
> +static void test_vmsplice_before_fork(char *mem, size_t size)
> +{
> +	do_test_vmsplice_in_parent(mem, size, true);
> +}
> +
> +static void test_vmsplice_after_fork(char *mem, size_t size)
> +{
> +	do_test_vmsplice_in_parent(mem, size, false);
> +}
> +
> +typedef void (*test_fn)(char *mem, size_t size);
> +
> +static void do_run_with_base_page(test_fn fn, bool swapout)
> +{
> +	char *mem;
> +	int ret;
> +
> +	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (mem == MAP_FAILED) {
> +		ksft_test_result_fail("mmap() failed\n");
> +		return;
> +	}
> +
> +	ret = madvise(mem, pagesize, MADV_NOHUGEPAGE);
> +	/* Ignore if not around on a kernel. */
> +	if (ret && errno != EINVAL) {
> +		ksft_test_result_fail("MADV_NOHUGEPAGE failed\n");
> +		goto munmap;
> +	}
> +
> +	/* Populate a base page. */
> +	memset(mem, 0, pagesize);
> +
> +	if (swapout) {
> +		madvise(mem, pagesize, MADV_PAGEOUT);
> +		if (!pagemap_is_swapped(pagemap_fd, mem)) {
> +			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
> +			goto munmap;
> +		}
> +	}
> +
> +	fn(mem, pagesize);
> +munmap:
> +	munmap(mem, pagesize);
> +}
> +
> +static void run_with_base_page(test_fn fn, const char *desc)
> +{
> +	ksft_print_msg("[RUN] %s ... with base page\n", desc);
> +	do_run_with_base_page(fn, false);
> +}
> +
> +static void run_with_base_page_swap(test_fn fn, const char *desc)
> +{
> +	ksft_print_msg("[RUN] %s ... with swapped out base page\n", desc);
> +	do_run_with_base_page(fn, true);
> +}
> +
> +struct test_case {
> +	const char *desc;
> +	test_fn fn;
> +};
> +
> +static const struct test_case test_cases[] = {
> +	/*
> +	 * Basic COW tests for fork() without any GUP. If we miss to break COW,
> +	 * either the child can observe modifications by the parent or the
> +	 * other way around.
> +	 */
> +	{
> +		"Basic COW after fork()",
> +		test_cow_in_parent,
> +	},
> +	/*
> +	 * vmsplice() [R/O GUP] + unmap in the child; modify in the parent. If
> +	 * we miss to break COW, the child observes modifications by the parent.
> +	 * This is CVE-2020-29374 reported by Jann Horn.
> +	 */
> +	{
> +		"vmsplice() + unmap in child",
> +		test_vmsplice_in_child
> +	},
> +	/*
> +	 * vmsplice() [R/O GUP] in parent before fork(), unmap in parent after
> +	 * fork(); modify in the child. If we miss to break COW, the parent
> +	 * observes modifications by the child.
> +	 */
> +	{
> +		"vmsplice() before fork(), unmap in parent after fork()",
> +		test_vmsplice_before_fork,
> +	},
> +	/*
> +	 * vmsplice() [R/O GUP] + unmap in parent after fork(); modify in the
> +	 * child. If we miss to break COW, the parent observes modifications by
> +	 * the child.
> +	 */
> +	{
> +		"vmsplice() + unmap in parent after fork()",
> +		test_vmsplice_after_fork,
> +	},
> +};
> +
> +static void run_test_case(struct test_case const *test_case)
> +{
> +	run_with_base_page(test_case->fn, test_case->desc);
> +	run_with_base_page_swap(test_case->fn, test_case->desc);
> +}
> +
> +static void run_test_cases(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
> +		run_test_case(&test_cases[i]);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int nr_test_cases = ARRAY_SIZE(test_cases);
> +	int err;
> +
> +	pagesize = getpagesize();
> +
> +	ksft_print_header();
> +	ksft_set_plan(nr_test_cases * 2);
> +
> +	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> +	if (pagemap_fd < 0)
> +		ksft_exit_fail_msg("opening pagemap failed\n");
> +
> +	run_test_cases();
> +
> +	err = ksft_get_fail_cnt();
> +	if (err)
> +		ksft_exit_fail_msg("%d out of %d tests failed\n",
> +				   err, ksft_test_num());
> +	return ksft_exit_pass();
> +}
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index e780e76c26b8..af59380bc254 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -197,4 +197,7 @@ fi
>  
>  run_test ./soft-dirty
>  
> +# COW tests for anonymous memory
> +run_test ./anon_cow
> +
>  exit $exitcode
> diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
> index b58ab11a7a30..6456027e1985 100644
> --- a/tools/testing/selftests/vm/vm_util.c
> +++ b/tools/testing/selftests/vm/vm_util.c
> @@ -28,6 +28,13 @@ bool pagemap_is_softdirty(int fd, char *start)
>  	return entry & 0x0080000000000000ull;
>  }
>  
> +bool pagemap_is_swapped(int fd, char *start)
> +{
> +	uint64_t entry = pagemap_get_entry(fd, start);
> +
> +	return entry & 0x4000000000000000ull;
> +}
> +
>  void clear_softdirty(void)
>  {
>  	int ret;
> diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
> index 2e512bd57ae1..bb8ec8d69623 100644
> --- a/tools/testing/selftests/vm/vm_util.h
> +++ b/tools/testing/selftests/vm/vm_util.h
> @@ -4,6 +4,7 @@
>  
>  uint64_t pagemap_get_entry(int fd, char *start);
>  bool pagemap_is_softdirty(int fd, char *start);
> +bool pagemap_is_swapped(int fd, char *start);
>  void clear_softdirty(void);
>  uint64_t read_pmd_pagesize(void);
>  uint64_t check_huge(void *addr);
> -- 
> 2.37.3
> 
