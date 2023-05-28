Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E33713A47
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjE1PD2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjE1PD1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 11:03:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA78B1;
        Sun, 28 May 2023 08:03:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30ae5f2ac94so802384f8f.1;
        Sun, 28 May 2023 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685286204; x=1687878204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMl9Sb/fU6NQWI1gD+M9CLxXIiuUmnByGtiF+Vw3V6w=;
        b=myY6bdOezLAUNiMFQppYWvJqRPkQcp0xEZCsJHRuUc8LdFags5PGainU5Fr0gPnsEC
         e6BdRZma48QcFk4puHJjAETHYV1HKCmM7SHC+o/ugEcvu0WQRIWJs8oHPGUzdQLpwNxp
         pMxasWv0++Va2iil24uYxPwgH2qLyhwOwSh53yLBPsEw8VeHbdQmeV5v+BDgbCxhrHbg
         AjpYEWjMIqtFPdoNUFDoXfCxPS/1zkoEguW3EM/o5sQT1CUl6IBKTqxpybWiYRuTIAUx
         WkLWRjg2V8XyZPjCNK12C3eZnIZhDa3T5S8liyC3sP0CnAzJt6w9J1/WGInIj/0yhxck
         PqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685286204; x=1687878204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMl9Sb/fU6NQWI1gD+M9CLxXIiuUmnByGtiF+Vw3V6w=;
        b=ItLWqtgNGi21jTVPQ2/nNvXo++nplH/+4rMi+YpaBvXF0c455Fczm7tsSZww+aGIbd
         IzjZwF1/7HMFtzdUzNsBJb5vLlc0Hp7nvNIaMtrQd3411p94vPa2R/r29SO790vGdl51
         uYhV/COBb4jBGIk85SDiIZm3oWd8Fe/B9DGPZjkgLUD/nA4P1YCUKkouBvZQq0izFfks
         rOyU2II1kBjOI3UBzNe03VISUXeWCIaVC4rFTS1hXen8zGAOZWEwv+ZAhF2LklY03un7
         VrNcnNYvzumkofuEHfr1dFY2mO5IVFUSwcspsXhbvTjkeoNJ+qMUEG07xPd/KSmwTLyl
         dYIQ==
X-Gm-Message-State: AC+VfDz9QjF3NaVQ+RWhmy+Mc0ykU2hj8xbFLZV4/zQcYCfsbVInc3ov
        E1u4D6ntZe4F5FH+WgyXpdg=
X-Google-Smtp-Source: ACHHUZ4nJbz57goJmsJHHinyO0TwIPchCxkKjfEu0Icg8fSXbjHgUIKqeonYxufamabTYqWpjF9qgw==
X-Received: by 2002:adf:e786:0:b0:30a:ec3b:58d5 with SMTP id n6-20020adfe786000000b0030aec3b58d5mr10153wrm.69.1685286203753;
        Sun, 28 May 2023 08:03:23 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d488c000000b003090cb7a9e6sm10931718wrq.31.2023.05.28.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 08:03:22 -0700 (PDT)
Date:   Sun, 28 May 2023 16:03:22 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1 2/3] selftests/mm: gup_longterm: new functional test
 for FOLL_LONGTERM
Message-ID: <be2346e4-e8c0-4470-9bf4-59eb864063a8@lucifer.local>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519102723.185721-3-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 12:27:22PM +0200, David Hildenbrand wrote:
> Let's add a new test for checking whether GUP long-term page pinning
> works as expected (R/O vs. R/W, MAP_PRIVATE vs. MAP_SHARED, GUP vs.
> GUP-fast). Note that COW handling with long-term R/O pinning in private
> mappings, and pinning of anonymous memory in general, is tested by the
> COW selftest. This test, therefore, focuses on page pinning in
> file mappings.
>
> The most interesting case is probably the "local tmpfile" case, as that
> will likely end up on a "real" filesystem such as ext4 or xfs, not on a
> virtual one like tmpfs or hugetlb where any long-term page pinning is
> always expected to succeed.
>
> For now, only add tests that use the "/sys/kernel/debug/gup_test"
> interface. We'll add tests based on liburing separately next.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/Makefile       |   3 +
>  tools/testing/selftests/mm/gup_longterm.c | 386 ++++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh |   4 +-
>  3 files changed, 392 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/mm/gup_longterm.c
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 23af4633f0f4..95acb099315e 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -34,6 +34,7 @@ LDLIBS = -lrt -lpthread
>
>  TEST_GEN_PROGS = cow
>  TEST_GEN_PROGS += compaction_test
> +TEST_GEN_PROGS += gup_longterm
>  TEST_GEN_PROGS += gup_test
>  TEST_GEN_PROGS += hmm-tests
>  TEST_GEN_PROGS += hugetlb-madvise
> @@ -164,6 +165,8 @@ endif
>  # IOURING_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
>  $(OUTPUT)/cow: LDLIBS += $(IOURING_EXTRA_LIBS)
>
> +$(OUTPUT)/gup_longterm: LDLIBS += $(IOURING_EXTRA_LIBS)
> +
>  $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
>
>  $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> new file mode 100644
> index 000000000000..44a3617fd423
> --- /dev/null
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * GUP long-term page pinning tests.
> + *
> + * Copyright 2023, Red Hat, Inc.
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
> +#include <assert.h>
> +#include <sys/mman.h>
> +#include <sys/ioctl.h>
> +#include <sys/vfs.h>
> +#include <linux/magic.h>
> +#include <linux/memfd.h>
> +
> +#include "local_config.h"
> +
> +#include "../../../../mm/gup_test.h"
> +#include "../kselftest.h"
> +#include "vm_util.h"
> +
> +static size_t pagesize;
> +static int nr_hugetlbsizes;
> +static size_t hugetlbsizes[10];
> +static int gup_fd;
> +
> +static __fsword_t get_fs_type(int fd)
> +{
> +	struct statfs fs;
> +	int ret;
> +
> +	do {
> +		ret = fstatfs(fd, &fs);
> +	} while (ret && errno == EINTR);
> +
> +	return ret ? 0 : fs.f_type;
> +}
> +
> +static bool fs_is_unknown(__fsword_t fs_type)
> +{
> +	/*
> +	 * We only support some filesystems in our tests when dealing with
> +	 * R/W long-term pinning. For these filesystems, we can be fairly sure
> +	 * whether they support it or not.
> +	 */
> +	switch (fs_type) {
> +	case TMPFS_MAGIC:
> +	case HUGETLBFS_MAGIC:
> +	case BTRFS_SUPER_MAGIC:
> +	case EXT4_SUPER_MAGIC:
> +	case XFS_SUPER_MAGIC:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static bool fs_supports_writable_longterm_pinning(__fsword_t fs_type)
> +{
> +	assert(!fs_is_unknown(fs_type));
> +	switch (fs_type) {
> +	case TMPFS_MAGIC:
> +	case HUGETLBFS_MAGIC:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +enum test_type {
> +	TEST_TYPE_RO,
> +	TEST_TYPE_RO_FAST,
> +	TEST_TYPE_RW,
> +	TEST_TYPE_RW_FAST,
> +};
> +
> +static void do_test(int fd, size_t size, enum test_type type, bool shared)
> +{
> +	__fsword_t fs_type = get_fs_type(fd);
> +	bool should_work;
> +	char *mem;
> +	int ret;
> +
> +	if (ftruncate(fd, size)) {
> +		ksft_test_result_fail("ftruncate() failed\n");
> +		return;
> +	}
> +
> +	if (fallocate(fd, 0, 0, size)) {
> +		if (size == pagesize)
> +			ksft_test_result_fail("fallocate() failed\n");
> +		else
> +			ksft_test_result_skip("need more free huge pages\n");
> +		return;
> +	}
> +
> +	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
> +	if (mem == MAP_FAILED) {
> +		if (size == pagesize || shared)
> +			ksft_test_result_fail("mmap() failed\n");
> +		else
> +			ksft_test_result_skip("need more free huge pages\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Fault in the page writable such that GUP-fast can eventually pin
> +	 * it immediately.
> +	 */
> +	memset(mem, 0, size);

Nitty but why not just MAP_POPULATE?

> +
> +	switch (type) {
> +	case TEST_TYPE_RO:
> +	case TEST_TYPE_RO_FAST:
> +	case TEST_TYPE_RW:
> +	case TEST_TYPE_RW_FAST: {
> +		struct pin_longterm_test args;
> +		const bool fast = type == TEST_TYPE_RO_FAST ||
> +				  type == TEST_TYPE_RW_FAST;
 +		const bool rw = type == TEST_TYPE_RW ||
> +				type == TEST_TYPE_RW_FAST;
> +
> +		if (gup_fd < 0) {
> +			ksft_test_result_skip("gup_test not available\n");
> +			break;
> +		}
> +
> +		if (rw && shared && fs_is_unknown(fs_type)) {
> +			ksft_test_result_skip("Unknown filesystem\n");
> +			return;
> +		}
> +		/*
> +		 * R/O pinning or pinning in a private mapping is always
> +		 * expected to work. Otherwise, we expect long-term R/W pinning
> +		 * to only succeed for special fielesystems.
> +		 */
> +		should_work = !shared || !rw ||
> +			      fs_supports_writable_longterm_pinning(fs_type);
> +
> +		args.addr = (__u64)(uintptr_t)mem;
> +		args.size = size;
> +		args.flags = fast ? PIN_LONGTERM_TEST_FLAG_USE_FAST : 0;
> +		args.flags |= rw ? PIN_LONGTERM_TEST_FLAG_USE_WRITE : 0;
> +		ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
> +		if (ret && errno == EINVAL) {
> +			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed\n");
> +			break;
> +		} else if (ret && errno == EFAULT) {
> +			ksft_test_result(!should_work, "Should have failed\n");
> +			break;
> +		} else if (ret) {
> +			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed\n");
> +			break;
> +		}
> +
> +		if (ioctl(gup_fd, PIN_LONGTERM_TEST_STOP))
> +			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
> +
> +		/*
> +		 * TODO: if the kernel ever supports long-term R/W pinning on
> +		 * some previously unsupported filesystems, we might want to
> +		 * perform some additional tests for possible data corruptions.
> +		 */
> +		ksft_test_result(should_work, "Should have worked\n");
> +		break;
> +	}
> +	default:
> +		assert(false);
> +	}
> +
> +	munmap(mem, size);
> +}
> +
> +typedef void (*test_fn)(int fd, size_t size);
> +
> +static void run_with_memfd(test_fn fn, const char *desc)
> +{
> +	int fd;
> +
> +	ksft_print_msg("[RUN] %s ... with memfd\n", desc);
> +
> +	fd = memfd_create("test", 0);
> +	if (fd < 0) {
> +		ksft_test_result_fail("memfd_create() failed\n");
> +		return;
> +	}
> +
> +	fn(fd, pagesize);
> +	close(fd);
> +}
> +
> +static void run_with_tmpfile(test_fn fn, const char *desc)
> +{
> +	FILE *file;
> +	int fd;
> +
> +	ksft_print_msg("[RUN] %s ... with tmpfile\n", desc);
> +
> +	file = tmpfile();
> +	if (!file) {
> +		ksft_test_result_fail("tmpfile() failed\n");
> +		return;
> +	}
> +
> +	fd = fileno(file);
> +	if (fd < 0) {
> +		ksft_test_result_fail("fileno() failed\n");
> +		return;
> +	}
> +
> +	fn(fd, pagesize);
> +	fclose(file);
> +}
> +
> +static void run_with_local_tmpfile(test_fn fn, const char *desc)
> +{
> +	char filename[] = __FILE__"_tmpfile_XXXXXX";
> +	int fd;
> +
> +	ksft_print_msg("[RUN] %s ... with local tmpfile\n", desc);
> +
> +	fd = mkstemp(filename);
> +	if (fd < 0) {
> +		ksft_test_result_fail("mkstemp() failed\n");
> +		return;
> +	}
> +
> +	if (unlink(filename)) {
> +		ksft_test_result_fail("unlink() failed\n");
> +		goto close;
> +	}
> +
> +	fn(fd, pagesize);
> +close:
> +	close(fd);
> +}
> +
> +static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
> +				   size_t hugetlbsize)
> +{
> +	int flags = MFD_HUGETLB;
> +	int fd;
> +
> +	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
> +		       hugetlbsize / 1024);
> +
> +	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;

Hm this feels a little cute :)

> +
> +	fd = memfd_create("test", flags);
> +	if (fd < 0) {
> +		ksft_test_result_skip("memfd_create() failed\n");
> +		return;
> +	}
> +
> +	fn(fd, hugetlbsize);
> +	close(fd);
> +}
> +
> +struct test_case {
> +	const char *desc;
> +	test_fn fn;
> +};
> +
> +static void test_shared_rw_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RW, true);
> +}
> +
> +static void test_shared_rw_fast_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RW_FAST, true);
> +}
> +
> +static void test_shared_ro_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RO, true);
> +}
> +
> +static void test_shared_ro_fast_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RO_FAST, true);
> +}
> +
> +static void test_private_rw_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RW, false);
> +}
> +
> +static void test_private_rw_fast_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RW_FAST, false);
> +}
> +
> +static void test_private_ro_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RO, false);
> +}
> +
> +static void test_private_ro_fast_pin(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_RO_FAST, false);
> +}
> +
> +static const struct test_case test_cases[] = {
> +	{
> +		"R/W longterm GUP pin in MAP_SHARED file mapping",
> +		test_shared_rw_pin,
> +	},
> +	{
> +		"R/W longterm GUP-fast pin in MAP_SHARED file mapping",
> +		test_shared_rw_fast_pin,
> +	},
> +	{
> +		"R/O longterm GUP pin in MAP_SHARED file mapping",
> +		test_shared_ro_pin,
> +	},
> +	{
> +		"R/O longterm GUP-fast pin in MAP_SHARED file mapping",
> +		test_shared_ro_fast_pin,
> +	},
> +	{
> +		"R/W longterm GUP pin in MAP_PRIVATE file mapping",
> +		test_private_rw_pin,
> +	},
> +	{
> +		"R/W longterm GUP-fast pin in MAP_PRIVATE file mapping",
> +		test_private_rw_fast_pin,
> +	},
> +	{
> +		"R/O longterm GUP pin in MAP_PRIVATE file mapping",
> +		test_private_ro_pin,
> +	},
> +	{
> +		"R/O longterm GUP-fast pin in MAP_PRIVATE file mapping",
> +		test_private_ro_fast_pin,
> +	},
> +};
> +
> +static void run_test_case(struct test_case const *test_case)
> +{
> +	int i;
> +
> +	run_with_memfd(test_case->fn, test_case->desc);
> +	run_with_tmpfile(test_case->fn, test_case->desc);
> +	run_with_local_tmpfile(test_case->fn, test_case->desc);
> +	for (i = 0; i < nr_hugetlbsizes; i++)
> +		run_with_memfd_hugetlb(test_case->fn, test_case->desc,
> +				       hugetlbsizes[i]);
> +}
> +
> +static int tests_per_test_case(void)
> +{
> +	return 3 + nr_hugetlbsizes;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int i, err;
> +
> +	pagesize = getpagesize();
> +	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
> +						    ARRAY_SIZE(hugetlbsizes));
> +
> +	ksft_print_header();
> +	ksft_set_plan(ARRAY_SIZE(test_cases) * tests_per_test_case());
> +
> +	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> +
> +	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
> +		run_test_case(&test_cases[i]);
> +
> +	err = ksft_get_fail_cnt();
> +	if (err)
> +		ksft_exit_fail_msg("%d out of %d tests failed\n",
> +				   err, ksft_test_num());
> +	return ksft_exit_pass();
> +}
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 4893eb60d96d..b6b1eb6a8a6b 100644
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -24,7 +24,7 @@ separated by spaces:
>  - mmap
>  	tests for mmap(2)
>  - gup_test
> -	tests for gup using gup_test interface
> +	tests for gup

Super nitty again, but I'm guessing this means the CONFIG_GUP_TEST
interface, perhaps worth keeping?

>  - userfaultfd
>  	tests for  userfaultfd(2)
>  - compaction
> @@ -196,6 +196,8 @@ CATEGORY="gup_test" run_test ./gup_test -a
>  # Dump pages 0, 19, and 4096, using pin_user_pages:
>  CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
>
> +CATEGORY="gup_test" run_test ./gup_longterm
> +
>  CATEGORY="userfaultfd" run_test ./uffd-unit-tests
>  uffd_stress_bin=./uffd-stress
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
> --
> 2.40.1
>

OK this patch is really nice + well implemented, I can only point out a
couple EXTREMELY nitty comments :) Thanks very much for adding a test for
this, it's super useful!

Therefore,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
