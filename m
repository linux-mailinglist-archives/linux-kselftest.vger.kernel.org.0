Return-Path: <linux-kselftest+bounces-7341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA489ACF1
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33B31F2148D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAA4D121;
	Sat,  6 Apr 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rRHpjH2t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784B18C1F;
	Sat,  6 Apr 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712436796; cv=none; b=X1a6oJvkueLNufH4S8kx5IZ+/tIfRYosKyISgvtljKRszxmk+JqMpqXsaRl7b7+aE70kfK7XTsLo4GF7sfCj0Wy9lmjd1HpaV69AjZ/pxWOjo/jI8nmrcxk54FsJuaVOt3Jh0gp70CyeXZffHy4RRQwk8AoyZj5FgKdn3goBgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712436796; c=relaxed/simple;
	bh=roYSw1kQCLsXlYbgAoXhYjVj51FVUPpjjG/i3jdOo+Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nqMmr6Keuc4J8z4z/jMNH/Nx1N2S2eoh5PYu+osX4nuBnymHbTZQZbg4OC0V24hfizKQj8tS8hvHx/UIaQHtJyrvSh8mKmNKXZ4fBEMN7dTilL6Xk7xEOj8ylHmbToFqoNbxWqZZFzJCPNbEKTRSfiRM/vO6Y4FPwFvuDeRXCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rRHpjH2t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712436793;
	bh=roYSw1kQCLsXlYbgAoXhYjVj51FVUPpjjG/i3jdOo+Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rRHpjH2t+vHpCmTok6OU6M2EdphcZE+iJAHsV6Fe6hvBNhzfqkhjykw8WfCFvjvKD
	 qgVSH5ClZMMq+tbZGX2o/Gt6K0ScHSEq3OG+T8ddRih3efZTrJD5xjgxfKqaqQ/tdk
	 zVI3A9ffM6ADHYlHL1fNTMMxY6QW26kOaHFxZTAcD2B5JyHIz7JBGwI5CpnfJIRh45
	 OqwRbja9ykiciku1tKKKuMhC91ZgCCLvf3FbHfuV31IsRIdcTgzf7Wdd4PLPIY5m7w
	 wgWk/EcbVRncTqRmY2GKhTJEZ63gEf0bWuPgWNLbmCLPMmFcgBeDI41t6sjzcz2DCd
	 Jup6PgGh9F0SA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2444037809D1;
	Sat,  6 Apr 2024 20:53:08 +0000 (UTC)
Message-ID: <46ad25c9-f63c-4bb7-9707-4bc8b21ccaca@collabora.com>
Date: Sun, 7 Apr 2024 01:53:40 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 2/2] selftests/timers/posix_timers: Test delivery of
 signals across threads
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
References: <20230316123028.2890338-1-elver@google.com>
 <20230316123028.2890338-2-elver@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230316123028.2890338-2-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/23 5:30 PM, Marco Elver wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
> 
> Test that POSIX timers using CLOCK_PROCESS_CPUTIME_ID eventually deliver
> a signal to all running threads.  This effectively tests that the kernel
> doesn't prefer any one thread (or subset of threads) for signal delivery.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v6:
> - Update wording on what the test aims to test.
> - Fix formatting per checkpatch.pl.
> ---
>  tools/testing/selftests/timers/posix_timers.c | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> index 0ba500056e63..8a17c0e8d82b 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -188,6 +188,80 @@ static int check_timer_create(int which)
>  	return 0;
>  }
>  
> +int remain;
> +__thread int got_signal;
> +
> +static void *distribution_thread(void *arg)
> +{
> +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> +	return NULL;
> +}
> +
> +static void distribution_handler(int nr)
> +{
> +	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
> +		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
> +}
> +
> +/*
> + * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
> + * timer signals. This primarily tests that the kernel does not favour any one.
> + */
> +static int check_timer_distribution(void)
> +{
> +	int err, i;
> +	timer_t id;
> +	const int nthreads = 10;
> +	pthread_t threads[nthreads];
> +	struct itimerspec val = {
> +		.it_value.tv_sec = 0,
> +		.it_value.tv_nsec = 1000 * 1000,
> +		.it_interval.tv_sec = 0,
> +		.it_interval.tv_nsec = 1000 * 1000,
> +	};
> +
> +	printf("Check timer_create() per process signal distribution... ");
Use APIs from kselftest.h. Use ksft_print_msg() here.

> +	fflush(stdout);
> +
> +	remain = nthreads + 1;  /* worker threads + this thread */
> +	signal(SIGALRM, distribution_handler);
> +	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> +	if (err < 0) {
> +		perror("Can't create timer\n");
ksft_perror() here

> +		return -1;
> +	}
> +	err = timer_settime(id, 0, &val, NULL);
> +	if (err < 0) {
> +		perror("Can't set timer\n");
> +		return -1;
> +	}
> +
> +	for (i = 0; i < nthreads; i++) {
> +		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
> +			perror("Can't create thread\n");
> +			return -1;
> +		}
> +	}
> +
> +	/* Wait for all threads to receive the signal. */
> +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> +
> +	for (i = 0; i < nthreads; i++) {
> +		if (pthread_join(threads[i], NULL)) {
> +			perror("Can't join thread\n");
> +			return -1;
> +		}
> +	}
> +
> +	if (timer_delete(id)) {
> +		perror("Can't delete timer\n");
> +		return -1;
> +	}
> +
> +	printf("[OK]\n");
ksft_test_result or _pass variant as needed?

> +	return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	printf("Testing posix timers. False negative may happen on CPU execution \n");
> @@ -217,5 +291,8 @@ int main(int argc, char **argv)
>  	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
>  		return ksft_exit_fail();
>  
> +	if (check_timer_distribution() < 0)
> +		return ksft_exit_fail();
> +
>  	return ksft_exit_pass();
>  }

-- 
BR,
Muhammad Usama Anjum

