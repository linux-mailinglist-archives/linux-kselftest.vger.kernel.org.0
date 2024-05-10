Return-Path: <linux-kselftest+bounces-10010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FC28C23C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D9B260F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1021340;
	Fri, 10 May 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fpq2/Tqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CD12AAC0;
	Fri, 10 May 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341250; cv=none; b=cg1xHhKAj5QiiSvZ8Cm4jZlk8uMyH0KQV516dzgCh9bk5drN1pScqZ2gniOd8/EX1McGyZ3NWq2FTsF6csQ8tQLwLjWkMUPNZ/uATGzXbxaNEFxTioyhdBx4e61I7kKeuHtVvGHf2lOAsRHFS08YEWaEgTH6nGK/harJXZ7RlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341250; c=relaxed/simple;
	bh=RbjHDzPLh3E9GZ4X448sxcxJtPFQU9RPmN+GEiL/x1Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iMdyJmaxcc8IbjrrMdpxk5zmpVCA92m0jLX+n8CyTF7zY2UGWQGWBssM/wIxiKucYFdCiW4vxyyMRC8+HOfnOVIYrKfgaT+SwDmRLtEsrETJhs9WbVm0eCdXCc6WdbtHYZ9a2EENlR2mhrbIkiEw1F/jhVQuP9Dhfo16WCv1StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fpq2/Tqa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715341247;
	bh=RbjHDzPLh3E9GZ4X448sxcxJtPFQU9RPmN+GEiL/x1Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fpq2/TqaNL7f3UaZ+UQN/qSIUoh9uCAtxlI2Iqx2Z8dMa5r/1XjfKuZKyt2/EwbCX
	 NWn8yQmhDGEAkdSsi/RCowaD80p+3RHQ/xJeZ4hTfbE19T2BzQ9uQ1tpCrzSwcirb8
	 zc+37ScXWx4v0HCcXeLPuqzqF1/TkzDWg/XB9stQPgCejUC5t8Z7I+iHG/gkIKf+H2
	 uIprfcL6j5ZFxElBSutbM2Yncn0EOrnhATsPqpDrFLcStLVjAhAj0N4HrvnFaUI663
	 RC/uvES+J9wTiyqHqh/S6jDUGEHcs7YubbXRfX6EUtXVmdOCReH+iQJo6IbaI2B044
	 TMCN5EghWTakw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 109393782185;
	Fri, 10 May 2024 11:40:43 +0000 (UTC)
Message-ID: <17a9be15-5e4f-4aed-a2b1-b3aa2defbfc9@collabora.com>
Date: Fri, 10 May 2024 16:41:08 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 SeongJae Park <sj@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/mqueue: fix 5 warnings about signed/unsigned
 mismatches
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20240508200028.272513-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240508200028.272513-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 1:00 AM, John Hubbard wrote:
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
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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

-- 
BR,
Muhammad Usama Anjum

