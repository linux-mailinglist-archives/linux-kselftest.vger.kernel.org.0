Return-Path: <linux-kselftest+bounces-18693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA398AFB4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328131F2356B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D1188A19;
	Mon, 30 Sep 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UyDQ28Ce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF72188A17
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734387; cv=none; b=LmUkjVkcVYt6u8P/Hx7+QmksHhuAnF+auZ1ZwpWk+exorrAUZ/mWgsBHamQfqOrJ4V2sBMDdx6FMf3QrKzP81DEsCRe3aFKMp1wdtznjo57ida3pOE1WbXMnrrGGLoHV+jTfN2wQChZzqv7YxBiJWho9xfkG46UqR5PkXfCdYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734387; c=relaxed/simple;
	bh=m4ms3JmsxqpPQA0u7b7+PvTGVtnoL1YT0C3HeQ9wy/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awdg3P/6qFjzR4EU5/ch3AIRcYRirN3bLCuO21WF5zz1G2OQ8rWxUpAx+6Z5fXC/QPv2JNfbU3iXCFt55P9/By3bSc6ai7k/jCDGOR3epFAXkmwn0bgtH1WnjmJQ0LOXLnn86pPNxrXH0IRp/ZSXL1po6AqJpl69grzas/3zexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UyDQ28Ce; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a1a3090f39so24730015ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727734385; x=1728339185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+hxwL1X6z1MpltYr/o5EqIxA/BcrRe5vUKnZ0fUv94=;
        b=UyDQ28Ceh+vRIc+eeOGTneeOv+U/Cvn5ZZ6rEJvLlpFWgbq1QUSdIjcVelW4awQU+f
         fGi/sIi1Uk3Wo2/5ERNYfF7pSoNzefi9CZ3OzXHjKxflSkbc0SRqkXIHiR1UCnQ5WI6e
         YBJP5s3zKx/bRj62oKR5tFliMhYMXugn5dKT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734385; x=1728339185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+hxwL1X6z1MpltYr/o5EqIxA/BcrRe5vUKnZ0fUv94=;
        b=KLqZDiifgH88QLJ2azSmKGHOXlBoTMthtKULGA+HJf1UmbeDRWQVFU4Z6USrxVCvYJ
         Ey9pvAaExorHBPEBl9fjbM76WQPMdJyM+hDgzvgVf+Fr3weNCgiExZ3FikiQ/Acr7h67
         Bgaa0qjy9GSMwAwzlhqY2OThEnx/mE00wvAo/0XpEMU7sOJlU7UMieiTgniMAfP752hE
         FrY/aF9ScgCkzEzD+eBxJxKkXxZP6ByuUVfL0qSurhNnrfwBpNothbbFoJFvlUWMS5u7
         R9jIhp/pvXWCb8wVTt/ceGb1Of9mxan6uahuu09i4FOT1XwNgQT9WWYCT+m11uhOtkKh
         rr1w==
X-Gm-Message-State: AOJu0YxcPP2jSwMkBTqYyiwp/S+qIL+qt3oLU1IprqjRzYIUAU8IXzkt
	sEosX9l5CJdVpsXZqodF5exHJdLf5HkwmMEGlMQ8DYq8oGWd9finSqRNgxLH1o4SGOWw2J3Y3sf
	8
X-Google-Smtp-Source: AGHT+IHqyFLFm6W9hfjUfYGPmiE0ZOv1aaapzXOHgkQR+8t2BtXEem6ih8ae49clWlg83Azm0ehinw==
X-Received: by 2002:a05:6e02:1a08:b0:3a0:92b1:ec3c with SMTP id e9e14a558f8ab-3a345161e57mr121183875ab.4.1727734384773;
        Mon, 30 Sep 2024 15:13:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888855ac4sm2324677173.56.2024.09.30.15.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 15:13:04 -0700 (PDT)
Message-ID: <ff1b6eec-06c5-4b5f-bc27-6637510014d9@linuxfoundation.org>
Date: Mon, 30 Sep 2024 16:13:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use
 remaining time to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, ramanan.govindarajan@oracle.com,
 sinadin.shan@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240930203603.2854629-1-yifei.l.liu@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240930203603.2854629-1-yifei.l.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 14:36, Yifei Liu wrote:
> "step_after_suspend_test fails with device busy error while
> writing to /sys/power/state to start suspend."  The test believes
> it failed to enter suspend state with
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
> After investigation, I noticed that for the code block
> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
> 	ksft_exit_fail_msg("Failed to enter Suspend state\n");
> 
> The write will return -1 and errno is set to 16 (device busy).
> It should be caused by the write function is not successfully returned
> before the system suspend and the return value get messed when waking up.
> As a result, It may be better to check the time passed of those few
> instructions to determine whether the suspend is executed correctly for
> it is pretty hard to execute those few lines for 5 seconds.
> 
> The timer to wake up the system is set to expire after 5 seconds and
> no re-arm. If the timer remaining time is 0 second and 0 nano secomd,
> it means the timer expired and wake the system up. Otherwise, the system
> could be considered to enter the suspend state failed if there is any
> remaining time.
> 
> After appling this patch, the test would not fail for it believes the
> system does not go to suspend by mistake. It now could continue to the
> rest part of the test after suspend.
> 
> Fixes: bfd092b8c272 ("selftests: breakpoint: add step_after_suspend_test")
> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
> ---

In the future add version to version changes to make it easier for
reviewers to check for the changes they asked for.

>   .../testing/selftests/breakpoints/step_after_suspend_test.c  | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index dfec31fb9b30d..8d275f03e977f 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -152,7 +152,10 @@ void suspend(void)
>   	if (err < 0)
>   		ksft_exit_fail_msg("timerfd_settime() failed\n");
>   
> -	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
> +	system("(echo mem > /sys/power/state) 2> /dev/null");
> +
> +	timerfd_gettime(timerfd, &spec);
> +	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
>   		ksft_exit_fail_msg("Failed to enter Suspend state\n");
>   
>   	close(timerfd);

thanks,
-- Shuah

