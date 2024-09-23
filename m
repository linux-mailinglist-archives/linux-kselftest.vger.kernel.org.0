Return-Path: <linux-kselftest+bounces-18258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB66F983931
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 23:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BAE1F218F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22A6E2BE;
	Mon, 23 Sep 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dd9D+K+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E37F9D4
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127977; cv=none; b=FjyBZ5w73CJ3rCTY/n8OcWLjgslWQSkK+MMoGgSX8zVuNnP4LtXIXvzp5boEzifeoI0GEYDAEHbh+CJENhjJjZv8qsiebAEULyVMG4CPWIUsyj5jNjWAcqZ4uRKU3mP5poKvIipFisP9dYHnHxJU52WupcLLRnjwiSbMCoCGYls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127977; c=relaxed/simple;
	bh=5clW22Su0XMjbKFkGbY67LKR0hTGXRubYdADzdoyElY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYkmIjZ6Z3VQVkpeXJaCWvuz186C9V46zHkoyFThABllAFDMLq4uF9ma+j7muT+EXMH69WuUJBlmaq4sShZb8hXlYCV9hNx0tjkcdrYWRRQwd6E/37XvQNcr1f8x4dpZ/wP3wUMI3+vtwstrDl9aD4QO3UA6sPSvHbnelYEMZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dd9D+K+Q; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82ce603d8daso177169139f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727127975; x=1727732775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xE3yMjkfcGnxM+4MB49Vhq71Yavg/A82xPPs9NwvjCI=;
        b=Dd9D+K+QeuqWImTQ0W7/935NgPgT4P1OfQ44iuri6UilfTOWBDcox/4gPx1LCuTeiv
         d7SK//6NBm32VOneNgq+4B3Wy8CS4uSyFua8hWDFm7QRH/aplg/W6WXvJ7OLnNEiewBZ
         UpgLJWvMzd9MutiCpoztyGhlc0jPm1j2egye4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727127975; x=1727732775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xE3yMjkfcGnxM+4MB49Vhq71Yavg/A82xPPs9NwvjCI=;
        b=oiAM2Am+rLk+ERnIff1Bwk4Z2NScy1vT2RbiA8sQmOS0FBLqgVzZ7OvG1OROdcLI00
         rZgyHoFLClCmIhaG4ytpUfn1H+yYdmgMoDHEEwqvALqqRwT6neB9afkjF7vMGHV/5Hab
         pTnZD33Lq3x4jrm/60QsFSEp+jPaTvQep7l7FoOWb+GzcUEwJXZi88AnTDCtBIDtBfBE
         6m95yha+tH9eoOtiJlrXddiVHxJeYkF84YbXyRNalIdtNWk6oLIa8qXEQo5ZmZXzGd9y
         9P5tOolOSPWSYfEIOYz+51v8XKHIf9CtUMjbdwHBO/KcJELD1/R7Iq7sZAlfzlkOQNkx
         Wvjg==
X-Forwarded-Encrypted: i=1; AJvYcCX6WfPymkvTo2wV3XaknvzGyExwc+vf/Cygzz2vlfaHL8pzrqZlHK9rwkQhQLiI96FhQkzjV/kDlY83/81Ob4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywacz4k0s9cxaV1+Q80dSVrmIDMtGl4SBeuPevEqC36omH/CLNa
	CSv+AUG/SRU+6A791P+QCdqXw8BQgJMa9lGqfWjw6gzHm+MhQKKtzvb9NEpurXI=
X-Google-Smtp-Source: AGHT+IFW7eKObRilbKFKz0wC2D2FSP6xj2ZVOJATsM8RpRAf4h6lnevENoOuEO5VVHY9v8k4giUDqg==
X-Received: by 2002:a05:6602:27c1:b0:82d:949:ff8b with SMTP id ca18e2360f4ac-83209d1aef3mr1260350439f.6.1727127974720;
        Mon, 23 Sep 2024 14:46:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f1bbc01sm64083173.108.2024.09.23.14.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 14:46:14 -0700 (PDT)
Message-ID: <5c23ed68-3d4b-4acc-b912-69639efda103@linuxfoundation.org>
Date: Mon, 23 Sep 2024 15:46:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use remaining time to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sinadin Shan <sinadin.shan@oracle.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240923204718.1862074-1-yifei.l.liu@oracle.com>
 <0a5b473a-281b-4911-984b-cf456d42a44f@linuxfoundation.org>
 <703DFBEE-D5EA-4798-B3EB-7F1E62533659@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <703DFBEE-D5EA-4798-B3EB-7F1E62533659@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 15:18, Yifei Liu wrote:
> 
> 
>> On Sep 23, 2024, at 1:56 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 9/23/24 14:47, Yifei Liu wrote:
>>> We recently notice that the step_after_suspend_test would
>>
>> noticed
> How about change this to find?

Either is fine - it would found instead of find - or you could write
it as below:

"step_after_suspend_test fails with device busy error while
writing to /sys/power/state to start suspend."

>>
>>> fail on our plenty devices.  The test believesit failed to
>>
>> "several of our devices"  believes it
>>> enter suspend state with
>>
>> Please do fix the above as pointed out earlier on v1.
> Apologies, forget to fix. Will fix that.
>>> $ sudo ./step_after_suspend_test
>>> TAP version 13
>>> Bail out! Failed to enter Suspend state
>>> However, in the kernel message, I indeed see the system get
>>> suspended and then wake up later.
>>> [611172.033108] PM: suspend entry (s2idle)
>>> [611172.044940] Filesystems sync: 0.006 seconds
>>> [611172.052254] Freezing user space processes
>>> [611172.059319] Freezing user space processes completed (elapsed 0.001 seconds)
>>> [611172.067920] OOM killer disabled.
>>> [611172.072465] Freezing remaining freezable tasks
>>> [611172.080332] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>>> [611172.089724] printk: Suspending console(s) (use no_console_suspend to debug)
>>> [611172.117126] serial 00:03: disabled
>>> --- some other hardware get reconnected ---
>>> [611203.136277] OOM killer enabled.
>>> [611203.140637] Restarting tasks ...
>>> [611203.141135] usb 1-8.1: USB disconnect, device number 7
>>> [611203.141755] done.
>>> [611203.155268] random: crng reseeded on system resumption
>>> [611203.162059] PM: suspend exit
>>> After investigation, I notice that for the code block
>>
>> noticed?
> How about use find here?

It is the tense issue - found or noticed would work.
>>
>>> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
>>> ksft_exit_fail_msg("Failed to enter Suspend state\n");
>>> The write will return -1 and errno is set to 16 (device busy).
>>> It should be caused by the write function is not successfully returned
>>> before the system suspend and the return value get messed when waking up.
>>> As a result, It may be better to check the time passed of those few instructions
>>> to determine whether the suspend is executed correctly for it is pretty hard to
>>> execute those few lines for 5 seconds.
>>> The timer to wake up the system is set to expired after 5 seconds and no-rearm.
>>> If the timer remaining time is 0 second and 0 nano secomd, it means the timer
>>> expired and wake the system up. Otherwise, the system could be considered to
>>> enter the suspend state failed if there is any remaining time.
>>
>> What would you get if you were to cat /sys/power/state at this point?
> According to file kernel/power/suspend, the cat will always return freeze mem disk.
> 
>> Does this fix the problem you are seeing? What is the outcome?
> Yes, it fixes. The test would not fail for it believes the system does not went to suspend by mistake. It now could continue to the rest part of the test after suspend.

Can you add this to the change log.

>>> Fixes: bfd092b8c2728 ("selftests: breakpoint: add step_after_suspend_test")
>>> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
>>> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
>>> ---
>>>   .../testing/selftests/breakpoints/step_after_suspend_test.c  | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>> index dfec31fb9b30d..33f5542bf741d 100644
>>> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>> @@ -152,7 +152,10 @@ void suspend(void)
>>>    if (err < 0)
>>>    ksft_exit_fail_msg("timerfd_settime() failed\n");
>>>   - if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
>>> + system("(echo mem > /sys/power/state) 2> /dev/null");
>>> +
>>> + timerfd_gettime(timerfd,&spec);
>>> + if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
>>>    ksft_exit_fail_msg("Failed to enter Suspend state\n");
>>>      close(timerfd);
>>

thanks,
-- Shuah


