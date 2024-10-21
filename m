Return-Path: <linux-kselftest+bounces-20325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA60D9A9211
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 23:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54BD1C22CD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24601FCF41;
	Mon, 21 Oct 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XhbJyo7A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFF1C9EDA
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546325; cv=none; b=PIenh83F7GnFHjObhEMwIg2fdS5fDxnf0jzF9JayRvYhvJ/dePDJ/lntD8sEQt0uAoqS18gxfzZSQ+GGssD3tXp/bzAUQRJ/f2g+1eCCUesSaT4QbImuDOUqrmrV3k2F4kEwCOlg7WGaMOfftsnW/CqYFFvZe2/CyHa7HLGVdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546325; c=relaxed/simple;
	bh=+JB9n5wTRqE8sZoIwUnh/7ZLskwahvOgmqhmETKnBZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO4LZ6yqe2Okk0a0x5s9N9/xFG6LsDJYd79ekuEx2Vj6z0i4YtCe8nL/JxH9+6ndkYQICDkU1yw97XFEl5TkraoUA9XHTVqmMJgz850JiwaZo0vUAQGvJ7uq+aeVMzw1KZsXOCGq7EzBbAhZc2rWckStY9b16M8r2xYr/qk30DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XhbJyo7A; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83ab21c26e5so188820839f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729546322; x=1730151122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=paXKAdDCbh8sHpFq/BpzuFt1t606tSHtvOs61brMXyY=;
        b=XhbJyo7A/RpinDk9JIlVxz/VwxjGgbhRunNzroTe1jpqTR8Ys3kINGeskc7eOKnsMV
         ISQiewPYR8afGfbMNunQYyWAN2QMNV15HX7UR7HOrLbW0FAZ77WIgN017Kmf6V5Lj5it
         KXRd6j9GuklKqtrh8970oOk5l7EBLcY0W5fSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546322; x=1730151122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paXKAdDCbh8sHpFq/BpzuFt1t606tSHtvOs61brMXyY=;
        b=DhVIjwmdKW/wLlJJcL5ZmSEeYpt+bSlsCE24sBSyYuSfofEGpk6upiuPRYTBGWjuZa
         lWW9iq2xh/JSEsfQMxr7Ms2qXuBM3o6CqKm+ynlFQZfLUCPDGYxaUP3q/fpIgunhG8/Z
         D87YjRO4pu6Duz+aF2kCUHkJJ6KaA4fVVqltvhNUDviNbG+fdKmTFChanGDcxCiNUKSS
         PVpAzPXar9cd+mgjyv4aw8+avI687hXEQrvv+wDtpW60C/8Am0aiT/nmeJuBFgrIHI8M
         4wzSp6Ub5Umjyx3ibhPK3P7fwF+QkYeNvW3pLif3yBmum071rXGgjsRMjvfE33wWGDBk
         9fvw==
X-Forwarded-Encrypted: i=1; AJvYcCXtwCp2dBMQ7sHE5DqN7yuOvM7m5+ee/8RUnDQxklJU+EwF74IEG8cHBs38w1emFojwdLBaPBD7Yn4PRoCSCSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZc9bFEXmLU5lqEfSM+NN+HhQKffJYZc9nM82hKeA6jFdTWOG
	4lgthJ5P9B6nlni+6IS25zU5nVsU+vkXPcunyThx5ADWxDRMOdI4jALmxB7RFbk=
X-Google-Smtp-Source: AGHT+IGJW8jlcC/yU06sLutaC98aTYwDhazap3Qy/Nz926gm8HncTJMWnKxkTTr2+dGJYQK5IhR+qg==
X-Received: by 2002:a05:6602:2dcb:b0:835:3ffe:fe31 with SMTP id ca18e2360f4ac-83aba612b82mr1526697439f.8.1729546321703;
        Mon, 21 Oct 2024 14:32:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ad1c4e380sm126760239f.13.2024.10.21.14.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 14:32:01 -0700 (PDT)
Message-ID: <360241aa-49ec-42b1-99c9-759a9a0873a0@linuxfoundation.org>
Date: Mon, 21 Oct 2024 15:31:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] selftests/mm: add self tests for guard page
 feature
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <090ed13db09bc25863a78eba902d8bf2c6534ced.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <090ed13db09bc25863a78eba902d8bf2c6534ced.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/24 10:20, Lorenzo Stoakes wrote:
> Utilise the kselftest harmness to implement tests for the guard page
> implementation.
> 
> We start by implement basic tests asserting that guard pages can be
> established (poisoned), cleared (remedied) and that touching poisoned pages
> result in SIGSEGV. We also assert that, in remedying a range, non-poison
> pages remain intact.
> 
> We then examine different operations on regions containing poison markers
> behave to ensure correct behaviour:
> 
> * Operations over multiple VMAs operate as expected.
> * Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
>    batches works correctly.
> * Ensuring that munmap() correctly tears down poison markers.
> * Using mprotect() to adjust protection bits does not in any way override
>    or cause issues with poison markers.
> * Ensuring that splitting and merging VMAs around poison markers causes no
>    issue - i.e. that a marker which 'belongs' to one VMA can function just
>    as well 'belonging' to another.
> * Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
> * Ensuring that mlock()'ing a range containing poison markers does not
>    cause issues.
> * Ensuring that mremap() can move a poisoned range and retain poison
>    markers.
> * Ensuring that mremap() can expand a poisoned range and retain poison
>    markers (perhaps moving the range).
> * Ensuring that mremap() can shrink a poisoned range and retain poison
>    markers.
> * Ensuring that forking a process correctly retains poison markers.
> * Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
> * Ensuring that lazyfree simply clears poison markers.
> * Ensuring that userfaultfd can co-exist with guard pages.
> * Ensuring that madvise(..., MADV_POPULATE_READ) and
>    madvise(..., MADV_POPULATE_WRITE) error out when encountering
>    poison markers.
> * Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
>    not remove poison markers.
> 
> If any test is unable to be run due to lack of permissions, that test is
> skipped.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   tools/testing/selftests/mm/.gitignore    |    1 +
>   tools/testing/selftests/mm/Makefile      |    1 +
>   tools/testing/selftests/mm/guard-pages.c | 1228 ++++++++++++++++++++++
>   3 files changed, 1230 insertions(+)
>   create mode 100644 tools/testing/selftests/mm/guard-pages.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 689bbd520296..8f01f4da1c0d 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -54,3 +54,4 @@ droppable
>   hugetlb_dio
>   pkey_sighandler_tests_32
>   pkey_sighandler_tests_64
> +guard-pages
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 02e1204971b0..15c734d6cfec 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
>   TEST_GEN_FILES += hugetlb_madv_vs_map
>   TEST_GEN_FILES += hugetlb_dio
>   TEST_GEN_FILES += droppable
> +TEST_GEN_FILES += guard-pages
>   
>   ifneq ($(ARCH),arm64)
>   TEST_GEN_FILES += soft-dirty
> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
> new file mode 100644
> index 000000000000..f67d2700d44a
> --- /dev/null
> +++ b/tools/testing/selftests/mm/guard-pages.c
> @@ -0,0 +1,1228 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <asm-generic/mman.h> /* Force the import of the tools version. */
> +#include <assert.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/userfaultfd.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <sys/uio.h>
> +#include <unistd.h>
> +
> +/*
> + * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
> + *
> + * "If the signal occurs other than as the result of calling the abort or raise
> + *  function, the behavior is undefined if the signal handler refers to any
> + *  object with static storage duration other than by assigning a value to an
> + *  object declared as volatile sig_atomic_t"
> + */
> +static volatile sig_atomic_t signal_jump_set;
> +static sigjmp_buf signal_jmp_buf;
> +
> +/*
> + * Ignore the checkpatch warning, we must read from x but don't want to do
> + * anything with it in order to trigger a read page fault. We therefore must use
> + * volatile to stop the compiler from optimising this away.
> + */
> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


