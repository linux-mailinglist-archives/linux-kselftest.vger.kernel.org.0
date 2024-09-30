Return-Path: <linux-kselftest+bounces-18667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B998AB10
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF85281B2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D91940B2;
	Mon, 30 Sep 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SXRuddkm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A33194096
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717129; cv=none; b=Vz4gGxMKhfaQI7iDqzckI80690sidwHoMJsO42n7mIF9xVtiMJctoM5/QsTRHO4JBBcMOk4DOlmAe73wmklWkQB7z+brtjpSbqHX7RlQhRrzmF5Ug9PqD2iv9mOoM2blkTjEplEE/RJW710iVyKn34inOxfQatbcdRu69syVZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717129; c=relaxed/simple;
	bh=93+7TC7llMQwsLqpLyw4GGkXHKLxCRr8E119T0+D6oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPxVtukyvK6KONzhXt8LwS4P2DvDGY/rcplDF32kw/S3J9RX0zg1JXEFxtqvet0U/4AF6U2xBo0Xpy/ecQAWUFCr+9bzm5BmFPSMAx1XiJnNQZKRIeymj7CeVl6MT0o2ELExypWMkkOi8fd++PCwee4nzeSYByl1lQ0pobvix28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SXRuddkm; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a626d73efso169311339f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727717126; x=1728321926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0a/2xnPv39gvad1/8/lZyLllluKshptvd14fJSfgkZg=;
        b=SXRuddkmg4712VFDHxNZU/nFeu+WhjiqLt/Wd7nXZB4doSuUP/OmZ9jH9noiyl5e7e
         0RNC/hnnB62bCjd8rDc3LrZEnlViFjYXcfeYCo7kLeBbnkn3Tze8rXZrN9MxrSaLAlay
         rlugeTNDp2HuzmTQEMbJXcPTBMnABhUeXLUQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717126; x=1728321926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0a/2xnPv39gvad1/8/lZyLllluKshptvd14fJSfgkZg=;
        b=G7W+qrnFQv/o6/R1YsW2Mdp7FAkRYCd6y8jO4H4A+/2ISRIeWZSOQOukTfuS7xXejR
         ykd5wgxVfskN7snol+kwgqF1ZjgjEA34yr03djU6QqkJrTZqYoNvb7X5ZoDKq6GZ1YAc
         N7EfrsmAbhT1tw9nrn6QjD/dgoPpSFwZv4KV6cjLKOQ4bpQ76F7hHQ6mSgB8ctPUexfA
         L61FlOB+DlCvmF3+DynAZ6cC2ScmZT9WN/6LoWqvha83Fk8V586/9Piy2v6Zx0tNWyqS
         Eb3VJeLL7X4BfLEXWBke55shfG/8cI7wta20HjKAh1gJhDr8P88HytI/mhyNEAHFi4Ed
         kosQ==
X-Gm-Message-State: AOJu0Yx/5283mDeOtY7G94r7yTli69yWPeUWImgV7gqpTNZ0f5VkeeEH
	NOXpbDDciflz0xtCLrZ1XPBoashur+F8mvHqQfW6V9yvc2Had1muMiHJsKXRj+4=
X-Google-Smtp-Source: AGHT+IHJfnSNecTWN/RaYsx8f5FwWgAV75LbDbv15vh8io6aOsCkOc4uIzcNVRKmP5u7EF5LhtaYcQ==
X-Received: by 2002:a05:6602:3425:b0:82d:835:e66d with SMTP id ca18e2360f4ac-834931d27bcmr799054939f.9.1727717125993;
        Mon, 30 Sep 2024 10:25:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834935ba062sm237329739f.0.2024.09.30.10.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:25:25 -0700 (PDT)
Message-ID: <07aa0512-fc72-4318-b69b-05ccb20cefa3@linuxfoundation.org>
Date: Mon, 30 Sep 2024 11:25:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use
 remaining time to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, ramanan.govindarajan@oracle.com,
 sinadin.shan@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240923225034.1869251-1-yifei.l.liu@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240923225034.1869251-1-yifei.l.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 16:50, Yifei Liu wrote:
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
> As a result, It may be better to check the time passed of those few instructions
> to determine whether the suspend is executed correctly for it is pretty hard to
> execute those few lines for 5 seconds.
> 
> The timer to wake up the system is set to expire after 5 seconds and no re-arm.
> If the timer remaining time is 0 second and 0 nano secomd, it means the timer
> expired and wake the system up. Otherwise, the system could be considered to
> enter the suspend state failed if there is any remaining time.
> 
> After appling this patch, the test would not fail for it believes the system does
> not go to suspend by mistake. It now could continue to the rest part of the test after suspend.
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

I am seeing coding style errors. Please run checkpatch script to find
them - fix and send v4.


ERROR: space required after that ',' (ctx:VxO)
#168: FILE: tools/testing/selftests/breakpoints/step_after_suspend_test.c:157:
+	timerfd_gettime(timerfd,&spec);
  	                       ^

ERROR: space required before that '&' (ctx:OxV)
#168: FILE: tools/testing/selftests/breakpoints/step_after_suspend_test.c:157:
+	timerfd_gettime(timerfd,&spec);
  	                        ^

thanks,
-- Shuah

