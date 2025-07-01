Return-Path: <linux-kselftest+bounces-36134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E9AEECAF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F0B3A4BEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626131DF268;
	Tue,  1 Jul 2025 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIklRhib"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1C13AD26;
	Tue,  1 Jul 2025 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339180; cv=none; b=idry/PxndYPmR6MGXNZ9uxrQQyu1CDWSKLB/B951fdyAfHsbWdTgcaSqqSab+ACvcjV4gauiPUD551FiI5ecednFl/94c9e0MWe2OKWM7R0GJGDc2MTFwowK/ll0cm84UICHQfJt/Nb9KMvilW9CcXy9ewGARae78s0QzlMZbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339180; c=relaxed/simple;
	bh=+HBR+jnxA9nNgWFa1PCjs1qWdyrmekDk5QwQfoG6iRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELj6/W6FVIXz/TQmjqRjc5VeqOEF9b92zbwW/Z2uZBWg8olH+3HiYBwuZV6dTcTKwkyXp/hUBDm+ULxNjjTMnXHWmWgm9CiuiCMjRqh2RHZ+rp/dxhzLKdtFHt4CgJTq9yzDRqBM7zBT/ffuefxk9aSDSSYeQmFgauqt3KsC0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIklRhib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD14C4CEE3;
	Tue,  1 Jul 2025 03:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751339177;
	bh=+HBR+jnxA9nNgWFa1PCjs1qWdyrmekDk5QwQfoG6iRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIklRhibGuYRMyTLTG5El9hliLy0gZEP35O+8eoTuZfh3YCIBgrnTew7/nFfTWUnZ
	 0+dRMXaRoCIag1rmOayV3cSis7FsiY4AALejdPVmPyyaUXKkL8mOwFBaw4CQtcv5fL
	 PQPn4VlaYded0K4EQtvV786jidzeIJ6PkeWhz72ZvMxCmYSostINyEdDJWNgMNEOEs
	 8L0DnVIWjaASZVPZ7MLP/ylKA4Gqaa14IlT8PMbiAE+YYHzdkP1B5foEbaf7tW50lm
	 SuoCikEl/hBVX3jJ+Rw5XL/F0x6CwU8rWc/uQAq3PDjl4CmO4pgPbuql+JrSeQDMu0
	 3JiXlZThttgEw==
From: SeongJae Park <sj@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	david@redhat.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: Re: [PATCH v2] selftests/mm: Add process_madvise() tests
Date: Mon, 30 Jun 2025 20:06:14 -0700
Message-Id: <20250701030614.68902-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630140957.4000-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wang,

On Mon, 30 Jun 2025 22:09:57 +0800 wang lian <lianux.mm@gmail.com> wrote:

> This patch adds tests for the process_madvise(), focusing on
> verifying behavior under various conditions including valid
> usage and error cases.
> 
> Signed-off-by: wang lian<lianux.mm@gmail.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>

I left a few trivial comments below, but overall this looks useful to me.
Thank you :)

Acked-by: SeongJae Park <sj@kernel.org>

FYI, 'git am' of this patch on latest mm-new fails.  Maybe this is not based on
the latest mm-new?  But, I also found Andrew added this to mm tree:
https://lore.kernel.org/20250630230052.AB95CC4CEE3@smtp.kernel.org .  Maybe
Andrew did rebase on his own?

[...]
> --- /dev/null
> +++ b/tools/testing/selftests/mm/process_madv.c
[...]
> +/* Try and read from a buffer, return true if no fatal signal. */
> +static bool try_read_buf(char *ptr)
> +{
> +	return try_access_buf(ptr, false);

Seems this is the only caller of try_access_buf().  How about removing 'write'
argument of try_access_buf() and its handling?

> +}
> +
> +TEST_F(process_madvise, basic)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	const int madvise_pages = 4;
> +	char *map;
> +	ssize_t ret;
> +	struct iovec vec[madvise_pages];
> +
> +	/*
> +	 * Create a single large mapping. We will pick pages from this
> +	 * mapping to advise on. This ensures we test non-contiguous iovecs.
> +	 */
> +	map = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	ASSERT_NE(map, MAP_FAILED);

So this will make this test marked as failed, for mmap() failure, which doesn't
really mean something in process_madvise() is wrong.  What about using
ksft_exit_skip() with failure check, instead?

> +
> +	/* Fill the entire region with a known pattern. */
> +	memset(map, 'A', pagesize * 10);
> +
> +	/*
> +	 * Setup the iovec to point to 4 non-contiguous pages
> +	 * within the mapping.
> +	 */
> +	vec[0].iov_base = &map[0 * pagesize];
> +	vec[0].iov_len = pagesize;
> +	vec[1].iov_base = &map[3 * pagesize];
> +	vec[1].iov_len = pagesize;
> +	vec[2].iov_base = &map[5 * pagesize];
> +	vec[2].iov_len = pagesize;
> +	vec[3].iov_base = &map[8 * pagesize];
> +	vec[3].iov_len = pagesize;
> +
> +	ret = sys_process_madvise(PIDFD_SELF, vec, madvise_pages, MADV_DONTNEED,
> +				  0);
> +	if (ret == -1 && errno == EPERM)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or permission denied, try running as root.\n");
> +	else if (errno == EINVAL)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or parameter invalid, please check arguments.\n");
> +
> +	/* The call should succeed and report the total bytes processed. */
> +	ASSERT_EQ(ret, madvise_pages * pagesize);
> +
> +	/* Check that advised pages are now zero. */
> +	for (int i = 0; i < madvise_pages; i++) {
> +		char *advised_page = (char *)vec[i].iov_base;
> +
> +		/* Access should be successful (kernel provides a new page). */
> +		ASSERT_TRUE(try_read_buf(advised_page));
> +		/* Content must be 0, not 'A'. */
> +		ASSERT_EQ(*advised_page, 0);
> +	}
> +
> +	/* Check that an un-advised page in between is still 'A'. */
> +	char *unadvised_page = &map[1 * pagesize];
> +
> +	ASSERT_TRUE(try_read_buf(unadvised_page));
> +	ASSERT_EQ(*unadvised_page, 'A');

What about using memcpy() and memcmp() for testing full bytes?  That could do
more complete test, and reduce unnecessary volatile and helper functions?

> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize * 10), 0);

Again, I think ksft_exit_skip() might be a better approach.

> +}
> +
> +static long get_smaps_anon_huge_pages(pid_t pid, void *addr)
> +{
> +	char smaps_path[64];
> +	char *line = NULL;
> +	unsigned long start, end;
> +	long anon_huge_kb;
> +	size_t len;
> +	FILE *f;
> +	bool in_vma;
> +
> +	in_vma = false;
> +	sprintf(smaps_path, "/proc/%d/smaps", pid);

I understand this is just a test code, but...  What about using the safer one,
snprintf()?

> +	f = fopen(smaps_path, "r");
> +	if (!f)
> +		return -1;
> +
> +	while (getline(&line, &len, f) != -1) {
> +		/* Check if the line describes a VMA range */
> +		if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
> +			if ((unsigned long)addr >= start &&
> +			    (unsigned long)addr < end)
> +				in_vma = true;
> +			else
> +				in_vma = false;
> +			continue;
> +		}
> +
> +		/* If we are in the correct VMA, look for the AnonHugePages field */
> +		if (in_vma &&
> +		    sscanf(line, "AnonHugePages: %ld kB", &anon_huge_kb) == 1)
> +			break;
> +	}
> +
> +	free(line);
> +	fclose(f);
> +
> +	return (anon_huge_kb > 0) ? (anon_huge_kb * 1024) : 0;
> +}
[...]
> +TEST_HARNESS_MAIN
> \ No newline at end of file

checkpatch.pl complaints having no newline at the end of the file.

> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index f96d43153fc0..5c28ebcf1ea9 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -61,6 +61,8 @@ separated by spaces:
>  	ksm tests that require >=2 NUMA nodes
>  - pkey
>  	memory protection key tests
> +- process_madvise

Shouldn't this match with the real category name (process_madv) ?

> +	test process_madvise
>  - soft_dirty
>  	test soft dirty page bit semantics
>  - pagemap
> @@ -424,6 +426,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
>  CATEGORY="madv_guard" run_test ./guard-regions
>  
> +# PROCESS_MADVISE TEST
> +CATEGORY="process_madv" run_test ./process_madv
> +
>  # MADV_DONTNEED and PROCESS_DONTNEED tests
>  CATEGORY="madv_dontneed" run_test ./madv_dontneed
>  
> -- 
> 2.43.0


Thanks,
SJ

