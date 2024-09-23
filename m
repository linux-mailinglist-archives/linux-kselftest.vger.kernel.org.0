Return-Path: <linux-kselftest+bounces-18256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CD197F1CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 22:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282CB1C20EFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 20:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40FC770E1;
	Mon, 23 Sep 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfUQAuev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4B8C06
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727124981; cv=none; b=FvZfgZmivD+lMrT34HkeFac8s6dBPoZ1eiNKEgPh6guIfZ8oaCIhgEirRVQdv+MD4XArudqyqJEzgHWUqEMoPSjPEJMa0uLzyQzErGYaOkrsV4bX6E9goEPm8jddihYsgzwnICCZD96Ja6aAbZ67zTEq58fYI6z6Fop1RfP1t9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727124981; c=relaxed/simple;
	bh=RfjhRpoc6rrQKTrz2dS8fjj5nwsLdmvTzKRoR8NRmlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxVze8h6iTkpNtFqNc4GmWnncRrBmAmeV2nS2spDSrH1jrt4QW4ATYMxKQuVwYrIgugylz5l4gX+HJ0kxJl9UT456g6tCS5tA9v5giDydFg0FNd3y/hqT7YI3p0yHaMmHjwpD58sK8tjmzXa3oYn0b1tEWGRN0sa/fH1ECejb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KfUQAuev; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82cdada0f21so190585239f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727124979; x=1727729779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4PSyIAR+9Ralh2GvG/eweZovU6jewNJ3To9GX/vNLo=;
        b=KfUQAuevlBHIoNp1sHA17jW5KHNFNI+UmVZ5dGOTdCgi5DWqaFmoURmcc+AoFGL5kR
         Tu33QN0gPzR6ro4Wkm0CmOf2Bx3l64j/Lwr7NblwfaZs2Tvri4P9zA2B7atIXjvRzMwV
         ZednpNTVGAMuBf+Wea+FsIkpgkdNTEY4rcEw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727124979; x=1727729779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4PSyIAR+9Ralh2GvG/eweZovU6jewNJ3To9GX/vNLo=;
        b=CD8ZgrrCTNpXvfMIpexmlDW2RrqWCUad8cMAapuvTXUKOxI/88CpiDxkvb7YfX8nsN
         Cun/xdDOwKeRAqM7D1NQKXx32Al0oOhKTIyfj5uG715Tdih7g0lPNIinSzD9p+mE0uef
         UvePRCHVXmMn8anVuFGWKnHCn7RzKHMo24oVK6pgG+6jZvyfi7katBB4w/WlQxYGNoZw
         5nuL7EIsru+7qUpLKYK9JzEfns36haTIOM0vZzoYR+S/CfHmOhj0abVDyJiVAdYv/Ynq
         MHFzthIS87CaJaIVUBQiHb8Mgq5wmgLMAzQ0fxYKytqDNzBFeI9YyWdPJSKeItMn/CkQ
         FN9w==
X-Gm-Message-State: AOJu0YzRpeuGYG7HupLI1XJMjBZxvOxXRhzV+ZJmpevvQnHZ4VTZLWED
	YSPoyln/E5WYZIRhIvr5Rm6LG4rCLVczlzFBAU2aVESqDIfebB/xjMG0KV5Vig4=
X-Google-Smtp-Source: AGHT+IERfstStFVWFHDomJ0STyVJoIgZ1aaV6Pwjoqcf/d2xxySSH/OngrfIK9vbY4fYGnPSqj4ZQg==
X-Received: by 2002:a05:6e02:16ce:b0:3a0:4c4e:2e53 with SMTP id e9e14a558f8ab-3a0c8c61aefmr123079535ab.5.1727124978644;
        Mon, 23 Sep 2024 13:56:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0c022f1a3sm34453585ab.88.2024.09.23.13.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 13:56:18 -0700 (PDT)
Message-ID: <0a5b473a-281b-4911-984b-cf456d42a44f@linuxfoundation.org>
Date: Mon, 23 Sep 2024 14:56:17 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use
 remaining time to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, ramanan.govindarajan@oracle.com,
 sinadin.shan@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240923204718.1862074-1-yifei.l.liu@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240923204718.1862074-1-yifei.l.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 14:47, Yifei Liu wrote:
> We recently notice that the step_after_suspend_test would

noticed

> fail on our plenty devices.  The test believesit failed to

"several of our devices"  believes it
> enter suspend state with

Please do fix the above as pointed out earlier on v1.
> 
> $ sudo ./step_after_suspend_test
> TAP version 13
> Bail out! Failed to enter Suspend state
> 
> However, in the kernel message, I indeed see the system get
> suspended and then wake up later.
> 
> [611172.033108] PM: suspend entry (s2idle)
> [611172.044940] Filesystems sync: 0.006 seconds
> [611172.052254] Freezing user space processes
> [611172.059319] Freezing user space processes completed (elapsed 0.001 seconds)
> [611172.067920] OOM killer disabled.
> [611172.072465] Freezing remaining freezable tasks
> [611172.080332] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [611172.089724] printk: Suspending console(s) (use no_console_suspend to debug)
> [611172.117126] serial 00:03: disabled
> --- some other hardware get reconnected ---
> [611203.136277] OOM killer enabled.
> [611203.140637] Restarting tasks ...
> [611203.141135] usb 1-8.1: USB disconnect, device number 7
> [611203.141755] done.
> [611203.155268] random: crng reseeded on system resumption
> [611203.162059] PM: suspend exit
> 
> After investigation, I notice that for the code block

noticed?

> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
> 	ksft_exit_fail_msg("Failed to enter Suspend state\n");
> 
> The write will return -1 and errno is set to 16 (device busy).
> It should be caused by the write function is not successfully returned
> before the system suspend and the return value get messed when waking up.
> As a result, It may be better to check the time passed of those few instructions
> to determine whether the suspend is executed correctly for it is pretty hard to
> execute those few lines for 5 seconds.
> 
> The timer to wake up the system is set to expired after 5 seconds and no-rearm.
> If the timer remaining time is 0 second and 0 nano secomd, it means the timer
> expired and wake the system up. Otherwise, the system could be considered to
> enter the suspend state failed if there is any remaining time.

What would you get if you were to cat /sys/power/state at this point?

Does this fix the problem you are seeing? What is the outcome?
> 
> Fixes: bfd092b8c2728 ("selftests: breakpoint: add step_after_suspend_test")
> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
> ---
>   .../testing/selftests/breakpoints/step_after_suspend_test.c  | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index dfec31fb9b30d..33f5542bf741d 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -152,7 +152,10 @@ void suspend(void)
>   	if (err < 0)
>   		ksft_exit_fail_msg("timerfd_settime() failed\n");
>   
> -	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
> +	system("(echo mem > /sys/power/state) 2> /dev/null");
> +
> +	timerfd_gettime(timerfd,&spec);
> +	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
>   		ksft_exit_fail_msg("Failed to enter Suspend state\n");
>   
>   	close(timerfd);

thanks,
-- Shuah

