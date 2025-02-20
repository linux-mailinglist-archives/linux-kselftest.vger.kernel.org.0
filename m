Return-Path: <linux-kselftest+bounces-27079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94FFA3DE9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D911A1883B87
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C862F1EEA27;
	Thu, 20 Feb 2025 15:32:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6611D5AA0;
	Thu, 20 Feb 2025 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065556; cv=none; b=s8kWUMskTuoAfc7gYJ87/VoUOeTF8MAbKuVyZuq0CssMRwehb7Ohw0zhu/o+zyMHaBTUBzyTTSFGRuYCjiXy/TlqPcirvXXoqfC+CH9kYqUd5XWsTQBH1CD/OUVBFstAVKa4fcPvNWT2MoZ+pqFYw/OnmJOgqOqkvRKch/lWCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065556; c=relaxed/simple;
	bh=Pi33kls6Ei68GLKOGLPPA9sBFFLRww40fx6lP4Kt8UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9CWyysyY7z6Gm3EHINXK3w95abIE77PcFbLiGIpjPzelSK2b7hobS3Gh//ptFvk+SjETvFniEJykpNHO5trZ+uisFN6CCLPtxfIRKLARA25XjhK+ljAUyovvxf9KCND16RfNWMTJawOkpLE3T+3fhVGklHFkWgG/Pnl3ITiz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7BD16F3;
	Thu, 20 Feb 2025 07:32:51 -0800 (PST)
Received: from [10.163.39.71] (unknown [10.163.39.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E5F93F59E;
	Thu, 20 Feb 2025 07:32:30 -0800 (PST)
Message-ID: <6d1a298f-6af9-4568-b171-cb4a83121a95@arm.com>
Date: Thu, 20 Feb 2025 21:02:26 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] selftests/mm: Report errno when things fail
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-1-9bbf57d64463@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250220-mm-selftests-v1-1-9bbf57d64463@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/02/25 8:33 pm, Brendan Jackman wrote:
> Just reporting failure doesn't tell you what went wrong. This can fail
> in different ways so report errno to help the reader get started
> debugging.

IMHO it would be even better if we reported strerror(errno).

> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/mm/gup_longterm.c | 32 +++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index 9423ad439a6140163bdef2974615bb86406a8c14..46a2139b3a646f6c050eb031a770f615be76c433 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -96,13 +96,13 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   	int ret;
>   
>   	if (ftruncate(fd, size)) {
> -		ksft_test_result_fail("ftruncate() failed\n");
> +		ksft_test_result_fail("ftruncate() failed (%d)\n", errno);
>   		return;
>   	}
>   
>   	if (fallocate(fd, 0, 0, size)) {
>   		if (size == pagesize)
> -			ksft_test_result_fail("fallocate() failed\n");
> +			ksft_test_result_fail("fallocate() failed (%d)\n", errno);
>   		else
>   			ksft_test_result_skip("need more free huge pages\n");
>   		return;
> @@ -112,7 +112,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
>   	if (mem == MAP_FAILED) {
>   		if (size == pagesize || shared)
> -			ksft_test_result_fail("mmap() failed\n");
> +			ksft_test_result_fail("mmap() failed (%d)\n", errno);
>   		else
>   			ksft_test_result_skip("need more free huge pages\n");
>   		return;
> @@ -130,7 +130,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		 */
>   		ret = mprotect(mem, size, PROT_READ);
>   		if (ret) {
> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_test_result_fail("mprotect() failed (%d)\n", errno);
>   			goto munmap;
>   		}
>   		/* FALLTHROUGH */
> @@ -165,18 +165,18 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		args.flags |= rw ? PIN_LONGTERM_TEST_FLAG_USE_WRITE : 0;
>   		ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
>   		if (ret && errno == EINVAL) {
> -			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed\n");
> +			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed (EINVAL)n");
>   			break;
>   		} else if (ret && errno == EFAULT) {
>   			ksft_test_result(!should_work, "Should have failed\n");
>   			break;
>   		} else if (ret) {
> -			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed\n");
> +			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed (%d)\n", errno);
>   			break;
>   		}
>   
>   		if (ioctl(gup_fd, PIN_LONGTERM_TEST_STOP))
> -			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
> +			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed (%d)\n", errno);
>   
>   		/*
>   		 * TODO: if the kernel ever supports long-term R/W pinning on
> @@ -202,7 +202,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		/* Skip on errors, as we might just lack kernel support. */
>   		ret = io_uring_queue_init(1, &ring, 0);
>   		if (ret < 0) {
> -			ksft_test_result_skip("io_uring_queue_init() failed\n");
> +			ksft_test_result_skip("io_uring_queue_init() failed (%d)\n", errno);
>   			break;
>   		}
>   		/*
> @@ -215,13 +215,13 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		/* Only new kernels return EFAULT. */
>   		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
>   			    errno == EFAULT)) {
> -			ksft_test_result(!should_work, "Should have failed\n");
> +			ksft_test_result(!should_work, "Should have failed (%d)\n", errno);
>   		} else if (ret) {
>   			/*
>   			 * We might just lack support or have insufficient
>   			 * MEMLOCK limits.
>   			 */
> -			ksft_test_result_skip("io_uring_register_buffers() failed\n");
> +			ksft_test_result_skip("io_uring_register_buffers() failed (%d)\n", errno);
>   		} else {
>   			ksft_test_result(should_work, "Should have worked\n");
>   			io_uring_unregister_buffers(&ring);
> @@ -249,7 +249,7 @@ static void run_with_memfd(test_fn fn, const char *desc)
>   
>   	fd = memfd_create("test", 0);
>   	if (fd < 0) {
> -		ksft_test_result_fail("memfd_create() failed\n");
> +		ksft_test_result_fail("memfd_create() failed (%d)\n", errno);
>   		return;
>   	}
>   
> @@ -266,13 +266,13 @@ static void run_with_tmpfile(test_fn fn, const char *desc)
>   
>   	file = tmpfile();
>   	if (!file) {
> -		ksft_test_result_fail("tmpfile() failed\n");
> +		ksft_test_result_fail("tmpfile() failed (%d)\n", errno);
>   		return;
>   	}
>   
>   	fd = fileno(file);
>   	if (fd < 0) {
> -		ksft_test_result_fail("fileno() failed\n");
> +		ksft_test_result_fail("fileno() failed (%d)\n", errno);
>   		goto close;
>   	}
>   
> @@ -290,12 +290,12 @@ static void run_with_local_tmpfile(test_fn fn, const char *desc)
>   
>   	fd = mkstemp(filename);
>   	if (fd < 0) {
> -		ksft_test_result_fail("mkstemp() failed\n");
> +		ksft_test_result_fail("mkstemp() failed (%d)\n", errno);
>   		return;
>   	}
>   
>   	if (unlink(filename)) {
> -		ksft_test_result_fail("unlink() failed\n");
> +		ksft_test_result_fail("unlink() failed (%d)\n", errno);
>   		goto close;
>   	}
>   
> @@ -317,7 +317,7 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
>   
>   	fd = memfd_create("test", flags);
>   	if (fd < 0) {
> -		ksft_test_result_skip("memfd_create() failed\n");
> +		ksft_test_result_skip("memfd_create() failed (%d)\n", errno);
>   		return;
>   	}
>   
> 


