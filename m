Return-Path: <linux-kselftest+bounces-7351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E546289AD11
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151061C20A88
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3C64EB41;
	Sat,  6 Apr 2024 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CUxgIwux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3293B18D;
	Sat,  6 Apr 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712439112; cv=none; b=tCgUhg3OwsqYYz9zRqBMrI4pVtQ5A0g0eCVWvrVSce/qL3UKNLNUwGx3mYw8zQPzvCXrhbQS1/sVaz0i+qLc8ewH51X3S1kDiUtYq9U8J0KtKrWBBsycybLlU9RcTQBJWTXelE0uhDRS3/sG3a18QdU7rSQtaldeyu4L7fYaXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712439112; c=relaxed/simple;
	bh=LCeSaZVCLLa2JNuSPQv7Fn1dVBTwCW+zy4H4kD71hew=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G8fS2ghR43I1z9YvTvBr5k0pPlHvO3UB5rHpHD17ArujmGxgebaQTOLVyg18zw4CGj2ILecudbPICG2tF/Fn6Tj2NjZXcW88kH3ablD8L0wtjoXSuBSoHwShnMgPcB0+WS7AJ/pZ6T/o4ffSUNPxCftBdPHGolc6hEwXSaRhdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CUxgIwux; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712439109;
	bh=LCeSaZVCLLa2JNuSPQv7Fn1dVBTwCW+zy4H4kD71hew=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CUxgIwuxt9Z2TbuPaK0KaJqZX5CFQs0UvOc+VhaVr+ZMgIx/95583IfGieS42QQkd
	 vT1ZMJvZwW4T715q58kGa+Ws9C4I5loYW+gzBrqAqQnzzwaSEzKWb7/94PnQ2smIrj
	 7RZbCF8vU1T8NjHp8N56zuJ5jC64b+ZcVJA69fRNX6sfvtv7qs6NW/9BZDsMNLSEOW
	 xEJU8rhaLLaUL6/yLnc4ZJCheJcy9o7+mHs/tuP7iYuwWRMeyXSZ6PQU087dKPVEh+
	 8yVTOSOW2mmjIzgVVNh9j6r3Viwdjh9LICFAXJiC8SDuQHMXyAD+DIxVeAm7EmRA8t
	 0SyTF6ct8mOUg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89F6037809CE;
	Sat,  6 Apr 2024 21:31:41 +0000 (UTC)
Message-ID: <a282446a-6e37-4be7-bb9c-e268c99656b6@collabora.com>
Date: Sun, 7 Apr 2024 02:32:14 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 2/2] selftests/timers/posix_timers: Test delivery of
 signals across threads
To: Oleg Nesterov <oleg@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <20230316123028.2890338-2-elver@google.com>
 <46ad25c9-f63c-4bb7-9707-4bc8b21ccaca@collabora.com>
 <20240406211312.GD3060@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240406211312.GD3060@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/24 2:13 AM, Oleg Nesterov wrote:
> Muhammad,
> 
> I am sorry, but... are you aware that this patch was applied over a year ago,
> and then this code was updated to use the ksft_API?
Sorry, didn't realized this is already applied. So this patch is already
applied and it has already been made compliant.

Thanks

> 
> Oleg.
> 
> On 04/07, Muhammad Usama Anjum wrote:
>>
>> On 3/16/23 5:30 PM, Marco Elver wrote:
>>> From: Dmitry Vyukov <dvyukov@google.com>
>>>
>>> Test that POSIX timers using CLOCK_PROCESS_CPUTIME_ID eventually deliver
>>> a signal to all running threads.  This effectively tests that the kernel
>>> doesn't prefer any one thread (or subset of threads) for signal delivery.
>>>
>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>> Signed-off-by: Marco Elver <elver@google.com>
>>> ---
>>> v6:
>>> - Update wording on what the test aims to test.
>>> - Fix formatting per checkpatch.pl.
>>> ---
>>>  tools/testing/selftests/timers/posix_timers.c | 77 +++++++++++++++++++
>>>  1 file changed, 77 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
>>> index 0ba500056e63..8a17c0e8d82b 100644
>>> --- a/tools/testing/selftests/timers/posix_timers.c
>>> +++ b/tools/testing/selftests/timers/posix_timers.c
>>> @@ -188,6 +188,80 @@ static int check_timer_create(int which)
>>>  	return 0;
>>>  }
>>>  
>>> +int remain;
>>> +__thread int got_signal;
>>> +
>>> +static void *distribution_thread(void *arg)
>>> +{
>>> +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
>>> +	return NULL;
>>> +}
>>> +
>>> +static void distribution_handler(int nr)
>>> +{
>>> +	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
>>> +		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
>>> +}
>>> +
>>> +/*
>>> + * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
>>> + * timer signals. This primarily tests that the kernel does not favour any one.
>>> + */
>>> +static int check_timer_distribution(void)
>>> +{
>>> +	int err, i;
>>> +	timer_t id;
>>> +	const int nthreads = 10;
>>> +	pthread_t threads[nthreads];
>>> +	struct itimerspec val = {
>>> +		.it_value.tv_sec = 0,
>>> +		.it_value.tv_nsec = 1000 * 1000,
>>> +		.it_interval.tv_sec = 0,
>>> +		.it_interval.tv_nsec = 1000 * 1000,
>>> +	};
>>> +
>>> +	printf("Check timer_create() per process signal distribution... ");
>> Use APIs from kselftest.h. Use ksft_print_msg() here.
>>
>>> +	fflush(stdout);
>>> +
>>> +	remain = nthreads + 1;  /* worker threads + this thread */
>>> +	signal(SIGALRM, distribution_handler);
>>> +	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
>>> +	if (err < 0) {
>>> +		perror("Can't create timer\n");
>> ksft_perror() here
>>
>>> +		return -1;
>>> +	}
>>> +	err = timer_settime(id, 0, &val, NULL);
>>> +	if (err < 0) {
>>> +		perror("Can't set timer\n");
>>> +		return -1;
>>> +	}
>>> +
>>> +	for (i = 0; i < nthreads; i++) {
>>> +		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
>>> +			perror("Can't create thread\n");
>>> +			return -1;
>>> +		}
>>> +	}
>>> +
>>> +	/* Wait for all threads to receive the signal. */
>>> +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
>>> +
>>> +	for (i = 0; i < nthreads; i++) {
>>> +		if (pthread_join(threads[i], NULL)) {
>>> +			perror("Can't join thread\n");
>>> +			return -1;
>>> +		}
>>> +	}
>>> +
>>> +	if (timer_delete(id)) {
>>> +		perror("Can't delete timer\n");
>>> +		return -1;
>>> +	}
>>> +
>>> +	printf("[OK]\n");
>> ksft_test_result or _pass variant as needed?
>>
>>> +	return 0;
>>> +}
>>> +
>>>  int main(int argc, char **argv)
>>>  {
>>>  	printf("Testing posix timers. False negative may happen on CPU execution \n");
>>> @@ -217,5 +291,8 @@ int main(int argc, char **argv)
>>>  	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
>>>  		return ksft_exit_fail();
>>>  
>>> +	if (check_timer_distribution() < 0)
>>> +		return ksft_exit_fail();
>>> +
>>>  	return ksft_exit_pass();
>>>  }
>>
>> -- 
>> BR,
>> Muhammad Usama Anjum
>>
> 

-- 
BR,
Muhammad Usama Anjum

