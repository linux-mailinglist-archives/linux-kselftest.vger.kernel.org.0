Return-Path: <linux-kselftest+bounces-36186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD4AAEFA12
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 15:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F8C445E9A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E6274656;
	Tue,  1 Jul 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk4uYSuS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BC26FDBD
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375921; cv=none; b=ksXbmbdbyOx5jbMbF2Bb/p+tmQyGtE4H5lySf+qhHX5gtCqZyoFJqC09iUnz2ru54rLQkg1f25ioqGb9A3GXarrfujYIHWmIyG5x/tGCPcPPyczvi8G/rp+VybDqXr5aMwdE3lHC71lWgIl/FWkXnw4vc3M8OnsCgi0/nTOdqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375921; c=relaxed/simple;
	bh=uCzRcBNaIf1ptDo8QyF7J4sO3VPLK+N9zJ4rjyKfzCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7lQ97cC5rgvo6RUkxVhfzwq2C9Rs1V2iLG6ORnAK/NJd6j1WEzKQP1r7MxZ/pkh/7Mq2dArgkaSi2YoI4eoZP3uHGuH026G44JMvEAT+VOzBphNTMlf/IRY7TA3+mTXzb6Khdndv7/OdQf7S+SNVN7/g/uUn7aNFMRcyJQnutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bk4uYSuS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751375918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BlkDEnXs3gwtKFtbej8eyp0snNnm4feYg7i77xZtujI=;
	b=Bk4uYSuSxRQG4VvJGJaFmx7ZkGSWi69bq0xsuOP4FTit7W3Bl4eGpYeJdPjnQXnYzqcQa1
	KVeDNfQJodm3q40HkxXjVacANv7Ak6UWr4JLqJJrstaHgxK5HOZH3lje7R8RCXBPOh2E/b
	IqdqcQ9pdquhW7akq7m0PuVOQlyiK2U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-DSUZoaonPFCgdwzG9tlr_Q-1; Tue, 01 Jul 2025 09:18:36 -0400
X-MC-Unique: DSUZoaonPFCgdwzG9tlr_Q-1
X-Mimecast-MFC-AGG-ID: DSUZoaonPFCgdwzG9tlr_Q_1751375915
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso1625398f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 06:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375915; x=1751980715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BlkDEnXs3gwtKFtbej8eyp0snNnm4feYg7i77xZtujI=;
        b=OnHUkuI+E703UxFn/G0LFrMqeHmGxHffN4HMB2HJcklVmJAG40YBqire1GByRYBESN
         ELS3Fh8GUUbreC+Cnnplh/yyiN/R/6aWCy577Z0AFl9+u1EUeAcAt5v/DThN68U9dw8q
         7anyafLmfLbBQ4G31Le9OmtD0h/H0k2vyRpuIOem2oi4wxN2hZ/IjLubo/THVLzOSdJI
         q8j3GLujhPJnmoDoEcn67sM13rK5zglE1IS7u01z7HEz8Vzm1MUCMRl4lSzWcBoJ5tFo
         f/OQZBJu3ZEeBq3ImVU8ur71vW7BPfNta9oio0PMK1RkkADToPfrzY+ltJcK+3ei/hLo
         1ASA==
X-Forwarded-Encrypted: i=1; AJvYcCV6N1Xsnz8tBRAIF5x6C0qMDSOZ2gRHlnCD1J6973Ld9x+eECyeNGmMK2X2mIMr58avy0GNFFPcsvAdrD2lMmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFZYM9NJW1MMR/ulAnvC8KUi1ypMQ5NaS5sLqg+nhAbQLPJZk
	pln9UJFY9plKi10DYkAGFA4ZMwxR12zhHdm5mU3GwI+eqYgmde0bQOgqt86qEcP38McaaWFz6Ib
	gK1PwReyC8l6TRtOgKcZQcFqwl2X76OU/HN50Y6Dts+ia0imrkm/YJQ8EB1UOd5PQVDRmDg==
X-Gm-Gg: ASbGncukuW3irtPUjQWN9nrZwQXH4qB5dD4fYD2YyKdTHcW6BLF/TValcCsjOsD4gng
	uwIHoXOF1spHktKBhUTncHXSt7SJqDRseRmBDzwlNwrvyiKFDPrfTi8vAXqiA35rtVJTt5RRPEe
	mTErShXOxiYsAGQEbwtrF+6DMdMZroLM0uV7fQyoupZHdUN5i5LqfpapN+CA01iy8k+ovCOZfVw
	/C4D3wul+xqPCrnlr1j2JdSIB2y6cjDOI45rcCQJo7Oy4tUz0z5ZsO9x/OBvdEE6s1cuZWTXmPu
	8hrQ3mYhkzbvkcBsDFPNnaR/WQ43ig9/3jMl/XQ5FVTQsvGAYAhEaiatCLNuUuJyFV6HlQgEeki
	XjgFl2N0CzOQIoPtGKI0u7CU47Dygt+Kt1sXDo8LNuB3p4laD5A==
X-Received: by 2002:a05:6000:652:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3a8fdb2a48amr12165684f8f.19.1751375914838;
        Tue, 01 Jul 2025 06:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ8tYTLOZ3vNvHB+6DJkrSdk7Wjj/zPzJNrnZJtssmPjKuQlHDrC4yMLBxRm+p274FM16AXg==
X-Received: by 2002:a05:6000:652:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3a8fdb2a48amr12165645f8f.19.1751375914336;
        Tue, 01 Jul 2025 06:18:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234b382sm197370235e9.9.2025.07.01.06.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:18:33 -0700 (PDT)
Message-ID: <1d67a048-00c0-4d2b-96ec-5e8d6d672dbd@redhat.com>
Date: Tue, 1 Jul 2025 15:18:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: Add process_madvise() tests
To: wang lian <lianux.mm@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, brauner@kernel.org, gkwang@linx-info.com,
 jannh@google.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, p1ucky0923@gmail.com, ryncsn@gmail.com,
 shuah@kernel.org, sj@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me
References: <20250630140957.4000-1-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250630140957.4000-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 16:09, wang lian wrote:
> This patch adds tests for the process_madvise(), focusing on
> verifying behavior under various conditions including valid
> usage and error cases.
> 
> Signed-off-by: wang lian<lianux.mm@gmail.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Changelog v2:
> - Drop MADV_DONTNEED tests based on feedback
> - Focus solely on process_madvise() syscall
> - Improve error handling and structure
> - Add future-proof flag test
> - Style and comment cleanups
> 
>   tools/testing/selftests/mm/.gitignore     |   1 +
>   tools/testing/selftests/mm/Makefile       |   1 +
>   tools/testing/selftests/mm/process_madv.c | 414 ++++++++++++++++++++++
>   tools/testing/selftests/mm/run_vmtests.sh |   5 +
>   4 files changed, 421 insertions(+)
>   create mode 100644 tools/testing/selftests/mm/process_madv.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 911f39d634be..a8c3be02188c 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -42,6 +42,7 @@ memfd_secret
>   hugetlb_dio
>   pkey_sighandler_tests_32
>   pkey_sighandler_tests_64
> +process_madv
>   soft-dirty
>   split_huge_page_test
>   ksm_tests
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 2352252f3914..725612e09582 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -86,6 +86,7 @@ TEST_GEN_FILES += mseal_test
>   TEST_GEN_FILES += on-fault-limit
>   TEST_GEN_FILES += pagemap_ioctl
>   TEST_GEN_FILES += pfnmap
> +TEST_GEN_FILES += process_madv
>   TEST_GEN_FILES += thuge-gen
>   TEST_GEN_FILES += transhuge-stress
>   TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
> new file mode 100644
> index 000000000000..73999c8e3570
> --- /dev/null
> +++ b/tools/testing/selftests/mm/process_madv.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <errno.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/pidfd.h>
> +#include "vm_util.h"
> +
> +#include "../pidfd/pidfd.h"
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

Instead of copying that, it should probably be moved to vm_util.h.

Essentially, also the comments for signal_jump_set are copy-pasted from 
guard-regions.c. Is there a way to avoid that?

For example, we could place stuff like signal_jump_set in vm_util.c instead.

> +
> +static void handle_fatal(int c)
> +{
> +	if (!signal_jump_set)
> +		return;
> +
> +	siglongjmp(signal_jmp_buf, c);
> +}

Also copy-pasted.

> +
> +FIXTURE(process_madvise)
> +{
> +	int pidfd;
> +	int flag;
> +};
> +
> +static void setup_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = &handle_fatal,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL))
> +		ksft_exit_fail_perror("sigaction");
> +}
> +
> +static void teardown_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = SIG_DFL,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	sigaction(SIGSEGV, &act, NULL);
> +}

These two as well.

Let's avoid that much copy-pasting.

-- 
Cheers,

David / dhildenb


