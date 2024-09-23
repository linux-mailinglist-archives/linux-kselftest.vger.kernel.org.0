Return-Path: <linux-kselftest+bounces-18230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E3897EE4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEEB28274D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B61E52C;
	Mon, 23 Sep 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DKWHQ63d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC92745E
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105859; cv=none; b=CtWiC0yoT9xhE01neqgOw2sGKMb9DvOnKuNPUNcUslamTlWn7nfMMwX/fNJ9qdWJQsH3aoRYXqnaZQ/+dVc/23k3CfN/YWl+tSIUkFR2H4DjoKuKqPcYTIvIq3rt9DnLO4GfxU6I1Hc73e6GGCcJVAFGQzfuWsWYQM9J2NR8W/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105859; c=relaxed/simple;
	bh=uEBXxbOqW9Yy42sheFICqD9rtp2i0UdIcZqgsO+Kkbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH87XSX/nzexdwrxrH/z9gy11/1h+udd5pYNOTfhCZSZNlPAtI9nuJR7RIqciRqSPXHaoB1nG1MmheHHmZ4sD8wouah9VX/T1Ns66iO+reUv8fUWiwsAtHqh578eCrfeNfEFskNFXi6R3SabzkV37HKsakrR0CRztHzhLLnivlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DKWHQ63d; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82ce1cd2026so164213839f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727105856; x=1727710656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ChnhTuQxXCD3M0IDZrD7IY52BB3CsfsDy3DMStkhbo=;
        b=DKWHQ63dT2YySF3rainD/qj8NlQQHOgIpraBhFH5EkcrNpE6qqRz+hr/DdLuth1GcJ
         29p0sjEm8VpnMkbB18aUeOOiV9sgKpn1PrNQ1YnX2RYIB9C0Oey5IcnuHhdVjMNAi+As
         vZDJBbPVXmZZjZKoJevY3RlU3IHPYU+kQDE8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105856; x=1727710656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ChnhTuQxXCD3M0IDZrD7IY52BB3CsfsDy3DMStkhbo=;
        b=TyHFV/GwMACErwximl2EsRa97zg54tnGGd1Dy7s0ixqjkSx0n/7tdz04rZxpo81oZ8
         y30UdOBKvIDMANaD1cD+97Pq7GWNZArxTzjPdTsZYHp/t9GObimQgPMZvWifIoyf/Z1u
         tNCaT1piAUZsFKrxj4OBOaB64W6o29EmZFF1uSx2JD1haUYkESW00Hunj/w/r/3Dl6lr
         LkN7qmkbIvpV8eCoHpXC3iwXFYAN4DT724jKZ6qkKTMUi7azKFNxwJLA3W/JU210Cm+C
         RdWFHqPXl6F9Mn97Dq26zVir7awykQjIpn/F8KtR/KGtQqCl6eFi1UoBAPwty6rkEqsQ
         2nTg==
X-Forwarded-Encrypted: i=1; AJvYcCWQnqfsf0RyZ71YWxRbMukZpWkemO1IyfP+yqMKAXMJrpStUHotpp462S2HhMRwXerNpKH76uQSUOICDU23wa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwRGcYNxqG5lfpFIMVv0skS9/lmmtq2NVddX+osKNMZLKza3t
	8FSKf5Nxt4wiMLXHGEQafXqoaNf/2bbeNtUp7sXG7xTj7NPY7cY1eOpBy64whjg=
X-Google-Smtp-Source: AGHT+IGkBoe9g6AC10ZnghD/s42mRzu3a6XZXWZI2VqYr0f/1XseSyixXFgDtmO4j3Ue/qTPh2qc/w==
X-Received: by 2002:a05:6602:1685:b0:82a:4480:badc with SMTP id ca18e2360f4ac-83209d7cff7mr961034539f.10.1727105856186;
        Mon, 23 Sep 2024 08:37:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed5994bsm5129395173.179.2024.09.23.08.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:37:35 -0700 (PDT)
Message-ID: <c89d0a27-7641-4832-b598-51c5eaae3a30@linuxfoundation.org>
Date: Mon, 23 Sep 2024 09:37:34 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use time passed to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sinadin Shan <sinadin.shan@oracle.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240917224837.478684-1-yifei.l.liu@oracle.com>
 <6cdd7cc3-e5ca-48b0-bd49-d33bbf908cda@linuxfoundation.org>
 <504209C8-0565-413D-BE89-A0ADE4E153AF@oracle.com>
 <9c1e9b57-649f-4f96-ab5d-ea512e05c1b9@linuxfoundation.org>
 <C8B50D46-3294-4B3A-B731-3A4B1ED0380D@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <C8B50D46-3294-4B3A-B731-3A4B1ED0380D@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/24 11:52, Yifei Liu wrote:
> Hi Shuah,
> 
>> On Sep 20, 2024, at 8:07 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 9/19/24 17:09, Yifei Liu wrote:
>>> Hi Shuah,
>>>> On Sep 19, 2024, at 11:36 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 9/17/24 16:48, Yifei Liu wrote:
>>>>> We recently notice that the step_after_suspend_test would
>>>>> fail on our plenty devices.  The test believesit failed to
>>>>
>>>> What are "plenty devices"
>>>> recently noticed?
>>> We have seen this issue on more than one platforms, including bare metal device and virtual machine.
>>>> Typo - believesit?
>>> Yes, missing a space here. It should be
>>> The test believes itself ffailed to enter suspend state.
>>> Thank you for pointing out.
>>>>
>>>>> enter suspend state with
>>>>> $ sudo ./step_after_suspend_test
>>>>> TAP version 13
>>>>> Bail out! Failed to enter Suspend state
>>>>> However, in the kernel message, I indeed see the system get
>>>>> suspended and then wake up later.
>>>>> [611172.033108] PM: suspend entry (s2idle)
>>>>> [611172.044940] Filesystems sync: 0.006 seconds
>>>>> [611172.052254] Freezing user space processes
>>>>> [611172.059319] Freezing user space processes completed (elapsed 0.001 seconds)
>>>>> [611172.067920] OOM killer disabled.
>>>>> [611172.072465] Freezing remaining freezable tasks
>>>>> [611172.080332] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>>>>> [611172.089724] printk: Suspending console(s) (use no_console_suspend to debug)
>>>>> [611172.117126] serial 00:03: disabled
>>>>> --- some other hardware get reconnected ---
>>>>> [611203.136277] OOM killer enabled.
>>>>> [611203.140637] Restarting tasks ...
>>>>> [611203.141135] usb 1-8.1: USB disconnect, device number 7
>>>>> [611203.141755] done.
>>>>> [611203.155268] random: crng reseeded on system resumption
>>>>> [611203.162059] PM: suspend exit
>>>>> After investigation, I notice that for the code block
>>>>> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
>>>>> ksft_exit_fail_msg("Failed to enter Suspend state\n");
>>>>> The write will return -1 and errno is set to 16 (device busy).
>>>>> It should be caused by the write function is not successfully returned
>>>>> before the system suspend and the return value get messed when waking up.
>>>>> As a result, It may be better to check the time passed of those few instructions
>>>>> to determine whether the suspend is executed correctly for it is pretty hard to
>>>>> execute those few lines for 4 seconds, or even more if it is not long enough.
>>>>
>>>> I don't think this is the right fix. Can you change this to do echo instead.
>>>> It does the same thing, but it goes through sysfs interface instead of direct
>>>> write:
>>>>
>>>> ret = system("echo mem > /sys/power/state”);
>>> Sure, I can do that.
>>>>
>>>>> Fixes: bfd092b8c2728 ("selftests: breakpoint: add step_after_suspend_test")
>>>>> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
>>>>> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
>>>>> ---
>>>>>   .../selftests/breakpoints/step_after_suspend_test.c      | 9 +++++++--
>>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>>>> index dfec31fb9b30d..d615f091e5bae 100644
>>>>> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>>>> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>>>> @@ -18,6 +18,7 @@
>>>>>   #include <sys/timerfd.h>
>>>>>   #include <sys/types.h>
>>>>>   #include <sys/wait.h>
>>>>> +#include <time.h>
>>>>>     #include "../kselftest.h"
>>>>>   @@ -133,6 +134,7 @@ void suspend(void)
>>>>>    int timerfd;
>>>>>    int err;
>>>>>    struct itimerspec spec = {};
>>>>> + clock_t t;
>>>>>      if (getuid() != 0)
>>>>>    ksft_exit_skip("Please run the test as root - Exiting.\n");
>>>>> @@ -152,8 +154,11 @@ void suspend(void)
>>>>>    if (err < 0)
>>>>>    ksft_exit_fail_msg("timerfd_settime() failed\n");
>>>>
>>>> I don't think you will need to add clock() code. timerfd_settime()
>>>> sets the time for 5 seconds and you can simply extend the alarm
>>>> time.
>>>>
>>>> There needs to be some logic to check timer elapse and poll the
>>>> timer_fd
>>> Yes, it is also a choice to check the remaining time of the timer. We could use timerfd_gettime() to get the remaining time. The timer would not rearm because the it_interval value is not set (set to 0). Then if the remaining time has both 0 or seconds and nano-seconds (tv_sec and tv_nsec), it should point out the time goes for at least 5 seconds. If the system fails to enter suspend state and waked up by the timer, it should not take 5 whole seconds or more to get to the check line.
>>
>> Right, You will have to check the remaining time. There is an example in
>> tools/testing/selftests/timers/alarmtimer-suspend.c you can refer to.
> I checked the remaining value, if the suspend succeed, it would be all 0 (0s and 0 ns). If it failed to enter suspend by any chance, it would be a non-zero value.
>>
>>> Would you prefer this methods?
>>
>> I am curious what happens with starting suspend with sysfs first and then
>> explore checking elapsed timer.
>>
>> system("echo mem > /sys/power/state”);
> I checked this, and find that it will give a similar failure.
> 
> sh: line 1: echo: write error: Device or resource busy
> 
> The console command will get its return result after the suspend and wake up. Maybe we could do
> 
> system("echo mem > /sys/power/state >/dev/nul”);

Yes. The idea is that we go through the sysfs interface as opposed
to writing to the file directly.

> 
> To avoid an error message in the console. And we are checking the success of suspend by the time, so it would not be necessary for us to see the output of this console command.
> 

Sounds good to me.

thanks,
-- Shuah

