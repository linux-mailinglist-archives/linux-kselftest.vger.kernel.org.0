Return-Path: <linux-kselftest+bounces-14036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C119398E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 06:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C3E282A45
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EF13BACB;
	Tue, 23 Jul 2024 04:30:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74177137748;
	Tue, 23 Jul 2024 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721709024; cv=none; b=oVSJdCh2kJ4gKLnSIMx6ShGt86QsJysMepcKBS8DIbsOVA02LP7PVkDfwYiuDcG3MrjQHVyZWdZEB/tc/AUSrdNTBfge6+ccNHQJKE5H1UPoNfK4a/L850Q5nzHwUDjJ1quajN8m/oXUJMHioLsQXtvwAjhM13TMJWqZZ7xFFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721709024; c=relaxed/simple;
	bh=JD3hSNDG+SHPSOjhdeLU3Oz4zp46fPJG4bzmOnhNneM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuMcVVbu/vQLABIBJd/7Gax09/RMj5VLVr766WbYtnbBRpiJiEs9eRtwapvFLLamr0/sfyg+NSVscHNWnV56VMyNM8Cw9bfUOX0WicfhuZf4lPNWFGcvw0dj47Cxbd+AUF4BSeIt9jaPkH1+03hiQPMyl2yh7Ggd+mtFxUXcpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 163371007;
	Mon, 22 Jul 2024 21:30:47 -0700 (PDT)
Received: from [10.162.43.18] (e116581.arm.com [10.162.43.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069303F766;
	Mon, 22 Jul 2024 21:30:16 -0700 (PDT)
Message-ID: <01e41c46-255a-419a-9b72-485a2798205f@arm.com>
Date: Tue, 23 Jul 2024 10:00:09 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] selftests: Add a test mangling with uc_sigmask
To: Shuah Khan <skhan@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
 mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627035215.1527279-1-dev.jain@arm.com>
 <20240627035215.1527279-3-dev.jain@arm.com>
 <20240630151808.GA13321@redhat.com>
 <09370b2d-2b52-4133-8e0d-83e66b801ff8@arm.com>
 <abd97c85-c9d9-43c9-b0c2-36f6f0e442e0@linuxfoundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <abd97c85-c9d9-43c9-b0c2-36f6f0e442e0@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/22/24 20:28, Shuah Khan wrote:
> On 7/15/24 05:49, Dev Jain wrote:
>>
>> On 6/30/24 20:48, Oleg Nesterov wrote:
>>> I see nothing wrong, but perhaps this test can be simplified?
>>> Feel free to ignore.
>>>
>>> Say,
>>>
>>> On 06/27, Dev Jain wrote:
>>>> +void handler_usr(int signo, siginfo_t *info, void *uc)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    /*
>>>> +     * Break out of infinite recursion caused by raise(SIGUSR1) 
>>>> invoked
>>>> +     * from inside the handler
>>>> +     */
>>>> +    ++cnt;
>>>> +    if (cnt > 1)
>>>> +        return;
>>>> +
>>>> +    ksft_print_msg("In handler_usr\n");
>
> This message isn't very useful. Why do you need this message?


There isn't any specific use; I am just showing the progress

of the test. If you think this is just waste output....

>
>>>> +
>>>> +    /* SEGV blocked during handler execution, delivered on return */
>>>> +    if (raise(SIGSEGV))
>>>> +        ksft_exit_fail_perror("raise");>>> +
>>>> +    ksft_print_msg("SEGV bypassed successfully\n");
>>> You could simply do sigprocmask(SIG_SETMASK, NULL, &oldset) and 
>>> check if
>>> SIGSEGV is blocked in oldset. SIG_SETMASK has no effect if newset == 
>>> NULL.
>>>
>>
>> IMHO, isn't raising the signal, and the process not terminating, a 
>> stricter test? I have already included your described approach in
>> the last testcase; so, the test includes both ways: raising the
>> signal -> process not terminating, and checking blockage with 
>> sigprocmask().
>
> thanks,
> -- Shuah
>

