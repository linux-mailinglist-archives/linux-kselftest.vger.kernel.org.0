Return-Path: <linux-kselftest+bounces-18170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8B97D74F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB72D1C20FBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237317C9AF;
	Fri, 20 Sep 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8/SgP7z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E417C7CA
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844884; cv=none; b=VA4ZT//49cKSCgNavPZfiIwP90GYsxZFtAyjIH+7PDO1+EY1D9/N23ap6N+RKqjiDPHimLXObEkgHohmR5Dc7dbgqqsWXA8YuyfxAKHwlWJTqfhTi2GiHj1oODN9v2ExqvRZqYeu+BYm8pMOGtFuRBk0rsoBVW/HmniDyOZ9Un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844884; c=relaxed/simple;
	bh=4A5QI5HSRcuhIjh1ER3hymrt6gt4XqguYxSzWk5w7c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msg5ZQRSf53e+HVsDuesUwYdNJ11gxDa7A+bmDG8LPydimAdGjMC5yaGisusLsL8RXTrTDQCM1h03726xdyOYm4WyQg6g9GaNNSSGOQNm1Ut1okqOggC6KS6i3m9Evlb5i7XF/dXweFgqguffJFDjrPcAowpyt3CzwY861FXYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8/SgP7z; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82ceab75c27so110258039f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726844881; x=1727449681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JSNrI88wnilLEea9WCwNdRZ5DKrm7LROAh8O3QS/5GI=;
        b=S8/SgP7z6SyOAnv6v1vOGWFsbXSduRVZPb4ZY43xY91rQOKiTNBAve2Mo1+W33dq/x
         0Sfe+n5dT0pdPRltD8yL/dxtgP0VkMvB4oZ6qObZw8lkGtn5/q7SGSAMTxUWe5kb9Qqd
         sirPbH6ACWR6zGyVbNrdfhsQBKhoOhr16bFTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844881; x=1727449681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSNrI88wnilLEea9WCwNdRZ5DKrm7LROAh8O3QS/5GI=;
        b=rxmQflO869Z3Bnx3MFMLP4ungvwZk30bCqHcrKF94uxOmJBtKhATdBb972shTAqn2H
         ed4oY8Bvx6Mk8OfWxaR4DLKgeJFpypdzvLK8bfdTetp+Ha1cNK3iPuzTlQcfj5y3QSdi
         C1zzW01ABSh/4W381jPJjyG8CTKSIjHD59J6IAxAEzWCizWlvBRFOaOsmlBdCoVj9qTT
         0ePXvDUvkl9BYESD0OH6i8e8gTyKnVMVtcb/qZ8MGApVKWMLm1UWwk1nYwOoqGBC3ePQ
         gEYo6P9Pf0RqGuDd9Rld7g2qdgG5NQFtUFXSrNrBpX08RLOLRnxQe1WXaJzDnZaxPM1x
         PfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf0DtemUZXPLE8/khdDuTUQvHZimphFbnu4FwXUIrXLSMGGOk01maWsD6Uo1IW3HIDnnSJtjcyTW3VaaWFlcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYMJg2PBP8fakJCdApvCRd2m3AnlbbwusfPZJxqW4hppO0AVj
	Yibdft3ORWUS6SJV8+SloWMJ3qyHHVCvuap1aphXmqi8LBiieTwP2i1tpagUpP6AGVX1Utln1HG
	p
X-Google-Smtp-Source: AGHT+IFfjDZ/zulJ/I0/oqczgvD9p32K3/tJEZGMHC9ZIh1D9lBg65VLftQqUjwsobwt9psxEblS2A==
X-Received: by 2002:a05:6602:628e:b0:82d:9b0:ecbe with SMTP id ca18e2360f4ac-83209cde43emr347661339f.3.1726844881477;
        Fri, 20 Sep 2024 08:08:01 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d49356363sm378150839f.50.2024.09.20.08.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 08:08:00 -0700 (PDT)
Message-ID: <9c1e9b57-649f-4f96-ab5d-ea512e05c1b9@linuxfoundation.org>
Date: Fri, 20 Sep 2024 09:07:59 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <504209C8-0565-413D-BE89-A0ADE4E153AF@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/24 17:09, Yifei Liu wrote:
> Hi Shuah,
> 
> 
>> On Sep 19, 2024, at 11:36 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 9/17/24 16:48, Yifei Liu wrote:
>>> We recently notice that the step_after_suspend_test would
>>> fail on our plenty devices.  The test believesit failed to
>>
>> What are "plenty devices"
>> recently noticed?
> We have seen this issue on more than one platforms, including bare metal device and virtual machine.
>> Typo - believesit?
> Yes, missing a space here. It should be
> The test believes itself ffailed to enter suspend state.
> Thank you for pointing out.
>>
>>> enter suspend state with
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
>>> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
>>> ksft_exit_fail_msg("Failed to enter Suspend state\n");
>>> The write will return -1 and errno is set to 16 (device busy).
>>> It should be caused by the write function is not successfully returned
>>> before the system suspend and the return value get messed when waking up.
>>> As a result, It may be better to check the time passed of those few instructions
>>> to determine whether the suspend is executed correctly for it is pretty hard to
>>> execute those few lines for 4 seconds, or even more if it is not long enough.
>>
>> I don't think this is the right fix. Can you change this to do echo instead.
>> It does the same thing, but it goes through sysfs interface instead of direct
>> write:
>>
>> ret = system("echo mem > /sys/power/state”);
> Sure, I can do that.
>>
>>> Fixes: bfd092b8c2728 ("selftests: breakpoint: add step_after_suspend_test")
>>> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
>>> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
>>> ---
>>>   .../selftests/breakpoints/step_after_suspend_test.c      | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>> index dfec31fb9b30d..d615f091e5bae 100644
>>> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>>> @@ -18,6 +18,7 @@
>>>   #include <sys/timerfd.h>
>>>   #include <sys/types.h>
>>>   #include <sys/wait.h>
>>> +#include <time.h>
>>>     #include "../kselftest.h"
>>>   @@ -133,6 +134,7 @@ void suspend(void)
>>>    int timerfd;
>>>    int err;
>>>    struct itimerspec spec = {};
>>> + clock_t t;
>>>      if (getuid() != 0)
>>>    ksft_exit_skip("Please run the test as root - Exiting.\n");
>>> @@ -152,8 +154,11 @@ void suspend(void)
>>>    if (err < 0)
>>>    ksft_exit_fail_msg("timerfd_settime() failed\n");
>>
>> I don't think you will need to add clock() code. timerfd_settime()
>> sets the time for 5 seconds and you can simply extend the alarm
>> time.
>>
>> There needs to be some logic to check timer elapse and poll the
>> timer_fd
> Yes, it is also a choice to check the remaining time of the timer. We could use timerfd_gettime() to get the remaining time. The timer would not rearm because the it_interval value is not set (set to 0). Then if the remaining time has both 0 or seconds and nano-seconds (tv_sec and tv_nsec), it should point out the time goes for at least 5 seconds. If the system fails to enter suspend state and waked up by the timer, it should not take 5 whole seconds or more to get to the check line.

Right, You will have to check the remaining time. There is an example in
tools/testing/selftests/timers/alarmtimer-suspend.c you can refer to.

> Would you prefer this methods?

I am curious what happens with starting suspend with sysfs first and then
explore checking elapsed timer.

system("echo mem > /sys/power/state”);

thanks,
-- Shuah

