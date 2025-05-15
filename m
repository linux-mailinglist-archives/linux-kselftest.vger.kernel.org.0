Return-Path: <linux-kselftest+bounces-33073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08E3AB82DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEE74E0709
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271D298C03;
	Thu, 15 May 2025 09:35:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD11298267;
	Thu, 15 May 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301715; cv=none; b=GOKoiSjiUYJdjZWkw6PTgOFB6epi8bJC68rYO5ui5BS7VWlJt6CEsOEAWh8WZ/FnwwZLl+kYqkBQDj/S13v/x32kzPgFRCwIWEF26OAFBT7Wj1aoBn0Xtw7IXqJilIFDr/6lplFM8J/YQF2eLuM54m1+hZWeq3MBmM2NubENap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301715; c=relaxed/simple;
	bh=freysB+g9fhe+V62LUYiA97zFZ0MZ3scrNYKCoebgEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aduoDP60DjvxZUn1x2KmwRWasCO++xPtWCEK2t1ps6Ri6V7+ceHEHpuJerg01L1CyPCWw886nUUPBEGglu6KQMkn0UKdxl4QaXLyM/fRd53JfD84nfnoJ/s7D67/rCNm1Z4ADuD1T8IM2p84z/IpR6rXIPs3ChHTWGAo4NSn4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECF6314BF;
	Thu, 15 May 2025 02:35:00 -0700 (PDT)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95A7E3F5A1;
	Thu, 15 May 2025 02:35:10 -0700 (PDT)
Message-ID: <7c2f66f9-a928-4fda-bf3e-4180c7525fef@arm.com>
Date: Thu, 15 May 2025 15:05:07 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/05/25 2:27 pm, Mark Brown wrote:
> The kselftest framework uses the string logged when a test result is
> reported as the unique identifier for a test, using it to track test
> results between runs. The gup_longterm test completely fails to follow
> this pattern, it runs a single test function repeatedly with various
> parameters but each result report is a string logging an error message
> which is fixed between runs.
> 
> Since the code already logs each test uniquely before it starts refactor
> to also print this to a buffer, then use that name as the test result.
> This isn't especially pretty, really this test could use a more
> substantial cleanup.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/gup_longterm.c | 163 ++++++++++++++++++++----------
>   1 file changed, 107 insertions(+), 56 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index 21595b20bbc3..a849537f9372 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -35,6 +35,8 @@ static int nr_hugetlbsizes;
>   static size_t hugetlbsizes[10];
>   static int gup_fd;
>   
> +static char test_name[1024];
> +
>   static __fsword_t get_fs_type(int fd)
>   {
>   	struct statfs fs;
> @@ -93,33 +95,48 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   	__fsword_t fs_type = get_fs_type(fd);
>   	bool should_work;
>   	char *mem;
> +	int result = KSFT_PASS;
>   	int ret;
>   
> +	if (fd < 0) {
> +		result = KSFT_FAIL;
> +		goto report;
> +	}
> +
>   	if (ftruncate(fd, size)) {
>   		if (errno == ENOENT) {
>   			skip_test_dodgy_fs("ftruncate()");
>   		} else {
> -			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
> +			ksft_print_msg("ftruncate() failed (%s)\n",
> +				       strerror(errno));
> +			result = KSFT_FAIL;
> +			goto report;
>   		}
>   		return;
>   	}
>   
>   	if (fallocate(fd, 0, 0, size)) {
> -		if (size == pagesize)
> -			ksft_test_result_fail("fallocate() failed (%s)\n", strerror(errno));
> -		else
> -			ksft_test_result_skip("need more free huge pages\n");
> -		return;
> +		if (size == pagesize) {
> +			ksft_print_msg("fallocate() failed (%s)\n", strerror(errno));
> +			result = KSFT_FAIL;
> +		} else {
> +			ksft_print_msg("need more free huge pages\n");
> +			result = KSFT_SKIP;
> +		}
> +		goto report;
>   	}
>   
>   	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
>   		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
>   	if (mem == MAP_FAILED) {
> -		if (size == pagesize || shared)
> -			ksft_test_result_fail("mmap() failed (%s)\n", strerror(errno));
> -		else
> -			ksft_test_result_skip("need more free huge pages\n");
> -		return;
> +		if (size == pagesize || shared) {
> +			ksft_print_msg("mmap() failed (%s)\n", strerror(errno));
> +			result = KSFT_FAIL;
> +		} else {
> +			ksft_print_msg("need more free huge pages\n");
> +			result = KSFT_SKIP;
> +		}
> +		goto report;
>   	}
>   
>   	/* Fault in the page such that GUP-fast can pin it directly. */
> @@ -134,7 +151,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		 */
>   		ret = mprotect(mem, size, PROT_READ);
>   		if (ret) {
> -			ksft_test_result_fail("mprotect() failed (%s)\n", strerror(errno));
> +			ksft_print_msg("mprotect() failed (%s)\n", strerror(errno));
> +			result = KSFT_FAIL;
>   			goto munmap;
>   		}
>   		/* FALLTHROUGH */
> @@ -147,12 +165,14 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   				type == TEST_TYPE_RW_FAST;
>   
>   		if (gup_fd < 0) {
> -			ksft_test_result_skip("gup_test not available\n");
> +			ksft_print_msg("gup_test not available\n");
> +			result = KSFT_SKIP;
>   			break;
>   		}
>   
>   		if (rw && shared && fs_is_unknown(fs_type)) {
> -			ksft_test_result_skip("Unknown filesystem\n");
> +			ksft_print_msg("Unknown filesystem\n");
> +			result = KSFT_SKIP;
>   			return;
>   		}
>   		/*
> @@ -169,14 +189,19 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		args.flags |= rw ? PIN_LONGTERM_TEST_FLAG_USE_WRITE : 0;
>   		ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
>   		if (ret && errno == EINVAL) {
> -			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed (EINVAL)n");
> +			ksft_print_msg("PIN_LONGTERM_TEST_START failed (EINVAL)n");
> +			result = KSFT_SKIP;
>   			break;
>   		} else if (ret && errno == EFAULT) {
> -			ksft_test_result(!should_work, "Should have failed\n");
> +			if (should_work)
> +				result = KSFT_FAIL;
> +			else
> +				result = KSFT_PASS;
>   			break;
>   		} else if (ret) {
> -			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed (%s)\n",
> -					      strerror(errno));
> +			ksft_print_msg("PIN_LONGTERM_TEST_START failed (%s)\n",
> +				       strerror(errno));
> +			result = KSFT_FAIL;
>   			break;
>   		}
>   
> @@ -189,7 +214,10 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		 * some previously unsupported filesystems, we might want to
>   		 * perform some additional tests for possible data corruptions.
>   		 */
> -		ksft_test_result(should_work, "Should have worked\n");
> +		if (should_work)
> +			result = KSFT_PASS;

Missed printing "Should have worked" here.

> +		else
> +			result = KSFT_FAIL;
>   		break;
>   	}
>   #ifdef LOCAL_CONFIG_HAVE_LIBURING
> @@ -199,8 +227,9 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   
>   		/* io_uring always pins pages writable. */
>   		if (shared && fs_is_unknown(fs_type)) {
> -			ksft_test_result_skip("Unknown filesystem\n");
> -			return;
> +			ksft_print_msg("Unknown filesystem\n");
> +			result = KSFT_SKIP;
> +			goto report;
>   		}
>   		should_work = !shared ||
>   			      fs_supports_writable_longterm_pinning(fs_type);
> @@ -208,8 +237,9 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		/* Skip on errors, as we might just lack kernel support. */
>   		ret = io_uring_queue_init(1, &ring, 0);
>   		if (ret < 0) {
> -			ksft_test_result_skip("io_uring_queue_init() failed (%s)\n",
> -					      strerror(-ret));
> +			ksft_print_msg("io_uring_queue_init() failed (%s)\n",
> +				       strerror(-ret));
> +			result = KSFT_SKIP;
>   			break;
>   		}
>   		/*
> @@ -222,17 +252,28 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		/* Only new kernels return EFAULT. */
>   		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
>   			    errno == EFAULT)) {
> -			ksft_test_result(!should_work, "Should have failed (%s)\n",
> -					 strerror(errno));
> +			if (should_work) {
> +				ksft_print_msg("Should have failed (%s)\n",
> +					       strerror(errno));
> +				result = KSFT_FAIL;
> +			} else {
> +				result = KSFT_PASS;
> +			}
>   		} else if (ret) {
>   			/*
>   			 * We might just lack support or have insufficient
>   			 * MEMLOCK limits.
>   			 */
> -			ksft_test_result_skip("io_uring_register_buffers() failed (%s)\n",
> -					      strerror(-ret));
> +			ksft_print_msg("io_uring_register_buffers() failed (%s)\n",
> +				       strerror(-ret));
> +			result = KSFT_SKIP;
>   		} else {
> -			ksft_test_result(should_work, "Should have worked\n");
> +			if (should_work) {
> +				result = KSFT_PASS;
> +			} else {
> +				ksft_print_msg("Should have worked\n");
> +				result = KSFT_FAIL;
> +			}
>   			io_uring_unregister_buffers(&ring);
>   		}
>   
> @@ -246,21 +287,32 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   
>   munmap:
>   	munmap(mem, size);
> +report:
> +	ksft_test_result(result, "%s\n", test_name);
>   }
>   
>   typedef void (*test_fn)(int fd, size_t size);
>   
> +static void log_test_start(const char *name, ...)
> +{
> +	va_list args;
> +	va_start(args, name);
> +
> +	vsnprintf(test_name, sizeof(test_name), name, args);
> +	ksft_print_msg("[RUN] %s\n", test_name);
> +
> +	va_end(args);
> +}
> +
>   static void run_with_memfd(test_fn fn, const char *desc)
>   {
>   	int fd;
>   
> -	ksft_print_msg("[RUN] %s ... with memfd\n", desc);
> +	log_test_start("%s ... with memfd", desc);
>   
>   	fd = memfd_create("test", 0);
> -	if (fd < 0) {
> -		ksft_test_result_fail("memfd_create() failed (%s)\n", strerror(errno));
> -		return;
> -	}
> +	if (fd < 0)
> +		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
>   
>   	fn(fd, pagesize);
>   	close(fd);
> @@ -271,23 +323,23 @@ static void run_with_tmpfile(test_fn fn, const char *desc)
>   	FILE *file;
>   	int fd;
>   
> -	ksft_print_msg("[RUN] %s ... with tmpfile\n", desc);
> +	log_test_start("%s ... with tmpfile", desc);
>   
>   	file = tmpfile();
>   	if (!file) {
> -		ksft_test_result_fail("tmpfile() failed (%s)\n", strerror(errno));
> -		return;
> -	}
> -
> -	fd = fileno(file);
> -	if (fd < 0) {
> -		ksft_test_result_fail("fileno() failed (%s)\n", strerror(errno));
> -		goto close;
> +		ksft_print_msg("tmpfile() failed (%s)\n", strerror(errno));
> +		fd = -1;
> +	} else {
> +		fd = fileno(file);
> +		if (fd < 0) {
> +			ksft_print_msg("fileno() failed (%s)\n", strerror(errno));
> +		}
>   	}
>   
>   	fn(fd, pagesize);
> -close:
> -	fclose(file);
> +
> +	if (file)
> +		fclose(file);
>   }
>   
>   static void run_with_local_tmpfile(test_fn fn, const char *desc)
> @@ -295,22 +347,22 @@ static void run_with_local_tmpfile(test_fn fn, const char *desc)
>   	char filename[] = __FILE__"_tmpfile_XXXXXX";
>   	int fd;
>   
> -	ksft_print_msg("[RUN] %s ... with local tmpfile\n", desc);
> +	log_test_start("%s ... with local tmpfile", desc);
>   
>   	fd = mkstemp(filename);
> -	if (fd < 0) {
> -		ksft_test_result_fail("mkstemp() failed (%s)\n", strerror(errno));
> -		return;
> -	}
> +	if (fd < 0)
> +		ksft_print_msg("mkstemp() failed (%s)\n", strerror(errno));
>   
>   	if (unlink(filename)) {
> -		ksft_test_result_fail("unlink() failed (%s)\n", strerror(errno));
> -		goto close;
> +		ksft_print_msg("unlink() failed (%s)\n", strerror(errno));
> +		close(fd);
> +		fd = -1;
>   	}
>   
>   	fn(fd, pagesize);
> -close:
> -	close(fd);
> +
> +	if (fd >= 0)
> +		close(fd);
>   }
>   
>   static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
> @@ -319,15 +371,14 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
>   	int flags = MFD_HUGETLB;
>   	int fd;
>   
> -	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
> +	log_test_start("%s ... with memfd hugetlb (%zu kB)", desc,
>   		       hugetlbsize / 1024);
>   
>   	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
>   
>   	fd = memfd_create("test", flags);
>   	if (fd < 0) {
> -		ksft_test_result_skip("memfd_create() failed (%s)\n", strerror(errno));
> -		return;
> +		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
>   	}
>   
>   	fn(fd, hugetlbsize);
> 
> ---
> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> change-id: 20250514-selftests-mm-gup-longterm-dups-68aa4e0fcc88
> 
> Best regards,


