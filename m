Return-Path: <linux-kselftest+bounces-9786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58DC8C0FC9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 14:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0371F23B74
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466113C3FA;
	Thu,  9 May 2024 12:43:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7A13B5B6;
	Thu,  9 May 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258585; cv=none; b=DYhRDjljLJWRJTU79QbXxLnFUMJogW6cOco+OEFMxhagH9oeijqc/YXoau27MFvD5lUWaU5mDVWyTbrWLU6u7K+zPRo3vVffqo2v5oDwwP8iAFv72LePn/llxbKTTZ8gZL/kZKqspbwPfAxTeOYuPGDV9SM8hr13JIk50TLxK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258585; c=relaxed/simple;
	bh=8BmZZE6TqpdGCbZ9A4QnBHieZRxO5UaDwlFmlYZ9Nos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6nVsZYtW4C5N3sWxiI2OaKDqirR/GyMUCPPtWUC5rOE+knYteuNlOXew3r590Q9tor/u0BzekS4VENT7Q/EXfH14+TOyxNpBgK96pjUavDQqRDlit3CpUv1O5N2QIEM/Pwh4NZdwooDdD+xg44czPUIRC887CMhit5akWhrSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6D1339;
	Thu,  9 May 2024 05:43:28 -0700 (PDT)
Received: from [10.1.38.172] (XHFQ2J9959.cambridge.arm.com [10.1.38.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59D6E3F6A8;
	Thu,  9 May 2024 05:43:01 -0700 (PDT)
Message-ID: <444612f4-8f3c-445f-bbdb-9b391dd5d5db@arm.com>
Date: Thu, 9 May 2024 13:42:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mqueue: fix 5 warnings about signed/unsigned
 mismatches
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240508200028.272513-1-jhubbard@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240508200028.272513-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2024 21:00, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about several cases of using a signed integer for the
> priority argument to mq_receive(3), which expects an unsigned int.
> 
> Fix this by declaring the type as unsigned int in all cases.
> 
> Also, both input and output priority are unsigned, per the man pages, so
> let's change the type of both priorities throughout, even though clang
> did not warn about the prio_out variable.
> 
> Also, add an argument name to test->func(), in order to address another
> warning from clang.
> 
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  tools/testing/selftests/mqueue/mq_perf_tests.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
> index 5c16159d0bcd..9380c656581f 100644
> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
> @@ -323,7 +323,8 @@ void *fake_cont_thread(void *arg)
>  void *cont_thread(void *arg)
>  {
>  	char buff[MSG_SIZE];
> -	int i, priority;
> +	int i;
> +	unsigned int priority;
>  
>  	for (i = 0; i < num_cpus_to_pin; i++)
>  		if (cpu_threads[i] == pthread_self())
> @@ -373,27 +374,27 @@ void *cont_thread(void *arg)
>  
>  struct test {
>  	char *desc;
> -	void (*func)(int *);
> +	void (*func)(unsigned int *prio);
>  };
>  
> -void const_prio(int *prio)
> +void const_prio(unsigned int *prio)
>  {
>  	return;
>  }
>  
> -void inc_prio(int *prio)
> +void inc_prio(unsigned int *prio)
>  {
>  	if (++*prio == mq_prio_max)
>  		*prio = 0;
>  }
>  
> -void dec_prio(int *prio)
> +void dec_prio(unsigned int *prio)
>  {
>  	if (--*prio < 0)
>  		*prio = mq_prio_max - 1;
>  }
>  
> -void random_prio(int *prio)
> +void random_prio(unsigned int *prio)
>  {
>  	*prio = random() % mq_prio_max;
>  }
> @@ -425,7 +426,7 @@ struct test test2[] = {
>  void *perf_test_thread(void *arg)
>  {
>  	char buff[MSG_SIZE];
> -	int prio_out, prio_in;
> +	unsigned int prio_out, prio_in;
>  	int i;
>  	clockid_t clock;
>  	pthread_t *t;
> 
> base-commit: 45db3ab70092637967967bfd8e6144017638563c
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27


